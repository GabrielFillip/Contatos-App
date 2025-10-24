import 'package:flutter/material.dart';

import '../models/contato.dart';

/// Card customizado para exibir um Contato
class ContatoCard extends StatelessWidget {
  final Contato contato;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ContatoCard({
    Key? key,
    required this.contato,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              child: Text(
                _initials(contato.nome),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contato.nome,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    contato.numeroConta,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.black87),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
