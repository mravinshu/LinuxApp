import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:linux/distro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linux Downloads',
      theme: ThemeData.dark(),
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
  final refernceDatabase = FirebaseDatabase.instance;
  String childdata = "Debian";
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
              child: new FirebaseAnimatedList(
                query: dt,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index1) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Distro(
                            distroname: snapshot.value['Name'],
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                        title: new Card(
                      child: Row(
                        children: [
                          Image(
                            image: NetworkImage(snapshot.value['Image']),
                            width: deviceinfo.size.width / 20,
                          ),
                          Text(
                            snapshot.value['Name'],
                            style:
                                TextStyle(fontSize: deviceinfo.size.width / 19),
                          ),
                        ],
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
