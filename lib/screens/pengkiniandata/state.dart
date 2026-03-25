import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../helper/Konstan.dart';

class PengkiniandataState {
  final List<Map<String, dynamic>> menuPengkinianData = [
    {
      'icon': FontAwesomeIcons.fileShield,
      'title': 'Kebijakan Perlindungan Data Pribadi',
      'description':
          'Lihat Informasi Kebijakan Perlindungan Data Pribadi JACCS MPM Finance Indonesia',
      'route': Konstan.rute_pengkinian_data_kebijakan_perlindungan
    },
    {
      'icon': FontAwesomeIcons.solidUser,
      'title': 'Request Penampilan Data Pribadi',
      'description': 'Lihat Informasi Pribadi Anda yang Terdaftar',
      'route': Konstan.rute_penampilan_data_pribadi
    },
    {
      'icon': FontAwesomeIcons.pen,
      'title': 'Request Pengkinian Data Pribadi',
      'description':
          'Ajukan Perubahan nama, alamat, atau data diri anda yang lain',
      'route': Konstan.rute_request_pengkinian_data_pribadi
    },
    {
      'icon': FontAwesomeIcons.trash,
      'title': 'Request Penghapusan Data Pribadi',
      'description':
          'Ajukan Penghapusan Data jika sudah tidak memiliki kewajiban',
      'route': Konstan.rute_request_penghapusan_data_pribadi
    },
    {
      'icon': FontAwesomeIcons.clockRotateLeft,
      'title': 'Riwayat Status Pengajuan',
      'description':
          'Ajukan Penghapusan Data jika sudah tidak memiliki kewajiban',
      'route': Konstan.rute_riwayat_pengkinian_data_pribadi
    },
  ];
}