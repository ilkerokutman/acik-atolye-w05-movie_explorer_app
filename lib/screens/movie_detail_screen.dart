import 'package:flutter/material.dart';
import '../models/simple_movie.dart';
import '../services/http_movie_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  final SimpleMovie initialMovie;

  const MovieDetailScreen({
    super.key,
    required this.movieId,
    required this.initialMovie,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final HttpMovieService _movieService = HttpMovieService();
  SimpleMovie? _movie;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _movie = widget.initialMovie; // Use initial data immediately
    _loadMovieDetails();
  }

  Future<void> _loadMovieDetails() async {
    try {
      final movie = await _movieService.getMovieDetails(widget.movieId);
      setState(() {
        _movie = movie;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error'),
            ElevatedButton(
              onPressed: _loadMovieDetails,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _movie!.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                _buildRatingRow(),
                const SizedBox(height: 16),
                Text(
                  'Overview',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(_movie!.overview),
                const SizedBox(height: 16),
                if (!_isLoading) ...[
                  _buildInfoRow('Release Date', _movie!.releaseDate),
                  _buildInfoRow('Original Title', _movie!.originalTitle),
                  _buildInfoRow(
                    'Vote Count',
                    _movie!.voteCount.toString(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 300.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: _movie!.backdropPath != null
            ? Hero(
                tag: 'movie-poster-${_movie!.id}',
                child: Image.network(
                  _movie!.fullBackdropPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.error_outline, size: 48),
                    );
                  },
                ),
              )
            : Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.movie_outlined, size: 48),
                ),
              ),
      ),
    );
  }

  Widget _buildRatingRow() {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber),
        const SizedBox(width: 4),
        Text(
          _movie!.voteAverage.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          ' / 10',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        if (_isLoading)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
