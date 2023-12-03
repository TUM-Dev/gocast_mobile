/// Global Objects and State for the Application
///
/// This file contains global keys and objects that are required to be accessed
/// across different parts of the application. Usage of globals is limited to scenarios
/// where passing data via constructors or context is not feasible.
///
/// Contains:
/// - GlobalKey for NavigatorState: Used for navigation in contexts where BuildContext is not available.
///
/// Note: Use globals judiciously as they can lead to tightly coupled code and make testing more difficult.
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Global key for the navigator state to be used for navigation in contexts where BuildContext is not available.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Provider for managing the lifecycle of the username text controller
final usernameControllerProvider =
    Provider.autoDispose((ref) => TextEditingController());

// Provider for managing the lifecycle of the password text controller
final passwordControllerProvider =
    Provider.autoDispose((ref) => TextEditingController());
