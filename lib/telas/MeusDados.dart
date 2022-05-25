import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as i;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class Meusdados extends StatefulWidget {
  const Meusdados({Key? key}) : super(key: key);

  @override
  _MeusdadosState createState() => _MeusdadosState();
}

class _MeusdadosState extends State<Meusdados> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerCpf = TextEditingController();
  TextEditingController _controllerCelular = TextEditingController();
  TextEditingController _controllerMatricula = TextEditingController();
  TextEditingController _controllerDatanascimento = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerQra = TextEditingController();


  final ImagePicker _picker = ImagePicker();
  late XFile _imagem;
  late String _idUserLogado;
  bool _subindoImagem = false;
  late String? _urlImagemRecuperada = null;

  var maskCellphone= new MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  var maskCPF= new MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  var maskDataNascimento= new MaskTextInputFormatter(
      mask: '##/##/####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );


  Future _recuperarImagem(String origemImagem) async{
    late XFile imagemSelecionada;
    switch(origemImagem){
      case "camera":
        imagemSelecionada = (await _picker.pickImage(source: ImageSource.camera))!;
        break;
      case "galeria" :
        imagemSelecionada = (await _picker.pickImage(source: ImageSource.gallery))!;
        break;
    }

    setState(() {
      _imagem = imagemSelecionada;
      if( _imagem != null){
        _subindoImagem = true;
        _uploadImagem();
      }
    });
  }

  Future _uploadImagem() async{
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo = pastaRaiz
        .child("perfil")
        .child(_idUserLogado + ".jpg");

    //Upload da imagem
    UploadTask task = arquivo.putFile(i.File(_imagem.path));

    //Controlar o progresso do upload
    task.snapshotEvents.listen((event) {
      if(event.state == TaskState.running){
        setState(() {
          _subindoImagem = true;
        });
      }else if(event.state == TaskState.success){
        _subindoImagem = false;
      }
    });

    //Recuperar a url
    task.then((TaskSnapshot snapshot) {
      _recuperarUrlImagem(snapshot);
    });
  }

  Future _recuperarUrlImagem(TaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    _atualizarUrlImagemFirestore(url);

    setState(() {
      _urlImagemRecuperada = url;
      print("erro" + url);
    });
  }

  _atualizarUrlImagemFirestore(String url){
    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String,dynamic> dadosAtualizar ={
      "urlImagem" : url
    };

    db.collection("Guardas")
    .doc(_idUserLogado)
    .update(dadosAtualizar);
  }

  _atualizarDadosFirestore(){
    String nome = _controllerNome.text;
    String cpf = _controllerCpf.text;
    String celular = _controllerCelular.text;
    String matricula = _controllerMatricula.text;
    String datanascimento = _controllerDatanascimento.text;
    String email = _controllerEmail.text;
    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String,dynamic> dadosAtualizar ={
      "nome" : nome,
      "cpf" : cpf,
      "celular" : celular,
      "matricula" : matricula,
      "data de nascimento" : datanascimento,
      "email" : email
    };

    db.collection("Guardas")
        .doc(_idUserLogado)
        .update(dadosAtualizar);
  }


  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User userLogado = await auth.currentUser!;
    FirebaseFirestore db = FirebaseFirestore.instance;
    _idUserLogado = userLogado.uid;

    User? usuarioLogado = await auth.currentUser;
    DocumentSnapshot snapshot = await db.collection("Guardas").doc(usuarioLogado!.uid).get();

    dynamic dados = snapshot.data();
    _controllerNome.text = dados["nome"];
    _controllerCpf.text = dados["cpf"];
    _controllerCelular.text = dados["celular"];
    _controllerMatricula.text = dados["matricula"];
    _controllerDatanascimento.text = dados["data de nascimento"];
    _controllerEmail.text =dados["email"];
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
      appBar: AppBar(title:
      Text("Meus Dados"),
        backgroundColor: Color(0xFF092757),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: _subindoImagem ? CircularProgressIndicator()
                      : Container(),
                ),
                CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                    _urlImagemRecuperada == null
                        ? NetworkImage("https://firebasestorage.googleapis.com/v0/b/whatsapp-8de85.appspot.com/o/perfil%2Favatar_padrao.jpg?alt=media&token=d3f4446e-62de-46c6-85d3-ae954eb86909"):
                    NetworkImage(_urlImagemRecuperada!)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        onPressed: () async { _recuperarImagem("camera");},
                        child: Text("Câmera")),
                    FlatButton(
                        onPressed: () async { _recuperarImagem("galeria");},
                        child: Text("Galeria")),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      labelText: "Nome",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    readOnly: true,
                    controller: _controllerQra,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      labelText: "Nome de guerra",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerCpf,
                    inputFormatters: [maskCPF],
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      labelText: "CPF",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerCelular,
                    inputFormatters: [maskCellphone],
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      labelText: "Celular",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    readOnly: true,
                    controller: _controllerMatricula,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      labelText: "Matrícula",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerDatanascimento,
                    inputFormatters: [maskDataNascimento],
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      labelText: "Data de Nascimento",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      labelText: "E-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                      "Salvar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Color(0xFF092757),
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    onPressed: () {
                      _atualizarDadosFirestore();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0)), //this right here
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextField(
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Dados salvos com sucesso!'),
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          color: const Color(0xFF1BC0C5),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}