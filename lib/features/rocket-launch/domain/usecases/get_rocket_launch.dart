import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/domain/repositories/rocket_launch_repo_base.dart';

class GetRocketLaunch {
  final RocketLaunchRepoBase _rocketLaunchesRepoBase;

  GetRocketLaunch(this._rocketLaunchesRepoBase);
  Future<RocketLaunch> call(String id) async {
    return _rocketLaunchesRepoBase.getLaunch(id);
  }
}
