import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/Usuario.dart';


class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  TextEditingController _controllerEmail = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redefinir senha'),
        backgroundColor: Color(0xFF092757),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 40,
          right:  40
        ),
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset("imagens/cadeado.png"),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Esqueceu sua senha?",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight .w500,
            ),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text("Por favor, informe o E-mail associado a sua conta que enviaremos um link para o mesmo com as instruções para restauração da sua senha.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 10,
            ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintText: 'Email'
          ),
          onChanged: (value) {
            setState(() {
              _controllerEmail.text = value.trim();
            });
          },
        ),
      Padding(padding: EdgeInsets.all(10)),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RaisedButton(
            color: Color(0xFF092757),
            child: Text('Enviar solicitação',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),),
            onPressed: () {
              auth.sendPasswordResetEmail(email: _controllerEmail.text);
              Navigator.of(context).pop();
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
                                    hintText: 'Senha enviada com sucesso para o e-mail'),
                              ),
                              SizedBox(
                                width: 320.0,
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/");
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
                  });
            },
          ),

        ],
      ),
          ],
        ),
      ),

    );
  }
}