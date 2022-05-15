class Usuario{
  String _idUsuario = "";
  String _nome = "";
  String _email = "";
  String _senha = "";
  String _tipoUsuario = "";
  String _celular = "";
  String _matricula = "";
  String _datanascimento = "";
  String _cpf = "";

  Usuario();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "cpf" : this.cpf,
      "nome" : this.nome,
      "matricula" : this.matricula,
      "celular" : this.celular,
      "data de nascimento" : this.datanascimento,
      "email" : this.email,
      "tipoUsuario": this.tipoUsuario,
    };
    return map;

  }

  String verificaTipoUsuario(bool tipoUsuario){
    return tipoUsuario ? "Comandante" : "Guarda";
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;
  }

  String get datanascimento => _datanascimento;

  set datanascimento(String value) {
    _datanascimento = value;
  }

  String get matricula => _matricula;

  set matricula(String value) {
    _matricula = value;
  }

  String get celular => _celular;

  set celular(String value) {
    _celular = value;
  }

  String get tipoUsuario => _tipoUsuario;

  set tipoUsuario(String value) {
    _tipoUsuario = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }
}

