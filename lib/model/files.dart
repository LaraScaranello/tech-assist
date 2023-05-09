// ignore_for_file: unused_field, unnecessary_this

class Files {
  // atributos
  late String _cliente;
  late int _numFicha;
  late DateTime _dataAbertura;
  late String _aparelho;
  late String _status;

  // construtor
  Files(String cliente, int numFicha, DateTime dataAbertura, String aparelho,
      String status) {
    this._cliente = cliente;
    this._numFicha = numFicha;
    this._dataAbertura = dataAbertura;
    this._aparelho = aparelho;
    this._status = status;
  }

  // getters e setters
  get cliente => this._cliente;
  set cliente(value) => this._cliente = value;

  get numFicha => this._numFicha;
  set numFicha(value) => this._numFicha = value;

  get dataAbertura => this._dataAbertura;
  set dataAbertura(value) => this._dataAbertura = value;

  get aparelho => this._aparelho;
  set aparelho(value) => this._aparelho = value;

  get status => this._status;
  set status(value) => this._status = value;
}
