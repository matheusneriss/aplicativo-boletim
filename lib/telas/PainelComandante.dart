import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PainelComandante extends StatefulWidget {
  const PainelComandante({Key? key}) : super(key: key);

  @override
  State<PainelComandante> createState() => _PainelComandanteState();
}

class _PainelComandanteState extends State<PainelComandante> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  late String? _urlImagemRecuperada = null;

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

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    User? usuarioLogado = await auth.currentUser;
    DocumentSnapshot snapshot = await db.collection("Guardas").doc(usuarioLogado!.uid).get();

    dynamic dados = snapshot.data();
    _controllerNome.text = dados["nome"];
    _controllerEmail.text =dados["email"];
    setState(() {
      _urlImagemRecuperada = "${(dados as dynamic)["urlImagem"]}";
    });

  }
  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Painel Comandante"),
          backgroundColor: Color(0xFF092757),
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
      drawer: new Drawer(
        child: ListView(
            children: [
              new UserAccountsDrawerHeader(
                accountName: new Text(
                    _controllerNome.text
                ),
                accountEmail: new Text(
                    _controllerEmail.text
                ),
                currentAccountPicture: new CircleAvatar(
                    backgroundImage:
                    _urlImagemRecuperada == null
                        ? NetworkImage("https://firebasestorage.googleapis.com/v0/b/whatsapp-8de85.appspot.com/o/perfil%2Favatar_padrao.jpg?alt=media&token=d3f4446e-62de-46c6-85d3-ae954eb86909"):
                    NetworkImage(_urlImagemRecuperada!)
                ),
              ),
              new ListTile(
                title: new Text("Meus Dados"),
                onTap: () {
                  Navigator.pushNamed(context, "/meusdados");
                },
              ),
              new ListTile(
                title: new Text("Listagem dos Guardas"),
                onTap: () {
                  Navigator.pushNamed(context, "/abaguardas");
                },
              ),
              new ListTile(
                title: new Text("Cadastrar pessoas"),
                onTap: () {
                  Navigator.pushNamed(context, "/meusdados");
                },
              ),
              new ListTile(
                title: new Text("Consultar pessoas"),
                onTap: () {
                  Navigator.pushNamed(context, "/meusdados");
                },
              ),
              new ListTile(
                title: new Text("Cadastrar boletim"),
                onTap: () {
                  Navigator.pushNamed(context, "/meusdados");
                },
              ),
              new ListTile(
                title: new Text("Consultar boletins"),
                onTap: () {
                  Navigator.pushNamed(context, "/meusdados");
                },
              ),
              new ListTile(
                title: new Text("Viaturas"),
                onTap: () {
                  Navigator.pushNamed(context, "/cadastroviatura");
                },
              ),
              new ListTile(
                title: new Text("Consultar Viaturas"),
                onTap: () {
                  Navigator.pushNamed(context, "/meusdados");
                },
              ),
              new ListTile(
                title: new Text("Sair"),
                onTap: () {
                  _deslogarUsuario();
                },
              ),
            ]
        ),
      ),
    );
  }
}
