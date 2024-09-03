import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopa/controller/repository/db_helper/exceptions.dart'; // Assuming custom exceptions








class RealTimeDatabaseService {

  // Private constructor
  RealTimeDatabaseService._privateConstructor();

  // Singleton instance
  static final RealTimeDatabaseService _instance = RealTimeDatabaseService._privateConstructor();

  // Getter to access the singleton instance
  static RealTimeDatabaseService get instance => _instance;

  // Realtime Database instance
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  // Initialize Firebase (Ensure this is called at app start)
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  // CREATE operation: Adds a document (auto-generated key) to a specified collection (node)
  Future<void> createDocument(String collection, Map<String, dynamic> data) async {
    try {
      DatabaseReference newRef = _databaseRef.child(collection).push(); // Auto-generates a unique key
      await newRef.set(data);
      print('Document added successfully with key: ${newRef.key}');
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  // STREAM: Listen to real-time updates on a document by ID (node key)
  Stream<DatabaseEvent> readDocument(String collection, String docId) {
    try {
      return _databaseRef.child('$collection/$docId').onValue;
    } catch (e, stackTrace) {
      print('Error reading document: $e');
      rethrow; // Ensure the stream fails appropriately
    }
  }

  // STREAM: Listen to real-time updates on a collection (node)
  Stream<DatabaseEvent> readCollection(String collection) {
    try {
      return _databaseRef.child(collection).onValue;
    } catch (e) {
      print('Error reading collection: $e');
      rethrow; // Ensure the stream fails appropriately
    }
  }

  // Query with search filter: Note that Realtime DB querying is limited compared to Firestore
  Stream<DatabaseEvent> readCollectionWithSearch(String collection, String searchQuery) {
    try {
      return _databaseRef.child(collection)
        .orderByChild('name') // Querying by a specific child field
        .startAt(searchQuery)
        .endAt('$searchQuery\uf8ff')
        .onValue;
    } catch (e) {
      print('Error adding document: $e');
      rethrow;
    }
  }

  // UPDATE operation: Updates a document by ID (node key) in a specified collection (node)
  Future<void> updateDocument(String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _databaseRef.child('$collection/$docId').update(data);
      print('Document updated successfully');
    } catch (e) {
      //_exceptionHandler.handleException(e);
      print('Error updating document: $e');
    }
  }

  // UPDATE operation: Creates or updates a document by ID (node key) in a specified collection (node)
  Future<void> updateDocumentPatch(String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _databaseRef.child('$collection/$docId').set(data); // Overwrites or creates
      print('Document created/updated successfully');
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  // DELETE operation: Deletes a document by ID (node key) in a specified collection (node)
  Future<void> deleteDocument(String collection, String docId) async {
    try {
      await _databaseRef.child('$collection/$docId').remove();
      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  ////REALTIME DATABASE QUERYING TECHNIQUES EXAMPLES////
  // Example: Fetch Users with a Specific Name (requires data to be indexed)
  Stream<DatabaseEvent> fetchUsersByName(String name) {
    return _databaseRef.child('users')
      .orderByChild('name')
      .equalTo(name)
      .onValue;
  }

  // Example: Fetch Users Older Than a Certain Age
  Stream<DatabaseEvent> fetchUsersOlderThan(int age) {
    return _databaseRef.child('users')
      .orderByChild('age')
      .startAt(age + 1) // Greater than the provided age
      .onValue;
  }


  // Example: Order Users by Age and Limit Results
  Stream<DatabaseEvent> fetchUsersOrderedByAge(int limit) {
    return _databaseRef.child('users')
      .orderByChild('age')
      .limitToFirst(limit)
      .onValue;
  }

  // Example: Pagination - Fetch Users After a Certain Key
  Future<DataSnapshot> fetchFirstPage(int limit) {
    return _databaseRef.child('users')
      .orderByChild('age')
      .limitToFirst(limit)
      .get();
  }

  Future<DataSnapshot> fetchNextPage(String lastKey, int limit) {
    return _databaseRef.child('users')
      .orderByKey()
      .startAfter(lastKey)
      .limitToFirst(limit)
      .get();
  }

  // Example: Fetch Users with a Specific Role in an Array (Array fields need special handling in RTDB)
  Stream<DatabaseEvent> fetchUsersByRole(String role) {
    return _databaseRef.child('users')
      .orderByChild('roles/$role') // Simulate array-contains using a map
      .equalTo(true)
      .onValue;
  }

  // Example: Fetch Users Aged Between a Minimum and Maximum Value
  Stream<DatabaseEvent> fetchUsersInAgeRange(int minAge, int maxAge) {
    return _databaseRef.child('users')
      .orderByChild('age')
      .startAt(minAge)
      .endAt(maxAge)
      .onValue;
  }

  
}
