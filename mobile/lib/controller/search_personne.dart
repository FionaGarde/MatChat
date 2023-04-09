import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchat/controller/FirestoreHepler.dart';
import 'package:matchat/globale.dart';
import 'package:matchat/model/utilisateur.dart';
import 'package:flutter/material.dart';

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
    //    return StreamBuilder<QuerySnapshot>(
    //       stream: FirestoreHelper().cloudUsers.snapshots(),
    //       builder: (context, snap) {
    //         List documents = snap.data?.docs ?? [];
    //         if (documents.isEmpty) {
    //           return const Center(child: CircularProgressIndicator.adaptive());
    //         } else {
    //           return ListView.builder(
    //               itemCount: documents.length,
    //               itemBuilder: (context, index) {
    //                 Utilisateur otherUser = Utilisateur(documents[index]);
    //                 if (monUtilisateur.id == otherUser.id) {
    //                   return Container();
    //                 } else {
    //                   return Card(
    //                     elevation: 5,
    //                     color: Colors.purple,
    //                     child: ListTile(
    //                       onTap: () {
    //                         //ouvrir une nouvelle page de chat todo
    //                         print("message");
    //                       },
    //                       leading: CircleAvatar(
    //                         radius: 30,
    //                         backgroundImage: NetworkImage(otherUser.avatar!),
    //                       ),
    //                       title: Text(otherUser.fullName),
    //                       subtitle: Text(otherUser.mail),
    //                     ),
    //                   );
    //                 }
    //               });
    //         }
    //       });
    // }

    return Scaffold(
        appBar: AppBar(title: const Text('test')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                ),
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    //search
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
        ));
  }
}
