import 'package:flutter/material.dart';
import 'package:lab_10_sqlite/db_helper.dart';
import 'package:lab_10_sqlite/update_user.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Map<String, dynamic>> us = [];

  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Users "),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  //            dbHelper.onDrop();
                  await Navigator.pushNamed(context, '/adduser');
                  _query();
                })
          ],
        ),
        body: _myListView(context));
  }

  Future<void> _query() async {
    final allRows = await dbHelper.queryAllRows();
    setState(() {
      us = allRows;
    });
  }

  void _delete(Map<String, dynamic> us) async {
    var _id = us['_id'];
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount();

    final rowsDeleted = await dbHelper.delete(_id);
    print('deleted $rowsDeleted row(s): row $_id');
    _query();
  }

  void _count() async {
    final countrow = await dbHelper.queryRowCount();
    print('Row count = $countrow');
  }

  Widget _myListView(BuildContext context) {
    _query();
    return Column(
      children: <Widget>[
        ElevatedButton(
            child: Text('count'),
            onPressed: () {
              _count();
            }),
        Expanded(
          child: us.isEmpty
              ? Center(
                  child: Text('Empty Table'),
                )
              : ListView.builder(
                  itemCount: us.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('No: ' +
                          us[index]['_id'].toString() +
                          ' ' +
                          'Name: ' +
                          us[index]['name'] +
                          ' Age: ' +
                          us[index]['age'].toString()),
                      subtitle: Text('Salary:' +
                          us[index]['salary'].toString() +
                          ' ' +
                          'Tel:' +
                          us[index]['mobile']),
                      trailing: IconButton(
                          icon: Icon(Icons.delete_rounded),
                          onPressed: () {
                            _delete(us[index]);
                          }),
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditUserPage(
                                us: us[index],
                              ),
                            ));
                        _query();
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
