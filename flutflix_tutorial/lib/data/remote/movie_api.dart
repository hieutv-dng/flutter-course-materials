import 'package:flutflix_tutorial/core/constants.dart';
import 'package:flutflix_tutorial/data/index.dart';

class MovieApi extends BaseRemoteSource {
  MovieApi({required this.service});

  final MovieService service;

  Future<List<Movie>> getTrendingMovies() {
    return callApiWithErrorParser(service.trendingMovies(Constants.apiKey))
        .then((response) {
      return response.data.results;
    });
  }

  Future<List<Movie>> getTopRatedMovies() {
    return callApiWithErrorParser(service.topRatedMovies(Constants.apiKey))
        .then((response) {
      return response.data.results;
    });
  }

  Future<List<Movie>> getUpcomingMovies() {
    return callApiWithErrorParser(service.upcomingMovies(Constants.apiKey))
        .then((response) {
      return response.data.results;
    });
  }
}
