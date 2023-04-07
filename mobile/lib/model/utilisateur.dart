import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchat/globale.dart';

class Utilisateur {
  //attributs
  late String id;
  String? avatar;
  DateTime? birthday;
  late String firstname;
  late String lastname;
  late String mail;
  late String phone;
  late String pseudo;
  //String? nickname;
  //late String email;
  //List? favoris;

  //un ou des constructeurs
  Utilisateur(DocumentSnapshot snapshot) {
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    lastname = map['NOM'];
    firstname = map['PRENOM'];
    mail = map['MAIL'];
    avatar = map["AVATAR"] ?? defaultImage;
    //favoris = map["FAVORIS"] ?? [];
    Timestamp? timeprovisoire = map["BIRTHDAY"];
    if (timeprovisoire == null) {
      birthday = DateTime.now();
    } else {
      birthday = timeprovisoire.toDate();
    }
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
