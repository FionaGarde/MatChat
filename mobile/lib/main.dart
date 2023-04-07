import 'package:matchat/controller/FirestoreHepler.dart';
import 'package:matchat/controller/home_page.dart';
import 'package:matchat/controller/permission_helper.dart';
import 'package:matchat/globale.dart';
import 'package:matchat/view/dashboard_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PermissionHelper().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MatChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //variables
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController nom = TextEditingController();
  List<bool> selection = [true, false];

  late TextEditingController controller;
  late LanguageIdentifier _languageIdentifier;
  late OnDeviceTranslator translator;
  String simpleLang = "";
  String mutlipleLang = "";
  String traductionText = "";

  //Méthode
  popUp() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          if (defaultTargetPlatform == TargetPlatform.iOS) {
            return CupertinoAlertDialog(
              title: const Text("Erreur"),
              content: const Text(
                  "Votre email et/ou votre mot de passe sont incorrectes"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("ok"))
              ],
            );
          } else {
            return AlertDialog(
              title: const Text("Erreur"),
              content: const Text(
                  "Votre email et/ou votre mot de passe sont incorrectes"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("ok"))
              ],
            );
          }
        });
  }

  getUniqueLanguage() async {
    simpleLang = "";
    String phrase = controller.text;
    if(phrase == "") return;
    final langage = await _languageIdentifier.identifyLanguage(phrase);
    setState(() {
      simpleLang = langage;
    });

  }

  getMultipleLanguage() async{
    mutlipleLang = "";
    String phrase = controller.text;
    if(phrase == "") return;
    final multiple = await _languageIdentifier.identifyPossibleLanguages(phrase);
    if(multiple.isEmpty){
      setState(() {
        mutlipleLang = "Nous n'avons pas trouvé aucune correspondance";
      });

    }
    else
      {
        for(var lang in multiple){
          setState(() {
            mutlipleLang += "${lang.languageTag}, avec une confiance de : ${lang.confidence *100}%";
          });

        }
      }

  }

  traduction() async{
    traductionText = "";
    if(controller.text == "") return;
    String phrase = controller.text;
    final tr = await translator.translateText(phrase);
    setState(() {
      traductionText = tr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("MatChat Messaging application"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: bodyPage(),
        ));
  }

  Widget bodyPage() {
    //image
    //entrer mail
    //entrer le mot de passe
    //bouton de validation

    // Row --> met les élements en ligne
    //Stack --> empile le widgets
    //Text
    //ElevatedButton
    //Container
    //Image
    //Texfield
    //Icon
    //listView
    return Column(
      children: [
        ToggleButtons(
            selectedColor: Colors.green,
            onPressed: (int choix) {
              if (choix == 0) {
                setState(() {
                  selection[0] = true;
                  selection[1] = false;
                });
              } else {
                setState(() {
                  selection[0] = false;
                  selection[1] = true;
                });
              }
            },
            isSelected: selection,
            children: const [Text("Connexion"), Text("Inscription")]),
        //image
        const SizedBox(height: 10),
        Image.network(
            "https://www.auto-moto.com/wp-content/uploads/sites/9/2022/02/01-peugeot-208-750x410.jpg"),
        const SizedBox(height: 10),

        //prenom

        (selection[0] == false)
            ? TextField(
                controller: prenom,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: "Entrer votre prénom"),
              )
            : Container(),
        const SizedBox(height: 10),

        //nom

        (selection[0] == false)
            ? TextField(
                controller: nom,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: "Entrer votre nom"),
              )
            : Container(),
        const SizedBox(height: 10),

        //mail
        TextField(
          controller: mail,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: "Entrer votre mail"),
        ),
        const SizedBox(height: 10),

        //password
        TextField(
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: "Entrer votre password"),
        ),
        const SizedBox(height: 10),

        //bouton
        ElevatedButton(
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            onPressed: () {
              if (selection[0] == false) {
                //si on en mode inscription
                FirestoreHelper()
                    .Inscription(
                        mail.text, password.text, nom.text, prenom.text)
                    .then((value) {
                  //si la méthode fonctionne bien
                  setState(() {
                    monUtilisateur = value;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DashBoardView(
                        mail: mail.text, password: password.text);
                  }));
                }).catchError((onError) {
                  //si on constate une erreur
                  popUp();
                });
              } else {
                //si en mode connexion
                FirestoreHelper()
                    .Connect(mail.text, password.text)
                    .then((value) {
                  setState(() {
                    monUtilisateur = value;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DashBoardView(
                        mail: mail.text, password: password.text);
                  }));
                }).catchError((onError) {
                  popUp();
                });
              }
            },
            child: const Text("Validation"))
      ],
    );
  }

  @override
  void initState() {
    controller = TextEditingController();
    _languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.3);
    translator = OnDeviceTranslator(sourceLanguage: TranslateLanguage.french, targetLanguage: TranslateLanguage.croatian);
    super.initState();
  }

  @override
  void dispose() {
    _languageIdentifier.close();
    translator.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: controller,

            ),


            Text("une langue identifié : $simpleLang"),

            Text("les langues identifiées  : $mutlipleLang"),

            Text("Message traduit  : $traductionText"),

            ElevatedButton(
                onPressed: getUniqueLanguage,

                child: const Text("Idenfier la langue")
            ),

            ElevatedButton(
                onPressed: getMultipleLanguage,

                child: const Text("Idenfier les langues")
            ),
            ElevatedButton(
                onPressed: traduction,

                child: const Text("Traduire de français en croate")
            ),



          ],
        ),
      ),

    );
  }
}
