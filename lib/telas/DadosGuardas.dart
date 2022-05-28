import 'package:flutter/material.dart';
import 'package:gcm_app/model/Usuario.dart';

class DadosGuardas extends StatefulWidget {

  Usuario guarda;
  DadosGuardas(this.guarda);

  @override
  State<DadosGuardas> createState() => _DadosGuardasState();
}

class _DadosGuardasState extends State<DadosGuardas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dados do Guarda"),
        backgroundColor: Color(0xFF092757),
      ),
      body: CircleAvatar(
        backgroundImage: NetworkImage(widget.guarda.urlImagem),
      ),
    );
  }
}
