import 'package:flutter/material.dart';

import 'ecran_login.dart';
import 'pagina_principal.dart';

class EcranRegisto extends StatelessWidget {
  const EcranRegisto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEAF8F0), Color(0xFFFFFFFF)],
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
                  // Logotipo
                  const Icon(
                    Icons.eco_rounded,
                    size: 75,
                    color: Color(0xFF20845F),
                  ),

                  const SizedBox(height: 10),

                  // Nome da aplicação
                  const Text(
                    'MyDay',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF124B3A),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // Título
                  const Text(
                    'Criar uma conta',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF173D32),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Regista-te para começares a organizar o teu dia.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF557368), fontSize: 14),
                  ),

                  const SizedBox(height: 30),

                  // Nome
                  TextField(
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

                  // Email
                  TextField(
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

                  // Palavra-passe
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

                  // Confirmar palavra-passe
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

                  // Botão Registar
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaginaPrincipal(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF20845F),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Registar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Acesso ao login
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
