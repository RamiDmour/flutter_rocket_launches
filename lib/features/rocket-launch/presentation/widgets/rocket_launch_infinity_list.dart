import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch_simplified.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/cubit/rocket_launches/rocket_launch_cubit.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/widgets/rocket_launch_card.dart';

class RocketLaunchInfinityList extends StatefulWidget {
  const RocketLaunchInfinityList(
      {Key? key,
      this.defaultOffset = 0,
      this.defaultLimit = 10,
      required this.onSelect})
      : super(key: key);
  final int defaultOffset;
  final int defaultLimit;
  final Function(RocketLaunchSimplified rocketLaunch) onSelect;
  @override
  _RocketLaunchInfinityListState createState() =>
      _RocketLaunchInfinityListState();
}

class _RocketLaunchInfinityListState extends State<RocketLaunchInfinityList> {
  late int _offset;
  late int _limit;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _offset = widget.defaultOffset;
    _limit = widget.defaultLimit;
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= 50) {
      setState(() {
        _offset += _limit;
        context
            .read<RocketLaunchCubit>()
            .loadLaunches(offset: _offset, limit: _limit);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RocketLaunchCubit, RocketLaunchState>(
      builder: (context, state) {
        if (state.rocketLaunchStatus == RocketLaunchStatus.initialLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(98, 75, 155, 1),
            ),
          );
        }

        if (state.rocketLaunches.isEmpty) {
          return Center(
            child: Text("Rocket launches list is empty"),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: state.hasReachedMax
              ? state.rocketLaunches.length
              : state.rocketLaunches.length + 1,
          itemBuilder: (context, index) {
            if (index >= state.rocketLaunches.length) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(98, 75, 155, 1),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: RocketLaunchCard(
                  key: ValueKey(state.rocketLaunches[index].id),
                  rocketLaunchSimplified: state.rocketLaunches[index],
                  onSelect: widget.onSelect,
                  height: 200,
                  width: double.infinity,
                ),
              );
            }
          },
        );
      },
    );
  }
}
