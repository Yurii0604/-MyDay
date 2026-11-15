import 'package:flutter/material.dart';

class CampoFormulario extends StatefulWidget {
  final String rotulo;
  final String? dica;
  final IconData? icone;
  final TextEditingController controlador;
  final String? Function(String?)? validador;
  final bool palavraPasse;
  final TextInputType? teclado;
  final int linhas;

  const CampoFormulario({
    super.key,
    required this.rotulo,
    required this.controlador,
    this.dica,
    this.icone,
    this.validador,
    this.palavraPasse = false,
    this.teclado,
    this.linhas = 1,
  });

  @override
  State<CampoFormulario> createState() => _CampoFormularioState();
}

class _CampoFormularioState extends State<CampoFormulario> {
  bool _oculto = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: widget.controlador,
        validator: widget.validador,
        keyboardType: widget.teclado,
        maxLines: widget.linhas,
        obscureText: widget.palavraPasse && _oculto,
        decoration: InputDecoration(
          labelText: widget.rotulo,
          hintText: widget.dica,
          alignLabelWithHint: widget.linhas > 1,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          prefixIcon: widget.icone == null ? null : Icon(widget.icone),
          suffixIcon: !widget.palavraPasse
              ? null
              : IconButton(
                  tooltip: _oculto ? 'Mostrar' : 'Ocultar',
                  icon: Icon(_oculto ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                  onPressed: () => setState(() => _oculto = !_oculto),
                ),
        ),
      ),
    );
  }
}