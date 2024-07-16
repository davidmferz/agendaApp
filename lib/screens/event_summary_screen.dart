import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa el paquete intl

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
    final DateFormat dateFormat =
        DateFormat('dd-MM-yyyy'); // Formateador de fechas

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen del Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Regresar'),
              ),
            ),
            const SizedBox(height: 20),
            Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              children: [
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Nombre del evento'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(title),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Tipo de evento'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(eventType),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Fecha inicio'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(dateFormat.format(startDate)),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Fecha fin'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(dateFormat.format(endDate)),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Todo el día'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(allDay ? 'Sí' : 'No'),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Descripción'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(description),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
