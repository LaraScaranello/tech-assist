// ignore_for_file: unused_field, unnecessary_this

class Clients {
  // atributos
  late String _cliente;
  late String _telefone;
  late String _email;

  // construtor
  Clients(String cliente, String email, String telefone) {
    this._cliente = cliente;
    this._email = email;
    this._telefone = telefone;
  }

  // getters e setters
  get cliente => this._cliente;
  set cliente(value) => this._cliente = value;

  get email => this._email;
  set email(value) => this._email = value;

  get telefone => this._telefone;
  set telefone(value) => this._telefone = value;
}
