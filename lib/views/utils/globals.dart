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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
