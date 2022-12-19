import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rocket_launches/core/utils/color.dart';
import 'package:flutter_rocket_launches/core/widgets/link.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/cubit/rocket_launch_detailed/rocket_launch_detailed_cubit.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/pages/rocket_launches_page.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/widgets/gallery.dart';

class RocketLaunchPage extends StatelessWidget {
  const RocketLaunchPage({Key? key}) : super(key: key);
  static const String routeName = 'details';

  @override
  Widget build(BuildContext context) {
    return RocketLauchView();
  }
}

class RocketLauchView extends StatelessWidget {
  const RocketLauchView({Key? key}) : super(key: key);

  List<Image> _buildNetworkImages(List<String> urls) => urls
      .map<Image>(
        (url) => Image.network(
          url,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, -1),
            end: Alignment(1.0, 1),
            colors: [
              HexColor.fromHex("#ee0979"),
              HexColor.fromHex("#ff6a00"),
            ],
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocBuilder<RocketLaunchDetailedCubit,
                RocketLaunchDetailedState>(
              builder: (context, state) {
                if (state.rocketLaunchDetailedStatus ==
                    RocketLaunchDetailedStatus.init) {
                  return Center(
                    child:
                        Text("Please, select rocket launch from the left list"),
                  );
                }

                if (state.rocketLaunchDetailedStatus ==
                    RocketLaunchDetailedStatus.loading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(98, 75, 155, 1),
                    ),
                  );
                }

                if (state.rocketLaunch == null) {
                  return Center(
                    child: Text(
                      "Rocket launch not found",
                      style: TextStyle(color: Colors.red, fontSize: 32),
                    ),
                  );
                }
                final RocketLaunch rocketLaunch = state.rocketLaunch!;
                final screenWidth = MediaQuery.of(context).size.width;
                final screenHeight = MediaQuery.of(context).size.height;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        rocketLaunch.missionName,
                        style: TextStyle(fontSize: 48),
                      ),
                      Text(
                        rocketLaunch.rocket.rocketName,
                        style: TextStyle(fontSize: 36),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Gallery(
                            images: _buildNetworkImages(
                                rocketLaunch.links.flickrImages),
                            imageWidth: screenWidth / 4,
                            imageHeight: screenHeight / 6),
                      ),
                      Text('Rocket Information',
                          style: TextStyle(fontSize: 36)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Company: ${rocketLaunch.rocket.company}'),
                              Text(
                                  'Cost per launch: ${rocketLaunch.rocket.costPerLaunch}\$'),
                              Text('Country: ${rocketLaunch.rocket.country}'),
                              Text(
                                  'Height: ${rocketLaunch.rocket.height} meters'),
                              Text(
                                  'Diameter: ${rocketLaunch.rocket.diameter} meters'),
                              Text('Mass: ${rocketLaunch.rocket.mass} kg'),
                              Text('Stages: ${rocketLaunch.rocket.stages}'),
                              Text(rocketLaunch.launchSuccess
                                  ? 'Rocket successfuly launched'
                                  : 'Rocket didn\'t launch')
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Links: ',
                        style: TextStyle(fontSize: 32),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (rocketLaunch.links.articleLink != null)
                                TextLink(
                                    linkText: "Link to article!",
                                    url: rocketLaunch.links.articleLink!)
                              else
                                SizedBox(),
                              if (rocketLaunch.links.presskit != null)
                                TextLink(
                                    linkText: "Link to presskit!",
                                    url: rocketLaunch.links.presskit!)
                              else
                                SizedBox(),
                              if (rocketLaunch.links.redditCampaign != null)
                                TextLink(
                                    linkText: "Link to reddit Campaign!",
                                    url: rocketLaunch.links.redditCampaign!)
                              else
                                SizedBox(),
                              if (rocketLaunch.links.redditLaunch != null)
                                TextLink(
                                    linkText: "Link to reddit launch!",
                                    url: rocketLaunch.links.redditLaunch!)
                              else
                                SizedBox(),
                              if (rocketLaunch.links.articleLink != null)
                                TextLink(
                                    linkText: "Link to Wikipedia!",
                                    url: rocketLaunch.links.wikipedia!)
                              else
                                SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
