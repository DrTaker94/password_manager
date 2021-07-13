import 'package:flutter/material.dart';
import 'package:password_manager/model/password_info.dart';
import 'package:password_manager/password_info_dump.dart';

class NewRecord extends StatefulWidget {
  // final Function addRec;
  // int idCount = 11; // Keep track of ID for now
  //
  // NewRecord(this.addRec, this.idCount);

  @override
  _NewRecordState createState() => _NewRecordState();
}

class _NewRecordState extends State<NewRecord> {
  final _titleController = TextEditingController(text: "WebSite");
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _urlController = TextEditingController();
  final _notesController = TextEditingController();

  void _submitData() {
    // TODO:Add new record
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredUsername = _usernameController.text;
    final enteredPassword = _passwordController.text;
    final enteredUrl = _urlController.text;
    final enteredNotes = _notesController.text;

    if (enteredUsername.isEmpty || enteredPassword.isEmpty) {
      return;
    }

    int lastId = DUMMY_INFO[DUMMY_INFO.length - 1].id;
    print("Last ID: $lastId");

    setState(() {
      DUMMY_INFO.add(PasswordInfo(
          id: lastId + 1,
          title: enteredTitle,
          username: enteredUsername,
          password: enteredPassword,
          url: enteredUrl,
          notes: enteredNotes));

      Navigator.of(context).pop();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Username'),
              controller: _usernameController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              controller: _passwordController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'URL'),
              controller: _urlController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Notes'),
              controller: _notesController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                  (states) => Theme.of(context).accentColor,
                ),
                backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => Theme.of(context).accentColor,
                ),
                elevation: MaterialStateProperty.resolveWith(
                  (states) => 10,
                ),
                padding: MaterialStateProperty.resolveWith(
                  (states) => EdgeInsets.all(20),
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
