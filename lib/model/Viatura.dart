class Viatura {
 String _marca ="";
 String _modelo ="";
 String _numeroviatura ="";
 String _placa ="";

 Viatura();

 String get placa => _placa;

  set placa(String value) {
    _placa = value;
  }

  String get numeroviatura => _numeroviatura;

  set numeroviatura(String value) {
    _numeroviatura = value;
  }

  String get modelo => _modelo;

  set modelo(String value) {
    _modelo = value;
  }

  String get marca => _marca;

  set marca(String value) {
    _marca = value;
  }
}