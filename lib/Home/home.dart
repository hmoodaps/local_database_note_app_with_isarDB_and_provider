import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Home/read.dart';
import 'package:untitled1/Home/update.dart';
import 'package:untitled1/isar_database/modelDB.dart';
import 'package:untitled1/isar_database/mydb.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readNote();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  //Create a note
  createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Create a note',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter youre title',
                  label: Text('Title'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descController,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your description',
                  label: Text('Description'),
                ),
                maxLines: 6,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              titleController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          TextButton(
            onPressed: () {
              context.read<NoteDB>().addNote(
                  titleController.text, descController.text, DateTime.now());
              descController.clear();
              titleController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  //Read note
  readNote() {
    context.read<NoteDB>().fetchNotes();
  }


  @override
  Widget build(BuildContext context) {
    //Note database
    final noteDatabase = context.watch<NoteDB>();
    //current notes
    List<NoteModel> currentNotes = noteDatabase.notes;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notes',style: TextStyle(fontWeight: FontWeight.bold , fontSize: 30),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: currentNotes.isEmpty
          ? const Center(
              child: Text(
                'there no notes yet \n try to add some ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];
                return listTileItem(note);
                //(title: Text(note.title!),subtitle: Text(note.text!),);
              }),
    );
  }

  Widget listTileItem(NoteModel note) => MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReadeNote(
                        title: note.title!,
                        desc: note.text!,
                        createAt:
                            '${note.createdAt?.day}-${note.createdAt?.month}-${note.createdAt?.year} ${note.createdAt?.hour}:${note.createdAt?.minute}',
                      )));
        },
        child: Slidable(
          endActionPane: ActionPane(
            motion: Container(
                color: Colors.red,
                child: IconButton(
                    onPressed: () {
                      context.read<NoteDB>().deleteNote(note.id);
                    },
                    icon: const Icon(Icons.delete))),
            children: const [],
          ),
          child: Card(
            child: Container(
              color: Colors.blue[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Text(
                    note.text!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                          '${note.createdAt?.day}-${note.createdAt?.month}-${note.createdAt?.year} ${note.createdAt?.hour}:${note.createdAt?.minute}'),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateNote(
                                          id: note.id,
                                          title: note.title!,
                                          desc: note.text!,
                                          createAt:
                                              '${note.createdAt?.day}-${note.createdAt?.month}-${note.createdAt?.year} ${note.createdAt?.hour}:${note.createdAt?.minute}',
                                        )));
                          },
                          icon: const Icon(
                            Icons.edit_note_outlined,
                            color: Colors.green,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}



