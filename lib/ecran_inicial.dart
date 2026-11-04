import 'package:flutter/material.dart';

class EcranInicial extends StatelessWidget {
  const EcranInicial({super.key});

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // Logotipo
                  Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD3F0DF),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.eco_rounded,
                      size: 58,
                      color: Color(0xFF20845F),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'MyDay',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF124B3A),
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    'Organiza o teu dia,\nalcança os teus objetivos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF173D32),
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Descrição
                  const Text(
                    'Tudo o que precisas para planear\no teu dia num só lugar.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF557368),
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Ilustração
                  Container(
                    width: double.infinity,
                    height: 190,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDF3E7),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Positioned(
                          left: 18,
                          bottom: 15,
                          child: Icon(
                            Icons.spa_rounded,
                            size: 55,
                            color: Color(0xFF65B994),
                          ),
                        ),

                        const Positioned(
                          right: 18,
                          bottom: 15,
                          child: Icon(
                            Icons.eco_rounded,
                            size: 50,
                            color: Color(0xFF22966B),
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.checklist_rounded,
                              size: 85,
                              color: Color(0xFF20845F),
                            ),

                            const SizedBox(height: 8),

                            Container(
                              width: 125,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            const SizedBox(height: 7),

                            Container(
                              width: 90,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _indicador(true),
                      _indicador(false),
                      _indicador(false),
                    ],
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registo');
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
                        'Começar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Botão Entrar
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton(
                      onPressed: () {
  Navigator.pushNamed(context, '/login');
},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF124B3A),
                        side: const BorderSide(color: Color(0xFF55A887)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Texto de acesso à conta
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Já tens uma conta?',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF557368),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Entrar na tua conta'),
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

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Indicador da página
  Widget _indicador(bool ativo) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: ativo ? 18 : 7,
      height: 7,
      decoration: BoxDecoration(
        color: ativo ? const Color(0xFF20845F) : const Color(0xFFB7D9C9),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
