import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcm_app/model/Boletim.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroBoletim extends StatefulWidget {

  @override
  _CadastroBoletimState createState() => _CadastroBoletimState();
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
class _CadastroBoletimState extends State<CadastroBoletim> {

  TextEditingController _controllernumbo = TextEditingController();
  TextEditingController _controllerhora_com = TextEditingController();
  TextEditingController _controllerhora_fat = TextEditingController();
  TextEditingController _controllerhora_log = TextEditingController();
  TextEditingController _controllerdata_fat = TextEditingController();
  TextEditingController _controllerhora_hosp_ch = TextEditingController();
  TextEditingController _controllerhora_hosp_sai = TextEditingController();
  TextEditingController _controllerhora_apre = TextEditingController();
  TextEditingController _controllerhora_ter = TextEditingController();
  TextEditingController _controllercod_nat = TextEditingController();
  TextEditingController _controllernat = TextEditingController();
  TextEditingController _controllerdata_com = TextEditingController();
  TextEditingController _controllervitima_pessoa = TextEditingController();
  TextEditingController _controllerversaopessoa = TextEditingController();
  TextEditingController _controllercarac_loc = TextEditingController();
  TextEditingController _controlleriluminacao_loc = TextEditingController();
  TextEditingController _controllerEtemp_loc = TextEditingController();
  TextEditingController _controllersemafaro_acidente = TextEditingController();
  TextEditingController _controllerforsinal_visivel = TextEditingController();
  TextEditingController _controllercond_pista= TextEditingController();
  TextEditingController _controllernum_veiculo_1 = TextEditingController();
  TextEditingController _controllernum_veiculo_2 = TextEditingController();
  TextEditingController _controllerplaca_veic_1 = TextEditingController();
  TextEditingController _controllerplaca_veic_2= TextEditingController();
  TextEditingController _controllerrenavan_vec_1 = TextEditingController();
  TextEditingController _controllerprop_veic_1 = TextEditingController();
  TextEditingController _controllerprop_veic_2 = TextEditingController();
  TextEditingController _controllerend_car_1 = TextEditingController();
  TextEditingController _controllerend_car_2 = TextEditingController();
  TextEditingController _controllermun_car_1 = TextEditingController();
  TextEditingController _controllermun_car_2 = TextEditingController();
  TextEditingController _controlleruf_car_1 = TextEditingController();
  TextEditingController _controlleruf_car_2 = TextEditingController();
  TextEditingController _controllerrenavan_vec_2 = TextEditingController();
  TextEditingController _controllerchassi_car_1 = TextEditingController();
  TextEditingController _controllerchassi_car_2 = TextEditingController();
  TextEditingController _controllerespecie_tipo_car_1 = TextEditingController();
  TextEditingController _controllerespecie_tipo_car_2 = TextEditingController();
  TextEditingController _controllerqtde_pass_car_1 = TextEditingController();
  TextEditingController _controllerqtde_pass_car_2 = TextEditingController();
  TextEditingController _controllermarca_car_1 = TextEditingController();
  TextEditingController _controllermarca_car_2 = TextEditingController();
  TextEditingController _controllerano_fab_1 = TextEditingController();
  TextEditingController _controllerano_fab_2 = TextEditingController();
  TextEditingController _controllercateg_car_1 = TextEditingController();
  TextEditingController _controllercateg_car_2 = TextEditingController();
  TextEditingController _controllercor_car_1 = TextEditingController();
  TextEditingController _controllercor_car_2  = TextEditingController();
  TextEditingController _controllerdanos_car_1 = TextEditingController();
  TextEditingController _controllerdanos_car_2  = TextEditingController();
  TextEditingController _controllerpont_impac_1 = TextEditingController();
  TextEditingController _controllepont_impac_2 = TextEditingController();
  TextEditingController _controllerrel_gdc = TextEditingController();
  TextEditingController _controllerkm_viatura_inicial  = TextEditingController();
  TextEditingController _controllerkm_viatura_final  = TextEditingController();
  TextEditingController _controllerkm_rodado  = TextEditingController();
  TextEditingController _controllerassinatura_chefe_imediato  = TextEditingController();

  String _mensagemErro = "";

  var maskCellphone= new MaskTextInputFormatter(
      mask: '(##) #####-####',
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

  var hora= new MaskTextInputFormatter(
      mask: '##:##:##',
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
    String numerobo = _controllernumbo.text;
    String horacomunicacao = _controllerhora_com.text;
    String horafato = _controllerhora_fat.text;
    String horaloc = _controllerhora_log.text;
    String datafat = _controllerdata_fat.text;
    String horahospchegada = _controllerhora_hosp_ch.text;
    String horahospsai = _controllerhora_hosp_sai.text;
    String horapre = _controllerhora_apre.text;
    String horater = _controllerhora_ter.text;
    String codnat = _controllercod_nat.text;
    String nat = _controllernat.text;
    String datacomunicacao = _controllerdata_com.text;
    String vitimapessoa = _controllervitima_pessoa.text;
    String versaopessoa = _controllerversaopessoa.text;
    String caractloc = _controllercarac_loc.text;
    String iluminacaoloc = _controlleriluminacao_loc.text;
    String etemploc = _controllerEtemp_loc.text;
    String semafaroacidente = _controllersemafaro_acidente.text;
    String forsinalvisivel = _controllerforsinal_visivel.text;
    String condpista = _controllercond_pista.text;
    String numveic1 = _controllernum_veiculo_1.text;
    String numveic2 = _controllernum_veiculo_2.text;
    String placaveic1 = _controllerplaca_veic_1.text;
    String placaveic2 = _controllerplaca_veic_2.text;
    String renavanveic1 = _controllerrenavan_vec_1.text;
    String propveic1 = _controllerprop_veic_1.text;
    String propveic2 = _controllerprop_veic_2.text;
    String endcar1 = _controllerend_car_1.text;
    String endcar2 = _controllerend_car_2.text;
    String muncar1 = _controllermun_car_1.text;
    String muncar2 = _controllermun_car_2.text;
    String ufcar1 = _controlleruf_car_1.text;
    String ufcar2 = _controlleruf_car_2.text;
    String renavanvec2 = _controllerrenavan_vec_2.text;
    String chassicar1 = _controllerchassi_car_1.text;
    String chassicar2 = _controllerchassi_car_2.text;
    String especietipocar1 = _controllerespecie_tipo_car_1.text;
    String especietipocar2 = _controllerespecie_tipo_car_2.text;
    String qtdpasscar1 = _controllerqtde_pass_car_1.text;
    String qtdpasscar2 = _controllerqtde_pass_car_2.text;
    String marcacar1 = _controllermarca_car_1.text;
    String marcacar2 = _controllermarca_car_2.text;
    String anofab1 = _controllerano_fab_1.text;
    String anofab2 = _controllerano_fab_2.text;
    String categcar1 = _controllercateg_car_1.text;
    String categcar2 = _controllercateg_car_2.text;
    String corcar1 = _controllercor_car_1.text;
    String corcar2 = _controllercor_car_2.text;
    String danoscar1 = _controllerdanos_car_1.text;
    String danoscar2 = _controllerdanos_car_2.text;
    String pontimpac1 = _controllerpont_impac_1.text;
    String pontimpac2 = _controllepont_impac_2.text;
    String relgdc = _controllerrel_gdc.text;
    String kmviaturaini = _controllerkm_viatura_inicial.text;
    String kmviaturafin = _controllerkm_viatura_final.text;
    String kmrodado = _controllerkm_rodado.text;
    String assinatura = _controllerassinatura_chefe_imediato.text;


    if(numerobo.isNotEmpty){
      if(horafato.isNotEmpty){
        if(numveic1.isNotEmpty){
          if(versaopessoa.isNotEmpty){
            setState((){
              _mensagemErro = "";
            });

            Boletim boletim = Boletim();
            boletim.numbo = numerobo;
            boletim.hora_com = horacomunicacao;
            boletim.hora_fat = horafato ;
            boletim.hora_log = horaloc;
            boletim.data_fat = datafat;
            boletim.hora_hosp_ch = horahospchegada;
            boletim.hora_hosp_sai = horahospsai;
            boletim.hora_apre = horapre;
            boletim.hora_ter = horater;
            boletim.cod_nat = codnat;
            boletim.nat = nat;
            boletim.data_com = datacomunicacao;
            boletim.vitima_pessoa = vitimapessoa;
            boletim.versaopessoa = versaopessoa;
            boletim.carac_loc = caractloc;
            boletim.iluminacao_loc = iluminacaoloc;
            boletim.temp_loc = etemploc;
            boletim.semafaro_acidente = semafaroacidente;
            boletim.for_sinal_visivel = forsinalvisivel;
            boletim.cond_pista = condpista;
            boletim.num_veiculo_1 = numveic1;
            boletim.num_veiculo_2 = numveic2;
            boletim.placa_veic_1 = placaveic1;
            boletim.placa_veic_2 = placaveic2;
            boletim.renavan_vec_1 = renavanveic1;
            boletim.prop_veic_1 = propveic1;
            boletim.prop_veic_2 = propveic2;
            boletim.end_car_1 = endcar1;
            boletim.end_car_2 = endcar2;
            boletim.mun_car_1 = muncar1;
            boletim.mun_car_2 = muncar2;
            boletim.uf_car_1 = ufcar1;
            boletim.uf_car_2 = ufcar2;
            boletim.renavan_vec_2 = renavanvec2;
            boletim.chassi_car_1 = chassicar1;
            boletim.chassi_car_2 = chassicar2;
            boletim.especie_tipo_car_1 = especietipocar1;
            boletim.especie_tipo_car_2 = especietipocar2;
            boletim.qtde_pass_car_1 = qtdpasscar1;
            boletim.qtde_pass_car_2 = qtdpasscar2;
            boletim.marca_car_1 = marcacar1;
            boletim.marca_car_2 = marcacar2;
            boletim.ano_fab_1 = anofab1;
            boletim.ano_fab_2 = anofab2;
            boletim.categ_car_1 = categcar1;
            boletim.categ_car_2 = categcar2;
            boletim.cor_car_1 = corcar1;
            boletim.cor_car_2 = corcar2;
            boletim.danos_car_1 = danoscar1;
            boletim.danos_car_2 = danoscar2;
            boletim.pont_impac_1 = pontimpac1;
            boletim.pont_impac_2 = pontimpac2;
            boletim.rel_gdc = relgdc;
            boletim.km_viatura_inicial = kmviaturaini;
            boletim.km_viatura_final = kmviaturafin;
            boletim.km_rodado = kmrodado;
            boletim.assinatura_chefe_imediato = assinatura;

            _cadastrarBoletim(boletim);
          }else{

            setState((){
              _mensagemErro = "Preencha o campo Versão da pessoa";
            });

          }

        }else{
          setState((){
            _mensagemErro = "Preencha o campo Numero do veiculo 1 ";
          });

        }

      }else{
        setState((){
          _mensagemErro = "Preencha o campo hora do fato";
        });

      }

    }else{
      setState((){
        _mensagemErro = "Preencha o campo numero do BO";
      });
    }
  }



  _cadastrarBoletim(Boletim boletim){
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("Boletim")
        .doc(boletim.numbo)
        .set(boletim.toMap());

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
            controller: _controllernumbo,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Numero do bo",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o numero do BO",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [hora],
            controller: _controllerhora_com,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Hora de comunicação",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a hora da comunicação",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [hora],
            controller: _controllerhora_fat,
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Hora do fato",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a hora do fato",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [hora],
            controller: _controllerhora_log,
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Hora de chegada no local",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a hora de chagada no local",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [maskDataNascimento],
            controller: _controllerdata_fat,
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Data do Fato",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a data do fato",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),TextFormField(
            inputFormatters: [hora],
            controller: _controllerhora_hosp_ch,
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Hora de chegada no hospital",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a hora de chegada no hospital",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [hora],
            controller: _controllerhora_hosp_sai,
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Hora de saida do hospital",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a hora de saida do hospital",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [hora],
            controller: _controllerhora_ter,
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Hora termino",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a hora do termino",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [maskDataNascimento],
            controller: _controllerdata_com,
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Data de comunicação",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a data de comunicação",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            inputFormatters: [hora],
            controller: _controllerhora_apre,
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Hora de apresentação",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a hora de apresentação",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllercod_nat,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Cod da natureza",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o codigo da natureza",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllervitima_pessoa,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Vitima",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a sigla da Vitima",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerversaopessoa,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Versão da pessoa",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a versão da pessoa",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllercarac_loc,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Caracteristica do local",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a caracteristica do local",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controlleriluminacao_loc,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Iluminação do local",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite as contições de iluminação do local",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllersemafaro_acidente,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Semafaro acidente",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite se tinha semafaro no local do acidente",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerforsinal_visivel,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Sinal visivel?",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite se no local tinha sinal visivel",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllernum_veiculo_1,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Número do veiculo 1",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o Número do veiculo 1",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllernum_veiculo_2,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Número do veiculo 2",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o Número do veiculo 2",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllerEtemp_loc,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Tempo no local",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite o tempo que estava no locla",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            controller: _controllercond_pista,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF092757),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Condição da pista",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hintText: "Digite a condição da pista",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),

        DropdownButton<String>(
          hint: Text('Selecione a pessoa para vincular a este boletim'),
          items: <String>['Matheus Neris Xavier Da Rocha', 'Pedro Henrique Ramos', 'Leticia Nunes', 'Geovana Ruiz'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        ),
    Padding(
            padding: EdgeInsets.only(top: 16),
            child: Center(
              child: Text(
                _mensagemErro,
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



