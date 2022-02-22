import 'package:flutter/material.dart';
import 'newUserEmail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(shrinkWrap: true, children: [
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Icon(Icons.arrow_back),
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all(CircleBorder()),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(8)),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff096B72)), // Button color
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.black; // Splash color
                                })))),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(15),
                        child: const Text(
                          'Settings',
                          style: TextStyle(fontSize: 20),
                        )),
                    SizedBox(
                      width: screenWidth / 2.8,
                    ),
                    Container(
                        child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.cancel),
                      iconSize: 45,
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight / 20,
              ),
              Container(
                  child: ListView(shrinkWrap: true, children: <Widget>[
                Expanded(
                    child: Column(children: [
                  Card(
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.supervisor_account, size: 40),
                      iconColor: Color(0xff096B72),
                      title: Text('Add Accounts'),
                    ),
                  ),
                ])),
              ])),
              Container(
                  child: ListView(shrinkWrap: true, children: <Widget>[
                Expanded(
                    child: Column(children: [
                  Card(
                      child: ListTile(
                    onTap: () {},
                    leading: Icon(Icons.settings, size: 40),
                    iconColor: Color(0xff096B72),
                    title: Text('General'),
                  )),
                ])),
              ])),
              Container(
                  child: ListView(shrinkWrap: true, children: <Widget>[
                Expanded(
                    child: Column(children: [
                  Card(
                      child: ListTile(
                    onTap: () {},
                    leading: Icon(Icons.manage_accounts_rounded, size: 40),
                    title: Text('EnRoute Account'),
                    iconColor: Color(0xff096B72),
                  )),
                ])),
              ])),
              Container(
                  child: ListView(shrinkWrap: true, children: <Widget>[
                Expanded(
                    child: Column(children: [
                  Card(
                      child: ListTile(
                    onTap: () {},
                    leading: Icon(Icons.map, size: 40),
                    title: Text('Map Settings'),
                    iconColor: Color(0xff096B72),
                  )),
                ])),
              ])),
              Container(
                  child: ListView(shrinkWrap: true, children: <Widget>[
                Expanded(
                    child: Column(children: [
                  Card(
                      child: ListTile(
                    onTap: () {},
                    leading: Icon(Icons.info, size: 40),
                    iconColor: Color(0xff096B72),
                    title: Text('Information'),
                  )),
                ])),
              ])),
              Container(
                  child: ListView(shrinkWrap: true, children: <Widget>[
                Expanded(
                    child: Column(children: [
                  Card(
                      child: ListTile(
                    onTap: () {},
                    leading: Icon(Icons.help, size: 40),
                    iconColor: Color(0xff096B72),
                    title: Text('Help'),
                  )),
                ])),
              ])),
            ])));
  }
}
