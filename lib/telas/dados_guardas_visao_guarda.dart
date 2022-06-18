import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gcm_app/model/Usuario.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DadosGuardasVG extends StatefulWidget {

  Usuario guarda;
  DadosGuardasVG(this.guarda);

  @override
  State<DadosGuardasVG> createState() => _DadosGuardasVGState();
}

class _DadosGuardasVGState extends State<DadosGuardasVG> {

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

  _removerGuarda(){
    String cpf = _controllerCpf.text;

    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String,dynamic> dadosAtualizar ={
      "cpf" : cpf,
      "excluido" : true
    };
    Usuario usuario = Usuario();
    db.collection("Guardas")
        .doc(cpf)
        .update(dadosAtualizar);
  }

  _atualizarDadosFirestore(){
    String nome = _controllerNome.text;
    String cpf = _controllerCpf.text;
    String celular = _controllerCelular.text;
    String qra = _controllerQra.text;
    String matricula = _controllerMatricula.text;
    String datanascimento = _controllerDatanascimento.text;
    String email = _controllerEmail.text;
    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String,dynamic> dadosAtualizar ={
      "nome" : nome,
      "cpf" : cpf,
      "nome de guerra" : qra,
      "celular" : celular,
      "matricula" : matricula,
      "data de nascimento" : datanascimento,
      "email" : email
    };
    Usuario usuario = Usuario();
    db.collection("Guardas")
        .doc(cpf)
        .update(dadosAtualizar);
  }

  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('Guardas')
        .where("excluido", isEqualTo: false);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Dados do Guarda"),
          backgroundColor: Color(0xFF092757),
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
                          readOnly: true,
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
                            labelText: "Nome de Guerra",
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
                          keyboardType: TextInputType.number,
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
                          readOnly: true,
                          controller: _controllerCelular,
                          inputFormatters: [maskCellphone],
                          autofocus: true,
                          keyboardType: TextInputType.number,
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
                          keyboardType: TextInputType.datetime,
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
                          readOnly: true,
                          controller: _controllerEmail,
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
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
