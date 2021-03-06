import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gcm_app/telas/PainelComandante.dart';
import '../model/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'PainelGuarda.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";
  bool _carregando = false;

  _validarCampos() {
    // Recuperar dados dos campos
    String senha = _controllerSenha.text;
    String email = _controllerEmail.text;


    Usuario usuario = Usuario();
    usuario.senha = senha;
    usuario.email = email;

    _logarUsuario(usuario);

    // Validar campos
    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {

      } else {
        setState(() {
          _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o E-mail válido";
      });
    }
  }

  _logarUsuario(Usuario usuario){
    setState((){
      _carregando = true;
    });

    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){
      _redirecionaPainelTipoUsuario(firebaseUser.user!.uid);
      }).catchError((error){
      _mensagemErro = "Erro ao autenticar usuário, verifique e-mail e senha e tente novamente!";
    });

  }

  _redirecionaPainelTipoUsuario(String idUsuario) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await db.collection("Guardas")
    .doc(idUsuario)
    .get();

    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    String tipoUsuario = data["tipoUsuario"];

    setState((){
      _carregando = false;
    });

    switch(tipoUsuario){
      case "Guarda" :
      Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(
                       builder: (context) => PainelGuarda(),
                     ));
        break;
      case "Comandante" :
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PainelComandante(),
            ));
        break;
    }

  }

    Future _verificarUsuarioLogado() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      FirebaseAuth auth = FirebaseAuth.instance;
      User? usuarioLogado = await auth.currentUser;
      if(usuarioLogado!=null){
        String idUsuario = usuarioLogado.uid;
        _redirecionaPainelTipoUsuario(idUsuario);
      }
  }

  @override
  void initState(){
    super.initState();
    _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("imagens/fundo.png"), fit: BoxFit.cover)),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "imagens/logo.png",
                    width: 200,
                    height: 220,
                  ),
                ),
                TextField(
                  controller: _controllerEmail,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 10, 32, 10),
                      hintText: "E-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                ),
                TextField(
                  controller: _controllerSenha,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 10, 32, 10),
                      hintText: "Senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Color.fromARGB(255, 6, 134, 49),
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    onPressed: () {
                      _validarCampos();
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Esqueceu sua senha?",
                      style: TextStyle(
                        decoration:  TextDecoration.underline,
                        color: Color.fromARGB(255, 6, 134, 49),
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, "/recuperarsenha");
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.all(7)),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Não tem conta? cadastre-se!",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/cadastro");
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                _carregando ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ): Container(),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
