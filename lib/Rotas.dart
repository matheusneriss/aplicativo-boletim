import 'package:flutter/material.dart';
import 'package:gcm_app/telas/Cadastro.dart';
import 'package:gcm_app/telas/CadastroBoletim.dart';
import 'package:gcm_app/telas/CadastroPessoa.dart';
import 'package:gcm_app/telas/CadastroViatura.dart';
import 'package:gcm_app/telas/DadosGuardas.dart';
import 'package:gcm_app/telas/DadosPessoas.dart';
import 'package:gcm_app/telas/DadosPessoasVG.dart';
import 'package:gcm_app/telas/DadosViaturas.dart';
import 'package:gcm_app/telas/DadosViaturasVG.dart';
import 'package:gcm_app/telas/ListagemGuardas.dart';
import 'package:gcm_app/telas/ListagemGuardasVG.dart';
import 'package:gcm_app/telas/ListagemPessoas.dart';
import 'package:gcm_app/telas/ListagemPessoasVG.dart';
import 'package:gcm_app/telas/ListagemViaturas.dart';
import 'package:gcm_app/telas/ListagemViaturasVG.dart';
import 'package:gcm_app/telas/MeusDados.dart';
import 'package:gcm_app/telas/PainelComandante.dart';
import 'package:gcm_app/telas/PainelGuarda.dart';
import 'package:gcm_app/telas/Home.dart';
import 'package:gcm_app/telas/Recuperar_senha.dart';
import 'package:gcm_app/telas/dados_guardas_visao_guarda.dart';

class Rotas {
  static Route<dynamic>? gerarRotas(RouteSettings settings) {

    dynamic args = settings.arguments;

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
        return MaterialPageRoute(builder: (_) => Guardaslistagem());
      case "/meusdados":
        return MaterialPageRoute(builder: (_) => Meusdados());
        case "/cadastroviatura":
        return MaterialPageRoute(builder: (_) => CadastroViatura());
      case "/dadosguardas":
        return MaterialPageRoute(builder: (_) => DadosGuardas(args));
      case "/dadosviaturas":
        return MaterialPageRoute(builder: (_) => DadosViaturas(args));
      case "/dadosviaturasVG":
        return MaterialPageRoute(builder: (_) => DadosViaturasVG(args));
      case "/dadospessoas":
        return MaterialPageRoute(builder: (_) => DadosPessoas(args));
      case "/dadospessoasVG":
        return MaterialPageRoute(builder: (_) => DadosPessoasVG(args));
      case "/listagemviaturas":
        return MaterialPageRoute(builder: (_) => Viaturaslistagem());
      case "/listagemviaturasVG":
        return MaterialPageRoute(builder: (_) => ViaturaslistagemVG());
      case "/abaguardasvg":
        return MaterialPageRoute(builder: (_) => GuardaslistagemVG());
      case "/listagempessoas":
        return MaterialPageRoute(builder: (_) => Pessoaslistagem());
      case "/listagempessoasVG":
        return MaterialPageRoute(builder: (_) => PessoaslistagemVG());
      case "/cadastropessoa":
        return MaterialPageRoute(builder: (_) => CadastroPessoa());
      case "/cadastroboletim":
        return MaterialPageRoute(builder: (_) => CadastroBoletim());
      case "/dadosguardasVg":
        return MaterialPageRoute(builder: (_) => DadosGuardasVG(args));

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
