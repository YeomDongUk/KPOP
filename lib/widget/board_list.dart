import 'package:kpop/data/board.dart';
import 'package:flutter/material.dart';
import 'package:kpop/widget/board_tile.dart';

class BoardList extends StatelessWidget {
  final List<Board> boardList;

  const BoardList({Key key, this.boardList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      itemCount: boardList.length,
      itemBuilder: (context, index) {
        Board board = boardList.elementAt(index);
        return BoardTile(board: board);
      },
    );
  }
}
