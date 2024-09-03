import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopa/controller/repository/db_helper/exceptions.dart';






class FirebaseService {

  // Private constructor
  FirebaseService._privateConstructor();

  // Singleton instance
  static final FirebaseService _instance = FirebaseService._privateConstructor();

  // Getter to access the singleton instance
  static FirebaseService get instance => _instance;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // Exception handler instance
  final FirebaseExceptionHandler _exceptionHandler = DefaultFirebaseExceptionHandler();
  
  //loading
  final isLoading = false.obs;

  // Initialize Firebase (Ensure this is called at app start)
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  // CREATE operation: Adds a document to a specified collection
  Future<void> createDocument(String collection, Map<String, dynamic> data, VoidCallback onSuccess) async {
    isLoading.value = true;
    try {
      DocumentReference docRef= await _firestore.collection(collection).add(data);
      await _firestore.collection(collection).doc(docRef.id).update({"id": docRef.id});
      isLoading.value = false;
      log('Document added successfully');
      onSuccess();
    } on FirebaseException catch (e) {
      isLoading.value = false;
      _exceptionHandler.handleException(e);
    }
  }

  // UPDATE operation: Updates a document by ID in a specified collection. if it doesn't exist, it will fail to create/update.
  Future<void> updateDocument(String collection, String docId, Map<String, dynamic> data, VoidCallback onSuccess) async {
    isLoading.value = true;
    try {
      await _firestore.collection(collection).doc(docId).update(data);
      isLoading.value = false;
      log('Strict Document updated successfully');
      onSuccess();
    } on FirebaseException catch (e) {
      isLoading.value = false;
      _exceptionHandler.handleException(e);
    }
  }

  // UPDATE operation: Updates a document by ID in a specified collection. if it doesn't exist, it will be created
  Future<void> updateDocumentPatch(String collection, String docId, Map<String, dynamic> data, VoidCallback onSuccess) async {
    isLoading.value = true;
    try {
      await _firestore.collection(collection).doc(docId).set(data);
      isLoading.value = false;
      log('Document updated successfully (set)');
      onSuccess();
    } on FirebaseException catch (e) {
      isLoading.value = false;
      _exceptionHandler.handleException(e);
    }
  }

  // DELETE operation: Deletes a document by ID in a specified collection
  Future<void> deleteDocument(String collection, String docId, VoidCallback onSuccess) async {
    isLoading.value = true;
    try {
      await _firestore.collection(collection).doc(docId).delete();
      isLoading.value = false;
      log('Document deleted successfully');
      onSuccess();
    } on FirebaseException catch (e) {
      isLoading.value = false;
      _exceptionHandler.handleException(e);
    }
  }


  // STREAM: Listen to real-time updates on a document by ID
  Stream<DocumentSnapshot<Map<String, dynamic>>> readDocument(String collection, String docId) {
    try {
      return _firestore.collection(collection).doc(docId).snapshots();
    } on FirebaseException catch (e) {
      _exceptionHandler.handleException(e);
      rethrow;  // We rethrow the exception to ensure the stream fails appropriately.
    }
  }

  // STREAM: Listen to real-time updates on a collection
  Stream<QuerySnapshot<Map<String, dynamic>>> readCollection(String collection, String orderBy) {
    try {
      return _firestore
      .collection(collection)
      .orderBy(orderBy)
      .snapshots(includeMetadataChanges: true);
      
      /*.listen((querySnapshot) {
        for(var change in querySnapshot.docChanges)  {
          if(change.type == DocumentChangeType.added || change.type == DocumentChangeType.modified || change.type == DocumentChangeType.removed) {
            final source = (querySnapshot.metadata.isFromCache) ? "local cache" : "server";
            log("Data fetched from $source");
          }
        }
      });*/

    } on FirebaseException catch (e) {
      _exceptionHandler.handleException(e);
      rethrow;  // We rethrow the exception to ensure the stream fails appropriately.
    }
  }

  // Query with search filter
  Stream<QuerySnapshot<Map<String, dynamic>>> readCollectionWithSearch(String collection, String searchQuery, String orderBy) {
    try {
      return _firestore
        .collection(collection)
        .where('name', isEqualTo: searchQuery)
        .where('name', isLessThanOrEqualTo: '$searchQuery\uf8ff') // Firebase query range trick for prefix search
        .orderBy(orderBy)
        .snapshots(includeMetadataChanges: true);
        /*.listen((querySnapshot) {
          for(var change in querySnapshot.docChanges)  {
            if(change.type == DocumentChangeType.added || change.type == DocumentChangeType.modified || change.type == DocumentChangeType.removed) {
              final source = (querySnapshot.metadata.isFromCache) ? "local cache" : "server";
              log("Data fetched from $source");
            }
          }
        });*/
    } on FirebaseException catch (e) {
      _exceptionHandler.handleException(e);
      rethrow;
    }
  }




  ////FIRESTORE QUERYING TECHNIQUES EXAMPLES////
  /*Firestore provides a variety of querying techniques that allow you to perform complex operations. Here's an overview of some advanced querying techniques you can use in Firestore, along with examples:

  1. Basic Queries
  Equality: Fetch documents where a field matches a specific value.
  Less Than / Greater Than: Fetch documents where a field is less than or greater than a specific value.
  . Compound Queries
  Combine multiple conditions in a single query using .where().
  3. Order and Limit
  You can order your results by a specific field and limit the number of results returned.
  4. Pagination
  Fetch data in chunks and support pagination using the startAfter or startAt methods.
  5. Array Queries
  Fetch documents where an array contains a specific value (array-contains) or multiple values (array-contains-any).
  6. Range Queries
  Use multiple .where() clauses to filter by a range of values.
  7. In Queries
  Fetch documents where a field matches one of several values using whereIn.*/


  // Example: Fetch Users with a Specific Name
  // Queries the Firestore 'users' collection for users where 'name' equals the provided name.
  Stream<QuerySnapshot> fetchUsersByName(String name) {
    return _firestore.collection('users')
      .where('name', isEqualTo: name) // Filter by 'name'
      .snapshots(); // Return as a real-time stream
  }

  // Example: Fetch Users Older Than a Certain Age
  // Queries the Firestore 'users' collection for users where 'age' is greater than the provided value.
  Stream<QuerySnapshot> fetchUsersOlderThan(int age) {
    return _firestore.collection('users')
      .where('age', isGreaterThan: age) // Filter by 'age' greater than a given value
      .snapshots(); // Return as a real-time stream
  }

  // Example: Compound Query - Fetch Users Older Than 30 and Name Starts with a Specific Letter
  // Uses Firestore compound queries to filter by both 'age' and 'name'.
  Stream<QuerySnapshot> fetchUsersWithConditions(String startingLetter, int age) {
    return _firestore.collection('users')
      .where('age', isGreaterThan: age) // Filter by 'age' greater than a given value
      .where('name', isGreaterThanOrEqualTo: startingLetter) // Filter by name starting with the given letter
      .where('name', isLessThanOrEqualTo: '$startingLetter\uf8ff') // Ensure range for names starting with the letter
      .snapshots(); // Return as a real-time stream
  }

  // Example: Order Users by Age and Limit the Results to a Specified Number
  // Fetches users from Firestore and orders them by 'age', limiting the results.
  Stream<QuerySnapshot> fetchUsersOrderedByAge(int limit) {
    return _firestore.collection('users')
      .orderBy('age') // Order results by 'age'
      .limit(limit) // Limit results to the specified number
      .snapshots(); // Return as a real-time stream
  }

  // Example: Pagination - Fetch First Page of Users Ordered by Age
  // Fetches the first page of users from Firestore ordered by 'age'.
  Future<QuerySnapshot> fetchFirstPage(int limit) {
    return _firestore.collection('users')
      .orderBy('age') // Order by 'age'
      .limit(limit) // Limit the number of results to a page size
      .get(); // Fetch the first page
  }

  // Example: Pagination - Fetch Next Page of Users After the Last Document
  // Fetches the next page of users from Firestore, starting after the last document.
  Future<QuerySnapshot> fetchNextPage(DocumentSnapshot lastDocument, int limit) {
    return _firestore.collection('users')
      .orderBy('age') // Order by 'age'
      .startAfterDocument(lastDocument) // Start after the last document of the previous page
      .limit(limit) // Limit the number of results to the page size
      .get(); // Fetch the next page
  }

  // Example: Fetch Users with a Specific Role in an Array
  // Queries Firestore 'users' collection for documents where 'roles' array contains the provided role.
  Stream<QuerySnapshot> fetchUsersByRole(String role) {
    return _firestore.collection('users')
      .where('roles', arrayContains: role) // Filter by array containing the given role
      .snapshots(); // Return as a real-time stream
  }

  // Example: Fetch Users with Any of Multiple Roles in an Array
  // Queries Firestore 'users' collection for documents where 'roles' array contains any of the provided roles.
  Stream<QuerySnapshot> fetchUsersByMultipleRoles(List<String> roles) {
    return _firestore.collection('users')
      .where('roles', arrayContainsAny: roles) // Filter by array containing any of the provided roles
      .snapshots(); // Return as a real-time stream
  }

  // Example: Range Query - Fetch Users Aged Between a Minimum and Maximum Value
  // Uses range queries in Firestore to fetch users whose age is within the given range.
  Stream<QuerySnapshot> fetchUsersInAgeRange(int minAge, int maxAge) {
    return _firestore.collection('users')
      .where('age', isGreaterThanOrEqualTo: minAge) // Filter by 'age' greater than or equal to minAge
      .where('age', isLessThanOrEqualTo: maxAge) // Filter by 'age' less than or equal to maxAge
      .snapshots(); // Return as a real-time stream
  }

  // Example: 'In' Query - Fetch Users with Names from a List of Names
  // Queries Firestore 'users' collection for documents where 'name' is in the provided list of names.
  Stream<QuerySnapshot> fetchUsersByNameList(List<String> names) {
    return _firestore.collection('users')
      .where('name', whereIn: names) // Filter by 'name' matching any value in the given list
      .snapshots(); // Return as a real-time stream
  }

  // Example: Advanced Query - Fetch Users with Role and Age in a Given Range and Paginate Results
  // Combines filters and pagination: filter by role, age range, and paginate the results.
  Future<QuerySnapshot> fetchFilteredPaginatedUsers(
    DocumentSnapshot? lastDocument,
    int limit,
    String role,
    int minAge,
    int maxAge,
  ) {
    Query query = _firestore.collection('users')
      .where('roles', arrayContains: role) // Filter by 'roles' array containing the given role
      .where('age', isGreaterThanOrEqualTo: minAge) // Filter by 'age' greater than or equal to minAge
      .where('age', isLessThanOrEqualTo: maxAge) // Filter by 'age' less than or equal to maxAge
      .orderBy('age'); // Order results by 'age'

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument); // Start after the last document for pagination
    }

    return query.limit(limit).get(); // Limit the results to the page size and fetch
  }
}