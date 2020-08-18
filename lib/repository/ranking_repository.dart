import 'package:kpop/api/api.dart';
import 'package:kpop/data/artist.dart';

class RankingRepository {
  Future<List<Artist>> getRanking({
    String loginToken,
    String typeCode,
    String genderCode,
  }) async {
    List<Artist> result = await Api.getRanking(
      loginToken: loginToken,
      typeCode: typeCode,
      genderCode: genderCode,
    );
    return result;
  }
}
