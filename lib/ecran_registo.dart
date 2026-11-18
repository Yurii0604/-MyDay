import 'package:flutter/material.dart';

import 'ecran_login.dart';
import 'pagina_principal.dart';

class EcranRegisto extends StatefulWidget {
  const EcranRegisto({super.key});

  @override
  State<EcranRegisto> createState() => _EcranRegistoState();
}

class _EcranRegistoState extends State<EcranRegisto> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void registar() {
    String nome = nomeController.text.trim();
    String email = emailController.text.trim();

    if (nome.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preenche todos os campos.')),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PaginaPrincipal(nomeUtilizador: nome, emailUtilizador: email),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F6),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEAF8F0), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  const Icon(
                    Icons.eco_rounded,
                    size: 75,
                    color: Color(0xFF20845F),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'MyDay',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF124B3A),
                    ),
                  ),

                  const SizedBox(height: 35),

                  const Text(
                    'Criar conta',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF173D32),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Preenche os teus dados para começar a usar o MyDay.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF557368)),
                  ),

                  const SizedBox(height: 30),

                  TextField(
                    controller: nomeController,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      prefixIcon: const Icon(Icons.person_outline),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Palavra-passe',
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirmar palavra-passe',
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: registar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF20845F),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Criar conta',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Já tens uma conta?',
                        style: TextStyle(color: Color(0xFF557368)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EcranLogin(),
                            ),
                          );
                        },
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            color: Color(0xFF20845F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
