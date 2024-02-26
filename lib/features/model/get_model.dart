class StudentModel {
  String? id;
  String? name;
  String? age;

  StudentModel({required this.name, required this.age, this.id});
  factory StudentModel.fromJson(json) {
    return StudentModel(
      id: json['_id'],
      name: json['title'],
      age: json['description'],
    );
  }
  static Map<String, dynamic> toMap(StudentModel studentObj) => {
        'title': studentObj.name!,
        'description': studentObj.age,
        '_id': studentObj.id
      };
}
// {
//   "title": "string",
//   "description": "string",
//   "is_completed": false
// }