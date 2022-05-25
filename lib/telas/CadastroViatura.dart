import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gcm_app/model/Viatura.dart';

class CadastroViatura extends StatefulWidget {
  const CadastroViatura({Key? key}) : super(key: key);

  @override
  State<CadastroViatura> createState() => _CadastroViaturaState();
}

class _CadastroViaturaState extends State<CadastroViatura> {

  //Controladores
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
        .add(viatura.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro viatura",
        ),
        backgroundColor: Color(0xFF092757),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                controller: _controllerMarca,
                  autofocus: true,
                  // inputFormatters: [maskDataNascimento],
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 10, 32, 10),
                      hintText: "Marca",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                ),
                TextField(
               controller: _controllerModelo,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 10, 32, 10),
                      hintText: "Modelo",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                ),
                TextField(
                  controller: _controllerNumeroviatura,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 10, 32, 10),
                      hintText: "Número da viatura",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                ),
                TextField(
                  controller: _controllerPlaca,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 10, 32, 10),
                      hintText: "Placa",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Color.fromARGB(255, 6, 134, 49),
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    onPressed: () {
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
                                             hintText: 'Cadastro realizado com sucesso!',
                                         )
                                     ),
                                     SizedBox(
                                       width: 320.0,
                                       child: RaisedButton(
                                         onPressed: () {
                                           Navigator.of(context).pop();
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
                         });
                    },
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
          ),
        ),
      ),
    );
  }
}
