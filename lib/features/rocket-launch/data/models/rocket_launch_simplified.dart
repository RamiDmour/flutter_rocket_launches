class RocketLaunchSimplified {
  RocketLaunchSimplified({
    required this.missionName,
    required this.rocket,
    required this.launchDateLocal,
    required this.launchSuccess,
    required this.id,
  });
  late final String missionName;
  late final RocketSimplified rocket;
  late final String launchDateLocal;
  late final bool? launchSuccess;
  late final String id;

  RocketLaunchSimplified.fromJson(Map<String, dynamic> json) {
    missionName = json['mission_name'] as String;
    rocket = RocketSimplified.fromJson(json['rocket']);
    launchDateLocal = json['launch_date_local'] as String;
    launchSuccess = json['launch_success'] as bool?;
    id = json['id'] as String;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mission_name'] = missionName;
    _data['rocket'] = rocket.toJson();
    _data['launch_date_local'] = launchDateLocal;
    _data['launch_success'] = launchSuccess;
    _data['id'] = id;
    return _data;
  }
}

class RocketSimplified {
  RocketSimplified({
    required this.costPerLaunch,
    required this.company,
    required this.mass,
    required this.rocketName,
  });
  late final int mass;
  late final int costPerLaunch;
  late final String rocketName;
  late final String company;

  RocketSimplified.fromJson(Map<String, dynamic> json) {
    mass = json['rocket']['mass']['kg'];
    costPerLaunch = json['rocket']['cost_per_launch'];
    company = json['rocket']['company'];
    rocketName = json['rocket_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rocket']['mass'] = mass;
    _data['rocket_name'] = rocketName;
    _data['company'] = company;
    return _data;
  }
}
