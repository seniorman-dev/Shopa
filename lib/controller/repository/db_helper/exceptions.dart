import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopa/view/utils/components/my_snackbar.dart';






/// Abstract class that defines the contract for handling Firebase exceptions.
abstract class FirebaseExceptionHandler {
  void handleException(FirebaseException exception);
}

/// Implementation of the FirebaseExceptionHandler for Firestore and Auth errors.
class DefaultFirebaseExceptionHandler extends FirebaseExceptionHandler {
  @override
  void handleException(FirebaseException exception) {
    if (exception is FirebaseAuthException) {
      // Handle Firebase Authentication errors
      switch (exception.code) {
        case 'user-not-found':
          print('No user found for that email.');
          showMessagePopup(title: "Uh oh!", message: 'No user found for that email.', buttonText: "Okay");
          break;
        case 'wrong-password':
          print('Wrong password provided.');
          showMessagePopup(title: "Uh oh!", message: 'Wrong password provided.', buttonText: "Okay");
          break;
        default:
          print('FirebaseAuthException: ${exception.message}');
          showMessagePopup(title: "Uh oh!", message: '${exception.message}', buttonText: "Okay");
      }
    } else if (exception is FirebaseException) {
      // Handle Firestore specific errors
      switch (exception.code) {
        case 'permission-denied':
          print('Permission denied for Firestore operation.');
          showMessagePopup(title: "Uh oh!", message: 'Permission denied for Firestore operation.', buttonText: "Okay");
          break;
        case 'not-found':
          print('Document not found.');
          showMessagePopup(title: "Uh oh!", message: 'Document not found.', buttonText: "Okay");
          break;
        default:
          print('FirebaseFirestoreException: ${exception.message}');
          showMessagePopup(title: "Uh oh!", message: '${exception.message}', buttonText: "Okay");
      }
    } else {
      // Handle other Firebase exceptions
      print('FirebaseException: ${exception.message}');
      showMessagePopup(title: "Uh oh!", message: '${exception.message}', buttonText: "Okay");
    }
  }
}
