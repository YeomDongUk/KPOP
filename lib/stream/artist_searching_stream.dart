import 'dart:async';
import 'package:kpop/api/api.dart';
import 'package:kpop/data/artist.dart';

class ArtistSearchingStream {
  StreamController<List<Artist>> _controller;
  Stream<List<Artist>> _stream;
  Stream<List<Artist>> get stream => _stream;
  ArtistSearchingStream() {
    _controller = StreamController<List<Artist>>.broadcast();
    _stream = _controller.stream;
  }

  void searchArtist(String loginToken, String singerName) async {
    List<Artist> artistList =
        await Api.searchArtist(loginToken: loginToken, singerName: singerName);
    _controller.sink.add(artistList);
  }

  void dispose() {
    _controller.close();
  }
}
