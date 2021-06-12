import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> listofwidgets = [];
  double _scale = 1.0;
  double _previousScale = 1.0;
  int crossAxisCount = 2;
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 500; i++) {
      if (i % 2 == 0) {
        listofwidgets.add(
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(
                color: Colors.black,
              ),
            ),
          ),
        );
      } else {
        listofwidgets.add(
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(
                color: Colors.black,
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onScaleStart: (ScaleStartDetails details) {
            // print(_scale);
            _previousScale = _scale;
            setState(() {});
          },
          onScaleUpdate: (ScaleUpdateDetails details) {
            if (details.scale > 1.0) {
              _scale = _previousScale * details.scale;
            } else if (details.scale < 1.0 && _scale > 1.0) {
              _scale = _previousScale * details.scale;
            }
            setState(() {
              crossAxisCount = ((_scale - 1).abs() * 10).round();
            });
          },
          onScaleEnd: (ScaleEndDetails details) {
            // print(_scale);

            _previousScale = 1.0;
            setState(() {});
          },
          child: GridView.count(
            crossAxisCount: crossAxisCount > 0 ? crossAxisCount : 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: listofwidgets,
          ),
        ),
      ),
    );
  }
}
