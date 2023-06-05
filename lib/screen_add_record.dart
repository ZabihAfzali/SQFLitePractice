
import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflitepractice/student_database.dart';

import 'model_student.dart';

class ScreenAddRecord extends StatefulWidget{

  const ScreenAddRecord ({Key? key}): super (key:key);

  @override
  State<ScreenAddRecord> createState()=>_ScreenAddRecordState();

}

class _ScreenAddRecordState extends State<ScreenAddRecord>{


  String id="";
  String name="";

  DatabaseStudent databaseStudent=DatabaseStudent();

  @override
  void initiate(){
    super.initState();

    setState(() {
      databaseStudent.initializeDatabase();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Add Record"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              onChanged: (String value){
                setState(() {
                  id=value;
                  print("ID: $id");
                });
              },
            ),
            SizedBox(height:20),
            TextFormField(
              onChanged: (String value){
                setState(() {
                  name=value;
                  print("Name: $name");
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                TextButton(onPressed: (){

                    ModelStudent modelSt = ModelStudent(

                        name: name, id: int.parse(id));
                    if(id.isNotEmpty) {
                    databaseStudent.initializeDatabase().then((value){
                      databaseStudent.UpdateStudent(modelSt).then((value) {
                        if (value) {
                          print("Record updated successfuly");
                        } else {
                          print("Record updation failed");
                        };
                      });
                    });
                  }else{
                    print("Please  enter id");
                  }
                },
                  child: Text("Update Record")),

                TextButton(
                    onPressed: () async {
                      ModelStudent modelStudent = ModelStudent(id: int.parse(id)
                          , name: name);
                      databaseStudent.AddStudent(modelStudent).then((value){
                        if(value){
                          print("Student Record added");

                        }
                        else{
                          print("Record insertion failed");
                        }

                      });
                    },
                    child: Text("Add Record")),



              ],
            ),
            SizedBox(height: 20),
            Row(
            children: [
              TextButton(
                  onPressed: () async {

                    databaseStudent.DeleteByStudentId(id).then((value){
                      if(value){
                        print("Record Delete by Single ID");

                      }
                      else{
                        print("Record deletion by id failed");
                      }

                    });
                  },
                  child: Text("Delete Single Record")),




              TextButton(
                  onPressed: () async {

                    databaseStudent.DeleteAllStudent().then((value){
                      if(value){
                        print("All Student Record Deleted");

                      }
                      else{
                        print("Record deletion failed");
                      }

                    });
                  },
                  child: Text("Delete All Record")),




            ],
            ),


            SizedBox(height: 20),
            Row(
              children: [
                TextButton(
                    onPressed: () async {

                      databaseStudent.GetCountStudent().then((value){
                          print("Count record: $value");


                          //print("Record deletion by id failed");

                      });
                    },
                    child: Text("Count record")),




                TextButton(
                    onPressed: () async {

                      databaseStudent.GetAllStudents().then((List<ModelStudent> list){
                      list.forEach((element) {
                        print("Id: ${element.id} Name: ${element.name }");
                      });



                          //print("Record deletion failed");


                      });
                    },
                    child: Text("Display Record")),




              ],
            )



          ],
        )


      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}