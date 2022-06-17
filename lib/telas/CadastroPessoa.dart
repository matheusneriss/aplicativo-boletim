import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../model/Pessoa.dart';

class CadastroPessoa extends StatefulWidget {
  @override
  _CadastroPessoaState createState() => _CadastroPessoaState();
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
class _CadastroPessoaState extends State<CadastroPessoa> {

  TextEditingController _controllerDatanascimento = TextEditingController();
  TextEditingController _controllerCor = TextEditingController();
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerLogradouro = TextEditingController();
  TextEditingController _controllerBairro = TextEditingController();
  TextEditingController _controllerNumero = TextEditingController();
  TextEditingController _controllerCep = TextEditingController();
  TextEditingController _controllerRg = TextEditingController();
  TextEditingController _controllerCpf = TextEditingController();
  TextEditingController _controllerUf = TextEditingController();
  TextEditingController _controllerNomedopai = TextEditingController();
  TextEditingController _controllerNomedamae = TextEditingController();
  TextEditingController _controllerNaturalidade = TextEditingController();
  TextEditingController _controllerProfissao = TextEditingController();
  TextEditingController _controllerUfrg = TextEditingController();
  TextEditingController _controllerNumcnh = TextEditingController();
  TextEditingController _controllerCatcnh = TextEditingController();
  TextEditingController _controllerExamecnh = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();
  TextEditingController _controllerCelular = TextEditingController();
  TextEditingController _controllerMunicipio = TextEditingController();
  TextEditingController _controllerEstadoNascimento = TextEditingController();
  String _mensagemErro = "";

  var maskCellphone= new MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  var maskCPF= new MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  var maskTelefone= new MaskTextInputFormatter(
      mask: '(##) ####-####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  var maskRG= new MaskTextInputFormatter(
      mask: '###.###.###-#',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  var maskCep= new MaskTextInputFormatter(
      mask: '#####-###',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );


  var maskDataNascimento= new MaskTextInputFormatter(
      mask: '##/##/####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  _validarCampos(){
    //recuperar dados dos campos
    String datanascimento = _controllerDatanascimento.text;
    String cor = _controllerCor.text;
    String nome = _controllerNome.text;
    String logradouro = _controllerLogradouro.text;
    String bairro = _controllerBairro.text;
    String numero = _controllerNumero.text;
    String cep = _controllerCep.text;
    String rg = _controllerRg.text;
    String cpf = _controllerCpf.text;
    String uf = _controllerUf.text;
    String nomepai = _controllerNomedopai.text;
    String nomemae = _controllerNomedamae.text;
    String naturalidade = _controllerNaturalidade.text;
    String profissao = _controllerProfissao.text;
    String ufrg = _controllerUfrg.text;
    String numcnh = _controllerNumcnh.text;
    String catcnh = _controllerCatcnh.text;
    String examecnh = _controllerExamecnh.text;
    String telefone = _controllerTelefone.text;
    String celular = _controllerCelular.text;
    String municipio = _controllerMunicipio.text;
    String estadonascimento = _controllerEstadoNascimento.text;

    bool isValidDate(String datanascimento) {
      try {
        DateTime.parse(datanascimento);
        return true;
      } catch (e) {
        return false;
      }
    }

    if(datanascimento.isNotEmpty && !isValidDate(datanascimento)){
      if(cor.isNotEmpty){
        if(nome.isNotEmpty){
          if(logradouro.isNotEmpty){
            setState((){
              _mensagemErro = "";
            });

            Pessoa pessoa = Pessoa();
            pessoa.datadenasicmento = datanascimento;
            pessoa.cor = cor;
            pessoa.nome = nome;
            pessoa.logradouro = logradouro;
            pessoa.bairro = bairro;
            pessoa.numero = numero;
            pessoa.cep = cep;
            pessoa.rg = rg;
            pessoa.cpf = cpf;
            pessoa.Uf = uf;
            pessoa.nomedopai = nomepai;
            pessoa.nomedamae = nomemae;
            pessoa.naturalidade = naturalidade;
            pessoa.profissao = profissao;
            pessoa.ufrg = ufrg;
            pessoa.numcnh = numcnh;
            pessoa.catcnh = catcnh;
            pessoa.examecnh = examecnh;
            pessoa.telefone = telefone;
            pessoa.celular = celular;
            pessoa.municipio = municipio;
            pessoa.estadoNascimento = estadonascimento;
            _cadastrarPessoa(pessoa);
          }else{

            setState((){
              _mensagemErro = "Preencha o campo Logradouro";
            });

          }

        }else{
          setState((){
            _mensagemErro = "Preencha o campo Nome";
          });

        }

      }else{
        setState((){
          _mensagemErro = "Preencha o campo cor";
        });

      }

    }else{
      setState((){
        _mensagemErro = "Preencha o campo e verifique se a data é valida";
      });
    }
  }

  _cadastrarPessoa(Pessoa pessoa){
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("Pessoas")
        .doc(pessoa.cpf)
        .set(pessoa.toMap());
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _progress = false;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cadastro"),
        backgroundColor: Color(0xFF092757),
        actions: [
          IconButton(onPressed: (){
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
                                  hintText: 'Dados salvos com sucesso!'),
                            ),
                            SizedBox(
                              width: 320.0,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
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
                });;
          }, icon: Icon(Icons.save_outlined))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _body(context),
      ),
    );
  }

  _body(BuildContext context) {

    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _controllerNome,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Nome",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o nome",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [maskCPF],
            controller: _controllerCpf,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "CPF",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o CPF",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [maskRG],
            controller: _controllerRg,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "RG",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o RG",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerUfrg,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "UF do RG",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o UF do RG",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerNumcnh,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Nº CNH",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a CNH",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerCatcnh,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Categoria",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a categoria",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),TextFormField(
            controller: _controllerExamecnh,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Exame médico",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o exame médico",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerCor,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Cor",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a cor",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [maskDataNascimento],
            controller: _controllerDatanascimento,
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Data de nascimento",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a data de nascimento",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerEstadoNascimento,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Estado de nascimento",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o estado de nascimento",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerMunicipio,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Município",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o município",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerNomedamae,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Nome da mãe",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o nome da mãe",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerNomedopai,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Nome do pai",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o nome do pai",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerNaturalidade,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Naturalidade",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a naturalidade",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerProfissao,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Profissão",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a profissão",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [maskCep],
            controller: _controllerCep,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Cep",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o cep",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerLogradouro,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Logradouro",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o logradouro",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerBairro,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Bairro",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o Bairro",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerNumero,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Número",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o Número",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerUf,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Uf",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o uf",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [maskTelefone],
            controller: _controllerTelefone,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Telefone",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o Telefone",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [maskCellphone],
            controller: _controllerCelular,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Celular",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o Celular",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
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
    );
  }

}



