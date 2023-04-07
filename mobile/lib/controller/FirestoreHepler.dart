//C'est de faire les opérations sur la base de donnée

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchat/model/utilisateur.dart';
import 'package:matchat/model/contact.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreHelper {
  //attributs
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final cloudUsers = FirebaseFirestore.instance.collection("UTILISATEURS");
  final cloudMessage = FirebaseFirestore.instance.collection("MESSAGES");
  final cloudContact = FirebaseFirestore.instance.collection("CONTACTS");
  //méthode

  //créer un utilisateur dans la base
  Future<Utilisateur> Inscription(String mail, String password, String name,
      String lastname, String pseudo, String langue) async {
    //creer dans l'authentification
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: mail, password: password);
    User? user = credential.user;
    if (user == null) {
      return Future.error("error");
    } else {
      String uid = user.uid;
      Map<String, dynamic> map = {
        "NAME": name,
        "LASTNAME": lastname,
        "MAIL": mail,
        "PSEUDO": pseudo,
        "LANGUE": langue
      };
      //stocker dans la partie du firestore database
      addUser(uid, map);
      return getUser(uid);
    }
  }

  //Récupérer les infos de l'utilisateur
  Future<Utilisateur> getUser(String id) async {
    DocumentSnapshot snapshots = await cloudUsers.doc(id).get();
    return Utilisateur(snapshots);
  }

  //se connecter à un compte
  Future<Utilisateur> Connect(String mail, String password) async {
    UserCredential credential =
        await auth.signInWithEmailAndPassword(email: mail, password: password);
    User? user = credential.user;
    if (user == null) {
      return Future.error("erreur");
    } else {
      String uid = user.uid;
      return getUser(uid);
    }
  }

  //ajouter un utilisateur
  addUser(String id, Map<String, dynamic> map) {
    cloudUsers.doc(id).set(map);
  }

  //supprimer un utlisateur
  deleteUser(String id, Map<String, dynamic> map) {
    cloudUsers.doc(id).delete();
  }

  //mise à jour des infos utlisateurs
  updateUser(String id, Map<String, dynamic> data) {
    cloudUsers.doc(id).update(data);
  }

  //ajouter un contact
  addContact(String id, Map<String, dynamic> map) {
    cloudContact.doc(id).set(map);
  }

  //delete un contact
  deleteContact(String id, Map<String, dynamic> map) {
    cloudContact.doc(id).delete();
  }

//ajouter un message

//supprimer un message

// upload une image
  Future<String> stockageImage(
      {required String dossier,
      required String dossierPersonnel,
      required String nameImage,
      required Uint8List bytesImage}) async {
    String url = "";
    TaskSnapshot taskSnapshot = await storage
        .ref("$dossier/$dossierPersonnel/$nameImage")
        .putData(bytesImage);
    url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}
