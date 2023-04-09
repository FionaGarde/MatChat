import 'dart:typed_data';

import 'package:matchat/controller/FirestoreHepler.dart';
import 'package:matchat/controller/liste_personne.dart';
import 'package:matchat/globale.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:matchat/model/utilisateur.dart';

class Contact extends StatefulWidget {
  String pseudo;
  Contact({Key? key, required this.pseudo})
      : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
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


  class MyDrawerState extends State<MyDrawer> {
    //variable
    String? pseudo;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(children: [

      
      ]),
    );
  }
}
