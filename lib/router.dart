import 'package:flutter/material.dart';
import 'package:invoice/features/invoice/screens/invoice_screen.dart';
import 'package:invoice/models/ceiling_model.dart';

import 'features/home/screens/home_screen.dart';

Route<dynamic> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case InvoiceScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => InvoiceScreen(
            ceilingItemList: routeSettings.arguments as List<CeilingModel>),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Page is doesn\'t exit'),
          ),
        ),
      );
  }
}
