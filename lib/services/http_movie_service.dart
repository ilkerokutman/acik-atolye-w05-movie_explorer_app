import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/simple_movie.dart';

class HttpMovieService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static String get _accessToken => dotenv.env['ACCESS_TOKEN'] ?? '';

  Future<List<SimpleMovie>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/popular'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => SimpleMovie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<SimpleMovie> getMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$movieId'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return SimpleMovie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
