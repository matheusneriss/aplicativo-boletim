import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario{
  String _idUsuario = "";
  String _nome = "";
  String _email = "";
  String _senha = "";
  String _tipoUsuario = "";
  String _celular = "";
  String _matricula = "";
  String _datanascimento = "";
  String _urlImagem = "";
  String _cpf = "";
  String _qra = "";
  String _excluido = "";

  String get excluido => _excluido;

  set excluido(String value) {
    _excluido = value;
  }

  Usuario();

  String get qra => _qra;

  set qra(String value) {
    _qra = value;
  }

  String get urlImagem => _urlImagem;

  set urlImagem(String value) {
    _urlImagem = value;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "cpf" : this.cpf,
      "nome" : this.nome,
      "matricula" : this.matricula,
      "celular" : this.celular,
      "data de nascimento" : this.datanascimento,
      "email" : this.email,
      "tipoUsuario": this.tipoUsuario,
      "urlImagem" : "https://cdn4.vectorstock.com/i/1000x1000/60/78/police-avatar-character-icon-vector-12646078.jpg",
      "nome de guerra" : this.qra,
      'excluido': false,
    };
    return map;

  }

  String verificaTipoUsuario(bool tipoUsuario){
    return tipoUsuario ? "" : "Guarda";
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

