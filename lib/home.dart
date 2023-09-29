import 'package:flutter/material.dart';
import 'package:lsp_thosin/database/databaseHelper.dart';
import 'package:lsp_thosin/setting.dart';

import 'CashFlowPage.dart';
import 'pemasukan.dart';
import 'pengeluaran.dart';

class HomePage extends StatefulWidget {
  final int id_user;
  const HomePage({Key key, @required this.id_user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<int> income;
  Future<int> outcome;

  @override
  void initState() {
    super.initState();
    income = DatabaseHelper().totalIncome(id_user: widget.id_user);
    outcome = DatabaseHelper().totalOutcome(id_user: widget.id_user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.grey.shade700,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Rangkuman Bulan Ini',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          FutureBuilder<int>(
            future: income,
            builder: (context, incomeSnapshot) {
              if (incomeSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (incomeSnapshot.hasError) {
                return Text("Error: ${incomeSnapshot.error}");
              } else {
                return Text(
                  "Pemasukan: Rp.${incomeSnapshot.data}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.green,
                  ),
                );
              }
            },
          ),
          FutureBuilder<int>(
            future: outcome,
            builder: (context, outcomeSnapshot) {
              if (outcomeSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (outcomeSnapshot.hasError) {
                return Text("Error: ${outcomeSnapshot.error}");
              } else {
                return Text(
                  "Pengeluaran: Rp.${outcomeSnapshot.data}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                  ),
                );
              }
            },
          ),
          SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PemasukanPage(
                                id_user: widget.id_user,
                              )));
                },
                icon: Icon(Icons.attach_money),
                label: Text('Pemasukan'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PengeluaranPage(
                                id_user: widget.id_user,
                              )));
                },
                icon: Icon(Icons.money_off),
                label: Text('Pengeluaran'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CashFlowPage(
                                id_user: widget.id_user,
                              )));
                },
                icon: Icon(Icons.list),
                label: Text('Detail Cash Flow'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingPage(
                                id_user: widget.id_user,
                              )));
                },
                icon: Icon(Icons.settings),
                label: Text('Setting'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
