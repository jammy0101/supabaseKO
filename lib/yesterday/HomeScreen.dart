import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//for supabase
final SupabaseClient supabase = Supabase.instance.client;
//for noteController
final TextEditingController noteController = TextEditingController();
//to listen the data
final _noteStream = supabase.from('notes').stream(primaryKey: ['id']);

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text('Note'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Center(child: Text('NOTE')),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: noteController,
                      decoration: InputDecoration(
                        hintText: 'Enter the note..',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          final value = noteController.text.trim();
                          if (value.isNotEmpty) {
                            await supabase.from('notes').insert({
                              'body': value,
                            });
                          }
                          Navigator.pop(context);
                        },
                        child: Text('Confirm'),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      //here is the stream builder to listen the data from supabase
      body: StreamBuilder(
        stream: _noteStream,
        builder: (context, snapshot) {
          //it will show the circular indicator when there is no data
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          //if there is data
          final notes = snapshot.data!;
          //the print that data
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(notes[index]['body']));
            },
          );
        },
      ),
    );
  }
}
