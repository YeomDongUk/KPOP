import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/IDolBar.dart';

class Favor extends StatefulWidget {
  final text;
  final list;
  final Function deleteAngel;
  final Function setAngel;
  final Function setFavorite;
  final Function deleteFavorite;
  final Function callback;
  Favor({
    Key key,
    this.text,
    this.list,
    this.setAngel,
    this.deleteAngel,
    this.setFavorite,
    this.deleteFavorite,
    this.callback,
  });
  @override
  _FavorState createState() => _FavorState();
}

class _FavorState extends State<Favor> {
  var text;
  var list;
  @override
  void initState() {
    text = widget.text;
    list = widget.list;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (BuildContext context, int index) {
        // print(list[index]);
        if (index == 0)
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: TextStyle(
                    color: colors["White"],
                  ),
                ),
              ),
              Container(
                height: 80,
                child: IDolBar(
                  star: list[index],
                  setAngel: widget.setAngel,
                  deleteAngel: widget.deleteAngel,
                  deleteFavorite: widget.deleteFavorite,
                  setFavorite: widget.setFavorite,
                  callback: widget.callback,
                  // getAngel: () => setState(() {}),
                ),
              )
            ],
          );
        return Container(
          height: 80,
          child: IDolBar(
            star: list[index],
            setAngel: widget.setAngel,
            deleteAngel: widget.deleteAngel,
            deleteFavorite: widget.deleteFavorite,
            setFavorite: widget.setFavorite,
            callback: widget.callback,
            // getAngel: () => setState(() {}),
          ),
        );
      },
    );
  }
}
