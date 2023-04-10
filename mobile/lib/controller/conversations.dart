import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchat/controller/FirestoreHepler.dart';
import 'package:matchat/globale.dart';
import 'package:matchat/model/utilisateur.dart';
import 'package:flutter/material.dart';
import 'FirestoreHepler.dart';

class Conversations extends StatefulWidget {
  const Conversations({Key? key}) : super(key: key);

  @override
  State<Conversations> createState() => _Conversations();
}

class _Conversations extends State<Conversations> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper()
          .cloudMessage
          .where('expediteur', arrayContains: monUtilisateur.pseudo)
          .snapshots(),
      builder: (context, snap) {
        List documents = snap.data?.docs ?? [];
        if (documents.isEmpty) {
          return const Center(
              child: Text(
                  'Commencez une conversation avec un utilisateur pour la voir s\'afficher ici'));
        } else {
          List<String> contactPseudos = [];
          for (var doc in documents) {
            String expediteur = doc['expediteur'];
            if (expediteur == monUtilisateur.pseudo) {
              contactPseudos.add(doc['destinataire']);
            }
          }
          return ListView.builder(
              itemCount: contactPseudos.length,
              itemBuilder: (context, index) {
                return FutureBuilder<DocumentSnapshot>(
                    future: FirestoreHelper()
                        .cloudUsers
                        .doc(contactPseudos[index])
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator.adaptive();
                      } else {
                        Utilisateur otherUser = Utilisateur(snapshot.data!);
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            onTap: () {
                              //ouvrir une nouvelle page de chat todo
                            },
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(otherUser.avatar!),
                            ),
                            title: Text(otherUser.fullName),
                            subtitle: Text(otherUser.mail),
                          ),
                        );
                      }
                    });
              });
        }
      },
    );
  }
}
