import 'package:flutter/material.dart';

import '../dados/estado_app.dart';
import '../utilitarios/validacoes.dart';
import '../widgets/botao_principal.dart';
import '../widgets/campo_formulario.dart';
import '../widgets/seccao_google.dart';

class EcranRegisto extends StatefulWidget {
  const EcranRegisto({super.key});

  @override
  State<EcranRegisto> createState() => _EcranRegistoState();
}

class _EcranRegistoState extends State<EcranRegisto> {
  final _formulario = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _palavraPasse = TextEditingController();
  final _confirmar = TextEditingController();

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _palavraPasse.dispose();
    _confirmar.dispose();
    super.dispose();
  }

  // Valida o formulário, cria a conta e abre o ecrã principal.
  Future<void> _criarConta() async {
    if (!_formulario.currentState!.validate()) return;

    final erro = await EstadoApp.instancia.registar(
      _nome.text,
      _email.text,
      _palavraPasse.text,
    );
    if (!mounted) return;

    if (erro != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(erro)));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Conta criada com sucesso.')),
    );
    Navigator.pushNamedAndRemoveUntil(context, '/principal', (rota) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Form(
          key: _formulario,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Criar conta',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Preenche os teus dados para começar a usar o MyDay.'),
              const SizedBox(height: 28),
              CampoFormulario(
                rotulo: 'Nome',
                icone: Icons.person_outline,
                controlador: _nome,
                validador: validarObrigatorio,
              ),
              CampoFormulario(
                rotulo: 'Email',
                icone: Icons.mail_outline,
                controlador: _email,
                teclado: TextInputType.emailAddress,
                validador: validarEmail,
              ),
              CampoFormulario(
                rotulo: 'Palavra-passe',
                icone: Icons.lock_outline,
                controlador: _palavraPasse,
                palavraPasse: true,
                validador: validarPalavraPasse,
              ),
              CampoFormulario(
                rotulo: 'Confirmar palavra-passe',
                icone: Icons.lock_outline,
                controlador: _confirmar,
                palavraPasse: true,
                validador: (valor) => valor == _palavraPasse.text
                    ? null
                    : 'As palavras-passe não coincidem.',
              ),
              const SizedBox(height: 6),
              BotaoPrincipal(texto: 'Criar conta', aoCarregar: _criarConta),
              const SeccaoGoogle(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Já tens uma conta?'),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/login'),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}