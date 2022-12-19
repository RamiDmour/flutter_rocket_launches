part of 'rocket_launch_cubit.dart';

class RocketLaunchState extends Equatable {
  RocketLaunchState({
    this.hasReachedMax = false,
    this.rocketLaunchStatus = RocketLaunchStatus.initialLoading,
    this.rocketLaunches = const [],
    RocketLaunchFilter? filter,
  }) : this.filter = filter ?? RocketLaunchFilter();

  final RocketLaunchStatus rocketLaunchStatus;
  final List<RocketLaunchSimplified> rocketLaunches;
  final bool hasReachedMax;
  final RocketLaunchFilter filter;

  @override
  List<Object> get props => [rocketLaunchStatus, rocketLaunches, hasReachedMax];

  RocketLaunchState copyWith({
    RocketLaunchStatus? rocketLaunchStatus,
    List<RocketLaunchSimplified>? rocketLaunches,
    bool? hasReachedMax,
    RocketLaunchFilter? filter,
  }) {
    return RocketLaunchState(
      rocketLaunchStatus: rocketLaunchStatus ?? this.rocketLaunchStatus,
      rocketLaunches: rocketLaunches ?? this.rocketLaunches,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      filter: filter ?? this.filter,
    );
  }
}

class RocketLaunchFilter {
  RocketLaunchFilter({this.from, this.to});

  final DateTime? from;
  final DateTime? to;

  RocketLaunchFilter copyWith({
    DateTime? from,
    DateTime? to,
  }) {
    return RocketLaunchFilter(
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  get filterFilled => from != null && to != null;
}

enum RocketLaunchStatus { ready, initialLoading, loadingMore }
