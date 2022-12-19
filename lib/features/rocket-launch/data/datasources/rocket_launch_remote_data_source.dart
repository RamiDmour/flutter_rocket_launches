import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/data/models/rocket_launch_simplified.dart';
import 'package:flutter_rocket_launches/features/rocket-launch/exceptions/rocket_launch_fetch_exceptions.dart';
import 'package:graphql/client.dart';

abstract class RocketLaunchRemoteDataSourceBase {
  Future<List<RocketLaunchSimplified>> getLaunches(
      {int limit = 10, int offset = 0});

  Future<RocketLaunch> getLaunch(String id);
}

class RocketLaunchRemoteDataSource implements RocketLaunchRemoteDataSourceBase {
  RocketLaunchRemoteDataSource({GraphQLClient? client})
      : _client = client ??
            GraphQLClient(
                link: HttpLink('http://api.spacex.land/graphql/'),
                cache: GraphQLCache());

  final GraphQLClient _client;

  @override
  Future<List<RocketLaunchSimplified>> getLaunches(
      {int limit = 10, int offset = 0}) async {
    final QueryOptions options = QueryOptions(
        document: gql(fetchRocketLaunches),
        variables: <String, dynamic>{'limit': limit, 'offset': offset});
    final QueryResult result = await _client.query(options);
    if (result.hasException || result.data == null) {
      throw RocketLaunchFetchException(message: result.exception!.toString());
    }

    return (result.data!['launches'] as List)
        .map<RocketLaunchSimplified>(
            (launch) => RocketLaunchSimplified.fromJson(launch))
        .toList();
  }

  @override
  Future<RocketLaunch> getLaunch(String id) async {
    final QueryOptions options = QueryOptions(
        document: gql(fetchRocketLaunch),
        variables: <String, dynamic>{'id': id});

    final QueryResult result = await _client.query(options);
    if (result.hasException || result.data == null) {
      throw RocketLaunchFetchException(message: result.exception!.toString());
    }

    return RocketLaunch.fromJson(result.data!['launch']);
  }
}

const String fetchRocketLaunches = r'''
  query FetchRocketLaunches($limit: Int!, $offset: Int!) {
    launches(limit: $limit, offset: $offset) {
      mission_name
      rocket {
        rocket {
          mass {
            kg
          }
          cost_per_launch
          company
        }
        rocket_name
      }
      launch_date_local
      launch_success
      id
    }
  }
''';

const String fetchRocketLaunch = r'''
  query FetchRocketLaunch($id: ID!) {
    launch(id: $id) {
      mission_name
      rocket {
        rocket {
          mass {
            kg
          }
          cost_per_launch
          company
          country
          height {
            meters
          }
          diameter {
            meters
          }
          stages
        }
        rocket_name
      }
      launch_date_local
      launch_success
      id
      links {
        article_link
        flickr_images
        mission_patch
        mission_patch_small
        presskit
        reddit_campaign
        reddit_launch
        reddit_media
        reddit_recovery
        video_link
        wikipedia
      }
      upcoming
    }
  }
''';
