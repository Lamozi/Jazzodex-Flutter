import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/jazz_artist.dart';
import '../widgets/artist_tile.dart' show gradientForArtist;
import '../widgets/artist_header_banner.dart';
import '../widgets/artist_stats_card.dart';

class ArtistDetailPage extends StatefulWidget {
  final JazzArtist artist;

  const ArtistDetailPage({super.key, required this.artist});

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  late Future<String> futureFamousSong;

  @override
  void initState() {
    super.initState();
    futureFamousSong = fetchFamousSong(widget.artist.name);
  }

  Future<String> fetchFamousSong(String name) async {
    final url = Uri.parse(
      'https://www.theaudiodb.com/api/v1/json/123/track-top10.php?s=${Uri.encodeComponent(name)}',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic>? tracks = data['track'];
      if (tracks != null && tracks.isNotEmpty) {
        return tracks[0]['strTrack']?.toString() ?? 'Unknown';
      }
      return 'Unknown';
    } else {
      throw Exception('Error loading famous song');
    }
  }

  @override
  Widget build(BuildContext context) {
    final artist = widget.artist;
    final gradient = gradientForArtist(artist.name);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F3FA),
      appBar: AppBar(
        backgroundColor: gradient[0],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ArtistHeaderBanner(artist: artist, gradient: gradient),
            const SizedBox(height: 24),
            ArtistStatsCard(
              artist: artist,
              accentColor: gradient[0],
              futureFamousSong: futureFamousSong,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
