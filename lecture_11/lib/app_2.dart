import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _AppState();
}

class _AppState extends State<App2> {
  bool isLoading = true;
  late SharedPreferences prefs;
  final TextEditingController _data = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> onSubmit() async {
    if (_formKey.currentState!.validate()) {
      await prefs.setInt('counter', int.tryParse(_data.text) ?? 0);
      await prefs.setString('action', _data.text);
      setState(() {});
    }
  }

  Future<void> deleteFile() async {
    await prefs.remove('counter');
    await prefs.remove('action');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shared Preferences Example')),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Text(
                      'Counter: ${prefs.getInt('counter') ?? 'No data in counter'}',
                    ),
                    Text(
                      'Action: ${prefs.getString('action') ?? 'No data in action'}',
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _data,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter data';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text('Data'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: onSubmit,
                      child: const Text('Submit'),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: deleteFile,
                      child: const Text('Delete Data'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
