import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'event_summary_screen.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  String _title = '';
  String _eventType = '';
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  bool _allDay = false;
  String _description = '';

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    return picked;
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Nombre del evento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El título no puede estar vacío';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value ?? '';
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Tipo de evento'),
                value: _eventType.isEmpty ? null : _eventType,
                items: ['Cita', 'Aniversario', 'Cuenta atrás']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _eventType = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El tipo de evento no puede estar vacío';
                  }
                  return null;
                },
                onSaved: (value) {
                  _eventType = value ?? '';
                },
              ),
              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(labelText: 'Fecha inicio'),
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await _selectDate(context);
                  if (picked != null) {
                    setState(() {
                      _startDate = picked;
                      _startDateController.text =
                          DateFormat('dd-MM-yyyy').format(picked);
                    });
                  }
                },
                validator: (value) {
                  if (_startDate == null) {
                    return 'La fecha de inicio no puede estar vacía';
                  }
                  return null;
                },
              ),
              if (!_allDay)
                TextFormField(
                  controller: _startTimeController,
                  decoration: const InputDecoration(labelText: 'Hora inicio'),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? picked = await _selectTime(context);
                    if (picked != null) {
                      setState(() {
                        _startTime = picked;
                        _startTimeController.text = picked.format(context);
                      });
                    }
                  },
                  validator: (value) {
                    if (_startTime == null && !_allDay) {
                      return 'La hora de inicio no puede estar vacía';
                    }
                    return null;
                  },
                ),
              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(labelText: 'Fecha fin'),
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await _selectDate(context);
                  if (picked != null) {
                    setState(() {
                      _endDate = picked;
                      _endDateController.text =
                          DateFormat('dd-MM-yyyy').format(picked);
                    });
                  }
                },
                validator: (value) {
                  if (_endDate == null && !_allDay) {
                    return 'La fecha de fin no puede estar vacía';
                  }
                  return null;
                },
              ),
              if (!_allDay)
                TextFormField(
                  controller: _endTimeController,
                  decoration: const InputDecoration(labelText: 'Hora fin'),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? picked = await _selectTime(context);
                    if (picked != null) {
                      setState(() {
                        _endTime = picked;
                        _endTimeController.text = picked.format(context);
                      });
                    }
                  },
                  validator: (value) {
                    if (_endTime == null && !_allDay) {
                      return 'La hora de fin no puede estar vacía';
                    }
                    return null;
                  },
                ),
              CheckboxListTile(
                title: const Text('Todo el día'),
                value: _allDay,
                onChanged: (value) {
                  setState(() {
                    _allDay = value ?? false;
                    if (_allDay) {
                      _startTime = null;
                      _endTime = null;
                      _startTimeController.clear();
                      _endTimeController.clear();
                    }
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descripción'),
                onSaved: (value) {
                  _description = value ?? '';
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventSummaryScreen(
                              title: _title,
                              eventType: _eventType,
                              startDate: _startDate!,
                              endDate: _endDate!,
                              allDay: _allDay,
                              description: _description,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Confirmar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
