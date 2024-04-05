import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/isar_database/modelDB.dart';

import 'home.dart';

class UpdateNote extends StatelessWidget {
  final String title;
  final String desc;
  final String createAt;
  final int id;

  UpdateNote({
    super.key,
    required this.title,
    required this.desc,
    required this.createAt,
    required this.id,
  });

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = title;
    descController.text = desc;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<NoteDB>().noteUpdate(id, descController.text,
                    titleController.text, DateTime.now());
                Navigator.popUntil(context, ModalRoute.withName('/'));

              },
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.black),
                maxLines: null,
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                maxLines: null,
                controller: descController,
                decoration: InputDecoration(
                  counterText: 'Created on $createAt',
                  labelText: 'Description',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
