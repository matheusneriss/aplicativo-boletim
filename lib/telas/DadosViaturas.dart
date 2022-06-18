import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcm_app/model/Viatura.dart';

class DadosViaturas extends StatefulWidget {

  Viatura viatura;
  DadosViaturas(this.viatura);

  @override
  State<DadosViaturas> createState() => _DadosViaturasState();
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

class _DadosViaturasState extends State<DadosViaturas> {

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
                          height: 120,
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
                                    hintText: 'Alterações realizadas!',
                                    hintStyle: TextStyle(
                                      color: Colors.black, // <-- Change this
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.topCenter,
                                    child: SizedBox(
                                      width: 100.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Ok",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        color: const Color(0xFF092757),
                                      ),
                                    )
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
                    title: Text('Excluir a viatura ' + widget.viatura.placa + '?'),
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
                    _removerGuarda();
                  }
                });
              },
            ),
          ],
        ),
        body:  Padding(
    padding: EdgeInsets.all(16),
    child: Form(
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
