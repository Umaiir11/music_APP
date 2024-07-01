import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasecud/app/mvvm/models/audio_model.dart';

import '../mvvm/models/user_model.dart';

//CURD
class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Create (add-user)
  Future<void> addUserDataa(UserModel user) async {
    CollectionReference collectionReference = _firestore.collection('User');
    await collectionReference.add(user.toJson());
  }

  //Fetch User( By Id)

  Future<UserModel?> fetchUserById(String userId) async {
    try {
      CollectionReference collectionReference = _firestore.collection('User');
      QuerySnapshot snap = await collectionReference.where('id', isEqualTo: userId).get();

      if (snap.docs.isNotEmpty) {
        DocumentSnapshot data = snap.docs.first;
        String documentId = data.id;
        return UserModel.fromFirestore(data, documentId);
      } else {
        return null; // Return null if user with given userId is not found
      }
    } catch (e) {
      print(e);
      return null; // Handle exceptions and return null on error
    }
  }

  //sign in

  Future<UserModel?> signInWithEmailAndPassword(UserModel user) async {
    try {
      if (user.email == null || user.password == null) {
        throw Exception('Email and password must not be null');
      }

      CollectionReference collectionReference = _firestore.collection('User');
      QuerySnapshot snap = await collectionReference
          .where('email', isEqualTo: user.email)
          .where('pass', isEqualTo: user.password)
          .get();

      if (snap.docs.isNotEmpty) {
        DocumentSnapshot data = snap.docs.first;
        String documentId = data.id;

        return UserModel.fromFirestore(data, documentId);
      } else {
        print('No user found with the provided email and password.');
        return null; // No user found
      }
    } catch (e) {
      print('Error signing in: $e');
      return null; // Return null on error
    }
  }

  //Read (fetch-users)
  Future<List<UserModel>> fetchUsers(List<UserModel> userList) async {
    try {
      CollectionReference collectionReference = _firestore.collection('User');
      QuerySnapshot snap = await collectionReference.get();
      List<DocumentSnapshot> documents = snap.docs;

      userList.clear();
      for (DocumentSnapshot data in documents) {
        // we get the document id for update the document instead of using where clause
        String documentId = data.id;
        UserModel userModel = UserModel.fromFirestore(data, documentId);
        userList.add(userModel);
      }
    } catch (e) {
      print(e);
    }
    return userList;
  }

  //Update (update-user)
  Future<void> updateUserData(String documentId, UserModel updatedUserData) async {
    //we use the document id to update the user
    try {
      CollectionReference collectionReference = _firestore.collection('User');
      await collectionReference.doc(documentId).update(updatedUserData.toJson());
    } catch (e) {
      print('Error updating document with ID: $documentId');
      print(e);
    }
  }

  //Delete (delete-user)
  Future<void> deleteUserData(String documentId) async {
    try {
      CollectionReference collectionReference = _firestore.collection('User');
      await collectionReference.doc(documentId).delete();
    } catch (e) {
      print(e);
    }
  }


  Future<bool> uploadAudioFile(AudioSongModel audioModel) async {
    try {
      if (audioModel.file == null) {
        throw Exception('File is null');
      }

      String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${audioModel.file!.path.split('/').last}';
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('audiosongs/${audioModel.categoryName}/$fileName');
      UploadTask uploadTask = storageReference.putFile(audioModel.file!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      // Update the song URL in the model
      AudioSongModel updatedModel = AudioSongModel(
        songName: audioModel.songName,
        songUrl: downloadURL,
        thumbnail: audioModel.thumbnail,
        categoryName: audioModel.categoryName,
        timestamp: audioModel.timestamp,
      );

      // Use categoryName as the document ID and add song data
      DocumentReference categoryDoc = FirebaseFirestore.instance
          .collection('audioSongs')
          .doc(audioModel.categoryName);

      await categoryDoc.update({
        'songs': FieldValue.arrayUnion([updatedModel.toMap()])
      }).catchError((error) async {
        // Create the document if it doesn't exist
        await categoryDoc.set({
          'categoryName': audioModel.categoryName,
          'songs': [updatedModel.toMap()]
        });
      });

      print('File uploaded and metadata saved successfully.');
      return true;
    } catch (e) {
      print('Error uploading file: $e');
      return false;
    }
  }

  //get all categories
  Future<List<String>> getAllCategories() async {
    List<String> categories = [];

    try {
      QuerySnapshot querySnapshot = await _firestore.collection('audioSongs').get();

      querySnapshot.docs.forEach((doc) {
        categories.add(doc.id);
      });

      return categories;
    } catch (e) {
      print('Error retrieving categories: $e');
      return []; // Return empty list on error
    }
  }

  //get songs against categories
  Future<List<AudioSongModel>> getSongsByCategory(String categoryName) async {
    List<AudioSongModel> songs = [];

    try {
      DocumentSnapshot categoryDoc = await _firestore
          .collection('audioSongs')
          .doc(categoryName)
          .get();

      if (categoryDoc.exists) {
        List<dynamic> songsList = categoryDoc['songs'];

        for (var songData in songsList) {
          songs.add(AudioSongModel(
            songName: songData['songName'],
            songUrl: songData['songUrl'],
            thumbnail: songData['thumbnail'],
            categoryName: categoryName,
            timestamp: songData['timestamp'],
          ));
        }
      }

      return songs;
    } catch (e) {
      print('Error retrieving songs for category $categoryName: $e');
      return []; // Return empty list on error
    }
  }
}

