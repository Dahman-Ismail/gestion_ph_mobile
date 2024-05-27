import 'package:my_new_app/db/db_helper.dart';


void main() async {
  final DBhelper = DBHelper();
  final db = await DBhelper.database;
  if (db.isOpen) {
    print('Database created successfully!');
  } else {
    print('Failed to create the database!');
  }
}