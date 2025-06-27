import 'course_model.dart';

class StudentDataModel {
  final int id;
  final String studentName;
  final String fatherName;
  final String fatherMobile;
  final String fatherProfession;
  final String motherName;
  final String motherMobile;
  final String motherProfession;
  final String? emailAddress;
  final String smsMobile;
  final int schoolId;
  final String studentPhoto;
  final String avatar;
  final List<Course> courses;
  final School school;

  StudentDataModel({
    required this.id,
    required this.studentName,
    required this.fatherName,
    required this.fatherMobile,
    required this.fatherProfession,
    required this.motherName,
    required this.motherMobile,
    required this.motherProfession,
    required this.emailAddress,
    required this.smsMobile,
    required this.schoolId,
    required this.studentPhoto,
    required this.avatar,
    required this.courses,
    required this.school,
  });

  factory StudentDataModel.fromJson(Map<String, dynamic> json) {
    return StudentDataModel(
      id: json['id'],
      studentName: json['student_name'],
      fatherName: json['father_name'],
      fatherMobile: json['father_mobile'],
      fatherProfession: json['father_profession'],
      motherName: json['mother_name'],
      motherMobile: json['mother_mobile'],
      motherProfession: json['mother_profession'],
      emailAddress: json['email_address'],
      smsMobile: json['sms_mobile'],
      schoolId: json['school_id'],
      studentPhoto: json['student_photo'],
      avatar: json['avatar'],
      courses: (json['courses'] as List)
          .map((e) => Course.fromJson(e))
          .toList(),
      school: School.fromJson(json['school']),
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'student_name': studentName,
    'father_name': fatherName,
    'father_mobile': fatherMobile,
    'father_profession': fatherProfession,
    'mother_name': motherName,
    'mother_mobile': motherMobile,
    'mother_profession': motherProfession,
    'email_address': emailAddress,
    'sms_mobile': smsMobile,
    'school_id': schoolId,
    'student_photo': studentPhoto,
    'avatar': avatar,
    'courses': courses.map((e) => e.toJson()).toList(),
    'school': school.toJson(),
  };

}