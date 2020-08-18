import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/angel/angel_bloc.dart';
import 'package:kpop/bloc/angel/angel_state.dart';
import 'package:kpop/data/artist.dart';
import 'package:kpop/repository/user_repository.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/stream/artist_searching_stream.dart';
import 'package:kpop/widget/artist_search_list.dart';

class SetArtistScreen extends StatefulWidget {
  final String title;
  final bool isAngel;

  const SetArtistScreen({
    Key key,
    @required this.title,
    this.isAngel,
  })  : assert(title != null),
        super(key: key);

  @override
  _SetArtistScreenState createState() => _SetArtistScreenState();
}

class _SetArtistScreenState extends State<SetArtistScreen> {
  ArtistSearchingStream artistSearchingStream = ArtistSearchingStream();
  TextEditingController tecController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    artistSearchingStream.dispose();
    super.dispose();
  }

  void searchArtist(String str) async {
    String loginToken =
        await RepositoryProvider.of<UserRepository>(context).getToken();
    artistSearchingStream.searchArtist(loginToken, str);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: CustomColor.deepBase,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            BlocConsumer<AngelBloc, AngelState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Angel ",
                              style: TextStyle(
                                color: CustomColor.main,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            if (state is AngelSuccess)
                              TextSpan(
                                text: state.artist.name,
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: (state is AngelSuccess)
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(state.artist.profileImage),
                                )
                              : null,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: CustomColor.main, width: 0.5),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: tecController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search Idol",
                                  hintStyle:
                                      TextStyle(color: Color(0xAAFFFFFF)),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => searchArtist(tecController.text),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CustomColor.main, width: 0.5),
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(3)),
                                  color: CustomColor.main,
                                ),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/icon/icon_search_normal.png",
                                  height: 47,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            Divider(),
            Expanded(
              child: StreamBuilder<List<Artist>>(
                initialData: [],
                stream: artistSearchingStream.stream,
                builder: (context, snapshot) => ArtistSearchList(
                  artistList: snapshot.data,
                  isAngel: widget.isAngel,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
