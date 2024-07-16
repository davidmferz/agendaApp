import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/screens/welcome_screen.dart';
import 'dart:convert';
import 'package:xml/xml.dart'; // Importa el paquete xml

class EventSummaryScreen extends StatefulWidget {
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
  _EventSummaryScreenState createState() => _EventSummaryScreenState();
}

class _EventSummaryScreenState extends State<EventSummaryScreen> {
  String _displayFormat = 'Texto';

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    String getSummaryText() {
      return '''
Nombre del evento: ${widget.title}
Tipo de evento: ${widget.eventType}
Fecha inicio: ${dateFormat.format(widget.startDate)}
Fecha fin: ${dateFormat.format(widget.endDate)}
Todo el día: ${widget.allDay ? 'Sí' : 'No'}
Descripción: ${widget.description}
''';
    }

    String getSummaryJson() {
      final event = {
        'title': widget.title,
        'eventType': widget.eventType,
        'startDate': widget.startDate.toIso8601String(),
        'endDate': widget.endDate.toIso8601String(),
        'allDay': widget.allDay,
        'description': widget.description,
      };
      return jsonEncode(event);
    }

    String getSummaryXml() {
      final builder = XmlBuilder();
      builder.element('event', nest: () {
        builder.element('title', nest: widget.title);
        builder.element('eventType', nest: widget.eventType);
        builder.element('startDate', nest: widget.startDate.toIso8601String());
        builder.element('endDate', nest: widget.endDate.toIso8601String());
        builder.element('allDay', nest: widget.allDay);
        builder.element('description', nest: widget.description);
      });
      return builder.buildDocument().toString();
    }

    String getSummary() {
      switch (_displayFormat) {
        case 'JSON':
          return getSummaryJson();
        case 'XML':
          return getSummaryXml();
        default:
          return getSummaryText();
      }
    }

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
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text('Inicio'),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _displayFormat,
              items: ['Texto', 'JSON', 'XML']
                  .map((format) => DropdownMenuItem(
                        value: format,
                        child: Text(format),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _displayFormat = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(getSummary()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
