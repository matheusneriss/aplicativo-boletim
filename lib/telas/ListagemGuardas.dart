import 'package:flutter/material.dart';

import 'AbaGuardas.dart';

class Guardaslistagem extends StatefulWidget {
  const Guardaslistagem({Key? key}) : super(key: key);

  @override
  State<Guardaslistagem> createState() => _GuardaslistagemState();
}

class _GuardaslistagemState extends State<Guardaslistagem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Listagem dos Guardas"),
    ),
      body: Container(
        child:AbaContatos()
      ),
    );
  }
}
