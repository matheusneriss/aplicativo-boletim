class Pessoa{
  String _datadenasicmento = "";
  String _cor = "";
  String _nome = "";
  String _logradouro = "";
  String _bairro = "";
  String _numero = "";
  String _cep = "";
  String _rg = "";
  String _cpf = "";
  String _Uf = "";
  String _nomedopai = "";
  String _nomedamae = "";
  String _naturalidade = "";
  String _profissao = "";
  String _ufrg = "";
  String _numcnh = "";
  String _catcnh = "";
  String _examecnh = "";
  String _telefone = "";
  String _celular = "";
  String _municipio = "";
  String _estadoNascimento = "";
  String _excluido = "";

  String get excluido => _excluido;

  set excluido(String value) {
    _excluido = value;
  }

  Pessoa();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "Data de nascimento" : this.datadenasicmento,
      "Cor" : this.cor,
      "Nome" : this.nome,
      "Logradouro" : this.logradouro,
      "Bairro" : this.bairro,
      "Numero" : this.numero,
      "Cep" : this.cep,
      "CPF" : this.cpf,
      "RG" : this.rg,
      "Uf" : this.Uf,
      "Nome do pai" : this.nomedopai,
      "Nome da mãe" : this.nomedamae,
      "Naturalidade" : this.naturalidade,
      "Profissao" : this.profissao,
      "Uf do rg" : this.ufrg,
      "CNH" : this.numcnh,
      "Categoria da cnh" : this.catcnh,
      "Exame CNH" : this.examecnh,
      "Telefone" : this.telefone,
      "Celular" : this.celular,
      "Municipio" : this.municipio,
      "Estado de Nascimento" : this.estadoNascimento,
      "excluido": false,
    };
    return map;

  }

  String get estadoNascimento => _estadoNascimento;

  set estadoNascimento(String value) {
    _estadoNascimento = value;
  }

  String get municipio => _municipio;

  set municipio(String value) {
    _municipio = value;
  }

  String get celular => _celular;

  set celular(String value) {
    _celular = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get examecnh => _examecnh;

  set examecnh(String value) {
    _examecnh = value;
  }

  String get catcnh => _catcnh;

  set catcnh(String value) {
    _catcnh = value;
  }

  String get numcnh => _numcnh;

  set numcnh(String value) {
    _numcnh = value;
  }

  String get ufrg => _ufrg;

  set ufrg(String value) {
    _ufrg = value;
  }

  String get profissao => _profissao;

  set profissao(String value) {
    _profissao = value;
  }

  String get naturalidade => _naturalidade;

  set naturalidade(String value) {
    _naturalidade = value;
  }

  String get nomedamae => _nomedamae;

  set nomedamae(String value) {
    _nomedamae = value;
  }

  String get nomedopai => _nomedopai;

  set nomedopai(String value) {
    _nomedopai = value;
  }

  String get Uf => _Uf;

  set Uf(String value) {
    _Uf = value;
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;
  }

  String get rg => _rg;

  set rg(String value) {
    _rg = value;
  }

  String get cep => _cep;

  set cep(String value) {
    _cep = value;
  }

  String get numero => _numero;

  set numero(String value) {
    _numero = value;
  }

  String get bairro => _bairro;

  set bairro(String value) {
    _bairro = value;
  }

  String get logradouro => _logradouro;

  set logradouro(String value) {
    _logradouro = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get cor => _cor;

  set cor(String value) {
    _cor = value;
  }

  String get datadenasicmento => _datadenasicmento;

  set datadenasicmento(String value) {
    _datadenasicmento = value;
  }
}