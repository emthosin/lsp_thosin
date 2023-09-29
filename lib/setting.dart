import 'package:flutter/material.dart';
import 'package:lsp_thosin/database/databaseHelper.dart';

class SettingPage extends StatefulWidget {
  final int id_user;
  const SettingPage({Key key, @required this.id_user}) : super(key: key);
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
        backgroundColor: Colors.grey.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the left
          children: <Widget>[
            Text(
              'Pengaturan',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Ganti Password',
              textAlign: TextAlign.left,
            ),
            TextFormField(
              controller: oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password Lama',
                labelStyle: TextStyle(color: Colors.grey.shade700),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
              ),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password Baru',
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
              onPressed: () async {
                if (oldPasswordController.text.isEmpty ||
                    newPasswordController.text.isEmpty) {
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
                  await DatabaseHelper().changePassword(
                      widget.id_user,
                      oldPasswordController.text,
                      newPasswordController.text,
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
            Spacer(), // Add Spacer widget to push everything to the bottom
            // Foto, nama, dan nomor
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(180.0),
                  child: Container(
                    width: 120,
                    height: 120,
                    child:
                        Image.asset('images/profilePic.jpg', fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'About This App',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Text(
                      'Aplikasi ini dibuat oleh:',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Nama: M. Thosin Yuhaililul Hilmi',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'NIM: 2141764032',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Tanggal: 24 September 2023',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
