import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart'
    as proto;

class Course {
  Course({
    required this.id,
    required this.name,
    required this.teachingTerm,
    required this.year,
  });

  int id;
  String name;
  String teachingTerm;
  int year;

  // Factory method to create a Course instance from the gRPC response
  factory Course.fromProto(proto.Course course) {
    return Course(
      id: course.id as int,
      name: course.name,
      teachingTerm: course.teachingTerm,
      year: course.year,
    );
  }
}
