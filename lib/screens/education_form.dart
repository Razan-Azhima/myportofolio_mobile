import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<StatefulWidget> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _institution = "";
  String _degree = "";
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isStill = false;
  String _period = "";

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  void _updatePeriod() {
    if (_startDate == null) {
      _period = "";
      return;
    }

    final start = _formatDate(_startDate!);
    final end = _isStill
        ? "Sekarang"
        : _endDate == null
        ? ""
        : _formatDate(_endDate!);

    _period = "$start - $end";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Education Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // institution
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Institusi",
                    labelText: "Nama Institusi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _institution = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama Institusi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              // degree atau keminatan
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Prodi/Keminatan",
                    labelText: "Nama Prodi/Keminatan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _degree = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama Prodi/Keminatan tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // == Periode ==
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // start
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "",
                          labelText: "Start Periode",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          suffixIcon: const Icon(Icons.calendar_today),
                        ),
                        controller: TextEditingController(
                          text: _startDate == null
                              ? ""
                              : "${_startDate!.day}/${_startDate!.month}/${_startDate!.year}",
                        ),
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _startDate ?? DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            setState(() {
                              _startDate = pickedDate;
                              _updatePeriod();
                              if (_endDate != null &&
                                  _endDate!.isBefore(pickedDate)) {
                                _endDate = null;
                              }
                            });
                          }
                        },
                        validator: (_) {
                          if (_startDate == null) {
                            return "Wajib diisi!";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    // end
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        enabled: !_isStill,
                        decoration: InputDecoration(
                          hintText: "",
                          labelText: "End Period",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          suffixIcon: const Icon(Icons.calendar_today),
                        ),
                        controller: TextEditingController(
                          text: _isStill
                              ? "Sekarang"
                              : _endDate == null
                              ? ""
                              : "${_endDate!.day}/${_endDate!.month}/${_endDate!.year}",
                        ),
                        onTap: _isStill
                            ? null
                            : () async {
                                final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: _endDate ?? DateTime.now(),
                                  firstDate: _startDate ?? DateTime(1950),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    _endDate = pickedDate;
                                    _updatePeriod();
                                  });
                                }
                              },
                        validator: (_) {
                          if (!_isStill && _endDate == null) {
                            return "Wajib diisi";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              CheckboxListTile(
                title: const Text("Masih berlangsung"),
                value: _isStill,
                onChanged: (value) {
                  setState(() {
                    _isStill = value ?? false;

                    if (_isStill) {
                      _endDate = null;
                    }

                    _updatePeriod();
                  });
                },
              ),

              // tombol simpan
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Edukasi berhasil ditambahkan!",
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Institusi: $_institution'),
                                    Text('Prodi/Keminatan: $_degree'),
                                    Text('Periode: $_period'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
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
