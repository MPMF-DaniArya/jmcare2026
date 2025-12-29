import 'package:jmcare/model/api/FormlanjutRequest.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../../model/api/MpmiSubmitClaimDetail.dart';

class UploadsttlpState{

  String strRequest = "";
  String strMpmiRequest = "";
  FormlanjutRequest? request;
  MpmiSubmitClaimDetail? mpmiRequest;

  FilePickerResult? result;
  File? file;
  PlatformFile? platformFile;
  String base64_file = "";

  String fileName = "";
  String fileBytes = "";
  String fileSizes = "";
  String fileExtension = "";
  String filePath = "";

  UploadsttlpState(){
    request = FormlanjutRequest();
  }
}