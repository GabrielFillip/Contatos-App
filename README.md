# Contatos App

Aplicativo Flutter (Android/iOS) para gerenciamento de contatos bancários com persistência local via SQLite. O projeto segue os tokens de design fornecidos, entrega fluxo CRUD completo e garante feedbacks de UI claros em cada etapa.

## ✨ Destaques
- CRUD completo com `sqflite` (listar, criar, editar, remover) e feedback em `SnackBar`
- Tema Material 3 configurado com cores primária `0xFF6200EA` e secundária `0xFF00BFA5`
- Validação de nome e número da conta com mensagens contextuais
- Estado vazio ilustrado, indicador de carregamento e diálogo de confirmação para exclusão
- Arquitetura simples: camada de dados (`DatabaseHelper`), modelo (`Contato`) e telas desacopladas
- Teste widget configurado com `sqflite_common_ffi` para garantir que a home renderize corretamente

## 🧱 Arquitetura e Decisões
- **Persistência**: `DatabaseHelper` encapsula o acesso ao SQLite usando padrão singleton.
- **Camadas**: `models`, `database`, `utils/validators`, `widgets` reutilizáveis e `screens` com controle de estado local.
- **Feedbacks**: `SnackBar`, `AlertDialog` e `EmptyState` garantem UX consistente.
- **Tratamento de erros**: cada operação assíncrona persiste `try/catch` com mensagens adequadas.
- **Testabilidade**: widget test inicializa FFI para usar SQLite em memória durante testes.

## 🛠 Pré-requisitos
- Flutter 3.22+ (Dart >= 3.4; compatível com o intervalo `>=2.18.0 <4.0.0`)
- Android Studio ou Xcode configurados para execução em emulador/dispositivo físico
- Android NDK 27.0.12077973 (alinhar em `android/app/build.gradle` caso necessário)

## 🚀 Executando o projeto
No PowerShell ou terminal de sua escolha:

```powershell
cd "c:/Users/gabri/Desktop/Contatos App"
flutter pub get
flutter run
```

> Dica: se você clonou o repositório sem as pastas de plataforma, rode `flutter create .` uma vez para gerar os diretórios `android/` e `ios/`.

### Rodando testes

```powershell
flutter test
```

O teste de widget utiliza `sqflite_common_ffi` e um `FakePathProvider` para simular caminhos válidos em ambiente de teste.

## 📁 Estrutura do projeto

```
lib/
	main.dart
	database/
		database_helper.dart
	models/
		contato.dart
	screens/
		lista_contatos_screen.dart
		form_contato_screen.dart
	utils/
		validators.dart
	widgets/
		contato_card.dart
		empty_state.dart
		custom_button.dart
assets/
	icons/
		app_logo.png
		empty_contacts.png
		person_placeholder.png
test/
	widget_test.dart
```

## 📸 UI & Fluxos
- **Lista de Contatos**: exibe loading, estado vazio ilustrado e cards com ações de editar/excluir.
- **Formulário de Contato**: valida entradas em tempo real, permite salvar ou excluir (em modo edição).
- **Feedbacks**: confirmações via diálogo, mensagens de sucesso/erro em `SnackBar`.

## 🧪 Qualidade
- Testes de widget com `flutter_test` garantem renderização inicial.
- Tratamento de exceções e mensagens de erro em operações de banco.
- Sugestão: adicionar testes instrumentados para fluxos completos em futuras iterações.

## 🎨 Design & Assets
- Tokens de cor e tipografia seguem especificação do desafio.
- Ícones fornecidos em `assets/icons/` (PNG com fundo transparente, @2x/@3x):
	- `Back_Arrow.png`
	- `Done.png`
	- `Pen.png`
	- `Plus.png`
	- `Trash.png`
- Se desejar adicionar ilustrações adicionais (ex.: estado vazio), basta colocar o arquivo na pasta e referenciar no widget correspondente.
- O `pubspec.yaml` já aponta para `assets/icons/`; após incluir novos arquivos execute `flutter pub get`.

## 🔧 Scripts úteis
- `flutter pub run build_runner build` (se futuramente adicionar geração de código)
- `flutter format lib` para manter padronização de código

## 🧭 Roadmap sugerido
- [ ] Persistir favoritos e filtragem por categoria
- [ ] Internacionalização (pt-BR ↔ en-US) com `flutter_localizations`
- [ ] Upload de avatar com integração a câmera/galeria
- [ ] Testes de integração cobrindo fluxo CRUD completo

## 🤝 Contribuindo
1. Crie um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nome-feature`)
3. Execute `flutter format` e `flutter test`
4. Abra um Pull Request descrevendo as mudanças e print(s) da tela

## 📄 Licença
Projeto acadêmico — utilize livremente para estudos e evolução pessoal. Para uso comercial, adapte conforme necessário e insira a licença de sua preferência.
