import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/contato.dart';
import '../widgets/contato_card.dart';
import '../widgets/empty_state.dart';
import 'form_contato_screen.dart';

/// Tela principal que lista os contatos
class ListaContatosScreen extends StatefulWidget {
  const ListaContatosScreen({Key? key}) : super(key: key);

  @override
  State<ListaContatosScreen> createState() => _ListaContatosScreenState();
}

class _ListaContatosScreenState extends State<ListaContatosScreen> {
  final _db = DatabaseHelper.instance;
  List<Contato> _contatos = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadContatos();
  }

  Future<void> _loadContatos() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final list = await _db.readAll();
      setState(() {
        _contatos = list;
      });
    } catch (e) {
      setState(() {
        _error = 'Erro ao carregar contatos';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _onDelete(Contato contato) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Contato?'),
        content: const Text('Esta ação não poderá ser desfeita.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await _db.delete(contato.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('✓ Contato excluído com sucesso!'),
            backgroundColor: Colors.teal),
      );
      await _loadContatos();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('✗ Erro ao excluir contato'),
            backgroundColor: Colors.red),
      );
    }
  }

  void _onEdit(Contato contato) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormContatoScreen(contato: contato)));
    await _loadContatos();
  }

  void _onAdd() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const FormContatoScreen()));
    await _loadContatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Meus Contatos'),
            Text('${_contatos.length} contatos',
                style: const TextStyle(fontSize: 12)),
          ],
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _loadContatos,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text(_error!))
                : _contatos.isEmpty
                    ? const EmptyState(
                        title: 'Nenhum contato encontrado',
                        subtitle: 'Toque em + para adicionar')
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 12, bottom: 80),
                        itemCount: _contatos.length,
                        itemBuilder: (context, index) {
                          final c = _contatos[index];
                          return ContatoCard(
                            contato: c,
                            onEdit: () => _onEdit(c),
                            onDelete: () => _onDelete(c),
                          );
                        },
                      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}
