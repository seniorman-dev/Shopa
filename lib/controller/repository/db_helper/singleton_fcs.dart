import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';





class FirebaseStorageService {


  // Private constructor
  FirebaseStorageService._internal();

  // Singleton instance
  static final FirebaseStorageService _instance = FirebaseStorageService._internal();

  // Getter to access the singleton instance
  static FirebaseStorageService get instance => _instance;

  //media storage url
  final responseUrl = "".obs;
  //loading
  final isLoading = false.obs;

  // Firebase storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;


  // Upload file to Firebase Storage
  Future<String> uploadFile({required File file, required String path}) async {
    isLoading.value = true;
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = await ref.putFile(file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      isLoading.value = false;
      responseUrl.value = downloadUrl;
      log("url: ${responseUrl.value}");
      return downloadUrl;
    } catch (e) {
      // Handle the error, print, log or throw exception
      isLoading.value = false;
      print("Error during file upload: $e");
      throw Exception("File upload failed");
    }
  }


  Future<List<String>> uploadMultipleFiles({
    required List<File> files,
    required String path,
  }) async {
    isLoading.value = true;
    List<String> downloadUrls = [];

    try {
      // Iterate through each file and upload it
      for (var file in files) {
        // Define a unique path for each file
        final fileName = file.path.split('/').last;
        final ref = _storage.ref().child('$path/$fileName');

        // Upload the file
        final uploadTask = await ref.putFile(file);

        // Get the download URL
        final downloadUrl = await uploadTask.ref.getDownloadURL();

        // Add the download URL to the list
        downloadUrls.add(downloadUrl);

        // Log each URL
        log("Uploaded file URL: $downloadUrl");
      }

      isLoading.value = false;

      // Return the list of download URLs
      return downloadUrls;
    } catch (e) {
      // Handle the error, log and stop loading
      isLoading.value = false;
      print("Error during file upload: $e");
      throw Exception("File upload failed for one or more files");
    }
  }


  // Download file from Firebase Storage
  Future<File?> downloadFile({required String path, required String fileName}) async {
    isLoading.value = true;
    try {
      final ref = _storage.ref().child(path);
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final File downloadToFile = File('${appDocDir.path}/$fileName');
      
      await ref.writeToFile(downloadToFile);
      isLoading.value = false;
      return downloadToFile;
    } catch (e) {
      // Handle the error, print, log or throw exception
      isLoading.value = false;
      print("Error during file download: $e");
      throw Exception("File download failed");
    }
  }

  // Delete file from Firebase Storage
  Future<void> deleteFile(String path) async {
    isLoading.value = true;
    try {
      final ref = _storage.ref().child(path);
      await ref.delete();
      isLoading.value = false;
    } catch (e) {
      // Handle the error, print, log or throw exception
      isLoading.value = false;
      print("Error during file deletion: $e");
      throw Exception("File deletion failed");
    }
  }

  // Download URL for viewing a file without downloading the file itself
  Future<String> getFileDownloadUrl(String path) async {
    isLoading.value = true;
    try {
      final ref = _storage.ref().child(path);
      final downloadUrl = await ref.getDownloadURL();
      isLoading.value = false;
      return downloadUrl;
    } catch (e) {
      // Handle the error, print, log or throw exception
      isLoading.value = false;
      print("Error getting file download URL: $e");
      throw Exception("Failed to get download URL");
    }
  }
}
