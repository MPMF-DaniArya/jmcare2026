import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/model/api/DropdownRespon.dart';

class DropdownService extends BaseService {
  static DropdownService instance = DropdownService();
  Future<DropdownRespon?> getDropdown (String modul, String submodul) async {
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getResources(Endpoint.TAG_DROPDOWN, body: {
        "modul":modul,
        "submodul":submodul
      });
    }catch(e){
      return DropdownError();
    }
  }
}