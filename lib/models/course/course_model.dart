import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart'
    as proto;

class Course {
  final int id;
  final String name;
  final String teachingTerm;
  final int year;

  Course({
    required this.id,
    required this.name,
    required this.teachingTerm,
    required this.year,
  });

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
