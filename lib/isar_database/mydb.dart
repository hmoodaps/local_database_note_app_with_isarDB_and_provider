import 'package:isar/isar.dart';

//this line need to generate file
//then we need to run : dart run build_runner build >>IN TERMINAL
part 'mydb.g.dart';

@collection
class NoteModel {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String ? title;

  String ? text;

   DateTime ? createdAt;

}