import 'package:behtarino/Models/ChatModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBase {
  Future<Database> initializeDB(String token) async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, '$token.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE $token (id INTEGER PRIMARY KEY AUTOINCREMENT, userMessage TEXT NOT NULL,serverMessage TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertChat(List chatList, String token) async {
    token = token.replaceAll(' ', '');

    int result = 0;
    final Database db = await initializeDB(token);

    for (var chat in chatList) {
      result = await db.insert(token, chat.toMap());
    }

    return result;
  }

  Future<List<ChatModel>> grabChat(
    var token,
  ) async {
    token = token.replaceAll(' ', '');

    // String tok = token.toString();
    final Database db = await initializeDB(token);
    final List<Map<String, Object?>> result = await db.query(token);
    return result.map((e) => ChatModel.fromMap(e)).toList();
  }

  Future<void> deleteUser(int id, String token) async {
    token = token.replaceAll(' ', '');

    final db = await initializeDB(token);
    await db.delete(
      token,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> updateUser(int id, String token, String type) async {
    token = token.replaceAll(' ', '');

    final db = await initializeDB(token);
    await db.update(
      token,
      type == "u" ? {'userMessage': ""} : {'serverMessage': ""},
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
