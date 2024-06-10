class Venda {
  final String id;
  final String clienteId;
  final String bilheteId;
  final int quantidade;
  final double precoTotal;
  final DateTime dataVenda;

  Venda(
      {required this.id,
      required this.clienteId,
      required this.bilheteId,
      required this.quantidade,
      required this.precoTotal,
      required this.dataVenda});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clienteId': clienteId,
      'bilheteId': bilheteId,
      'quantidade': quantidade,
      'precoTotal': precoTotal,
      'dataVenda': dataVenda.toIso8601String(),
    };
  }

  factory Venda.fromMap(Map<String, dynamic> map) {
    return Venda(
      id: 'id',
      bilheteId: map['bilheteid'],
      clienteId: map['clienteId'],
      quantidade: map['quantidade'].toInt(),
      precoTotal: map['precoTotal'].toDouble(),
      dataVenda: DateTime.parse(map['dataVenda']),
    );
  }
}
