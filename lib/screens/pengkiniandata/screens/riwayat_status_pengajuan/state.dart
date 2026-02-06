class RiwayatStatusPengajuanState {
  final List<String> categories = [
    'Semua',
    'Baru',
    'Diproses',
    'Selesai',
    'Ditolak'
  ];

  final List<HistoryModel> historyList = [
    HistoryModel(
        id: 'PDPT-001',
        title: 'Penghapusan Data Pribadi',
        date: '10 Mei 2024',
        status: 'Diproses'),
    HistoryModel(
        id: 'PDPT-002',
        title: 'Perubahan Alamat Domisili',
        date: '11 Mei 2024',
        status: 'Selesai'),
    HistoryModel(
        id: 'PDPT-003',
        title: 'Update Nomor Handphone',
        date: '12 Mei 2024',
        status: 'Baru'),
    HistoryModel(
        id: 'PDPT-004',
        title: 'Perubahan Alamat Email',
        date: '13 Mei 2024',
        status: 'Ditolak'),
  ];
}

class HistoryModel {
  final String id;
  final String title;
  final String date;
  final String status;

  HistoryModel({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
  });
}
