import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gmaps_practice/DAO/developerDAO.dart';
import 'package:gmaps_practice/entity/developer.dart';
import 'package:gmaps_practice/screens/map_screen.dart';

class HomeScreen extends StatefulWidget {
  final DeveloperDAO dao;
  const HomeScreen({required this.dao});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gmaps with floor'),
        actions: [
          IconButton(
            onPressed: () async {
              final developer = Developer(
                firstName: Faker().person.firstName(),
                lastName: Faker().person.lastName(),
                email: Faker().internet.email(),
                jobTitle: Faker().job.title(),
              );
              await widget.dao.insertDeveloper(developer);
              final snackBar = SnackBar(content: Text('Add Success'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              widget.dao.deleteAllDeveloper();
              setState(() {
                final snackBar = SnackBar(content: Text('Clear Success'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            },
            icon: Icon(Icons.clear),
          )
        ],
      ),
      body: StreamBuilder(
        stream: widget.dao.getAllDeveloper(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var listDeveloper = snapshot.data as List<Developer?>;
            return ListView.builder(
              itemCount: listDeveloper.length,
              itemBuilder: (context, index) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle_outlined,
                      size: 50.0,
                    ),
                    title: Text(
                      '${listDeveloper[index]!.firstName} ${listDeveloper[index]!.lastName}',
                    ),
                    subtitle: Text(
                      'Job: ${listDeveloper[index]!.jobTitle}\ne-mail: ${listDeveloper[index]!.email} ',
                    ),
                    isThreeLine: true,
                  ),
                  secondaryActions: [
                    IconSlideAction(
                      caption: 'Update',
                      color: Colors.blue,
                      icon: Icons.update,
                      onTap: () async {
                        final updateDeveloper = listDeveloper[index];
                        updateDeveloper!.firstName = Faker().person.firstName();
                        updateDeveloper.lastName = Faker().person.lastName();
                        updateDeveloper.email = Faker().internet.email();
                        updateDeveloper.jobTitle = Faker().job.title();

                        await widget.dao.updateDeveloper(updateDeveloper);
                      },
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.remove,
                      onTap: () async {
                        final deleteDeveloper = listDeveloper[index];

                        await widget.dao.deleteDeveloper(deleteDeveloper);
                      },
                    )
                  ],
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapScreen()),
        ),
        child: Icon(Icons.pin_drop_outlined),
      ),
    );
  }
}
