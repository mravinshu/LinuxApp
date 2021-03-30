import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class Distro extends StatelessWidget {
  final FirebaseApp app;
  Distro({this.distroname, this.app});
  DatabaseReference linuxx;
  final FirebaseDatabase database = FirebaseDatabase();
  DatabaseReference dt;
  final String distroname;
  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceinfo = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          Container(
            height: deviceinfo.size.height - 30,
            width: deviceinfo.size.width / 3,
            child: Card(
              elevation: 2,
              child: Flexible(
                child: new FirebaseAnimatedList(
                  query: FirebaseDatabase.instance.reference().child('Distro'),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index1) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
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
                        elevation: 3,
                        child: Row(
                          children: [
                            Image(
                              image: NetworkImage(snapshot.value['Image']),
                              width: deviceinfo.size.width / 20,
                            ),
                            Text(
                              snapshot.value['Name'],
                              style: TextStyle(
                                  fontSize: deviceinfo.size.width / 19),
                            ),
                          ],
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
                query: FirebaseDatabase.instance.reference().child(distroname),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return GestureDetector(
                    onTap: () {
                      print(snapshot.value['Linux']);
                    },
                    child: ListTile(
                        title: new Card(
                      elevation: 3,
                      child: Row(
                        children: [
                          Image(
                            image: NetworkImage(snapshot.value['Image']),
                            width: deviceinfo.size.width / 20,
                          ),
                          Text(
                            snapshot.value['Linux'],
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
