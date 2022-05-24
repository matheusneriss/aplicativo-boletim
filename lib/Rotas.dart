import 'package:flutter/material.dart';
import 'package:gcm_app/telas/AbaGuardas.dart';
import 'package:gcm_app/telas/Cadastro.dart';
import 'package:gcm_app/telas/MeusDados.dart';
import 'package:gcm_app/telas/PainelComandante.dart';
import 'package:gcm_app/telas/PainelGuarda.dart';
import 'package:gcm_app/telas/Home.dart';
import 'package:gcm_app/telas/Recuperar_senha.dart';

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
      case "/recuperarsenha":
        return MaterialPageRoute(builder: (_) => ResetScreen());
      case "/abaguardas":
        return MaterialPageRoute(builder: (_) => AbaContatos());
      case "/meusdados":
        return MaterialPageRoute(builder: (_) => Meusdados());
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
