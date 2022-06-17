import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/Viatura.dart';

class CadastroViatura extends StatefulWidget {
  @override
  _CadastroViaturaState createState() => _CadastroViaturaState();
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
class _CadastroViaturaState extends State<CadastroViatura> {
  TextEditingController _controllerMarca = TextEditingController();
  TextEditingController _controllerModelo = TextEditingController();
  TextEditingController _controllerNumeroviatura = TextEditingController();
  TextEditingController _controllerPlaca = TextEditingController();
  String _mensagemErro = "";

  _validarCampos(){

    //recuperar dados dos campos
    String marca = _controllerMarca.text;
    String modelo = _controllerModelo.text;
    String numeroviatura = _controllerNumeroviatura.text;
    String placa = _controllerPlaca.text;

    if(marca.isNotEmpty){
      if(modelo.isNotEmpty){
        if(numeroviatura.isNotEmpty){
          if(placa.isNotEmpty){
            setState((){
              _mensagemErro = "";
            });

            Viatura viatura = Viatura();
            viatura.placa = placa;
            viatura.numeroviatura = numeroviatura;
            viatura.modelo = modelo;
            viatura.marca = marca;

            _cadastrarViatura(viatura);
          }else{

            setState((){
              _mensagemErro = "Preencha o campo Placa";
            });

          }

        }else{
          setState((){
            _mensagemErro = "Preencha o campo Número da viatura";
          });

        }

      }else{
        setState((){
          _mensagemErro = "Preencha o campo Modelo";
        });

      }

    }else{
      setState((){
        _mensagemErro = "Preencha o campo Marca";
      });
    }
  }

  _cadastrarViatura(Viatura viatura){
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("Viaturas")
        .doc(viatura.placa)
        .set(viatura.toMap());
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
            _validarCampos();
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
                                color: const Color(0xFF092757),
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
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            controller: _controllerMarca,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 22,
            ),
            decoration: InputDecoration(
              labelText: "Marca",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              hintText: "Digite a marca",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            controller: _controllerModelo,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 22,
            ),
            decoration: InputDecoration(
              labelText: "Modelo",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              hintText: "Digite o modelo",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            controller: _controllerNumeroviatura,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 22,
            ),
            decoration: InputDecoration(
              labelText: "Número da viatura",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              hintText: "Digite o número da viatura",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            controller: _controllerPlaca,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 22,
            ),
            decoration: InputDecoration(
              labelText: "Placa",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              hintText: "Digite a placa",
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

