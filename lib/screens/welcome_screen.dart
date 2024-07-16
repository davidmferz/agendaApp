import 'package:flutter/material.dart';
import 'add_event_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido a la Agenda'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/user.jpg',
              width: 200, // Ajusta el ancho
              height: 200, // Ajusta la altura
              fit: BoxFit
                  .cover, // Ajusta cómo se recorta la imagen para que se ajuste al contenedor
            ),
            const SizedBox(height: 20),
            const Text(
              'Bienvenido a la Agenda de Eventos',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddEventScreen()),
                );
              },
              child: const Text('Añadir Evento'),
            ),
          ],
        ),
      ),
    );
  }
}
