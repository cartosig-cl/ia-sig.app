import 'package:flutter/material.dart';

class ToolsGrid extends StatelessWidget {
  const ToolsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = [
      {
        'title': 'Análisis SIG',
        'icon': Icons.map,
        'description': 'Procesamiento geoespacial avanzado',
      },
      {
        'title': 'Procesamiento de Imágenes',
        'icon': Icons.image,
        'description': 'Análisis y edición de imágenes',
      },
      {
        'title': 'Detección de Objetos',
        'icon': Icons.auto_awesome,
        'description': 'Reconocimiento visual inteligente',
      },
      {
        'title': 'Análisis Espectral',
        'icon': Icons.auto_graph,
        'description': 'Procesamiento de datos espectrales',
      },
      {
        'title': 'Clasificación de Uso de Suelo',
        'icon': Icons.landscape,
        'description': 'Categorización automática',
      },
      {
        'title': 'Análisis de Cambio',
        'icon': Icons.change_circle,
        'description': 'Detección de cambios temporales',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.85,
        ),
        itemCount: tools.length,
        itemBuilder: (context, index) {
          final tool = tools[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Función ${tool['title']} seleccionada'),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      tool['icon'] as IconData,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    tool['title'] as String,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      tool['description'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}