import 'package:DooBee/models/task_model.dart';
import 'package:DooBee/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel taskModel) {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Future<void> addUser(UserModel userModel) {
    var collection = getUsersCollection();
    var docRef = collection.doc(userModel.id);
    return docRef.set(userModel);
  }

  static Stream<QuerySnapshot<TaskModel>> getTask(DateTime dateTime) {
    return getTaskCollection()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
        .orderBy('id')
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTaskCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel taskModel) {
    var taskCollection = getTaskCollection();
    return taskCollection.doc(taskModel.id).update(taskModel.toJson());
  }

  static void createUserAccount(
      {required String email,
      required String password,
      required String fullName,
      required Function onSuccess,
      required Function onError}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //credential.user!.sendEmailVerification();
      // FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      UserModel userModel = UserModel(
          id: credential.user?.uid ?? '', email: email, fullName: fullName);
      addUser(userModel).then((value) {
        onSuccess();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
      onError(e.message);
    } catch (e) {
      onError("Something went wrong");
    }
  }

  static void signInUser(
    String email,
    String password,
    Function onSuccess,
    Function onError,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      //if(credential.user!.emailVerified){
      onSuccess();
      /*else{
        onError('please check your email and verify');
      }*/
    } on FirebaseAuthException catch (e) {
      /*if (e.code == 'user-not-found') {
        onError('No user found for that email.');

      } else if (e.code == 'wrong-password') {
        onError('Wrong password provided for that user.');
      }*/
      onError('Wrong password or email');
    }
  }

  static Future<UserModel?> readUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String id = user.uid;
      DocumentSnapshot<UserModel> documentSnapshot =
          await getUsersCollection().doc(id).get();
      return documentSnapshot.data();
    } else {
      return null;
    }
  }

  static Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
