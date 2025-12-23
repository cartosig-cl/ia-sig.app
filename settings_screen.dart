import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configuración',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: ListTile(
                  title: const Text('Modo Oscuro'),
                  trailing: Switch(
                    value: settings.isDarkMode,
                    onChanged: (value) {
                      settings.toggleDarkMode();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: const Text('Reconocimiento de Voz'),
                  subtitle: const Text('Activar entrada por voz'),
                  trailing: Switch(
                    value: settings.voiceEnabled,
                    onChanged: (value) {
                      settings.toggleVoiceEnabled();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: const Text('Modo Sin Conexión'),
                  subtitle: const Text('Usar solo modelos locales'),
                  trailing: Switch(
                    value: settings.offlineMode,
                    onChanged: (value) {
                      settings.toggleOfflineMode();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: const Text('Idioma'),
                  subtitle: const Text('Español'),
                  trailing: DropdownButton<String>(
                    value: settings.language,
                    items: const [
                      DropdownMenuItem(
                        value: 'es',
                        child: Text('Español'),
                      ),
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('English'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        settings.setLanguage(value);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Acerca de',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'IA Experta en SIG y Procesamiento Digital de Imágenes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Versión 1.0.0',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Esta aplicación combina inteligencia artificial con tecnologías SIG y procesamiento de imágenes para brindar asistencia experta en análisis geoespacial y visual.',
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Desarrollado con Flutter, TensorFlow Lite, OpenCV y Ollama',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}