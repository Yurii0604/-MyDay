import 'package:flutter/material.dart';

import '../dados/estado_app.dart';
import '../utilitarios/validacoes.dart';
import '../widgets/botao_principal.dart';
import '../widgets/campo_formulario.dart';
import '../widgets/seccao_google.dart';

class EcranLogin extends StatefulWidget {
  const EcranLogin({super.key});

  @override
  State<EcranLogin> createState() => _EcranLoginState();
}

class _EcranLoginState extends State<EcranLogin> {
  final _formulario = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _palavraPasse = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _palavraPasse.dispose();
    super.dispose();
  }

  // Valida o formulário, confere os dados e abre o ecrã principal.
  Future<void> _entrar() async {
    if (!_formulario.currentState!.validate()) return;

    final erro = await EstadoApp.instancia.entrar(
      _email.text,
      _palavraPasse.text,
    );
    if (!mounted) return;

    if (erro != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(erro)));
      return;
    }
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
                'Entrar',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Bem-vindo de volta!'),
              const SizedBox(height: 28),
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
                validador: validarObrigatorio,
              ),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/recuperar'),
                  child: const Text('Esqueceste-te da palavra-passe?'),
                ),
              ),
              const SizedBox(height: 8),
              BotaoPrincipal(texto: 'Entrar', aoCarregar: _entrar),
              const SeccaoGoogle(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ainda não tens conta?'),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/registo'),
                    child: const Text(
                      'Criar conta',
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