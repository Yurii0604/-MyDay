import 'package:flutter/material.dart';

import '../dados/estado_app.dart';

// Perfil do utilizador: dados da conta, tema e terminar sessão.
class PaginaPerfil extends StatelessWidget {
  const PaginaPerfil({super.key});

  // Abre uma janela para mudar o nome e guarda-o.
  Future<void> _editarNome(BuildContext context) async {
    final estado = EstadoApp.instancia;
    final controlador = TextEditingController(text: estado.nome);

    final novoNome = await showDialog<String>(
      context: context,
      builder: (contexto) => AlertDialog(
        title: const Text('Editar perfil'),
        content: TextField(
          controller: controlador,
          decoration: const InputDecoration(labelText: 'Nome'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(contexto),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(contexto, controlador.text),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    if (novoNome == null || !context.mounted) return;

    if (novoNome.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('O nome não pode ficar vazio.')),
      );
      return;
    }

    await estado.atualizarNome(novoNome);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil atualizado.')),
    );
  }

  // Opções que ainda não estão implementadas.
  void _indisponivel(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Esta opção ainda não está disponível.')),
    );
  }

  Future<void> _terminarSessao(BuildContext context) async {
    await EstadoApp.instancia.sair();
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/inicial', (rota) => false);
  }

  // Uma linha da lista de opções.
  Widget _opcao(IconData icone, String texto, {Widget? fim, VoidCallback? aoCarregar}) {
    return ListTile(
      leading: Icon(icone),
      title: Text(texto),
      trailing: fim ?? const Icon(Icons.chevron_right),
      onTap: aoCarregar,
    );
  }

  @override
  Widget build(BuildContext context) {
    final estado = EstadoApp.instancia;
    final cores = Theme.of(context).colorScheme;

    return SafeArea(
      child: ListenableBuilder(
        listenable: estado,
        builder: (context, _) {
          final inicial = estado.nome.isEmpty ? '?' : estado.nome[0].toUpperCase();

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            children: [
              const Text(
                'Perfil',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 46,
                  backgroundColor: cores.primaryContainer,
                  child: Text(
                    inicial,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: cores.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  estado.nome,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Center(child: Text(estado.email)),
              const SizedBox(height: 22),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  border: Border.all(color: cores.outlineVariant),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _opcao(
                      Icons.edit_outlined,
                      'Editar perfil',
                      aoCarregar: () => _editarNome(context),
                    ),
                    const Divider(height: 1),
                    // O tema é guardado e mantém-se ao reiniciar a app.
                    ValueListenableBuilder<bool>(
                      valueListenable: estado.temaEscuro,
                      builder: (context, escuro, _) => _opcao(
                        Icons.light_mode_outlined,
                        'Tema',
                        fim: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(escuro ? 'Escuro' : 'Claro'),
                            Switch(
                              value: escuro,
                              onChanged: estado.definirTemaEscuro,
                            ),
                          ],
                        ),
                        aoCarregar: () => estado.definirTemaEscuro(!escuro),
                      ),
                    ),
                    const Divider(height: 1),
                    _opcao(
                      Icons.notifications_none,
                      'Notificações',
                      aoCarregar: () => _indisponivel(context),
                    ),
                    const Divider(height: 1),
                    _opcao(
                      Icons.shield_outlined,
                      'Privacidade',
                      aoCarregar: () => _indisponivel(context),
                    ),
                    const Divider(height: 1),
                    _opcao(
                      Icons.help_outline,
                      'Ajuda e suporte',
                      aoCarregar: () => _indisponivel(context),
                    ),
                    const Divider(height: 1),
                    _opcao(
                      Icons.info_outline,
                      'Sobre o MyDay',
                      aoCarregar: () => showAboutDialog(
                        context: context,
                        applicationName: 'MyDay',
                        applicationVersion: '1.0.0',
                        applicationLegalese: 'Aplicação para organizar tarefas e atividades diárias.',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () => _terminarSessao(context),
                  child: const Text('Terminar sessão'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}