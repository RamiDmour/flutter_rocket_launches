import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch_simplified.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/domain/repositories/rocket_launch_repo_base.dart';

class GetRocketLaunches {
  final RocketLaunchRepoBase _rocketLaunchesRepoBase;

  GetRocketLaunches(this._rocketLaunchesRepoBase);
  Future<List<RocketLaunchSimplified>> call({int limit = 10, int offset = 0}) {
    return _rocketLaunchesRepoBase.getLaunches(limit: limit, offset: offset);
  }
}
