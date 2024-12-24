import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/user.dart' as myapp_user;
import 'package:myapp/pages/authenticate/authenticate.dart';
import 'package:myapp/pages/Home/landing.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myapp_user.UserModel?>(context); // Listen to authentication state

    if (user == null) {
      return Authenticate();
    } else {
      return const Landing();
    }
  }
}
