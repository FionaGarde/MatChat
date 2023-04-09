//Faire les opérations sur la base de donnée
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchat/globale.dart';
import 'package:matchat/model/utilisateur.dart';
import 'package:matchat/model/message.dart';
import 'package:matchat/model/contact.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreHelper {
  //attributs
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final cloudUsers = FirebaseFirestore.instance.collection("users");
  final cloudMessage = FirebaseFirestore.instance.collection("messages");
  final cloudContact = FirebaseFirestore.instance.collection("contacts");
  //méthode

  //créer un utilisateur dans la base
  Future<Utilisateur> Inscription(String mail, String password, String name,
      String lastname, String pseudo, String langue, String phone) async {
    //creer dans l'authentification
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: mail, password: password);
    User? user = credential.user;
    if (user == null) {
      return Future.error("error");
    } else {
      String uid = user.uid;
      Map<String, dynamic> map = {
        "firstname": name,
        "lastname": lastname,
        "mail": mail,
        "pseudo": pseudo,
        "langue": langue,
        "phone": phone
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

  //récuperer une liste de contacts
  Future<List<DocumentSnapshot>> getContacts(String str) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('contact')
        .where('pseudo1', isEqualTo: str)
        .get();
    var querySnapshot2 = await FirebaseFirestore.instance
        .collection('contact')
        .where('pseudo2', isEqualTo: str)
        .get();

    querySnapshot.docs.addAll(querySnapshot2.docs);
    return querySnapshot.docs;
  }

  //delete un contact
  deleteContact(String id, Map<String, dynamic> map) {
    cloudContact.doc(id).delete();
  }

//ajouter un message
  addMessage(String id, Map<String, dynamic> map) {
    cloudMessage.doc(id).set(map);
  }

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
