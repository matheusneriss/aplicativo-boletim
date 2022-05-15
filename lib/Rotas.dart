import 'package:flutter/material.dart';
import 'package:gcm_app/Cadastro.dart';
import 'package:gcm_app/PainelComandante.dart';
import 'package:gcm_app/PainelGuarda.dart';
import 'package:gcm_app/telas/Home.dart';

class Rotas {
  static Route<dynamic>? gerarRotas(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Home());
      case "/cadastro":
        return MaterialPageRoute(builder: (_) => Cadastro());
      case "/painel-guarda":
        return MaterialPageRoute(builder: (_) => PainelGuarda());
      case "/painel-comandante":
        return MaterialPageRoute(builder: (_) => PainelComandante());
      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela não encontrada!"),
        ),
        body: Center(
          child: Text("Tela não encontrada!"),
        ),
      );
    });
  }
}
