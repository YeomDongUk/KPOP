import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/SlideList.dart';
import 'package:kpop/Object/Http.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xFF10151A),
        elevation: 0,
        title: Text("Events"),
        centerTitle: false,
      ),
      body: Container(
        color: colors["Base"],
        child: FutureBuilder(
          future: fetch("IF011", {'typeCode': "EVENTS"}),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var res = jsonDecode(snapshot.data.body)['board'];
              return ListView.builder(
                itemCount: res.length,
                itemBuilder: (BuildContext context, index) {
                  print(res[index]);
                  return Container(
                    child: SlideList(
                      title: res[index]['title'],
                      content: res[index]['content'],
                      flag: res[index]['newYn'] == "Y" ? true : false,
                    ),
                  );
                },
                physics: const ClampingScrollPhysics(),
              );
            } else {
              return Container(
                child: Text("Loading"),
              );
            }
          },
        ),
      ),
    );
  }
}
