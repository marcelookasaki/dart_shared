import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String tema = "Light";
  var temaData = ThemeData.light();

  // Inicializa
  @override
  void initState() {
    super.initState();
    loadTema();
  }

  setTema(Theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tema = Theme;
      temaData = Theme == "Dark" ? ThemeData.dark() : ThemeData.light();
      prefs.setString("tema", tema);
    });
  }

  loadTema() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tema = prefs.getString("tema") ?? "Light";
      temaData = tema == "Dark" ? ThemeData.dark() : ThemeData.light();
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: temaData,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Preferências"),
        ),
        body: Column(children: [
          ElevatedButton(
              onPressed: () {
                setTema("Light");
              },
              child: Text("Light")),
          ElevatedButton(
              onPressed: () {
                setTema("Dark");
              },
              child: Text("Dark"))
        ]),
      ),
    );
  }
}
