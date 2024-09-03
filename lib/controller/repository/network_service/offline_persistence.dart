
import 'package:cloud_firestore/cloud_firestore.dart';


//This function enables or handless offline data access, persistence and synchronization to cloud firestore
void enableFirestoreOfflinePersistence() {
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
}