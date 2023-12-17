import 'package:flutter/material.dart';
import 'package:loginproject/models/usersModel.dart';
import 'package:loginproject/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Datum?> users = [];
  Services _service = Services();
  @override
  void initState() {
    getToken();
    getUsers();
    super.initState();
  }

  getToken() async {
    SharedPreferences token = await SharedPreferences.getInstance();
    String? tokenn = token.getString('token');
    print(tokenn);
  }

  getUsers() async {
    await _service.getUsers().then((value) {
      if (mounted) {
        setState(() {
          users = value!.data;
          print(users);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(users);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ana Sayfa",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(15.0), // Adjust the radius as needed
              ),
              color: Colors.blue,
              child: ListTile(
                leading: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(users[index]!.avatar)),
                title: Text(users[index]!.firstName),
                subtitle: Text(users[index]!.email),
              ),
            );
          },
        ),
      ),
    );
  }
}
