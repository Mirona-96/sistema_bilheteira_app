class Cliente {
  final String id;
  final String nome;
  final String contato;
  final String email;

  Cliente(
      {required this.id,
      required this.nome,
      required this.contato,
      required this.email});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'contato': contato, 'email': email};
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'] as String,
      nome: map['nome'] as String,
      contato: map['contato'] as String,
      email: map['email'] as String,
    );
  }
}
