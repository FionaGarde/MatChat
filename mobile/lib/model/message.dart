import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchat/globale.dart';

class Message {
  //attributs
  late String id;
  late String name;
  late String expediteur;
  late String destinataire;
  late String message;
  DateTime? date_add;
  DateTime? date_upd;

  //un ou des constructeurs
  Message(DocumentSnapshot snapshot) {
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    name = map['Name'];
    expediteur = map['EXPEDITEUR'];
    destinataire = map['DESTINATAIRES'];
    message = map['mESSAGE'];
    Timestamp? timeprovisoire = map["DATE_ADD"];
    if (timeprovisoire == null) {
      date_add = DateTime.now();
    } else {
      date_add = timeprovisoire.toDate();
    }
    Timestamp? timeprovisoireupd = map["DATE_UPD"];
    if (timeprovisoireupd == null) {
      date_upd = DateTime.now();
    } else {
      date_upd = timeprovisoireupd.toDate();
    }
  }

  Message.empty() {
    id = "";
    name = "";
    expediteur = "";
    destinataire = "";
    message = "";
  }

  //méthode
}
