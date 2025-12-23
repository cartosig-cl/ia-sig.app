# IA Experta en SIG y Procesamiento Digital de Imágenes

Aplicación móvil de inteligencia artificial especializada en Sistemas de Información Geográfica (SIG) y procesamiento digital de imágenes.

## Características principales

- 🤖 Agente IA experto en SIG y procesamiento de imágenes
- 🎤 Reconocimiento y síntesis de voz en español
- 💬 Interfaz de chat por texto y voz
- 🗺️ Funcionalidades SIG completas
- 📸 Procesamiento de imágenes avanzado
- 💾 Almacenamiento local (funciona sin conexión)
- 🌐 Interfaz completamente en español

## Requisitos previos

1. Flutter SDK (versión 3.10 o superior)
2. Android Studio
3. Teléfono Android con depuración USB habilitada

## Instalación

1. Clona este repositorio:
   ```bash
   git clone <url_del_repositorio>
   cd ia_sig_experta
   ```

2. Instala las dependencias:
   ```bash
   flutter pub get
   ```

3. Verifica la configuración:
   ```bash
   flutter doctor
   ```

## Ejecutar en dispositivo Android

1. Conecta tu teléfono Android al PC mediante USB
2. Asegúrate de que la depuración USB está habilitada
3. Verifica que el dispositivo es detectado:
   ```bash
   flutter devices
   ```

4. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

## Compilar para distribución

Para generar un APK de release:
```bash
flutter build apk --release
```

El APK se generará en `build/app/outputs/flutter-apk/app-release.apk`

## Estructura del proyecto

- `lib/` - Código fuente principal
- `lib/screens/` - Pantallas de la aplicación
- `lib/services/` - Servicios (IA, voz, SIG, imágenes)
- `lib/providers/` - Gestión de estado
- `assets/` - Recursos (imágenes, modelos, datos)
- `test/` - Pruebas unitarias

## Tecnologías utilizadas

- Flutter para interfaz multiplataforma
- TensorFlow Lite para IA en dispositivo
- OpenCV para procesamiento de imágenes
- SQLite para almacenamiento local
- VOSK para reconocimiento de voz offline
- Ollama para modelos LLM locales
- Flutter Map para funcionalidades SIG

## Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.