import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PainelGuarda extends StatefulWidget {
  const PainelGuarda({Key? key}) : super(key: key);

  @override
  State<PainelGuarda> createState() => _PainelGuardaState();
}

class _PainelGuardaState extends State<PainelGuarda> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

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
      drawer: new Drawer(
        child: ListView(
          children: [
            new UserAccountsDrawerHeader(
                accountName: new Text(
                   "Matheus Neris Xavier Da Rocha"
                ),
                accountEmail: new Text(
                    "matheusneris2011@gmail.com"
                ),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage(
                  'https://uploads.metropoles.com/wp-content/uploads/2022/05/09154316/foto-Neymar-PSG-08052022-600x400.jpg',
                ),
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
      //body: Container(),
    );
  }
}
