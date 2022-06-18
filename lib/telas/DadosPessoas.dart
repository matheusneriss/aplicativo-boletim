import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../model/Pessoa.dart';

class DadosPessoas extends StatefulWidget {

  Pessoa pessoa;
  DadosPessoas(this.pessoa);

  @override
  State<DadosPessoas> createState() => _DadosPessoasState();
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

class _DadosPessoasState extends State<DadosPessoas> {

  late final _controllerDatanascimento =  TextEditingController(text: widget.pessoa.datadenasicmento);
  late final _controllerCor =  TextEditingController(text: widget.pessoa.cor);
  late final _controllerNome =  TextEditingController(text: widget.pessoa.nome) ;
  late final _controllerLogradouro =  TextEditingController(text: widget.pessoa.logradouro);
  late final _controllerBairro =  TextEditingController(text: widget.pessoa.bairro);
  late final _controllerNumero =  TextEditingController(text: widget.pessoa.numero);
  late final _controllerCep =  TextEditingController(text: widget.pessoa.cep) ;
  late final _controllerRg =  TextEditingController(text: widget.pessoa.rg);
  late final _controllerCpf =  TextEditingController(text: widget.pessoa.cpf);
  late final _controllerUf =  TextEditingController(text: widget.pessoa.Uf);
  late final _controllerNomedopai =  TextEditingController(text: widget.pessoa.nomedopai) ;
  late final _controllerNomedamae =  TextEditingController(text: widget.pessoa.nomedamae);
  late final _controllerNaturalidade =  TextEditingController(text: widget.pessoa.naturalidade);
  late final _controllerProfissao =  TextEditingController(text: widget.pessoa.profissao);
  late final _controllerUfrg =  TextEditingController(text: widget.pessoa.ufrg) ;
  late final _controllerNumcnh =  TextEditingController(text: widget.pessoa.numcnh);
  late final _controllerCatcnh =  TextEditingController(text: widget.pessoa.catcnh);
  late final _controllerExamecnh =  TextEditingController(text: widget.pessoa.examecnh);
  late final _controllerTelefone =  TextEditingController(text: widget.pessoa.telefone);
  late final _controllerCelular =  TextEditingController(text: widget.pessoa.celular);
  late final _controllerMunicipio =  TextEditingController(text: widget.pessoa.municipio);
  late final _controllerEstadoNascimento =  TextEditingController(text: widget.pessoa.estadoNascimento);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _removerGuarda(){
    String cpf = _controllerCpf.text;

    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String,dynamic> dadosAtualizar ={
      "excluido" : true
    };
    db.collection("Pessoas")
        .doc(cpf)
        .update(dadosAtualizar);
  }

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

  _atualizarDadosFirestore(){

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

    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String,dynamic> dadosAtualizar ={
      "Data de nascimento" : datanascimento,
      "Cor" : cor,
      "Nome" : nome,
      "Logradouro" : logradouro,
      "Bairro" : bairro,
      "Numero" : numero,
      "Cep" : cep,
      "CPF" : cpf,
      "RG" : rg,
      "Uf" : uf,
      "Nome do pai" : nomepai,
      "Nome da mãe" : nomemae,
      "Naturalidade" : naturalidade,
      "Profissao" : profissao,
      "Uf do rg" : ufrg,
      "CNH" : numcnh,
      "Categoria da cnh" : catcnh,
      "Exame CNH" : examecnh,
      "Telefone" : telefone,
      "Celular" : celular,
      "Municipio" : municipio,
      "Estado de Nascimento" : estadonascimento,
    };
    db.collection("Pessoas")
        .doc(cpf)
        .update(dadosAtualizar);
  }

  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('Pessoas')
        .where("excluido", isEqualTo: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dados da pessoa"),
        backgroundColor: Color(0xFF092757),
        actions: [
          IconButton(
            icon: Icon(Icons.save_outlined),
            onPressed: (){
              _atualizarDadosFirestore();
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(20.0)), //this right here
                      child: Container(
                        height: 120,
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
                                  hintText: 'Alterações realizadas!',
                                  hintStyle: TextStyle(
                                    color: Colors.black, // <-- Change this
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                              Container(
                                  alignment: Alignment.topCenter,
                                  child: SizedBox(
                                    width: 100.0,
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Ok",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      color: const Color(0xFF092757),
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });;
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Excluir a viatura ' + widget.pessoa.nome + '?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Não'),
                      onPressed: () =>
                          Navigator.of(context).pop(false),
                    ),
                    FlatButton(
                      child: Text('Sim'),
                      onPressed: () =>
                          Navigator.of(context).pop(true),
                    ),
                  ],
                ),
              ).then((confirmed) async {
                if (confirmed) {
                  _removerGuarda();
                }
              });
            },
          ),
        ],
      ),
      body:  Padding(
        padding: EdgeInsets.all(16),
        child: Form(
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
                // child: Center(
                //   child: Text(
                //     _mensagemErro,
                //     style: TextStyle(color: Colors.red, fontSize: 20),
                //   ),
                // ),
              )
            ],
          ),
        )
      ),
    );
  }
}
