part of 'rocket_launch_detailed_cubit.dart';

class RocketLaunchDetailedState extends Equatable {
  const RocketLaunchDetailedState({
    this.rocketLaunchDetailedStatus = RocketLaunchDetailedStatus.init,
    this.rocketLaunch,
  });
  final RocketLaunchDetailedStatus rocketLaunchDetailedStatus;
  final RocketLaunch? rocketLaunch;
  @override
  List<Object?> get props => [rocketLaunchDetailedStatus, rocketLaunch];

  RocketLaunchDetailedState copyWith({
    RocketLaunchDetailedStatus? rocketLaunchDetailedStatus,
    RocketLaunch? rocketLaunch,
  }) {
    return RocketLaunchDetailedState(
      rocketLaunchDetailedStatus:
          rocketLaunchDetailedStatus ?? this.rocketLaunchDetailedStatus,
      rocketLaunch: rocketLaunch ?? this.rocketLaunch,
    );
  }
}

enum RocketLaunchDetailedStatus { init, loading, ready }
