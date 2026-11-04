
String? validarObrigatorio(String? valor) {
  if (valor == null || valor.trim().isEmpty) {
    return 'Preenche este campo.';
  }
  return null;
}

String? validarEmail(String? valor) {
  final erro = validarObrigatorio(valor);
  if (erro != null) return erro;
  final formato = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  return formato.hasMatch(valor!.trim()) ? null : 'Escreve um email válido.';
}

String? validarPalavraPasse(String? valor) {
  if (valor == null || valor.length < 6) {
    return 'Usa pelo menos 6 caracteres.';
  }
  return null;
}