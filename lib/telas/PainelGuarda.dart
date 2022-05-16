import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PainelGuarda extends StatefulWidget {
  const PainelGuarda({Key? key}) : super(key: key);

  @override
  State<PainelGuarda> createState() => _PainelGuardaState();
}

class _PainelGuardaState extends State<PainelGuarda> {

  List<String> itensMenu = [
    "Configurações", "Deslogar"
  ];

  _deslogarUsuario() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/");
  }
  _escolhaMenuItem(String escolha){

  switch(escolha){
    case "Deslogar" :
      _deslogarUsuario();
      break;
    case "Configurações" :

      break;
  }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel Guarda"),
        actions: [
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context){

              return itensMenu.map((String item){
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();

            },
          )
        ],
      ),
      body: Container(),
    );
  }
}
