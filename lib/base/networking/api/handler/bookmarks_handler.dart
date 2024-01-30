import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:logger/logger.dart';

import 'grpc_handler.dart';

class BooKMarkHandler {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  BooKMarkHandler(this._grpcHandler);

  /// Fetches user bookmarks.
  ///
  /// This method sends a `getUserBookmarks` gRPC call to fetch the user's bookmarks.
  ///
  /// returns a [List<Bookmark>] instance that represents the user's bookmarks.
  Future<List<Bookmark>> fetchUserBookmarks() async {
    _logger.i('Fetching user bookmarks');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.getUserBookmarks(GetBookmarksRequest());
        _logger.d('User bookmarks: ${response.bookmarks}');
        return response.bookmarks;
      },
    );
  }


  /// Adds a bookmark for the current user.
  ///
  /// Sends a `putUserBookmark` gRPC call with the given [bookmarkData] to add a bookmark.
  /// Logs the action of adding and provides details of the added bookmark.
  ///
  /// [bookmarkData]: The data of the bookmark to be added, encapsulated in a `BookmarkData` object.
  ///
  /// returns [Bookmark]: The `Bookmark` instance representing the added bookmark.
  Future<Bookmark> addToBookmark(BookmarkData bookmarkData) async {
    var request = PutBookmarkRequest(
      description: bookmarkData.description,
      hours: bookmarkData.hours,
      minutes: bookmarkData.minutes,
      seconds: bookmarkData.seconds,
      streamID: bookmarkData.streamID,
    );
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.putUserBookmark(request);
        _logger.d('User bookmark: ${response.bookmark}');
        return response.bookmark;
      },
    );
  }

  Future<bool> removeFromBookmarks(int bookmarkID) async {
    var request = DeleteBookmarkRequest(bookmarkID: bookmarkID);
    try {
      await _grpcHandler.callGrpcMethod(
        (client) async {
          await client.deleteUserBookmark(request);
        },
      );
      _logger.i('User bookmark removed successfully');
      return true;
    } catch (e) {
      _logger.e('Error removing bookmark: $e');
      return false;
    }
  }

  /// Updates a bookmark for the current user.
  ///
  /// Sends a `patchUserBookmark` gRPC call with the given [bookmarkData] to update a bookmark.
  /// Logs the action of updating and provides details of the updated bookmark.
  ///
  /// [bookmarkData]: The data of the bookmark to be updated, encapsulated in a `BookmarkData` object.
  ///
  /// returns [Bookmark]: The `Bookmark` instance representing the updated bookmark.
  Future<Bookmark> updateBookmark(
    int bookmarkID,
    BookmarkData bookmarkData,
  ) async {
    var request = PatchBookmarkRequest(
      bookmarkID: bookmarkID,
      description: bookmarkData.description,
      hours: bookmarkData.hours,
      minutes: bookmarkData.minutes,
      seconds: bookmarkData.seconds,
    );
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.patchUserBookmark(request);
        _logger.d('User bookmark: ${response.bookmark}');
        return response.bookmark;
      },
    );
  }
}

// Purpose: Encapsulates the data for a bookmark.
//
// This class is used to store the data for a bookmark.
class BookmarkData {
  final String description;
  final int hours;
  final int minutes;
  final int seconds;
  final int streamID;

  BookmarkData({
    required this.description,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.streamID,
  });
}
