import 'package:class_manager/models/student.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'class_manager.db';
  static const _databaseVersion = 1;
  static const table = 'students';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> _initDatabase() async{
    String path = join(await getDatabasesPath(),_databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> _onCreate(Database db, int version) async{
    await db.execute(
      '''
        CREATE TABLE $table(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL, 
          gender TEXT NOT NULL,
          phone TEXT NOT NULL,
          email TEXT NOT NULL,
          className TEXT NOT NULL,
          department TEXT NOT NULL, 
          dateRegistered TEXT NOT NULL,
          present INTEGER NOT NULL DEFAULT 0
        )
      '''
    );
  }

  Future <int> insertStudent(Student student) async{
    Database db = await database;
    return await db.insert(table, student.toMap());
  }

  Future <List<Student>> getAllStudents() async{
    Database db = await database;
    List<Map<String,dynamic>> maps = await db.query(table);
    return List.generate(
      maps.length, 
      (i)=> Student.fromMap(maps[i])
      );
  }

  Future<Student?> getStudent(id) async{
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id]
    );
    if(maps.isNotEmpty){
      return Student.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateStudent(Student student) async{
    Database db = await database;
    return await db.update(
      table, 
      student.toMap(),
      where: 'id=?',
      whereArgs: [student.id],
      );
  }

  Future <int> deleteStudent(int id) async {
    Database db = await database;
    return await db.delete(
      table,
      where: 'id=?',
      whereArgs: [id]
      );
  }

  Future <int> toggleAttendance (int id, bool present) async {
    Database db = await database;
    return await db.update(
      table, 
      {'present' : present? 1 : 0},
      where: 'id=?',
      whereArgs: [id]
      );
  }

  Future <List<Student>> searchStudent(String query) async {
    Database db = await database;
    List<Map<String,dynamic>> maps = await db.query(
      table,
      where: 'name LIKE? OR email LIKE? OR className LIKE? OR department LIKE?',
      whereArgs: ['%$query%', '%$query%', '%$query%', '%$query%']
      );
      return List.generate(
        maps.length, 
        (i) => Student.fromMap(maps[i])
        );
  }
}