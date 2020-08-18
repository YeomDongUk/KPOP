import 'package:flutter/material.dart';
import 'package:kpop/api/api.dart';
import 'package:kpop/data/board.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/widget/board_list.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Container(
          color: CustomColor.light,
          child: FutureBuilder<List<Board>>(
            initialData: [],
            future: Api.getNotice(typeCode: "EVENTS"),
            builder: (_, snapshot) {
              if (snapshot.data.isEmpty)
                return Center(child: CircularProgressIndicator());
              return BoardList(boardList: snapshot.data);
            },
          ),
        ),
      ),
    );
  }
}
