import 'dart:typed_data';

import 'package:matchat/controller/FirestoreHepler.dart';
import 'package:matchat/controller/liste_personne.dart';
import 'package:matchat/globale.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:matchat/model/utilisateur.dart';

class Message extends StatefulWidget {
  String expediteur;
  String destinataire;
  String message;
  Message({Key? key, required this.expediteur, required this.destinataire, required this.message})
      : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  //variable
  int indexCurrent = 1;
  PageController controllerPage = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: MyDrawer()),
      appBar: AppBar(
        title: Text(monUtilisateur.fullName),
      ),
      body: bodyPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexCurrent,
        onTap: (value) {
          setState(() {
            indexCurrent = value;
            controllerPage.jumpToPage(value);
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Personnes"),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit_outlined), label: "Favoris"),
          BottomNavigationBarItem(
              icon: Icon(Icons.back_hand), label: "Nouveau"),
        ],
      ),
    );
  }

  Widget bodyPage() {
    return PageView(
      controller: controllerPage,
      onPageChanged: (value) {
        setState(() {
          controllerPage.jumpToPage(value);
          indexCurrent = value;
        });
      },
      children: const [
        ListPersonn(),
      ],
    );
  }
}

class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyDrawerState();
  }
}

class MyDrawerState extends State<MyDrawer> {
  //variable
    String? expediteur;
    String? destinataire;
    String? message;
    DateTime? date_add;

  //méthode

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(children: [
        //bulle de message
      
      ]),
    );
  }
}
