import 'package:date_dif/screens/validator.dart';
import 'package:date_dif/screens/home.dart';
import 'package:date_dif/screens/login.dart';
import 'package:get/route_manager.dart';

routes() => [
      GetPage(
        name: '/home',
        page: () => HomePage(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: '/login',
        page: () => const LoginPage(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: '/validator',
        page: () => const ValidatorPage(),
        transition: Transition.cupertino,
      ),
    ];
