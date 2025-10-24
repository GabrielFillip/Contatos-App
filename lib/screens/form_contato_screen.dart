import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/contato.dart';
import '../utils/validators.dart';
import '../widgets/custom_button.dart';

/// Tela de formulário para criar/editar um contato
class FormContatoScreen extends StatefulWidget {
  final Contato? contato;

  const FormContatoScreen({Key? key, this.contato}) : super(key: key);

  @override
  State<FormContatoScreen> createState() => _FormContatoScreenState();
}

class _FormContatoScreenState extends State<FormContatoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _numeroController = TextEditingController();
  bool _isSaving = false;
  final _db = DatabaseHelper.instance;

  bool get isEditMode => widget.contato != null;

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      _nomeController.text = widget.contato!.nome;
      _numeroController.text = widget.contato!.numeroConta;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _numeroController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    try {
      final contato = Contato(
        id: widget.contato?.id,
        nome: _nomeController.text.trim(),
        numeroConta: _numeroController.text.trim(),
      );

      if (isEditMode) {
        await _db.update(contato);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('✓ Contato editado com sucesso !'),
              backgroundColor: Colors.teal),
        );
      } else {
        await _db.create(contato);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('✓ Contato salvo com sucesso !'),
              backgroundColor: Colors.teal),
        );
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('✗ Erro ao salvar contato'),
            backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _delete() async {
    if (!isEditMode) return;
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
      await _db.delete(widget.contato!.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('✓ Contato excluído com sucesso !'),
            backgroundColor: Colors.teal),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('✗ Erro ao excluir contato'),
            backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Editar Contato' : 'Criar Contato'),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            CircleAvatar(
              radius: 40,
              backgroundColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              child: Text(
                (isEditMode ? widget.contato!.nome : ' ')
                    .trim()
                    .split(' ')
                    .where((s) => s.isNotEmpty)
                    .map((s) => s[0])
                    .take(2)
                    .join()
                    .toUpperCase(),
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              onChanged: () => setState(() {}),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration:
                        const InputDecoration(labelText: 'Nome do Contato'),
                    validator: Validators.validarNome,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _numeroController,
                    decoration: const InputDecoration(
                        labelText: 'Número da conta', hintText: 'Ex: 12345-6'),
                    validator: Validators.validarNumeroConta,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed:
                            _isSaving ? null : () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      CustomButton(
                        text: isEditMode ? 'Editar Contato' : 'Salvar Contato',
                        onPressed: _isSaving ? null : _save,
                        isPrimary: true,
                        isLoading: _isSaving,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (isEditMode)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: _isSaving ? null : _delete,
                        icon: const Icon(Icons.delete, color: Colors.red),
                        label: const Text('Excluir',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
