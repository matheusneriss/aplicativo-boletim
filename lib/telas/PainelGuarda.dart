import 'package:flutter/material.dart';

class PainelGuarda extends StatefulWidget {
  const PainelGuarda({Key? key}) : super(key: key);

  @override
  State<PainelGuarda> createState() => _PainelGuardaState();
}

class _PainelGuardaState extends State<PainelGuarda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel Guarda"),
      ),
      body: Container(),
    );
  }
}
