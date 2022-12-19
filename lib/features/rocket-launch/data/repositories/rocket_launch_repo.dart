import 'package:flutter_rocket_launches/features/rocket-launch/data/datasources/rocket_launch_remote_data_source.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch_simplified.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/domain/repositories/rocket_launch_repo_base.dart';

class RocketLaunchRepo extends RocketLaunchRepoBase {
  final RocketLaunchRemoteDataSourceBase _rocketLaunchRemoteDataSourceBase;

  RocketLaunchRepo({RocketLaunchRemoteDataSourceBase? remoteDataSource})
      : _rocketLaunchRemoteDataSourceBase =
            remoteDataSource ?? RocketLaunchRemoteDataSource();

  @override
  Future<List<RocketLaunchSimplified>> getLaunches(
      {int limit = 10, int offset = 0}) {
    return _rocketLaunchRemoteDataSourceBase.getLaunches(
        limit: limit, offset: offset);
  }

  @override
  Future<RocketLaunch> getLaunch(String id) {
    return _rocketLaunchRemoteDataSourceBase.getLaunch(id);
  }
}
