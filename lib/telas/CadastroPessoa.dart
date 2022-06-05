import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/Viatura.dart';

class CadastroPessoa extends StatefulWidget {
  @override
  _CadastroPessoaState createState() => _CadastroPessoaState();
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
class _CadastroPessoaState extends State<CadastroPessoa> {
  TextEditingController _controllerDatanascimento = TextEditingController();
  TextEditingController _controllerCor = TextEditingController();
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerLogradouro = TextEditingController();
  TextEditingController _controllerBairro = TextEditingController();
  TextEditingController _controllerNumero = TextEditingController();
  TextEditingController _controllerCep = TextEditingController();
  TextEditingController _controllerRg = TextEditingController();
  TextEditingController _controllerCpf = TextEditingController();
  TextEditingController _controllerUf = TextEditingController();
  TextEditingController _controllerNomedopai = TextEditingController();
  TextEditingController _controllerNomedamae = TextEditingController();
  TextEditingController _controllerNaturalidade = TextEditingController();
  TextEditingController _controllerProfissao = TextEditingController();
  TextEditingController _controllerUfrg = TextEditingController();
  TextEditingController _controllerNumcnh = TextEditingController();
  TextEditingController _controllerCatcnh = TextEditingController();
  TextEditingController _controllerExamecnh = TextEditingController();
  TextEditingController _controllerNumregistro = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();
  TextEditingController _controllerCelular = TextEditingController();
  TextEditingController _controllerMunicipio = TextEditingController();
  TextEditingController _controllerEstadoNascimento = TextEditingController();
  String _mensagemErro = "";


  // _validarCampos(){
  //
  //   //recuperar dados dos campos
  //   String marca = _controllerMarca.text;
  //   String modelo = _controllerModelo.text;
  //   String numeroviatura = _controllerNumeroviatura.text;
  //   String placa = _controllerPlaca.text;
  //
  //   if(marca.isNotEmpty){
  //     if(modelo.isNotEmpty){
  //       if(numeroviatura.isNotEmpty){
  //         if(placa.isNotEmpty){
  //           setState((){
  //             _mensagemErro = "";
  //           });
  //
  //           Viatura viatura = Viatura();
  //           viatura.placa = placa;
  //           viatura.numeroviatura = numeroviatura;
  //           viatura.modelo = modelo;
  //           viatura.marca = marca;
  //
  //           _cadastrarViatura(viatura);
  //         }else{
  //
  //           setState((){
  //             _mensagemErro = "Preencha o campo Placa";
  //           });
  //
  //         }
  //
  //       }else{
  //         setState((){
  //           _mensagemErro = "Preencha o campo Número da viatura";
  //         });
  //
  //       }
  //
  //     }else{
  //       setState((){
  //         _mensagemErro = "Preencha o campo Modelo";
  //       });
  //
  //     }
  //
  //   }else{
  //     setState((){
  //       _mensagemErro = "Preencha o campo Marca";
  //     });
  //   }
  // }

  _cadastrarViatura(Viatura viatura){
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("Viaturas")
        .add(viatura.toMap());
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _progress = false;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cadastro"),
        backgroundColor: Color(0xFF092757),
        actions: [
          IconButton(onPressed: (){
            // _validarCampos();
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
          }, icon: Icon(Icons.save_outlined))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _body(context),
      ),
    );
  }

  _body(BuildContext context) {

    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _controllerNome,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Nome",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o nome",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerCpf,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "CPF",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o CPF",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerRg,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "RG",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o RG",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerNumcnh,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Nº CNH",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a CNH",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerCatcnh,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Categoria",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a categoria",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),TextFormField(
            controller: _controllerExamecnh,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Exame médico",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o exame médico",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerDatanascimento,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Data de nascimento",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a data de nascimento",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerNomedamae,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Nome da mãe",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o nome da mãe",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerNomedopai,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Nome do pai",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o nome do pai",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
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
    );
  }
}

