/// Modelo de dados para um Contato

class Contato {
  int? id;
  String nome;
  String numeroConta;
  DateTime? dataCriacao;

  Contato({
    this.id,
    required this.nome,
    required this.numeroConta,
    DateTime? dataCriacao,
  }) : dataCriacao = dataCriacao ?? DateTime.now();

  /// Converte o objeto Contato para Map (usado pelo sqflite)
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'nome': nome,
      'numeroConta': numeroConta,
      'dataCriacao': dataCriacao?.toIso8601String(),
    };
    if (id != null) map['id'] = id;
    return map;
  }

  /// Cria um Contato a partir de um Map (retorno do banco)
  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
      id: map['id'] as int?,
      nome: map['nome'] as String? ?? '',
      numeroConta: map['numeroConta'] as String? ?? '',
      dataCriacao: map['dataCriacao'] != null
          ? DateTime.parse(map['dataCriacao'] as String)
          : null,
    );
  }

  /// Cria uma cópia do Contato com possíveis substituições
  Contato copyWith(
      {int? id, String? nome, String? numeroConta, DateTime? dataCriacao}) {
    return Contato(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      numeroConta: numeroConta ?? this.numeroConta,
      dataCriacao: dataCriacao ?? this.dataCriacao,
    );
  }

  @override
  String toString() =>
      'Contato(id: $id, nome: $nome, numeroConta: $numeroConta, dataCriacao: $dataCriacao)';
}
