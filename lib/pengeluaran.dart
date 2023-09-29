import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lsp_thosin/database/databaseHelper.dart';

import 'CashFlowPage.dart';

class PengeluaranPage extends StatefulWidget {
  final int id_user;
  const PengeluaranPage({Key key, @required this.id_user}) : super(key: key);

  @override
  _PengeluaranPageState createState() => _PengeluaranPageState();
}

class _PengeluaranPageState extends State<PengeluaranPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pengeluaran'),
        backgroundColor: Colors.grey.shade700,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Tambah Pengeluaran',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: selectedDate == null
                      ? ''
                      : DateFormat('dd-MM-yyyy').format(selectedDate),
                ),
                decoration: InputDecoration(
                  labelText: 'Tanggal',
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    color: Colors.grey.shade700,
                    onPressed: () async {
                      final selected = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selected != null) {
                        setState(() {
                          selectedDate = selected;
                        });
                      }
                    },
                  ),
                ),
              ),
              TextFormField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Nominal Uang',
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                ),
                keyboardType: TextInputType.number, // Keyboard tipe angka
                onChanged: (value) {
                  if (value.isEmpty) return;
                  if (double.tryParse(value) == null) {
                    amountController.clear();
                  }
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Keterangan',
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedDate = DateTime(2021, 1, 1);
                    amountController.clear();
                    descriptionController.clear();
                  });
                },
                child: Text('Reset'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (amountController.text.isEmpty ||
                      descriptionController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Data tidak boleh kosong.'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    DatabaseHelper().addOutcome(
                        widget.id_user,
                        selectedDate.toString(),
                        int.parse(amountController.text),
                        descriptionController.text,
                        context);
                  }
                },
                child: Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Kembali'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
