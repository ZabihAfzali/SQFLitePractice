import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:sqflitepractice/model_student.dart';

final String database_name = "student_db";
final String table_name = "student_table";
final String collumn_id = "id";
final String collumn_name = "name";

class DatabaseStudent {

  static DatabaseStudent? _databaseStudent;


  DatabaseStudent._createInstance();

  factory DatabaseStudent() {
    if (_databaseStudent == null) {
      _databaseStudent = DatabaseStudent._createInstance();
    }
    return _databaseStudent!;
  }


  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }



  Future<Database> initializeDatabase() async {
    try {
      var databasePath = await getDatabasesPath();

      String path = p.join(databasePath, database_name);

      Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) {
          db.execute('''
        create table $table_name(
        $collumn_id INTEGER PRIMARY KEY,
        $collumn_name text not null
        )
        ''');

        },
      );
      return database;
     } catch (e) {
      print("Database error ${e.toString()}");
      return null!;
    }
  }

  Future<bool> AddStudent(ModelStudent modelStudent) async {
     try{
      Database db = await this.database;
      var result =  await db.insert(table_name , modelStudent.toMap());
      print("Database result ${result}");
      return true;
    }
    catch(e){
      print("Database add Error ${e.toString()}");
      return false;
    }
  }





  Future<bool> UpdateStudent(ModelStudent modelStudent) async{
    try{
      Database db = await this.database;
      var result =  await db.update(
        table_name ,
        modelStudent.toMap(),
        where:"$collumn_id = ?" ,
        whereArgs: [modelStudent.id],
      );
      print("Database result ${result}");
      return true;
    }
    catch(e){
      print("Database update id Error ${e.toString()}");
      return false;
    }
  }

  Future<bool> DeleteAllStudent() async{
    try{
      Database db=await this.database;
      var result= await db.delete(table_name);
      return true;
    }
    catch (e) {
      print("Database error in Delete function ${e.toString()}");
      return false;
    }
  }

  Future<bool> DeleteByStudentId (String id) async{
    try{
      Database db=await this.database;
      var result=await db.delete(table_name, where: "$collumn_id=?", whereArgs: [id]);
      print("Database error result: $result");
      return true;
    }
    catch (e) {
      print("Database error in Delete function ${e.toString()}");
      return false;
    }
  }


  Future<List<ModelStudent>> GetAllStudents() async{

    List<ModelStudent> list_student=[];
    try{
      Database db=await this.database;
      List<Map<String, dynamic>> result=await db.query(table_name, orderBy: "$collumn_id DESC");
      if(result.length>0){
      for(int i=0; i<result.length; i++){
        ModelStudent modelStudent=ModelStudent.madeObjectFromMap(result[i]);
        list_student.add(modelStudent);
      }
      }
      return list_student;
    }

    catch (e) {
      print("Database error in Get All student function ${e.toString()}");
      return list_student;
    }
  }



  Future<int> GetCountStudent() async{


    try{
      Database db=await this.database;
      List<Map<String, dynamic>> result=await db.query(table_name);

      return result.length;
    }

    catch (e) {
      print("Database error in Get All student Count function ${e.toString()}");
      return 0;
    }
  }


}
