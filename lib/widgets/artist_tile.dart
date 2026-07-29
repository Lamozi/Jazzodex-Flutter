import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../models/jazz_artist.dart';

String webSafeImageUrl(String url) {
  if (!kIsWeb || url.isEmpty) return url;
  final withoutScheme = url.replaceFirst(RegExp(r'^https?://'), '');
  return 'https://images.weserv.nl/?url=$withoutScheme';
}

const List<List<Color>> _avatarGradients = [
  [Color(0xFFFF6B6B), Color(0xFFFFA36C)],
  [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
  [Color(0xFF00B894), Color(0xFF55EFC4)],
  [Color(0xFF0984E3), Color(0xFF74B9FF)],
  [Color(0xFFE17055), Color(0xFFFAB1A0)],
  [Color(0xFFE84393), Color(0xFFFD79A8)],
  [Color(0xFFD68910), Color(0xFFFFD966)],
];

List<Color> gradientForArtist(String seed) {
  final index = seed.hashCode.abs() % _avatarGradients.length;
  return _avatarGradients[index];
}

class ArtistTile extends StatelessWidget {
  final JazzArtist artist;
  final VoidCallback onTap;

  const ArtistTile({super.key, required this.artist, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final gradient = gradientForArtist(artist.name);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      elevation: 3,
      shadowColor: gradient[0].withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: onTap,
        leading: ArtistTileAvatar(artist: artist, backgroundColor: gradient[0]),
        title: Text(
          artist.name,
          style: const TextStyle(
            fontFamily: 'Adelphe',
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        subtitle: Text(
          artist.city,
          style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontStyle: FontStyle.italic,
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: gradient[0]),
      ),
    );
  }
}

class ArtistTileAvatar extends StatelessWidget {
  final JazzArtist artist;
  final Color backgroundColor;

  const ArtistTileAvatar({
    super.key,
    required this.artist,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: artist.id,
      child: CircleAvatar(
        radius: 26,
        backgroundColor: backgroundColor,
        backgroundImage: artist.thumbUrl.isNotEmpty
            ? NetworkImage(webSafeImageUrl(artist.thumbUrl))
            : null,
        child: artist.thumbUrl.isEmpty
            ? const Icon(Icons.person, color: Colors.white)
            : null,
      ),
    );
  }
}
