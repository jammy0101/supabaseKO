import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

final nStream = supabase.from('notes2').stream(primaryKey: ['id']);
//final TextEditingController notesController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController ageController = TextEditingController();
final TextEditingController rollController = TextEditingController();
final TextEditingController classController = TextEditingController();

final SupabaseClient supabase = Supabase.instance.client;

class _Home2State extends State<Home2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Center(child: Text('Notes')),
                children: [
                  _widget(nameController, 'Entre the name'),
                  _widget(ageController, 'Enter the age'),
                  _widget(classController, 'Enter the class'),
                  _widget(rollController, 'Enter the rollNO'),

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
                          final name = nameController.text.trim();
                          final age = ageController.text.trim();
                          final classK = classController.text.trim();
                          final roll_no = rollController.text.trim();
                          if (name.isNotEmpty &&
                              age != null &&
                              classK.isNotEmpty &&
                              roll_no.isNotEmpty) {
                            await supabase.from('notes2').insert({
                              'name': name,
                              'age': age,
                              'classK': classK,
                              'roll_no': roll_no,
                            });
                            Navigator.pop(context);
                          }
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
      body: StreamBuilder(
        stream: nStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  "Name: ${notes[index]['name']}\n"
                  "Age: ${notes[index]['age']}\n"
                  "RollNO: ${notes[index]['roll_no']}\n"
                  "Class: ${notes[index]['classK']}\n",
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _widget(
    TextEditingController controller,
    String hint, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
