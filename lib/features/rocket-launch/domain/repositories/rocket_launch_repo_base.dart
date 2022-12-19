import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch_simplified.dart';

abstract class RocketLaunchRepoBase {
  Future<List<RocketLaunchSimplified>> getLaunches(
      {int limit = 10, int offset = 0});
  Future<RocketLaunch> getLaunch(String id);
}
