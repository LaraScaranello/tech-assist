// ignore_for_file: unused_field, unnecessary_this

class Clients {
  // atributos
  int? _idClient;
  String? _idUser;
  String? _cliente;
  String? _documento;
  String? _telefone;
  String? _email;
  bool? _status;

  // construtor
  Clients(String? idUser, String? cliente, String? documento, String? email,
      String? telefone, bool? status) {
    this._idUser = idUser;
    this._cliente = cliente;
    this._documento = documento;
    this._email = email;
    this._telefone = telefone;
    this._status = status;
  }

  // getters e setters
  get idClient => this._idClient;
  set idClient(value) => this._idClient = value;

  get idUser => this._idUser;
  set idUser(value) => this._idUser = value;

  get cliente => this._cliente;
  set cliente(value) => this._cliente = value;

  get documento => this._documento;
  set documento(value) => this._documento = value;

  get email => this._email;
  set email(value) => this._email = value;

  get telefone => this._telefone;
  set telefone(value) => this._telefone = value;

  get status => this._status;
  set status(value) => this._status = value;
}
