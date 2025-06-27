class Course {
  final int id;
  final int studentTypeId;
  final int classId;
  final int batchId;
  final int rollNo;
  final CourseInfo course;
  final ClassInfo classInfo;
  final Batch batch;

  Course({
    required this.id,
    required this.studentTypeId,
    required this.classId,
    required this.batchId,
    required this.rollNo,
    required this.course,
    required this.classInfo,
    required this.batch,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      studentTypeId: json['student_type_id'],
      classId: json['class_id'],
      batchId: json['batch_id'],
      rollNo: json['roll_no'],
      course: CourseInfo.fromJson(json['course']),
      classInfo: ClassInfo.fromJson(json['class_info']),
      batch: Batch.fromJson(json['batch']),
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'student_type_id': studentTypeId,
    'class_id': classId,
    'batch_id': batchId,
    'roll_no': rollNo,
    'course':  course.toJson(),
    'class_info': classInfo.toJson(),
    'batch': batch.toJson(),
  };
}
class CourseInfo {
  final int id;
  final String studentType;

  CourseInfo({
    required this.id,
    required this.studentType,
  });

  factory CourseInfo.fromJson(Map<String, dynamic> json) {
    return CourseInfo(
      id: json['id'],
      studentType: json['student_type'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'student_type': studentType,
  };
}


class ClassInfo {
  final int id;
  final String className;

  ClassInfo({
    required this.id,
    required this.className,
  });

  factory ClassInfo.fromJson(Map<String, dynamic> json) {
    return ClassInfo(
      id: json['id'],
      className: json['class_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'class_name': className,
  };
}


class Batch {
  final int id;
  final String batchName;

  Batch({
    required this.id,
    required this.batchName,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      id: json['id'],
      batchName: json['batch_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'batch_name': batchName,
  };
}


class School {
  final int id;
  final String schoolName;

  School({
    required this.id,
    required this.schoolName,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      schoolName: json['school_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'school_name': schoolName,
  };
}
