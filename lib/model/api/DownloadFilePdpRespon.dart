class PreviewFilePdpRespon {
  String? base64File;

  PreviewFilePdpRespon({this.base64File});

  PreviewFilePdpRespon.fromJson(Map<String, dynamic> json) {
    base64File = json['base64_file'];
  }
}

class DownloadFilePdpError extends PreviewFilePdpRespon {}
