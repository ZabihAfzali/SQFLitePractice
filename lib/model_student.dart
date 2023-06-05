

class ModelStudent{
  int?  id;
  String? name;

  ModelStudent({required this.name,required this.id});

  Map<String, dynamic> toMap()=>{"id":id,"name":name}; // returns the maps with values to parent class

  factory ModelStudent.madeObjectFromMap(Map<String, dynamic> map_value)=>
      ModelStudent(
          name: map_value["name"],
          id: map_value["id"]);

}



/*


class ModelUser{

  ModelStudent modelStudent=ModelStudent(name: "zabi", id: 2112)

  int?  id;
  String? userId;
  String? name;
  String? email;
  String? home;
  String? fcm;

  ModelUser({this.email,this.id,this.userId,this.name,this.home,this.fcm});

  factory ModelUser.fromMap(Map<String, dynamic> json)=> ModelUser(
    id:json["id"],
    userId: json["user_id"],
    name: json["name"],
    email: json["email"],
    home: json["home"],
    fcm: json["fcm"],
  );

  Map<String, dynamic> toMap()=>{
    "user_id": userId,
    "name":name,
    "email":email,
    "home":home,
    "fcm":fcm,
  };

}
*/