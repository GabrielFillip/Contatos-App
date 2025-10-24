import 'package:flutter/material.dart';
import 'screens/lista_contatos_screen.dart';

const primaryColor = Color(0xFF6200EA);

void main() {
  runApp(const ContatosApp());
}

class ContatosApp extends StatelessWidget {
  const ContatosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contatos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          secondary: const Color(0xFF00BFA5),
        ),
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF80CBC4),
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28))),
        ),
      ),
      home: const ListaContatosScreen(),
    );
  }
}
