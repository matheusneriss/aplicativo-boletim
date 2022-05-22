import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PainelComandante extends StatefulWidget {
  const PainelComandante({Key? key}) : super(key: key);

  @override
  State<PainelComandante> createState() => _PainelComandanteState();
}

class _PainelComandanteState extends State<PainelComandante> {
  List<String> itensMenu = [
    "Sair"
  ];

  _deslogarUsuario() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/");
  }
  _escolhaMenuItem(String escolha){

    switch(escolha){
      case "Sair" :
        _deslogarUsuario();
        break;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Painel Comandante"),
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
    body: Container()
    );
  }
}
