// // import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:flutter/material.dart';

// var colors = {
//   "White": Color(0xFFFFFFFF),
//   "Black": Color(0xFF000000),
//   "Base": Color(0xFF191E28),
//   "Main": Color(0xFFFA2F9F)
// };

// class VideoListView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: <Widget>[
//         SliverGrid(
//           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 200.0,
//             mainAxisSpacing: 10.0,
//             crossAxisSpacing: 10.0,
//             childAspectRatio: 1.15,
//           ),
//           delegate: SliverChildBuilderDelegate(
//             (BuildContext context, int index) {
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     PageRouteBuilder(
//                         opaque: false,
//                         pageBuilder: ((BuildContext context, _, __) =>
//                             VideoViewer()),
//                         transitionsBuilder: (___, Animation<double> animation,
//                             ____, Widget child) {
//                           Animation<Offset> custom = Tween<Offset>(
//                                   begin: Offset(1.0, 0.0),
//                                   end: Offset(0.0, 0.0))
//                               .animate(animation);
//                           return SlideTransition(
//                               position: custom, child: child);
//                         }),
//                   );
//                 },
//                 child: ListView(
//                   physics: NeverScrollableScrollPhysics(),
//                   children: [
//                     Container(
//                       child: Image.asset("images/test.png"),
//                       color: Colors.black,
//                     ),
//                     Container(
//                       color: Color(0xFF191E28),
//                       alignment: Alignment.topCenter,
//                       padding: EdgeInsets.all(10),
//                       child: Text(
//                         "[MV] (G)I-DLE ((여자)아이들) _ LATATA [MV]",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.5,
//                         ),
//                         maxLines: 2,
//                       ),
//                       height: 60,
//                     ),
//                   ],
//                 ),
//               );
//             },
//             childCount: 30,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class VideoViewer extends StatefulWidget {
//   VideoViewer({Key key}) : super(key: key);
//   // final String title;

//   @override
//   _VideoViewer createState() => _VideoViewer();
// }

// class _VideoViewer extends State<VideoViewer> {
//   YoutubePlayerController _controller = YoutubePlayerController();
//   // var _idController = TextEditingController();
//   // var _seekToController = TextEditingController();
//   // double _volume = 100;
//   // bool _muted = false;
//   List<ImageButton> _buttons;

//   @override
//   void initState() {
//     super.initState();

//     _buttons = [
//       ImageButton(
//         imgsrc: "images/icon_like_normal.png",
//         pressed: false,
//         toggle: this.callback,
//       ),
//       ImageButton(
//         imgsrc: "images/icon_like_normal.png",
//         pressed: false,
//         toggle: this.callback,
//       ),
//       ImageButton(
//         imgsrc: "images/icon_like_normal.png",
//         pressed: false,
//         toggle: this.callback,
//       ),
//       ImageButton(
//         imgsrc: "images/icon_like_normal.png",
//         pressed: false,
//         toggle: this.callback,
//       ),
//     ];
//   }

//   void callback() {
//     setState() {
//       _buttons[0].pressed = !_buttons[0].pressed;
//     }
//   }

//   void toggleB() {}

//   String _playerStatus;
//   String _errorCode;

//   String _videoId = "uAjn3-c9boc";

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var videoHeight = height * 0.288;
//     var titleHeight = height * 0.1;
//     var iconHeight = height * 0.07;
//     void listener() {
//       setState(() {
//         _playerStatus = _controller.value.playerState.toString();
//         _errorCode = _controller.value.errorCode.toString();
//       });
//     }

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("영상보기"),
//         ),
//         body: Column(
//           children: [
//             Container(
//               height: videoHeight,

//               /*************************** 유튜브 플레이어 ***********************************/
//               child: YoutubePlayer(
//                 context: context,
//                 videoId: _videoId,
//                 autoPlay: false,
//                 hideControls: false,
//                 showVideoProgressIndicator: true,
//                 videoProgressIndicatorColor: Colors.amber,
//                 progressColors: ProgressColors(
//                   playedColor: Colors.red,
//                   handleColor: Colors.red,
//                 ),
//                 onPlayerInitialized: (controller) {
//                   _controller = controller;
//                   _controller.addListener(listener);
//                 },
//               ),
//             ),

//             /*************************** 타이틀 및 버튼 ***********************************/
//             Container(
//               color: colors["Base"],
//               padding: EdgeInsets.all(10),
//               alignment: Alignment.center,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     height: titleHeight,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 0, 0, 11),
//                           child: Text(
//                             "[MV] (G)I-DLE ((여자)아이들) _ LATATA",
//                             maxLines: 1,
//                             style: TextStyle(
//                                 color: colors["White"], fontSize: 16.5),
//                           ),
//                         ),
//                         Text(
//                           "115,909,593 views",
//                           maxLines: 1,
//                           style:
//                               TextStyle(color: colors["White"], fontSize: 10.5),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: height * 0.06,
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         _buttons[0],
//                         Text(
//                           "2,088",
//                           style:
//                               TextStyle(color: colors["White"], fontSize: 10),
//                         ),
//                         _buttons[1],
//                         Text(
//                           "5",
//                           style:
//                               TextStyle(color: colors["White"], fontSize: 10),
//                         ),
//                         _buttons[2],
//                         _buttons[3]
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: height * 0.06,
//                     child: Opacity(
//                       opacity: 0.5,
//                       child: Row(
//                         children: <Widget>[
//                           Image.asset(
//                             "images/icon_downarrow_normal.png",
//                             color: colors["White"],
//                             scale: 2,
//                           ),
//                           Text(
//                             "[MV] The BOYZ(더보이즈) _ Right Here",
//                             style: TextStyle(color: colors["White"]),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),

//             /*************************** 하단 리스트뷰 ***********************************/
//             Expanded(
//               child: Container(
//                 height: height * 0.365,
//                 color: colors["Base"],
//                 padding: EdgeInsets.all(5),
//                 child: new GridView.count(
//                   crossAxisCount: 3,
//                   children: new List.generate(16, (index) {
//                     return new GestureDetector(
//                       onTap: () {
//                         print("tapped $index");
//                       },
//                       child: new GridTile(
//                         child: new Card(
//                           color: Colors.blue.shade200,
//                           child: new Text("title $index"),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ImageButton extends StatefulWidget {
//   ImageButton({Key key, this.imgsrc, this.pressed, this.toggle})
//       : super(key: key);
//   // ImageButton(this.toggle);
//   final String imgsrc;
//   bool pressed;
//   Function toggle;

//   _ImageButton createState() => _ImageButton();
// }

// class _ImageButton extends State<ImageButton> {
//   void tapping() {
//     print(widget.pressed);
//     setState() {
//       widget.pressed = true;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: this.tapping,
//       child: Image.asset(
//         "images/icon_like_normal.png",
//         color: (widget.pressed == true ? colors["Main"] : colors["White"]),
//       ),
//     );
//   }
// }

// class MyBehavior extends ScrollBehavior {
//   @override
//   Widget buildViewportChrome(
//       BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }
// }

// //   return ButtonTheme(
// //     minWidth: 1,
// //     height: 10,
// //     child: FlatButton(
// //       child: Image.asset(
// //         widget.imgsrc,
// //         color: (pressed == true ? colors["Main"] : colors["White"]),
// //         scale: 2,
// //       ),
// //       onPressed: () {
// //         setState(() {
// //           this.pressed = !this.pressed;
// //         });
// //       },
// //     ),
// //   );
