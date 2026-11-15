import 'package:flutter/material.dart';

import '../utilitarios/validacoes.dart';
import '../widgets/botao_principal.dart';
import '../widgets/campo_formulario.dart';

// A aplicação não tem servidor, por isso não consegue enviar emails.
class EcranRecuperar extends StatefulWidget {
  const EcranRecuperar({super.key});

  @override
  State<EcranRecuperar> createState() => _EcranRecuperarState();
}

class _EcranRecuperarState extends State<EcranRecuperar> {
  final _formulario = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _enviar() {
    if (!_formulario.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('O envio de emails ainda não está disponível nesta versão.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

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
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: cores.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mark_email_read_outlined,
                  size: 80,
                  color: cores.primary,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Recuperar palavra-passe',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Introduz o teu email e enviaremos um link para redefinires a tua palavra-passe.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              CampoFormulario(
                rotulo: 'Email',
                icone: Icons.mail_outline,
                controlador: _email,
                teclado: TextInputType.emailAddress,
                validador: validarEmail,
              ),
              const SizedBox(height: 6),
              BotaoPrincipal(texto: 'Enviar', aoCarregar: _enviar),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Voltar para o login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}