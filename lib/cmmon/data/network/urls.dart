class Urls {
  static const String _baseUrl = 'https://parvezsir.net/api/student';
  static const String attendanceUrl = '$_baseUrl/attendance-report';
  static const String upComingExam = '$_baseUrl/upcoming-exam';


  static String loginUrl({required String id, required String password}) {
    return '$_baseUrl/$id/$password';
  }

}
