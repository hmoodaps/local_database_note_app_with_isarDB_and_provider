import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/isar_database/modelDB.dart';

import 'Home/home.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDB.initDB();
  runApp(ChangeNotifierProvider(create:(context )=> NoteDB(),child: const MyApp(),));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
