import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linux Downloads',
      theme: ThemeData(),
      home: MyHomePage(title: 'Linux Downloads'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final FirebaseApp app;
  MyHomePage({Key key, this.title, this.app}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference dt;
  DatabaseReference linuxx;
  String childdata = 'Debian';
  final refernceDatabase = FirebaseDatabase.instance;
  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    dt = database.reference().child('Distro');

    linuxx = database.reference().child(childdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ref = refernceDatabase.reference();
    MediaQueryData deviceinfo = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Linux Downloads'),
        ),
      ),
      body: Row(
        children: [
          Container(
            height: deviceinfo.size.height - 30,
            width: deviceinfo.size.width / 3,
            child: Card(
              elevation: 2,
              child: Flexible(
                child: new FirebaseAnimatedList(
                  query: dt,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index1) {
                    return GestureDetector(
                      onTap: () {
                        print(snapshot.value['Name']);
                        setState(() {
                          childdata = snapshot.value['Name'];
                        });
                      },
                      child: ListTile(
                          title: new Card(
                        elevation: 3,
                        child: Text(
                          snapshot.value['Name'],
                          style:
                              TextStyle(fontSize: deviceinfo.size.width / 19),
                        ),
                      )),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            child: Flexible(
              child: new FirebaseAnimatedList(
                query: linuxx,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return GestureDetector(
                    onTap: () {
                      print(snapshot.value['Linux']);
                    },
                    child: ListTile(
                        title: new Card(
                      elevation: 3,
                      child: Text(
                        snapshot.value['Linux'],
                        style: TextStyle(fontSize: deviceinfo.size.width / 19),
                      ),
                    )),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
