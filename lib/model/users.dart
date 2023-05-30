// ignore_for_file: unused_field, unnecessary_this

class Users {
  // atributos
  late String _idUser;
  late String _nomeEmpresa;
  late String _nome;
  late String _telefone;
  late String _email;
  late String _senha;

  // construtor

  Users(String nomeEmpresa, String nome, String telefone, String email,
      String senha) {
    //this._idUser = idUser;
    this._nomeEmpresa = nomeEmpresa;
    this._nome = nome;
    this._telefone = telefone;
    this._email = email;
    this._senha = senha;
  }

  Users.Login(String email, String senha) {
    this._email = email;
    this._senha = senha;
  }

  // getters e setters
  get idUser => this._idUser;
  set idUser(value) => this._idUser = value;

  get nomeEmpresa => this._nomeEmpresa;
  set nomeEmpresa(value) => this._nomeEmpresa = value;

  get nome => this._nome;
  set nome(value) => this._nome = value;

  get telefone => this._telefone;
  set telefone(value) => this._telefone = value;

  get email => this._email;
  set email(value) => this._email = value;

  get senha => this._senha;
  set senha(value) => this._senha = value;
}
