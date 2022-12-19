import 'package:flutter/material.dart';
import 'package:flutter_rocket_launches/app/routing/rocket_launches_route_path.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/pages/rocket_launch_page.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/pages/rocket_launches_page.dart';

class RocketLaunchesInformationParser
    extends RouteInformationParser<RocketLaunchesRoutePath> {
  @override
  Future<RocketLaunchesRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.length == 0) return RocketLaunchesRoutePath.home();
    if (uri.pathSegments.first == RocketLaunchesPage.routeName)
      return RocketLaunchesRoutePath.home();
    if (uri.pathSegments.first == RocketLaunchPage.routeName &&
        uri.pathSegments.length == 2) {
      final String id = uri.pathSegments.elementAt(1);
      return RocketLaunchesRoutePath.details(id);
    }
    return RocketLaunchesRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(RocketLaunchesRoutePath path) {
    if (path.isUnknown) return RouteInformation(location: '/404');

    if (path.isHomePage)
      return RouteInformation(location: RocketLaunchesPage.routeName);

    if (path.isDetailsPage)
      return RouteInformation(
          location: '/${RocketLaunchPage.routeName}/${path.id}');

    return null;
  }
}
