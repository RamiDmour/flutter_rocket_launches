import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch_simplified.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/domain/repositories/rocket_launch_repo_base.dart';
part 'rocket_launch_state.dart';

class RocketLaunchCubit extends Cubit<RocketLaunchState> {
  RocketLaunchCubit(RocketLaunchRepoBase rocketLaunchRepoBase)
      : _rocketLaunchRepo = rocketLaunchRepoBase,
        super(RocketLaunchState()) {
    loadLaunches();
  }
  final RocketLaunchRepoBase _rocketLaunchRepo;
  Future<void> loadLaunches({int limit = 10, int offset = 0}) async {
    if (state.hasReachedMax) {
      return;
    }

    if (state.rocketLaunchStatus == RocketLaunchStatus.loadingMore) {
      return;
    } else if (state.rocketLaunches.isNotEmpty) {
      emit(state.copyWith(rocketLaunchStatus: RocketLaunchStatus.loadingMore));
    }
    List<RocketLaunchSimplified> launches =
        await _rocketLaunchRepo.getLaunches(limit: limit, offset: offset);
    if (launches.isEmpty) {
      emit(state.copyWith(
          hasReachedMax: launches.isEmpty,
          rocketLaunchStatus: RocketLaunchStatus.ready));
      return;
    }

    if (state.filter.filterFilled) {
      launches.removeWhere((launch) {
        final DateTime date = DateTime.parse(launch.launchDateLocal);
        return date.isAfter(state.filter.from!) &&
            date.isBefore(state.filter.to!);
      });
    }

    emit(state.copyWith(
        rocketLaunches: [...state.rocketLaunches, ...launches],
        rocketLaunchStatus: RocketLaunchStatus.ready));
  }

  void updateFilter({DateTime? from, DateTime? to}) {
    emit(state.copyWith(filter: RocketLaunchFilter(from: from, to: to)));
  }
}
