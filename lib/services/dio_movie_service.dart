import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/movie.dart';

class DioMovieService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static String get _accessToken => dotenv.env['ACCESS_TOKEN'] ?? '';

  final Dio _dio;

  DioMovieService() : _dio = Dio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'Authorization': 'Bearer $_accessToken',
      'accept': 'application/json',
    };
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await _dio.get('/movie/popular');

      final List<dynamic> results = response.data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load movies: ${e.message}');
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId');

      return Movie.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load movie details: ${e.message}');
    }
  }
}
