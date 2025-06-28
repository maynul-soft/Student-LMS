class Urls {
  static const String _baseUrl = 'https://parvezsir.net/api/student';
  static const String attendanceUrl = '$_baseUrl/attendance-report';

  static String loginUrl({required String id, required String password}) {
    return '$_baseUrl/$id/$password';
  }

}
