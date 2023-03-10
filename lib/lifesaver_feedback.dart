import 'package:flutter/material.dart';
import 'input_design..dart';

class LifeSavers_Feedback extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LifeSavers_Feedback> {
  final _textController = TextEditingController();
  List<String> _entries = [];

  void _addEntry() {
    setState(() {
      _entries.add(_textController.text);
      _textController.clear();
    });
  }

  void _deleteEntry(int index) {
    setState(() {
      _entries.removeAt(index);
    });
  }

  @override
  // void dispose() {
  //   _textController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "Post-Emergency Form",
          style: TextStyle(fontFamily: "Poppins", color: Colors.redAccent),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.redAccent,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Name of patient(s):",
              style: TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.redAccent),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                itemCount: _entries.length + 1,
                itemBuilder: (context, index) {
                  if (index == _entries.length) {
                    // Add a new entry field with the plus icon
                    return TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        focusColor: Colors.red.shade50,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(
                              style: BorderStyle.none, width: 0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(
                              style: BorderStyle.none, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(
                              style: BorderStyle.none, width: 0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: _addEntry,
                        ),
                      ),
                    );
                  } else {
                    // Show the existing entry
                    return ListTile(
                      title: Text(_entries[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteEntry(index);
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            Text(
              "Details:",
              style: TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.redAccent),
            ),
            TextField(
              maxLines: 2,
              decoration: buildInputDecoration(Icons.person_outline, ""),
            ),
            Divider(
              color: Colors.redAccent,
            ),
            Text(
              "Caller Details:",
              style: TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.redAccent),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Caller: Sara Khan",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ),
            ),
            Center(
              child: Text(
                "Contact: 03332428145",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              maxLines: 2,
              decoration: buildInputDecoration(
                  Icons.person_outline, "Post Emergency Details"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                fixedSize: Size(MediaQuery.of(context).size.width, 30),
                textStyle: const TextStyle(
                    fontSize: 18, fontFamily: 'Poppins', color: Colors.white),
              ),
              onPressed: () {},
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
