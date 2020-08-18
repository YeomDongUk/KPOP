import 'package:flutter/material.dart';
import 'package:kpop/widget/angel_list.dart';
import 'package:kpop/widget/favorite_list.dart';

class AngelOfHonorScreen extends StatefulWidget {
  @override
  _AngelOfHonorScreenState createState() => _AngelOfHonorScreenState();
}

class _AngelOfHonorScreenState extends State<AngelOfHonorScreen> {
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController(keepScrollOffset: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, __) {
        return SizedBox(
          height: __.maxHeight,
          child: ListView(
            controller: _scrollController,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              AngelList(height: __.maxHeight),
              FavoriteList(height: __.maxHeight)
            ],
          ),
        );
      },
    );
  }
}
