import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    User user = Provider.of<User>(context);
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit your information",
            style: GoogleFonts.mcLaren(fontSize: 15)),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage("${user.photoURL}"),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(user.displayName,
                    style: GoogleFonts.mcLaren(
                        fontSize: 15, color: Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(user.email,
                    style: GoogleFonts.mcLaren(
                        fontSize: 10, color: Colors.grey)),
              ),
              SizedBox(
                height: 40,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}