import 'package:date_dif/screens/home.dart';
import 'package:get/route_manager.dart';

routes() => [
      GetPage(
          name: '/home',
          page: () => const HomePage(),
          transition: Transition.zoom)
    ];
