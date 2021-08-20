import 'package:flutter/material.dart';
import 'package:lab_10_sqlite/db_helper.dart';

class EditUserPage extends StatefulWidget {
  final Map<String, dynamic> us;
  EditUserPage({Key key, @required this.us}) : super(key: key);
  @override
  _EditUserPageState createState() => _EditUserPageState();
  // receive data from the FirstScreen as a parameter

}

class _EditUserPageState extends State<EditUserPage> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _id = TextEditingController(text: widget.us['_id'].toString());
    final _name = TextEditingController(text: widget.us['name'].toString());
    final _age = TextEditingController(text: widget.us['age'].toString());
    final _salary = TextEditingController(text: widget.us['salary'].toString());
    final _mobile = TextEditingController(text: widget.us['mobile'].toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Update User'),
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: _name,
              //   initialValue: widget.us['name'],
              decoration: InputDecoration(
                labelText: 'name',
                icon: Icon(Icons.people),
              ),
              validator: (value) => value.isEmpty ? 'Please fill in name' : null,
            ),
            TextFormField(
                controller: _age,
                //  initialValue: widget.us['age'].toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'age',
                  icon: Icon(Icons.list),
                ),
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please fill in age';
                  else {
                    int age = int.parse(value);
                    if (age < 0)
                      return 'Please fill in age';
                    else
                      return null;
                  }
                }),
            TextFormField(
                controller: _salary,
                //  initialValue: widget.us['age'].toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'salary',
                  icon: Icon(Icons.list),
                ),
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please fill in salary';
                  else {
                    int salary = int.parse(value);
                    if (salary < 0)
                      return 'Please fill in salary';
                    else
                      return null;
                  }
                }),
            TextFormField(
              controller: _mobile,
              //   initialValue: widget.us['name'],
              decoration: InputDecoration(
                labelText: 'mobile',
                icon: Icon(Icons.people),
              ),
              validator: (value) => value.isEmpty ? 'Please fill in mobile' : null,
            ),
            ElevatedButton(
                child: Text('Save'),
                onPressed: () async {
                  if (this._form.currentState.validate()) {
                    print('save button press');

                    Map<String, dynamic> row = {
                      DatabaseHelper.columnId: int.parse(_id.text),
                      DatabaseHelper.columnName: _name.text,
                      DatabaseHelper.columnAge: int.parse(_age.text),
                      DatabaseHelper.columnSalary: int.parse(_salary.text),
                      DatabaseHelper.columnMobile: _mobile.text,
                    };
                    final dbHelper = DatabaseHelper.instance;
                    final rowsAffected = await dbHelper.update(row);
                    print('updated $rowsAffected row(s)');
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(this._form.currentContext).showSnackBar(
                      SnackBar(
                        content: Text('Please validate value'),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
