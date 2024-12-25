import 'dart:math' as math;
import 'package:path/path.dart' as pathLib;
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class App3 extends StatefulWidget {
  const App3({super.key});

  @override
  State<App3> createState() => _AppState();
}

class _AppState extends State<App3> {
  late Database db;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<String> get getDbPath async => await getDatabasesPath();

  Future<void> _init() async {
    var databasePath = await getDbPath;
    String dbPath = pathLib.join(databasePath, 'demo.db');
    db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)',
        );
      },
    );
    showMessage('DB opened');
    setState(() {
      isLoading = false;
    });
  }

  void showMessage(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> deleteDB() async {
    var databasePath = await getDbPath;
    await deleteDatabase(pathLib.join(databasePath, 'demo.db'));
    showMessage('DB deleted');
  }

  @override
  void dispose() {
    db.close();
    super.dispose();
  }

  Future<void> insertIntoDB() async {
    await db.transaction((txn) async {
      int id1 = await txn.rawInsert(
        'INSERT INTO Test(name, value, num) VALUES("some name", ?, ?)',
        [math.Random().nextInt(1000), math.Random().nextDouble()],
      );
      print('Inserted: $id1');
    });
    setState(() {});
  }

  Future<void> updateIntoDB() async {
    await db.rawUpdate(
      'UPDATE Test SET name = ?, value = ? WHERE name = ?',
      ['updated name', 9876, 'some name'],
    );
    setState(() {});
  }

  Future<List<Map<String, dynamic>>> getDataFromDB() async {
    return await db.rawQuery('SELECT * FROM Test');
  }

  Future<void> clearDB() async {
    await db.rawDelete('DELETE FROM Test');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: insertIntoDB,
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: updateIntoDB,
            icon: const Icon(Icons.update),
          ),
          IconButton(
            onPressed: clearDB,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : FutureBuilder<List<Map<String, dynamic>>>(
              future: getDataFromDB(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return Row(
                      children: [
                        Expanded(child: Text(item['id'].toString())),
                        Expanded(child: Text(item['name'].toString())),
                        Expanded(child: Text(item['value'].toString())),
                        Expanded(child: Text(item['num'].toString())),
                      ],
                    );
                  },
                );
              },
            ),
    );
  }
}
