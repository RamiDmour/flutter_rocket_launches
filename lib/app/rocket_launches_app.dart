import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rocket_launches/app/routing/rocket_launches_info_parser.dart';
import 'package:flutter_rocket_launches/app/routing/rocket_launches_router_delegate.dart';
import 'package:flutter_rocket_launches/core/routing/arguments/web_native_page_arguments.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/data/repositories/rocket_launch_repo.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/domain/repositories/rocket_launch_repo_base.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/cubit/rocket_launches/rocket_launch_cubit.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/cubit/rocket_launch_detailed/rocket_launch_detailed_cubit.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/pages/rocket_launch_page.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/presentation/pages/rocket_launches_page.dart';

class RocketLaunchesApp extends StatelessWidget {
  const RocketLaunchesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RocketLaunchRepoBase>(
            create: (context) => RocketLaunchRepo())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RocketLaunchCubit>(
            create: (context) =>
                RocketLaunchCubit(context.read<RocketLaunchRepoBase>()),
          ),
          BlocProvider<RocketLaunchDetailedCubit>(
            create: (context) =>
                RocketLaunchDetailedCubit(context.read<RocketLaunchRepoBase>()),
          )
        ],
        child: MaterialApp.router(
          routerDelegate: RocketLaunchesRouterDelegate(),
          routeInformationParser: RocketLaunchesInformationParser(),
          debugShowCheckedModeBanner: false,
          title: 'Rocket launches application',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        ),
      ),
    );
  }
}
