import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchat/controller/FirestoreHepler.dart';
import 'package:matchat/globale.dart';
import 'package:matchat/model/utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'FirestoreHepler.dart';

class SearchPersonn extends StatefulWidget {
  const SearchPersonn({Key? key}) : super(key: key);

  @override
  State<SearchPersonn> createState() => _SearchPersonnState();
}

class _SearchPersonnState extends State<SearchPersonn> {
  //enregistrer la valeur de la barre de recherche
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Card(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Rechercher une personne à ajouter aux contacts...',
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper()
            .cloudContact
            .where('pseudo1', arrayContains: monUtilisateur.pseudo)
            .snapshots(),
        builder: (context, snap) {
          List documents = snap.data?.docs ?? [];
          if (documents.isEmpty) {
            return const Center(child: Text('Aucun contact trouvé'));
          } else {
            List<String> contactPseudos = [];
            for (var doc in documents) {
              String pseudo1 = doc['pseudo1'];
              String pseudo2 = doc['pseudo2'];
              if (pseudo1 == monUtilisateur.pseudo) {
                contactPseudos.add(pseudo2);
              } else if (pseudo2 == monUtilisateur.pseudo) {
                contactPseudos.add(pseudo1);
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                backgroundImage:
                                    NetworkImage(otherUser.avatar!),
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
      ),
    );
  }
}
