import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/domain/repositories/rocket_launch_repo_base.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/domain/usecases/get_rocket_launch.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/exceptions/rocket_launch_fetch_exceptions.dart';

part 'rocket_launch_detailed_state.dart';

class RocketLaunchDetailedCubit extends Cubit<RocketLaunchDetailedState> {
  RocketLaunchDetailedCubit(RocketLaunchRepoBase rocketLaunchRepoBase)
      : _rocketLaunchRepo = rocketLaunchRepoBase,
        super(RocketLaunchDetailedState());
  final RocketLaunchRepoBase _rocketLaunchRepo;
  Future<void> fetchRocketLaunch(String id) async {
    emit(state.copyWith(
        rocketLaunchDetailedStatus: RocketLaunchDetailedStatus.loading));
    try {
      final RocketLaunch rocketLaunch =
          await GetRocketLaunch(_rocketLaunchRepo)(id);
      emit(
        state.copyWith(
            rocketLaunch: rocketLaunch,
            rocketLaunchDetailedStatus: RocketLaunchDetailedStatus.ready),
      );
    } on RocketLaunchFetchException catch (e) {
      print(e.message);
    }
  }
}
