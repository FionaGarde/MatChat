import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchat/globale.dart';

class Contact {
  //attributs
  late String id;
  DateTime? dateAdd;
  late String pseudo;

  //un ou des constructeurs
  Contact(DocumentSnapshot snapshot) {
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    pseudo = map['PSEUDO'];
    Timestamp? timeprovisoire = map["DATEADD"];
    if (timeprovisoire == null) {
      dateAdd = DateTime.now();
    } else {
      dateAdd = timeprovisoire.toDate();
    }
  }

  Contact.empty() {
    id = "";
    pseudo = "";
  }
}
