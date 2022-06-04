import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gcm_app/model/Usuario.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DadosGuardas extends StatefulWidget {

  Usuario guarda;
  DadosGuardas(this.guarda);

  @override
  State<DadosGuardas> createState() => _DadosGuardasState();
}

class _DadosGuardasState extends State<DadosGuardas> {

  late final _controllerNome =  TextEditingController(text: widget.guarda.nome) ;
  late final _controllerQra =  TextEditingController(text: widget.guarda.qra) ;
  late final _controllerCpf =  TextEditingController(text: widget.guarda.cpf) ;
  late final _controllerCelular =  TextEditingController(text: widget.guarda.celular) ;
  late final _controllerMatricula =  TextEditingController(text: widget.guarda.matricula) ;
  late final _controllerDatanascimento =  TextEditingController(text: widget.guarda.datanascimento) ;
  late final _controllerEmail =  TextEditingController(text: widget.guarda.email) ;

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
        .doc()
        .update(dadosAtualizar);
  }

  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('Guardas')
        .where('excluido', isEqualTo: false);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Dados do Guarda"),
          backgroundColor: Color(0xFF092757),
          actions: [
            IconButton(
              icon: Icon(Icons.save_outlined),
              onPressed: (){
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
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir o guarda ' + widget.guarda.nome + '?'),
                    content: Text('Tem certeza?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Não'),
                        onPressed: () =>
                            Navigator.of(context).pop(false),
                      ),
                      FlatButton(
                        child: Text('Sim'),
                        onPressed: () =>
                            Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ).then((confirmed) async {
                  if (confirmed) {
                      FirebaseFirestore db = FirebaseFirestore.instance;
                      Map<String,dynamic> dadosAtualizar ={
                        "excluido" : true
                      };
                      db.collection("Guardas")
                          .doc()
                          .update(dadosAtualizar);
                  }
                });
              },
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
                child: Column(
                    children: [ CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(widget.guarda.urlImagem),
                    ),
                      Padding(padding: EdgeInsets.all(10)),
                      Padding(padding: EdgeInsets.only(bottom: 8),
                        child: TextField(
                          controller: _controllerNome,
                          readOnly: true,
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
                          controller: _controllerQra,
                          readOnly: true,
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
                          readOnly: true,
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

                    ])
            ),
          ),
        )
    );
  }
}
