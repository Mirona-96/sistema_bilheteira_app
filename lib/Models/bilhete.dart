class Bilhete {
  final String id;
  final String evento;
  final String descricao;
  final String endereco;
  final double preco;
  final DateTime dataValidade;

  Bilhete({
    required this.id,
    required this.evento,
    required this.descricao,
    required this.endereco,
    required this.preco,
    required this.dataValidade,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'evento': evento,
      'descricao': descricao,
      'endereco': endereco,
      'preco': preco,
      'dataValidade': dataValidade.toIso8601String(),
    };
  }

  factory Bilhete.fromMap(Map<String, dynamic> map) {
    return Bilhete(
      id: map['id'],
      evento: map['evento'],
      descricao: map['descricao'],
      endereco: map['endereco'],
      preco: map['preco'].toDouble(),
      dataValidade: DateTime.parse(map['dataValidade']),
    );
  }
}
