class Validators {
  /// Valida o nome do contato
  /// Regras:
  /// - Não pode ser vazio
  /// - Mínimo 3 caracteres
  /// - Apenas letras e espaços
  static String? validarNome(String? value) {
    if (value == null || value.trim().isEmpty) return 'Nome não pode ser vazio';
    final trimmed = value.trim();
    if (trimmed.length < 3) return 'Nome deve ter ao menos 3 caracteres';
    final regex = RegExp(r'^[A-Za-zÀ-ÖØ-öø-ÿ ]+$');
    if (!regex.hasMatch(trimmed))
      return 'Nome deve conter apenas letras e espaços';
    return null;
  }

  /// Valida o número da conta
  /// Regras:
  /// - Não pode ser vazio
  /// - Formato: 5 dígitos + hífen + 1 dígito (ex: 12345-6)
  static String? validarNumeroConta(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Número da conta não pode ser vazio';
    final trimmed = value.trim();
    final regex = RegExp(r'^\d{5}-\d$');
    if (!regex.hasMatch(trimmed)) return 'Formato inválido. Ex: 12345-6';
    return null;
  }
}
