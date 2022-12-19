import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rocket_launches/app/routing/rocket_launches_route_path.dart';
import 'package:flutter_rocket_launches/app/routing/unknown_page.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/cubit/rocket_launch_detailed/rocket_launch_detailed_cubit.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/pages/rocket_launches_page.dart';

class RocketLaunchesRouterDelegate
    extends RouterDelegate<RocketLaunchesRoutePath>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<RocketLaunchesRoutePath> {
  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  String? _selectedId;
  bool show404 = false;

  void _handleRocketLaunchSelect(String id) {
    _selectedId = id;
    notifyListeners();
  }

  RocketLaunchesRoutePath get currentConfiguration {
    if (show404) return RocketLaunchesRoutePath.unknown();

    if (_selectedId == null) return RocketLaunchesRoutePath.home();

    return RocketLaunchesRoutePath.details(_selectedId);
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedId != null) {
      context.read<RocketLaunchDetailedCubit>().fetchRocketLaunch(_selectedId!);
    }
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('RocketLaunchesPage'),
          child: RocketLaunchesPage(
            id: _selectedId,
            onRocketLaynchSelect: _handleRocketLaunchSelect,
          ),
        ),
        if (show404)
          MaterialPage(
            key: ValueKey('UnknownPage'),
            child: UnknownPage(),
          )
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          print("SUCCESS");
          return false;
        }
        print("TEST");

        _selectedId = null;
        show404 = false;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RocketLaunchesRoutePath path) async {
    if (path.isUnknown) {
      _selectedId = null;
      show404 = true;
      return;
    }

    if (path.isDetailsPage) {
      if (int.tryParse(path.id!) == null) {
        show404 = true;
        return;
      } else if (int.parse(path.id!) < 0) {
        show404 = true;
        return;
      } else {
        _selectedId = path.id;
      }
    } else {
      _selectedId = null;
    }
    show404 = false;
  }
}
