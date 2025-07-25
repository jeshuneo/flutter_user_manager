import 'package:flutter/material.dart';
import '../../presentation/pages/user_list_page.dart';
import '../../presentation/pages/add_user_page.dart';

class AppRouter {
  static const String userList = '/';
  static const String addUser = '/add-user';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case userList:
        return MaterialPageRoute(builder: (_) => const UserListPage());
      case addUser:
        return MaterialPageRoute(
          builder: (_) => const AddUserPage(),
          fullscreenDialog: true,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
