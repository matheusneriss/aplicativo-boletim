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
        title: Text('Redefinir senha'),),
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
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
            Text("Por favor, informe o E-mail associado a sua conta que enviaremos um link para o mesmo com as instruções para restauração da sua senha.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
              textAlign: TextAlign.center,
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RaisedButton(
            child: Text('Send Request'),
            onPressed: () {
              auth.sendPasswordResetEmail(email: _controllerEmail.text);
              Navigator.of(context).pop();
            },
            color: Theme.of(context).accentColor,
          ),

        ],
      ),
          ],
        ),
      ),

    );
  }
}