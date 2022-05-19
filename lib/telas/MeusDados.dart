import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as i;

class Meusdados extends StatefulWidget {
  const Meusdados({Key? key}) : super(key: key);

  @override
  _MeusdadosState createState() => _MeusdadosState();
}

class _MeusdadosState extends State<Meusdados> {

  TextEditingController _controllerNome = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late XFile _imagem;
  late String _idUserLogado;
  bool _subindoImagem = false;
  late String? _urlImagemRecuperada = null;


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
    setState(() {
      _urlImagemRecuperada = url;
      print("erro" + url);
    });
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User userLogado = await auth.currentUser!;
    _idUserLogado = userLogado.uid;
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configurações"),),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _subindoImagem ? CircularProgressIndicator()
                    : Container(),
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
                      hintText: "Nome",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
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
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    onPressed: () {
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