import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:path_provider/path_provider.dart';
import '../model/api/models.dart' as models;

class ServiceLoggerInterceptor extends InterceptorsWrapper {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
}

abstract class BaseService {

  String username = "saya#4dalahus3r*jmpmfi!";
  String password = "jmpmf!@2022*api=keren";
  static String basicAuth = 'Basic ${base64Encode(utf8.encode('saya#4dalahus3r*jmpmfi!:jmpmf!@2022*api=keren'))}';
  static String header_esign = "${Endpoint.TAG_ESIGN_API_KEY}@${Endpoint.TAG_ESIGN_TENANT_CODE}";

  static Map<String, String> headerJSON = {'Content-Type': 'application/json', 'Accept': '*/*', 'merchantkey': Konstan.tag_merchant_key, 'authorization': basicAuth};
  static Map<String, String> headerEsign = {'Content-Type': 'application/json', 'Accept': '*/*', 'x-api-key': header_esign};
  static Map<String, String> headerPlain = {'Content-Type': 'text/plain', 'Accept': '*/*', 'merchantkey': Konstan.tag_merchant_key, 'authorization': basicAuth};

  static late Dio client;

  static initialize(Dio newClient) async {
    client = newClient;
  }

  Future<T?> post<T>(String url, {Map<String, dynamic>? body}) async {
    try{
      final response = await _wrapRequest(() => client.post(url, data: body));
      return models.ModelGenerator.resolve<T>(response.data);
    }catch(e){
      // Fungsi.errorToast(e.toString());
      return null;
    }
  }

  Future<T?> postJSON<T>(String url, {Map<String, dynamic>? body}) async {
    try{
      client.options.baseUrl = Endpoint.base_url;
      final response = await _wrapRequest(() => client.post(url,
          data: body,
          options: Options(
            headers: headerJSON,
          )));
      return models.ModelGenerator.resolve<T>(response.data);
    }catch(e){
      // Fungsi.errorToast(e.toString());
      return null;
    }
  }

  Future<T?> postMPMI<T>(String url, {Map<String, dynamic>? body}) async {
    try{
      client.options.baseUrl = Endpoint.base_url_mpmi;
      final response = await _wrapRequest(() => client.post(url,
          data: body,
          options: Options(
            headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
          )));
      return models.ModelGenerator.resolve<T>(response.data);
    }catch(e){
      // Fungsi.errorToast(e.toString());
      return null;
    }
  }

  Future<T?> postEsign<T>(String url, {Map<String, dynamic>? body}) async {
    try{
      client.options.baseUrl = Endpoint.base_url_esign;
      final response = await _wrapRequest(() => client.post(url,
          data: body,
          options: Options(
            headers: headerEsign,
          )));
      return models.ModelGenerator.resolve<T>(response.data);
    }catch(e){
      // Fungsi.errorToast(e.toString());
      return null;
    }
  }

  Future<T?> postString<T>(String url, {Map<String, dynamic>? body}) async {
    try{
      String param = jsonEncode(body);
      client.options.baseUrl = Endpoint.base_url;
      final response = await _wrapRequest(() => client.post(url,
          data: param,
          options: Options(
            headers: headerPlain,
          )));
      return models.ModelGenerator.resolve<T>(response.data);
    }catch(e){
      // Fungsi.errorToast(e.toString());
      return null;
    }
  }

  Future<T?> postRawString<T>(String url, String body) async {
    try{
      client.options.baseUrl = Endpoint.base_url;
      final response = await _wrapRequest(() => client.post(url,
          data: body,
          options: Options(
            headers: headerPlain,
          )));
      return models.ModelGenerator.resolve<T>(response.data);
    }catch(e){
      // Fungsi.errorToast(e.toString());
      return null;
    }
  }

  Future<T?> postQuery<T>(String url, {Map<String, dynamic>? body}) async {
    try{
      client.options.baseUrl = Endpoint.base_url;
      final response = await _wrapRequest(() => client.post(url,
          queryParameters: body,
          options: Options(
            headers: headerPlain,
          )));
      return models.ModelGenerator.resolve<T>(response.data);
    }catch(e){
      // Fungsi.errorToast(e.toString());
      return null;
    }

  }

  //tambahkan '{"data":' di sebelah kiri respon dan '}' disebelah kanan respon
  //buat model di json to dart berdasarkan tambahan tadi
  Future<T?> getJsonArray<T>(String url, {Map<String, dynamic>? body}) async {
    try{
      String param = jsonEncode(body);
      client.options.baseUrl = Endpoint.base_url;
      final response = await _wrapRequest(() => client.post(url,
          data: param,
          options: Options(
            headers: headerPlain,
          )));
      var encoded = jsonEncode(response.data);
      var bodi = '{"data":' + encoded + '}';
      var decoded = jsonDecode(bodi);
      return models.ModelGenerator.resolve<T>(decoded);
    }catch(e){
      // Fungsi.errorToast(e.toString());
      return null;
    }
  }

  //tambahkan '{"data":' di sebelah kiri respon dan '}' disebelah kanan respon
  //buat model di json to dart berdasarkan tambahan tadi
  Future<T?> getResources<T>(String url, {Map<String, dynamic>? body}) async {
    try{
      String param = jsonEncode(body);
      client.options.baseUrl = Endpoint.base_url;
      final response = await _wrapRequest(() => client.post(url,
          data: param,
          options: Options(
            headers: headerJSON,
          )));
      var encoded = jsonEncode(response.data);
      var bodi = '{"data":' + encoded + '}';
      var decoded = jsonDecode(bodi);
      return models.ModelGenerator.resolve<T>(decoded);
    }catch(e){
      // Fungsi.errorToast(e.toString());
      return null;
    }
  }

  //tambahkan '{"data":' di sebelah kiri respon dan '}' disebelah kanan respon
  //buat model di json to dart berdasarkan tambahan tadi
  Future<T?> getResource<T>(String url, {Map<String, dynamic>? body}) async {
    try{
      String param = jsonEncode(body);
      client.options.baseUrl = Endpoint.base_url;
      final response = await _wrapRequest(() => client.post(url,
          data: param,
          options: Options(
            headers: headerPlain,
          )));
      var encoded = jsonEncode(response.data);
      var bodi = '{"data":' + encoded + '}';
      var decoded = jsonDecode(bodi);
      return models.ModelGenerator.resolve<T>(decoded);
    }catch(e){
      // Fungsi.errorToast(e.toString());
      return null;
    }
  }

  //tambahkan '{"data":' di sebelah kiri respon dan '}' disebelah kanan respon
  //buat model di json to dart berdasarkan tambahan tadi
  Future<T?> getJMO<T>(String url, {Map<String, dynamic>? body}) async {
    try{
      String param = jsonEncode(body);
      client.options.baseUrl = Endpoint.base_url_jmo;
      final response = await _wrapRequest(() => client.get(url,
          data: param,
          options: Options(
            headers: headerPlain,
          )));
      var encoded = jsonEncode(response.data);
      var bodi = '{"data":' + encoded + '}';
      var decoded = jsonDecode(bodi);
      return models.ModelGenerator.resolve<T>(decoded);
    }catch(e){
      // Fungsi.errorToast(e.toString());
      return null;
    }
  }

  //tambahkan '{"data":' di sebelah kiri respon dan '}' disebelah kanan respon
  //buat model di json to dart berdasarkan tambahan tadi
  Future<T?> postJMO<T>(String url, {Map<String, dynamic>? body}) async {
    try{
      String param = jsonEncode(body);
      client.options.baseUrl = Endpoint.base_url_jmo;
      final response = await _wrapRequest(() => client.post(url,
          data: param,
          options: Options(
            headers: headerPlain,
          )));
      var encoded = jsonEncode(response.data);
      var bodi = '{"data":' + encoded + '}';
      var decoded = jsonDecode(bodi);
      return models.ModelGenerator.resolve<T>(decoded);
    }catch(e){
      // Fungsi.errorToast(e.toString());
      return null;
    }
  }

  Future<T?> postSMS<T>(String url) async {
    try{
      client.options.baseUrl = Endpoint.base_url_reset_pass_sms;
      final response = await _wrapRequest(() => client.post(url,
          options: Options(
            headers: {'Accept': '*/*'},
          )));
      return models.ModelGenerator.resolve<T>(response.data);
    }catch(e){
      // Fungsi.errorToast(e.toString());
      return null;
    }
  }

  Future<int> download(String baseURL, String fileName) async {
    try{
      client.options.baseUrl = baseURL;
      String path = await _getFilePath(fileName);
      await _wrapRequest(() => client.download(baseURL, path));
      return 1;
    }catch(e){
      // Fungsi.errorToast(e.toString());
      // Fungsi.errorToast("Gagal download");
      return 0;
    }
  }

  Future<String> _getFilePath(String filename) async {
    Directory? dir;
    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/'); // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      // Fungsi.errorToast("Cannot get download folder path $err");
    }
    return "${dir?.path}$filename";
  }

  _wrapRequest(request, {int retryCount = 3}) async {
    try {
      return await request();
    } on DioException catch (e) {
      if (e.error is SocketException ) {
        if (retryCount == 3) {
          rethrow;
        } else {
          await Future.delayed(const Duration(seconds: 1), () {
            print('retrying request');
          });
          return _wrapRequest(request, retryCount: retryCount + 1);
        }
      }else if (e.error == DioExceptionType.connectionTimeout){
        // Fungsi.errorToast("Error: Timeout connection");
      }
      rethrow;
    } on SocketException catch (e) {
      if (retryCount == 3) {
        rethrow;
      } else {
        await Future.delayed(const Duration(seconds: 1), () {
          print('retrying request');
        });
        return _wrapRequest(request, retryCount: retryCount + 1);
      }
    } catch (e) {
      rethrow;
    }
  }
}
