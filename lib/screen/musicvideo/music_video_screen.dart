import 'package:flutter/material.dart';
import 'package:kpop/data/user.dart';
import 'package:kpop/screen/musicvideo/artist_list_screen.dart';
import 'package:kpop/screen/musicvideo/drama_ost_video_screen.dart';
import 'package:kpop/screen/musicvideo/lyrics_video_screen.dart';
import 'package:kpop/screen/musicvideo/newvideo/new_video_screen.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/stream/favorite_video_stream.dart';
import 'package:kpop/widget/nav_bar.dart';
import 'package:kpop/widget/side_menu.dart';

class MusicVideoScreen extends StatefulWidget {
  final User user;

  const MusicVideoScreen({Key key, this.user}) : super(key: key);
  @override
  _MusicVideoScreenState createState() => _MusicVideoScreenState();
}

class _MusicVideoScreenState extends State<MusicVideoScreen> {
  PageController _pageController = PageController(initialPage: 0);
  FavoriteVideoStream _videoStream = FavoriteVideoStream();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _videoStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: NavBar(),
        title: Text("Music Video"),
        centerTitle: false,
        elevation: 0,
      ),
      drawer: SideMenu(user: widget.user),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            NewVideoScreen(),
            ArtistListScreen(),
            DramaOstVideoScreen(),
            LyricsVideoScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottonNavBar(pageController: _pageController),
    );
  }
}

class BottonNavBar extends StatefulWidget {
  const BottonNavBar({
    Key key,
    @required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  _BottonNavBarState createState() => _BottonNavBarState();
}

class _BottonNavBarState extends State<BottonNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: CustomColor.base,
      onTap: (int index) async {
        widget._pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );
        setState(() => currentIndex = index);
      },
      selectedItemColor: CustomColor.main,
      currentIndex: currentIndex,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icon/icon_new_normal.png",
            scale: 3,
            color: currentIndex == 0 ? CustomColor.main : null,
          ),
          title: Text("New"),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icon/icon_artist_normal.png",
            scale: 3,
            color: currentIndex == 1 ? CustomColor.main : null,
          ),
          title: Text("Artist"),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icon/icon_dramaost_normal.png",
            scale: 3,
            color: currentIndex == 2 ? CustomColor.main : null,
          ),
          title: Text("Drama OST"),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icon/icon_lyrics_normal.png",
            scale: 3,
            color: currentIndex == 3 ? CustomColor.main : null,
          ),
          title: Text("Lyrics"),
        ),
      ],
    );
  }
}
