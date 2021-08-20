import 'package:flutter/material.dart';
import 'package:lab_10_sqlite/db_helper.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _form = GlobalKey<FormState>();
  final _id = TextEditingController();
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _salary = TextEditingController();
  final _mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            //    buildIdField(),
            buildNameField(),
            buildAgeField(),
            buildSalaryField(),
            buildMobileField(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  ElevatedButton buildSaveButton() {
    return ElevatedButton(
        child: Text('Save'),
        onPressed: () async {
          if (this._form.currentState.validate()) {
            print('save button press');

            Map<String, dynamic> row = {
              DatabaseHelper.columnName: _name.text,
              DatabaseHelper.columnAge: int.parse(_age.text),
              DatabaseHelper.columnSalary: int.parse(_salary.text),
              DatabaseHelper.columnMobile: _mobile.text,
            };

            final dbHelper = DatabaseHelper.instance;
            final id = await dbHelper.insert(row);

            print('inserted row id: $id');

            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(this._form.currentContext).showSnackBar(
              SnackBar(
                content: Text('Please validate value'),
              ),
            );
          }
        });
  }

  TextFormField buildIdField() {
    return TextFormField(
      controller: _id,
      decoration: InputDecoration(
        labelText: 'id',
        icon: Icon(Icons.book),
      ),
      validator: (value) => value.isEmpty ? 'Please fill in id' : null,
    );
  }

  TextFormField buildNameField() {
    return TextFormField(
      controller: _name,
      decoration: InputDecoration(
        labelText: 'name',
        icon: Icon(Icons.people),
      ),
      validator: (value) => value.isEmpty ? 'Please fill in name' : null,
    );
  }

  TextFormField buildAgeField() {
    return TextFormField(
        controller: _age,
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
        });
  }

  TextFormField buildSalaryField() {
    return TextFormField(
        controller: _salary,
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
        });
  }

  TextFormField buildMobileField() {
    return TextFormField(
      controller: _mobile,
      decoration: InputDecoration(
        labelText: 'mobile',
        icon: Icon(Icons.people),
      ),
      validator: (value) => value.isEmpty ? 'Please fill in mobile' : null,
    );
  }
}
