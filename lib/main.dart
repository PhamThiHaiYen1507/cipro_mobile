import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Future<void> main() async {
//   configureDependencies();
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Database database;

  @override
  void initState() {
    super.initState();
    _setupDatabase();
  }

  Future<void> _setupDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'example.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY,
            name TEXT
          )
        ''');
        await db.insert('users', {'id': 1, 'name': 'Alice'});
        await db.insert('users', {'id': 2, 'name': 'Bob'});
      },
    );
  }

  Future<String> _getUserById(String userId) async {
    try {
      // LỖ HỔNG SQL INJECTION: Chuỗi đầu vào được chèn trực tiếp vào truy vấn
      final result =
          await database.rawQuery('SELECT * FROM users WHERE id = $userId');
      if (result.isNotEmpty) {
        return 'User: ${result.first['name']}';
      } else {
        return 'Không tìm thấy người dùng.';
      }
    } catch (e) {
      return 'Lỗi: $e';
    }
  }

  @override
  void dispose() {
    database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('SQL Injection Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration:
                  const InputDecoration(labelText: 'Nhập ID người dùng'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final result = await _getUserById(controller.text);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Text(result),
                  ),
                );
              },
              child: const Text('Truy vấn'),
            ),
          ],
        ),
      ),
    );
  }
}
