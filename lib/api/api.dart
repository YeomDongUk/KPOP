import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:kpop/data/artist.dart';
import 'package:kpop/data/board.dart';
import 'package:kpop/data/my_star_detail.dart';
import 'package:kpop/data/star.dart';
import 'package:kpop/data/star_history.dart';
import 'package:kpop/data/user.dart';

class Api {
  static BaseOptions _baseOptions = BaseOptions(
    baseUrl: "http://58.229.240.20:9070/api",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static Dio _dio = Dio(_baseOptions);

  ///
  /// IF002
  ///
  static Future<Map<String, dynamic>> signIn({
    @required String id,
    @required String password,
  }) async {
    try {
      Response response = await _dio.post(
        '/IF002',
        data: {
          "registTypeCode": "EMAIL",
          "id": id,
          "password": password,
          "platformTypeCode": Platform.isAndroid ? "ANDROID" : "iOS",
          "pushToken": null
        },
      );
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['success']) {
          return {
            'loginToken': response.data['loginToken'],
            'userInfo': User.fromJson(
                Map<String, dynamic>.from(response.data['userInfo']))
          };
        } else {
          throw Exception(response.data['message']);
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      print("IF002: $error");
      return null;
    }
  }

  /// IF003
  ///
  static Future<Map<String, dynamic>> autoSignIn({
    @required String loginToken,
  }) async {
    try {
      Response response = await _dio.post(
        '/if003',
        data: {
          "loginToken": loginToken,
        },
      );
      if (response.statusCode == 200) {
        if (response.data['success']) {
          return {
            'loginToken': response.data['loginToken'],
            'userInfo': User.fromJson(
              Map<String, dynamic>.from(response.data['userInfo']),
            ),
          };
        } else {
          throw Exception(response.data['message']);
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      return null;
    }
  }

  static Future<List<Artist>> searchArtist({
    @required String singerName,
    @required String loginToken,
  }) async {
    try {
      Response response = await _dio.post(
        '/if004',
        data: {
          "loginToken": loginToken,
          "singerName": singerName,
        },
      );

      if (response.statusCode == 200) {
        if (response.data['success']) {
          List<Artist> artistList = [];
          for (Map map in response.data['singer']) {
            artistList.add(Artist.fromJson(Map<String, dynamic>.from(map)));
          }
          return artistList;
        } else {
          if (response.data["message"] == "유효하지 않은 로그인토큰 입니다") {
            throw Exception(response.data['message']);
          } else {
            return [];
          }
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      return null;
    }
  }

  static Future<Artist> getAngel({
    @required String loginToken,
  }) async {
    try {
      Response response = await _dio.post(
        '/if005',
        data: {
          "loginToken": loginToken,
        },
      );

      if (response.statusCode == 200) {
        if (response.data['success']) {
          Artist artist = Artist.fromJson(
              Map<String, dynamic>.from(response.data['singer']));
          return artist;
        } else {
          if (response.data["message"] == "유효하지 않은 로그인토큰 입니다") {
            throw Exception(response.data['message']);
          } else {
            return Artist.fromJson({});
          }
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      return null;
    }
  }

  static Future<Artist> setAngel({
    @required String loginToken,
    @required int singerUid,
  }) async {
    try {
      Response response = await _dio.post(
        '/if006',
        data: {
          "loginToken": loginToken,
          "singerUid": singerUid,
        },
      );

      if (response.statusCode == 200) {
        if (response.data['success']) {
          Artist artist = Artist.fromJson(
              Map<String, dynamic>.from(response.data['singer']));
          return artist;
        } else {
          throw Exception(response.data['message']);
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<List<Artist>> getFavorite({
    @required String loginToken,
  }) async {
    try {
      Response response = await _dio.post(
        '/if007',
        data: {
          "loginToken": loginToken,
        },
      );

      if (response.statusCode == 200) {
        if (response.data['success']) {
          List<Artist> artistList = [];
          for (Map map in response.data['singer']) {
            artistList.add(Artist.fromJson(Map<String, dynamic>.from(map)));
          }
          return artistList;
        } else {
          if (response.data["message"] == "유효하지 않은 로그인토큰 입니다") {
            throw Exception(response.data['message']);
          } else {
            return [];
          }
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      return null;
    }
  }

  static Future<Artist> setFavorite({
    @required String loginToken,
    @required int singerUid,
  }) async {
    try {
      Response response = await _dio.post(
        '/if008',
        data: {
          "loginToken": loginToken,
          "singerUid": singerUid,
        },
      );
      print("aaa");
      if (response.statusCode == 200) {
        if (response.data['success']) {
          Artist artist = Artist.fromJson(
              Map<String, dynamic>.from(response.data['singer']));
          return artist;
        } else {
          throw Exception(response.data['message']);
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<List<Board>> getNotice({@required String typeCode}) async {
    try {
      Response response = await _dio.post(
        '/if011',
        data: {"typeCode": typeCode},
      );
      if (response.statusCode == 200) {
        if (response.data['success']) {
          List<Board> boardList =
              List<Map<String, dynamic>>.from(response.data['board'])
                  .map((board) => Board.fromJson(board))
                  .toList();
          return boardList;
        } else {
          throw Exception(response.data['message']);
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<List<Artist>> getRanking({
    @required String loginToken,
    @required String typeCode,
    @required String genderCode,
  }) async {
    try {
      Response response = await _dio.post(
        '/IF012',
        data: {
          "loginToken": loginToken,
          "typeCode": typeCode,
          "genderCode": genderCode,
        },
      );
      if (response.statusCode == 200) {
        List<Artist> artistList = [];
        for (Map map in response.data['singer']) {
          artistList.add(Artist.fromJson(Map<String, dynamic>.from(map)));
        }
        return artistList;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      return null;
    }
  }

  static Future<List<Artist>> getMonthlyHof({
    @required String loginToken,
    @required String typeCode,
    @required String genderCode,
  }) async {
    try {
      Response response = await _dio.post(
        '/IF013',
        data: {
          "loginToken": loginToken,
          "typeCode": typeCode,
          "genderCode": genderCode,
        },
      );
      if (response.statusCode == 200) {
        List<Artist> artistList = [];
        for (Map map in response.data['singer']) {
          artistList.add(Artist.fromJson(Map<String, dynamic>.from(map)));
        }
        return artistList;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      return null;
    }
  }

  static Future<List<Artist>> getDailyHof({
    @required String loginToken,
    @required String typeCode,
    @required String genderCode,
    @required int month,
  }) async {
    try {
      Response response = await _dio.post(
        '/IF014',
        data: {
          "loginToken": loginToken,
          "typeCode": typeCode,
          "genderCode": genderCode,
          "month": month ?? 0,
        },
      );
      if (response.statusCode == 200) {
        List<Artist> artistList = [];
        for (Map map in response.data['singer']) {
          artistList.add(Artist.fromJson(Map<String, dynamic>.from(map)));
        }
        return artistList;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      return null;
    }
  }

  static Future<Star> getMyStar({
    @required String loginToken,
  }) async {
    try {
      Response response = await _dio.post(
        '/IF015',
        data: {"loginToken": loginToken},
      );
      if (response.statusCode == 200) {
        return Star.fromJson(Map<String, dynamic>.from(response.data));
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      return null;
    }
  }

  static Future<MyStarDetail> getMyStarDetail({
    @required String loginToken,
  }) async {
    try {
      Response response = await _dio.post(
        '/IF016',
        data: {"loginToken": loginToken},
      );
      if (response.statusCode == 200) {
        Star star = Star.fromJson({
          "myStarCount": response.data['myStarCount'],
          "everStarCount": response.data['everStarCount'],
          "dailyStarCount": response.data['dailyStarCount'],
        });

        List<Map<String, dynamic>> _starUsageHistory =
            List<Map<String, dynamic>>.from(response.data['starUsageHistory']);
        List<Map<String, dynamic>> _starEarnHistory =
            List<Map<String, dynamic>>.from(response.data['starEarnHistory']);

        List<StarHistory> starUsageHistory = _starUsageHistory.map((f) {
          return StarHistory.fromJson(f);
        }).toList();
        List<StarHistory> starEarnHistory = _starEarnHistory.map((f) {
          return StarHistory.fromJson(f);
        }).toList();

        MyStarDetail myStarDetail = MyStarDetail(
          star: star,
          starUsageHistory: starUsageHistory,
          starEarnHistory: starEarnHistory,
        );
        return myStarDetail;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<bool> voteToArtist({
    @required String loginToken,
    @required int singerUid,
    @required int starCount,
  }) async {
    try {
      Response response = await _dio.post(
        '/IF017',
        data: {
          "loginToken": loginToken,
          "singerUid": singerUid,
          "starCount": starCount,
        },
      );
      if (response.statusCode == 200) {
        if (response.data['success']) return true;
        if (response.data['message'] == "스타가 부족합니다") return false;
      }
      throw Exception(response.statusMessage);
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<bool> removeAngel({
    @required String loginToken,
  }) async {
    try {
      Response response = await _dio.post(
        '/if024',
        data: {"loginToken": loginToken},
      );

      if (response.statusCode == 200) {
        if (response.data['success']) {
          return true;
        } else {
          throw Exception(response.data['message']);
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      return null;
    }
  }

  static Future<bool> removeFavorite({
    @required String loginToken,
    @required int singerUid,
  }) async {
    try {
      Response response = await _dio.post(
        '/if025',
        data: {
          "loginToken": loginToken,
          "singerUid": singerUid,
        },
      );
      if (response.statusCode == 200) {
        if (response.data['success']) {
          return true;
        } else {
          throw Exception(response.data['message']);
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<bool> chargingStar({
    @required String loginToken,
    @required int starCount,
    @required String typeCode,
    @required String content,
    @required String starCode,
  }) async {
    try {
      Response response = await _dio.post(
        '/if026',
        data: {
          "loginToken": loginToken,
          "starCount": starCount,
          "typeCode": typeCode,
          "content": content,
          "starCode": starCode,
        },
      );
      if (response.statusCode == 200) {
        if (response.data['success']) {
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}
