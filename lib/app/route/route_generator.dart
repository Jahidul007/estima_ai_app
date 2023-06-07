import 'package:flutter/material.dart';

import 'estima_app_route.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    MaterialPageRoute? page;

    page = getEstimaAppRoutes(settings);
    if (page != null) return page;

    return page; //todo this might cause error
  }

}
