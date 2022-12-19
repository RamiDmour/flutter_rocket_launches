class RocketLaunchesRoutePath {
  final String? id;
  final bool isUnknown;

  RocketLaunchesRoutePath.home()
      : id = null,
        isUnknown = false;

  RocketLaunchesRoutePath.details(this.id) : isUnknown = false;

  RocketLaunchesRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;
}
