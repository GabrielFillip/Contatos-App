import 'package:flutter/material.dart';

/// Widget para estado vazio
class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? assetPath;

  const EmptyState({
    Key? key,
    this.title = 'Nenhum contato',
    this.subtitle = 'Adicione um novo contato usando o botão +',
    this.assetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (assetPath != null) ...[
              Image.asset(assetPath!, width: 160, height: 160),
              const SizedBox(height: 16),
            ],
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
