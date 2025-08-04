class Urls {
  static const String _baseUrl = 'https://jahangirsir.net/api/student';
  static const String attendanceUrl = '$_baseUrl/attendance-report';
  static const String upcomingExamUrl = '$_baseUrl/upcoming-exam';
  static const String examListUrl = '$_baseUrl/exam';
  static const String resultUrl = '$_baseUrl/result';

  static String loginUrl({required String id, required String password}) {
    return '$_baseUrl/$id/$password';
  }

}
