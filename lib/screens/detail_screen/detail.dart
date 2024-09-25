import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> movie;

  const DetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          movie['name'],
          style: const TextStyle(color: Colors.red),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMovieImage(), // Large movie image
              const SizedBox(height: 20),
              _buildMovieTitle(), // Movie title
              const SizedBox(height: 10),
              _buildMovieInfoRow(), // Genre, rating, etc.
              const SizedBox(height: 20),
              _buildMovieSummary(), // Movie summary
            ],
          ),
        ),
      ),
    );
  }

  // Movie Image - Full Width Image
  Widget _buildMovieImage() {
    return Container(
      height: 400.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(movie['image'] != null ? movie['image']['original'] : ''),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Movie Title - Bold, Netflix-Style Title
  Widget _buildMovieTitle() {
    return Text(
      movie['name'],
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Movie Info Row - Genre, Language, Rating, Premiered Date
  Widget _buildMovieInfoRow() {
    return Wrap(
      spacing: 8.0, // Space between tags
      runSpacing: 4.0, // Space between lines when it overflows
      children: [
        if (movie['genres'] != null && movie['genres'].isNotEmpty)
          _buildInfoTag(movie['genres'].join(', ')), // Genres
        if (movie['language'] != null) _buildInfoTag(movie['language']), // Language
        if (movie['rating'] != null && movie['rating']['average'] != null)
          _buildInfoTag('Rating: ${movie['rating']['average']}'), // Rating
        if (movie['premiered'] != null) _buildInfoTag('Premiered: ${movie['premiered']}'), // Premier Date
      ],
    );
  }

  // Movie Summary - Detailed Description
  Widget _buildMovieSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Summary',
          style: TextStyle(
            color: Colors.red,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          movie['summary'] != null
              ? movie['summary'].replaceAll(RegExp(r'<[^>]*>'), '') // Strip HTML tags
              : 'No summary available',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  // Helper Widget for Information Tags (e.g., Genres, Rating, Language)
  Widget _buildInfoTag(String info) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        info,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
