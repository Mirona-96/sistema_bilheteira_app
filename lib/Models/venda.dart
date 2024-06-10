class Venda {
  final String id;
  final String idCliente;
  final String idBilhete;
  final int quantidade;
  final double precoTotal;
  final DateTime dataVenda;

  Venda(
      {required this.id,
      required this.idCliente,
      required this.idBilhete,
      required this.quantidade,
      required this.precoTotal,
      required this.dataVenda});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idCliente': idCliente,
      'idBilhete': idBilhete,
      'quantidade': quantidade,
      'precoTotal': precoTotal,
      'dataVenda': dataVenda.toIso8601String(),
    };
  }

  factory Venda.fromMap(Map<String, dynamic> map) {
    return Venda(
      id: 'id',
      idCliente: map['idCliente'],
      idBilhete: map['idBilhete'],
      quantidade: map['quantidade'].toInt(),
      precoTotal: map['precoTotal'].toDouble(),
      dataVenda: DateTime.parse(map['dataVenda']),
    );
  }
}
