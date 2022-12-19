class RocketLaunch {
  late String missionName;
  late Rocket rocket;
  late String launchDateLocal;
  late bool launchSuccess;
  late String id;
  late Links links;

  RocketLaunch(
      {required this.missionName,
      required this.rocket,
      required this.launchDateLocal,
      required this.launchSuccess,
      required this.id,
      required this.links});

  RocketLaunch.fromJson(Map<String, dynamic> json) {
    missionName = json['mission_name'];
    rocket = new Rocket.fromJson(json['rocket']);
    launchDateLocal = json['launch_date_local'];
    launchSuccess = json['launch_success'];
    id = json['id'];
    links = new Links.fromJson(json['links']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mission_name'] = this.missionName;
    data['rocket'] = this.rocket.toJson();
    data['launch_date_local'] = this.launchDateLocal;
    data['launch_success'] = this.launchSuccess;
    data['id'] = this.id;
    data['links'] = this.links.toJson();
    return data;
  }
}

class Rocket {
  late String rocketName;
  late int mass;
  late int costPerLaunch;
  late String company;
  late String country;
  late double height;
  late double diameter;
  late int stages;

  Rocket(
      {required this.rocketName,
      required this.mass,
      required this.costPerLaunch,
      required this.company,
      required this.country,
      required this.height,
      required this.diameter,
      required this.stages});

  Rocket.fromJson(Map<String, dynamic> json) {
    rocketName = json['rocket_name'] as String;
    mass = json['rocket']['mass']['kg'] as int;
    costPerLaunch = json['rocket']['cost_per_launch'] as int;
    company = json['rocket']['company'] as String;
    country = json['rocket']['country'] as String;
    height = json['rocket']['height']['meters'].toDouble() as double;
    diameter = json['rocket']['diameter']['meters'] as double;
    stages = json['rocket']['stages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rocket']['mass']['kg'] = mass;
    data['rocket']['cost_per_launch'] = costPerLaunch;
    data['rocket']['company'] = company;
    data['rocket']['country'] = country;
    data['rocket']['height']['meters'] = height;
    data['rocket']['diameter']['meters'] = diameter;
    data['rocket']['stages'] = stages;
    data['rocket_name'] = this.rocketName;

    return data;
  }
}

class Links {
  String? articleLink;
  late List<String> flickrImages;
  String? missionPatch;
  String? missionPatchSmall;
  String? presskit;
  String? redditCampaign;
  String? redditLaunch;
  String? redditMedia;
  String? redditRecovery;
  String? videoLink;
  String? wikipedia;

  Links(
      {required this.articleLink,
      required this.flickrImages,
      required this.missionPatch,
      required this.missionPatchSmall,
      required this.presskit,
      required this.redditCampaign,
      required this.redditLaunch,
      required this.redditMedia,
      required this.redditRecovery,
      required this.videoLink,
      required this.wikipedia});

  Links.fromJson(Map<String, dynamic> json) {
    articleLink = json['article_link'];
    flickrImages = json['flickr_images'].cast<String>();
    missionPatch = json['mission_patch'];
    missionPatchSmall = json['mission_patch_small'];
    presskit = json['presskit'];
    redditCampaign = json['reddit_campaign'];
    redditLaunch = json['reddit_launch'];
    redditMedia = json['reddit_media'];
    redditRecovery = json['reddit_recovery'];
    videoLink = json['video_link'];
    wikipedia = json['wikipedia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['article_link'] = this.articleLink;
    data['flickr_images'] = this.flickrImages;
    data['mission_patch'] = this.missionPatch;
    data['mission_patch_small'] = this.missionPatchSmall;
    data['presskit'] = this.presskit;
    data['reddit_campaign'] = this.redditCampaign;
    data['reddit_launch'] = this.redditLaunch;
    data['reddit_media'] = this.redditMedia;
    data['reddit_recovery'] = this.redditRecovery;
    data['video_link'] = this.videoLink;
    data['wikipedia'] = this.wikipedia;
    return data;
  }
}
