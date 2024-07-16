import 'package:flutter/material.dart';

class EventSummaryScreen extends StatelessWidget {
  final String title;
  final String eventType;
  final DateTime startDate;
  final DateTime endDate;
  final bool allDay;
  final String description;

  const EventSummaryScreen({
    super.key,
    required this.title,
    required this.eventType,
    required this.startDate,
    required this.endDate,
    required this.allDay,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen del Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre del evento: $title'),
            Text('Tipo de evento: $eventType'),
            Text('Fecha inicio: ${startDate.toLocal()}'),
            Text('Fecha fin: ${endDate.toLocal()}'),
            Text('Todo el día: $allDay'),
            Text('Descripción: $description'),
          ],
        ),
      ),
    );
  }
}
