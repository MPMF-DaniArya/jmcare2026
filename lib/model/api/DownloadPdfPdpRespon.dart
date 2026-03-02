class DownloadPdfPdpRespon {
  String? base64Pdf;
  String? pesan;

  DownloadPdfPdpRespon({
    this.base64Pdf,
  });

  DownloadPdfPdpRespon.fromJson(Map<String, dynamic> json) {
    base64Pdf = json['base64PDF'];
    pesan = json['pesan'];
  }
}

class DownloadPdfPdpError extends DownloadPdfPdpRespon {}
