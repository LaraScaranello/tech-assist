// ignore_for_file: unused_field, unnecessary_this

class Budgets {
  // atributos
  String? _idUser;
  int? _numFicha;
  String? _status;
  String? _cliente;
  String? _email;
  String? _telefone;
  DateTime? _dataAbertura;
  String? _aparelho;
  String? _defeito;
  String? _diagnostico;
  String? _servicos;
  double? _valorPecas;
  double? _valorMaoDeObra;
  double? _valorTotal;

  // construtor
  Budgets(
      String? idUser,
      int? numFicha,
      String? status,
      String? cliente,
      String? email,
      String? telefone,
      DateTime? dataAbertura,
      String? aparelho,
      String? defeito,
      String? diagnostico,
      String? servicos,
      double? valorPecas,
      double? valorMaoDeObra,
      double? valorTotal) {
    this._idUser = idUser;
    this._numFicha = numFicha;
    this._status = status;
    this._cliente = cliente;
    this._email = email;
    this._telefone = telefone;
    this._dataAbertura = dataAbertura;
    this._aparelho = aparelho;
    this._defeito = defeito;
    this._diagnostico = diagnostico;
    this._servicos = servicos;
    this._valorPecas = valorPecas;
    this._valorMaoDeObra = valorMaoDeObra;
    this._valorTotal = valorTotal;
  }

  // getters e setters
  get idUser => this._idUser;
  set idUser(value) => this._idUser = value;

  get numFicha => this._numFicha;
  set numFicha(value) => this._numFicha = value;

  get status => this._status;
  set status(value) => this._status = value;

  get cliente => this._cliente;
  set cliente(value) => this._cliente = value;

  get email => this._email;
  set email(value) => this._email = value;

  get telefone => this._telefone;
  set telefone(value) => this._telefone = value;

  get dataAbertura => this._dataAbertura;
  set dataAbertura(value) => this._dataAbertura = value;

  get aparelho => this._aparelho;
  set aparelho(value) => this._aparelho = value;

  get defeito => this._defeito;
  set defeito(value) => this._defeito = value;

  get diagnostico => this._diagnostico;
  set diagnostico(value) => this._diagnostico = value;

  get servicos => this._servicos;
  set servicos(value) => this._servicos = value;

  get valorPecas => this._valorPecas;
  set valorPecas(value) => this._valorPecas = value;

  get valorMaoDeObra => this._valorMaoDeObra;
  set valorMaoDeObra(value) => this._valorMaoDeObra = value;

  get valorTotal => this._valorTotal;
  set valorTotal(value) => this._valorTotal = value;
}
