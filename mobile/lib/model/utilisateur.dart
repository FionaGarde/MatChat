import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchat/globale.dart';

class Utilisateur {
  //attributs
  late String id;
  String? avatar;
  DateTime? birthday;
  late DateTime dateAdd;
  late DateTime dateUpd;
  late String firstname;
  late String lastname;
  late String mail;
  String? phone;
  late String pseudo;
  String? langue;
  late String password;
  //List? favoris;

  //un ou des constructeurs
  Utilisateur(DocumentSnapshot snapshot) {
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    lastname = map['lastname'];
    firstname = map['firstname'];
    mail = map['mail'];
    avatar = map["avatar"] ?? defaultImage;
    langue = map["langue"] ?? defaultLangue;
    Timestamp? timeprovisoire = map["birthday"];
    if (timeprovisoire == null) {
      birthday = DateTime.now();
    } else {
      birthday = timeprovisoire.toDate();
    }
    Timestamp? timeadd = map["date_add"];
    if (timeadd == null) {
      dateAdd = DateTime.now();
    } else {
      dateAdd = timeadd.toDate();
    }
    Timestamp? timeupd = map["date_upd"];
    if (timeupd == null) {
      dateUpd = DateTime.now();
    } else {
      dateUpd = timeupd.toDate();
    }
    phone = map["phone"];
    pseudo = map["pseudo"];
  }

  Utilisateur.empty() {
    id = "";
    lastname = "";
    firstname = "";
    pseudo = "";
    mail = "";
    phone = "";
  }

  //variable calculé
  String get fullName {
    return "$firstname $lastname";
  }

  //get the age of the user
  num get age {
    num age;
    if (birthday == null) {
      return 0;
    } else {
      age = (DateTime.now().difference(birthday!).inDays / 365).floor();
    }
    return age;
  }
}
