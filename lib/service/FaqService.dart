import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/model/api/FaqRespon.dart';

class FaqService extends BaseService {
  static FaqService instance = FaqService();
  Future<FaqRespon?> getFAQ(int searchMode, String keyword) async {
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getResources(Endpoint.TAG_FAQ_GET, body: {
        "search_mode":searchMode,
        "keyword":keyword
      });
    }catch(e){
      return FaqError();
    }
  }
}