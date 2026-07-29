import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/jazz_artist.dart';
import '../widgets/artist_list_state_views.dart';
import 'artist_detail_page.dart';

final List<String> nomsArtistes = [
  'Miles Davis',
  'John Coltrane',
  'Louis Armstrong',
  'Ella Fitzgerald',
  'Duke Ellington',
  'Charlie Parker',
  'Thelonious Monk',
  'Herbie Hancock',
  'Nina Simone',
  'Chet Baker',
  'Billie Holiday',
  'Dizzy Gillespie',
  'Count Basie',
  'Sarah Vaughan',
  'Dave Brubeck',
  'Stan Getz',
  'Wes Montgomery',
  'Wayne Shorter',
  'Sonny Rollins',
  'Art Blakey',
  'Bill Evans',
  'Cannonball Adderley',
  'Oscar Peterson',
  'Benny Goodman',
  'Charles Mingus',
  'Pat Metheny',
  'Diana Krall',
  'Esperanza Spalding',
  'Kamasi Washington',
  'Al Jarreau',
];

class ArtistListPage extends StatefulWidget {
  const ArtistListPage({super.key});

  @override
  State<ArtistListPage> createState() => _ArtistListPageState();
}

class _ArtistListPageState extends State<ArtistListPage> {
  late Future<List<JazzArtist>> futureArtists;

  int _requestsDone = 0;

  @override
  void initState() {
    super.initState();
    futureArtists = fetchArtists();
  }

  Future<List<JazzArtist>> fetchArtists() async {
    _requestsDone = 0;
    final List<JazzArtist> artists = [];

    for (final nom in nomsArtistes) {
      final url = Uri.parse(
        'https://www.theaudiodb.com/api/v1/json/123/search.php?s=${Uri.encodeComponent(nom)}',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic>? artistsJson = data['artists'];
        if (artistsJson != null && artistsJson.isNotEmpty) {
          artists.add(JazzArtist.fromJson(artistsJson[0]));
        }
      } else {
        throw Exception('Error loading artists');
      }

      if (mounted) {
        setState(() => _requestsDone++);
      }
    }

    return artists;
  }

  void _reload() {
    setState(() {
      futureArtists = fetchArtists();
    });
  }

  void _openDetail(JazzArtist artist) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ArtistDetailPage(artist: artist)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.music_note),
            SizedBox(width: 8),
            Text('Jazzodex'),
          ],
        ),
      ),
      body: FutureBuilder<List<JazzArtist>>(
        future: futureArtists,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingArtistsView(
              loaded: _requestsDone,
              total: nomsArtistes.length,
            );
          } else if (snapshot.hasError) {
            return ArtistsErrorView(error: snapshot.error, onRetry: _reload);
          } else if (snapshot.hasData) {
            final artists = snapshot.data!;
            if (artists.isEmpty) {
              return const Center(child: Text('No artist found'));
            }
            return ArtistsListView(artists: artists, onArtistTap: _openDetail);
          } else {
            return const Center(child: Text('No artist found'));
          }
        },
      ),
    );
  }
}
