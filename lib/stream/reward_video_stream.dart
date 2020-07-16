import 'dart:async';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:kpop/api/api.dart';
import 'package:kpop/repository/user_repository.dart';

class RewardVideoStream {
  final UserRepository userRepository;
  StreamController<RewardedVideoAdEvent> _controller;
  Stream<RewardedVideoAdEvent> _stream;
  Stream<RewardedVideoAdEvent> get stream => _stream;
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );
  RewardVideoStream({this.userRepository}) {
    _controller = StreamController<RewardedVideoAdEvent>.broadcast();
    _stream = _controller.stream;
    _init();
  }

  void _init() {
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.closed) {
        _loadRewardVideo();
      } else if (event == RewardedVideoAdEvent.rewarded) {
        Api.chargingStar(
          loginToken: userRepository.loginToken,
          starCode: "EVER",
          content: "영상 AAD",
          typeCode: "VIDEOAD",
          starCount: 36,
        );
      }
      _controller.sink.add(event);
    };
    _loadRewardVideo();
  }

  void _loadRewardVideo() {
    RewardedVideoAd.instance.load(
      adUnitId: RewardedVideoAd.testAdUnitId,
      targetingInfo: targetingInfo,
    );
  }

  void dispose() {
    _controller.close();
  }
}
