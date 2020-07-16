import 'package:kpop/api/api.dart';
import 'package:kpop/data/artist.dart';

class HofRepository {
  Future<List<Artist>> getMonthlyHof({
    String loginToken,
    String typeCode,
    String genderCode,
  }) async {
    List<Artist> result = await Api.getMonthlyHof(
      loginToken: loginToken,
      typeCode: typeCode,
      genderCode: genderCode,
    );
    return result;
  }

  Future<List<Artist>> getDailyHof({
    String loginToken,
    String typeCode,
    String genderCode,
    int month,
  }) async {
    List<Artist> result = await Api.getDailyHof(
      loginToken: loginToken,
      typeCode: typeCode,
      genderCode: genderCode,
      month: month,
    );
    return result;
  }
}
