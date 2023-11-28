import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart'
    as proto;

class Bookmark {
  final int id;
  final String description;
  final int hours;
  final int minutes;
  final int seconds;
  final int userID;
  final int streamID;

  Bookmark({
    required this.id,
    required this.description,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.userID,
    required this.streamID,
  });

  // Factory method to create a Bookmark instance from the gRPC response
  factory Bookmark.fromProto(proto.Bookmark bookmarkProto) {
    return Bookmark(
      id: bookmarkProto.id,
      description: bookmarkProto.description,
      hours: bookmarkProto.hours,
      minutes: bookmarkProto.minutes,
      seconds: bookmarkProto.seconds,
      userID: bookmarkProto.userID,
      streamID: bookmarkProto.streamID,
    );
  }
}
