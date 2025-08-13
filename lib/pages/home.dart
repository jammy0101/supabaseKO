
import 'package:flutter/material.dart';
import 'package:supa2/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {
  final _userController = TextEditingController();
  final _webController = TextEditingController();

  @override
  void initState() {
    _getInitialProfile();
    super.initState();
  }

  Future<void>  _getInitialProfile()async{
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase.from('profiles').select().eq('id', userId).single();
    setState(() {
      _userController.text = data['username'];
      _webController.text = data['website'];
    });
  }
  Future<void> _logout() async {
    await supabase.auth.signOut();
  }

  @override
  void dispose() {
    _userController.dispose();
    _webController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Profile'),
          automaticallyImplyLeading: false,
          actions: [
          IconButton(
            onPressed: () {
              _logout();
              Navigator.pushNamed(context, '/login');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _userController,
              decoration: InputDecoration(
                label: Text('UserName'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _webController,
              decoration: InputDecoration(
                label: Text('Web'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () async {
              try{

                final username = _userController.text.trim();
                final website = _webController.text.trim();
                final userId = supabase.auth.currentUser!.id;

                await supabase
                    .from('profiles')
                    .update({'username': username,
                  'website': website})
                    .eq('id', userId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Your data has been saved"),
                  ),
                );
              }catch(e){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Issue : $e"),
                  ),
                );
              }
            },
            child: Text('save'),
          ),
        ],
      ),
    );
  }
}
