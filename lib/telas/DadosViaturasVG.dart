import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcm_app/model/Viatura.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DadosViaturasVG extends StatefulWidget {

  Viatura viatura;
  DadosViaturasVG(this.viatura);

  @override
  State<DadosViaturasVG> createState() => _DadosViaturasVGState();
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

class _DadosViaturasVGState extends State<DadosViaturasVG> {

  late final _controllerMarca =  TextEditingController(text: widget.viatura.marca) ;
  late final _controllerModelo =  TextEditingController(text: widget.viatura.modelo) ;
  late final _controllerNumeroviatura =  TextEditingController(text: widget.viatura.numeroviatura) ;
  late final _controllerPlaca =  TextEditingController(text: widget.viatura.placa) ;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  _removerGuarda(){
    String placa = _controllerPlaca.text;

    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String,dynamic> dadosAtualizar ={
      "excluido" : true
    };

    db.collection("Viaturas")
        .doc(placa)
        .update(dadosAtualizar);
  }

  _atualizarDadosFirestore(){
    String marca = _controllerMarca.text;
    String modelo = _controllerModelo.text;
    String numeroviatura = _controllerNumeroviatura.text;
    String placa = _controllerPlaca.text;

    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String,dynamic> dadosAtualizar ={
      "Marca" : marca,
      "Modelo" : modelo,
      "Número da viatura" : numeroviatura,
      "Placa" : placa,
    };
    db.collection("Viaturas")
        .doc(placa)
        .update(dadosAtualizar);
  }

  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('Viaturas')
        .where("excluido", isEqualTo: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dados da viatura"),
        backgroundColor: Color(0xFF092757),
      ),
      body:  Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                readOnly: true,
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
                readOnly: true,
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
                readOnly: true,
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
                readOnly: true,
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
            ],
          ),
        ),
      ),
    );
  }
}