import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rocket_launches/core/routing/arguments/web_native_page_arguments.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/cubit/rocket_launch_detailed/rocket_launch_detailed_cubit.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/pages/rocket_launch_page.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/widgets/rocket_launch_infinity_list.dart';

class RocketLaunchesPage extends StatelessWidget {
  static const String routeName = 'list';
  const RocketLaunchesPage(
      {Key? key, this.id, required this.onRocketLaynchSelect})
      : super(key: key);
  final String? id;
  final Function(String id) onRocketLaynchSelect;

  @override
  Widget build(BuildContext context) {
    return RocketLaunchesView(
      id: id,
      onRocketLaynchSelect: onRocketLaynchSelect,
    );
  }
}

class RocketLaunchesView extends StatelessWidget {
  const RocketLaunchesView(
      {Key? key, this.id, required this.onRocketLaynchSelect})
      : super(key: key);
  final String? id;
  final Function(String id) onRocketLaynchSelect;

  Widget _getWebBody(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: RocketLaunchInfinityList(
              onSelect: (rocketLaunch) => onRocketLaynchSelect(rocketLaunch.id),
            ),
            flex: 1),
        Expanded(
          child: RocketLaunchPage(),
          flex: 2,
        ),
      ],
    );
  }

  Widget _getMobileBody(BuildContext context) => id == null
      ? RocketLaunchInfinityList(
          onSelect: (rocketLaunch) => onRocketLaynchSelect(rocketLaunch.id))
      : RocketLaunchPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromRGBO(156, 195, 204, 1),
              const Color.fromRGBO(152, 150, 200, 1)
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return _getMobileBody(context);
              } else {
                return _getWebBody(context);
              }
            },
          ),
        ),
      ),
    );
  }
}
