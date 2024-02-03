import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gocast_mobile/providers.dart';


class DownloadService {
  final WidgetRef ref;
  final bool Function() isWidgetMounted;
  final Function(String message) onShowSnackBar;
  final Function() showDownloadConfirmationDialog;
  final Function() showMobileDataNotAllowedDialog;
  final String startingDownloadMessage;
  final String downloadNotAvailableMessage;
  final String downloadCompletedMessage;
  final String downloadFailedMessage;
  final String donwloadCancelledMessage;



  DownloadService({
    required this.ref,
    required this.isWidgetMounted,
    required this.onShowSnackBar,
    required this.startingDownloadMessage,
    required this.downloadNotAvailableMessage,
    required this.downloadCompletedMessage,
    required this.downloadFailedMessage,
    required this.donwloadCancelledMessage,
    required this.showDownloadConfirmationDialog,
    required this.showMobileDataNotAllowedDialog,
  });

  Future<void> downloadVideo(Stream stream, String type, String streamName, String streamDate) async {
    bool canDownload = await _handleDownloadConnectivity(stream, type);
    if (!canDownload) return;

    String? downloadUrl;
    for (var download in stream.downloads) {
      if (download.friendlyName == type) {
        downloadUrl = download.downloadURL;
        break;
      }
    }

    if (downloadUrl == null) {
      if (!isWidgetMounted()) return;
      onShowSnackBar(downloadNotAvailableMessage);
      return;
    }

    onShowSnackBar(startingDownloadMessage);

    ref.read(downloadViewModelProvider.notifier)
        .downloadVideo(downloadUrl, stream, streamName, streamDate)
        .then((localPath) {
      if (!isWidgetMounted()) return;
      onShowSnackBar(localPath.isNotEmpty ? downloadCompletedMessage : downloadFailedMessage);
    });
  }


Future<bool> _handleDownloadConnectivity(Stream stream, String type) async {
  final isDownloadWithWifiOnly = ref
      .watch(settingViewModelProvider)
      .isDownloadWithWifiOnly;
  var connectivityResult = await (Connectivity().checkConnectivity());
  // If 'Download Over Wi-Fi Only' is enabled and connected to mobile, show a dialog
  if (connectivityResult == ConnectivityResult.mobile && isDownloadWithWifiOnly) {
    if (!isWidgetMounted()) return false;
    showMobileDataNotAllowedDialog();
    return false;
  }
  // If on mobile data and 'Download Over Wi-Fi Only' is disabled, ask for confirmation
  if (connectivityResult == ConnectivityResult.mobile && !isDownloadWithWifiOnly) {
    bool shouldProceed = await showDownloadConfirmationDialog();
    if (!isWidgetMounted()) return false;
    if (!shouldProceed) {
      onShowSnackBar(donwloadCancelledMessage);
      return false;
    }
  }
  return true;
}


}