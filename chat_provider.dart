import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [
    Message(
      text: '¡Hola! Soy tu IA experta en SIG y procesamiento de imágenes. ¿En qué puedo ayudarte hoy?',
      sender: 'ai',
      timestamp: DateFormat('HH:mm').format(DateTime.now()),
    ),
  ];
  
  final TextEditingController _messageController = TextEditingController();
  
  bool _isListening = false;
  bool _isLoading = false;

  List<Message> get messages => _messages;
  TextEditingController get messageController => _messageController;
  bool get isListening => _isListening;
  bool get isLoading => _isLoading;

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    
    // Agregar mensaje del usuario
    _messages.add(Message(
      text: text,
      sender: 'user',
      timestamp: DateFormat('HH:mm').format(DateTime.now()),
    ));
    
    // Limpiar el campo de texto
    _messageController.clear();
    notifyListeners();
    
    // Simular respuesta de la IA
    _simulateAIResponse(text);
  }

  void _simulateAIResponse(String userMessage) {
    _isLoading = true;
    notifyListeners();
    
    // Simular procesamiento
    Future.delayed(const Duration(seconds: 2), () {
      String response;
      
      // Respuestas simuladas según el tipo de consulta
      if (userMessage.toLowerCase().contains('mapa') || 
          userMessage.toLowerCase().contains('sig') ||
          userMessage.toLowerCase().contains('geoespacial')) {
        response = _getSIGResponse(userMessage);
      } else if (userMessage.toLowerCase().contains('imagen') ||
                 userMessage.toLowerCase().contains('foto') ||
                 userMessage.toLowerCase().contains('visual')) {
        response = _getImageProcessingResponse(userMessage);
      } else {
        response = _getGeneralResponse(userMessage);
      }
      
      _messages.add(Message(
        text: response,
        sender: 'ai',
        timestamp: DateFormat('HH:mm').format(DateTime.now()),
      ));
      
      _isLoading = false;
      notifyListeners();
    });
  }

  String _getSIGResponse(String message) {
    final responses = [
      'He analizado tu consulta sobre SIG. Para procesar datos geoespaciales, puedes cargar archivos shapefile o GeoJSON. ¿Qué tipo de análisis necesitas realizar?',
      'Entiendo que necesitas ayuda con sistemas de información geográfica. Puedo ayudarte con análisis espacial, procesamiento de raster, o creación de mapas temáticos. ¿Cuál es tu objetivo específico?',
      'Para trabajar con datos SIG, te recomiendo primero definir el sistema de coordenadas adecuado. ¿Estás trabajando con datos vectoriales o raster?',
      'Puedo realizar análisis de proximidad, cálculos de área y perímetro, o análisis de visibilidad. ¿Qué tipo de operaciones geoespaciales necesitas?',
    ];
    
    return responses[Random().nextInt(responses.length)];
  }

  String _getImageProcessingResponse(String message) {
    final responses = [
      'Para el procesamiento de imágenes, puedo ayudarte con corrección radiométrica, análisis espectral, o detección de bordes. ¿Qué tipo de imagen estás procesando?',
      'Entiendo que necesitas análisis de imágenes. Puedo realizar clasificación supervisada, extracción de características, o análisis de textura. ¿Cuál es tu objetivo?',
      'Para mejorar la calidad de tus imágenes, puedo aplicar filtros espaciales, corrección atmosférica, o realce de contraste. ¿Qué tipo de mejora necesitas?',
      'Puedo detectar objetos específicos en tus imágenes usando técnicas de visión por computadora. ¿Qué elementos estás buscando identificar?',
    ];
    
    return responses[Random().nextInt(responses.length)];
  }

  String _getGeneralResponse(String message) {
    final responses = [
      'Como experta en SIG y procesamiento de imágenes, puedo ayudarte con análisis geoespacial, procesamiento digital de imágenes, y visualización de datos. ¿Qué tipo de proyecto estás desarrollando?',
      'Mi especialidad es combinar técnicas de inteligencia artificial con procesamiento geoespacial e imágenes satelitales. ¿En qué aspecto específico necesitas asistencia?',
      'Puedo ayudarte con cualquier consulta técnica sobre sistemas de información geográfica, análisis espacial, o procesamiento digital de imágenes. ¿Cuál es tu pregunta?',
      'Como asistente especializada, puedo proporcionar orientación experta en aplicaciones SIG, análisis de datos espaciales, y técnicas avanzadas de procesamiento de imágenes. ¿Qué necesitas?',
    ];
    
    return responses[Random().nextInt(responses.length)];
  }

  void toggleListening() {
    _isListening = !_isListening;
    notifyListeners();
    
    if (_isListening) {
      // Simular reconocimiento de voz
      Future.delayed(const Duration(seconds: 3), () {
        if (_isListening) {
          _isListening = false;
          // Simular texto reconocido
          _messageController.text = '¿Cómo puedo procesar una imagen satelital para detectar cambios en el uso del suelo?';
          notifyListeners();
        }
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

class Message {
  final String text;
  final String sender;
  final String timestamp;

  Message({
    required this.text,
    required this.sender,
    required this.timestamp,
  });
}