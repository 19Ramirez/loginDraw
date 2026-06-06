import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7B2FBE),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      // Ruta inicial
      initialRoute: '/login',
      // Definición de rutas nombradas
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
      },
      // Manejo de rutas desconocidas (404)
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => NotFoundScreen(routeName: settings.name ?? 'unknown'),
        );
      },
    );
  }
}

// ─── Pantalla 404 - Ruta no encontrada ──────────────────────────────────────
class NotFoundScreen extends StatelessWidget {
  final String routeName;

  const NotFoundScreen({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4A90D9),
              Color(0xFF7B2FBE),
              Color(0xFFE91E8C),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              const Text(
                '404',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Página no encontrada',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '"/$routeName"',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                icon: const Icon(Icons.home_rounded),
                label: const Text('Volver al inicio'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF7B2FBE),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
