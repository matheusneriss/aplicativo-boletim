import 'package:cloud_firestore/cloud_firestore.dart';
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
  TextEditingController _controllerQra = TextEditingController();

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
    _controllerQra.text = dados["nome de guerra"];
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
        centerTitle: true,
        title: Text("Painel Guarda"),
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
                  'Nome: ' + _controllerNome.text,
                  style: new TextStyle(
                      fontSize: 18.0),
                ),
                accountEmail: new Text(
                  'Nome de Guerra: ' + _controllerQra.text,
                  style: new TextStyle(
                      fontSize: 16.0),
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
                leading: Icon(Icons.account_box_outlined),
                onTap: () {
                  Navigator.pushNamed(context, "/meusdados");
                },
              ),
              new ListTile(
                title: new Text("Listagem dos Guardas"),
                leading: Icon(Icons.line_style_sharp),
                onTap: () {
                  Navigator.pushNamed(context, "/abaguardasvg");
                },
              ),
              new ListTile(
                title: new Text("Cadastrar pessoas"),
                leading: Icon(Icons.people_alt_outlined),
                onTap: () {
                  Navigator.pushNamed(context, "/cadastropessoa");
                },
              ),
              new ListTile(
                title: new Text("Consultar pessoas"),
                leading: Icon(Icons.list_rounded),
                onTap: () {
                  Navigator.pushNamed(context, "/listagempessoasVG");
                },
              ),
              new ListTile(
                title: new Text("Cadastrar boletim"),
                leading: Icon(Icons.add_alert_outlined),
                onTap: () {
                  Navigator.pushNamed(context, "/cadastroboletim");
                },
              ),
              new ListTile(
                title: new Text("Boletins Aprovados"),
                leading: Icon(Icons.list_alt_outlined),
                onTap: () {
                  Navigator.pushNamed(context, "/listagensboletinsaprovados");
                },
              ),
              new ListTile(
                title: new Text("Boletins Pendentes"),
                leading: Icon(Icons.list_alt_outlined),
                onTap: () {
                  Navigator.pushNamed(context, "/listagensboletinspendentes");
                },
              ),
              new ListTile(
                title: new Text("Boletins Reprovados"),
                leading: Icon(Icons.list_alt_outlined),
                onTap: () {
                  Navigator.pushNamed(context, "/listagensboletinsreprovados");
                },
              ),
              // new ListTile(
              //   title: new Text("Cadastrar Viaturas"),
              //   leading: Icon(Icons.car_rental),
              //   onTap: () {
              //     Navigator.pushNamed(context, "/cadastroviatura");
              //   },
              // ),
              new ListTile(
                title: new Text("Listagem das Viaturas"),
                leading: Icon(Icons.policy_rounded),
                onTap: () {
                  Navigator.pushNamed(context, "/listagemviaturasVG");
                },
              ),
              Divider(
                color: Colors.black,
                thickness: 0.5,
              ),
              new ListTile(
                title: new Text("Sair"),
                leading: Icon(Icons.logout_outlined),
                onTap: () {
                  _deslogarUsuario();
                },
              ),
            ]
        ),
      ),
      body:  Container(
        padding: EdgeInsets.all(10.0),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  "imagens/logo.png",
                  width: 300,
                  height: 300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
