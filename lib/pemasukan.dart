import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lsp_thosin/database/databaseHelper.dart';

import 'CashFlowPage.dart';

class PemasukanPage extends StatefulWidget {
  final int id_user;
  const PemasukanPage({Key key, @required this.id_user}) : super(key: key);

  @override
  _PemasukanPageState createState() => _PemasukanPageState();
}

class _PemasukanPageState extends State<PemasukanPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pemasukan'),
        backgroundColor: Colors.grey.shade700,
      ),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Tambah Pemasukan',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: _selectedDate == null
                      ? ''
                      : DateFormat('dd-MM-yyyy').format(_selectedDate),
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
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selected != null) {
                        setState(() {
                          _selectedDate = selected;
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
                  // Hapus karakter yang bukan angka
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
                  // Tambahkan fungsi untuk mereset inputan
                  setState(() {
                    _selectedDate = DateTime(2021, 1, 1);
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
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                              ),
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    DatabaseHelper().addIncome(
                        widget.id_user,
                        _selectedDate.toString(),
                        int.parse(amountController.text),
                        descriptionController.text,
                        context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
                child: Text('Simpan'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
                child: Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
