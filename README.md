# Contatos App

Aplicativo Flutter simples para gerenciar contatos com CRUD (Create, Read, Update, Delete).

Estrutura principal criada conforme especificação. Use o Flutter SDK para rodar o app.

Requisitos:
- Flutter SDK (versão compatível com Dart >=2.18)
- Plugins: sqflite, path_provider, path, intl (já configurados no `pubspec.yaml`)

Como rodar:

1. Abra um terminal na pasta do projeto `c:/Users/gabri/Desktop/Contatos App`
2. Rode:

```powershell
flutter pub get
flutter run
```

Notas:
- Adicione os ícones na pasta `assets/icons/` conforme `assets/icons/README.txt` e então descomente o bloco `assets:` no `pubspec.yaml`.
- O Database usa `sqflite` e armazena os dados em um banco local.

Checklist implementado:
- CRUD completo com sqflite
- Validações (nome e número da conta)
- Try/catch em métodos assíncronos e feedback via SnackBar
- Dialog de confirmação para exclusão
- Empty state e loading states
- Tema global aplicado em `main.dart`
