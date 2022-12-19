import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch_simplified.dart';
import 'package:intl/intl.dart';

class RocketLaunchCard extends StatefulWidget {
  const RocketLaunchCard(
      {Key? key,
      double? width,
      double? height,
      required this.onSelect,
      required RocketLaunchSimplified rocketLaunchSimplified})
      : _width = width ?? double.infinity,
        _height = height ?? 200,
        _rocketLaunchSimplified = rocketLaunchSimplified,
        super(key: key);
  final double _width;
  final double _height;
  final Function(RocketLaunchSimplified rocketLaunch) onSelect;
  final RocketLaunchSimplified _rocketLaunchSimplified;
  @override
  RocketLaunchCardState createState() => RocketLaunchCardState();
}

class RocketLaunchCardState extends State<RocketLaunchCard> {
  bool cardSelected = false;

  Widget _buildRocketDetails({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.black38),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.black38),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(widget._rocketLaunchSimplified.launchDateLocal);
    return GestureDetector(
      onTap: () => widget.onSelect(widget._rocketLaunchSimplified),
      onTapCancel: () => setState(() => cardSelected = false),
      onTapUp: (details) => setState(() => cardSelected = false),
      onTapDown: (details) => setState(() => cardSelected = true),
      child: AnimatedContainer(
        padding: EdgeInsets.all(cardSelected ? 0 : 5),
        width: widget._width,
        height: widget._height,
        duration: Duration(milliseconds: 500),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(top: 48, bottom: 20),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(98, 75, 155, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 0.0)
                    ]),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget._rocketLaunchSimplified.id,
                        maxLines: 1,
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('yyyy-MM-dd').format(date),
                            style: TextStyle(color: Colors.white60),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            DateFormat('kk:mm').format(date),
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    ]),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget._rocketLaunchSimplified.missionName,
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              widget._rocketLaunchSimplified.rocket.company,
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildRocketDetails(
                                  title: "Rocket name",
                                  value: widget._rocketLaunchSimplified.rocket
                                      .rocketName),
                              const SizedBox(
                                width: 5,
                              ),
                              _buildRocketDetails(
                                  title: "Launch cost",
                                  value: widget._rocketLaunchSimplified.rocket
                                          .costPerLaunch
                                          .toString() +
                                      '\$'),
                              const SizedBox(
                                width: 5,
                              ),
                              _buildRocketDetails(
                                  title: "Weight",
                                  value: widget
                                      ._rocketLaunchSimplified.rocket.mass
                                      .toString()),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
