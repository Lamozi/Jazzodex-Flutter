import 'package:flutter/material.dart';
import '../models/jazz_artist.dart';
import 'artist_tile.dart' show webSafeImageUrl;

class ArtistHeaderBanner extends StatelessWidget {
  final JazzArtist artist;
  final List<Color> gradient;

  const ArtistHeaderBanner({
    super.key,
    required this.artist,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 36),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ArtistAvatarHero(artist: artist),
          const SizedBox(height: 16),
          ArtistNameTitle(name: artist.name),
        ],
      ),
    );
  }
}

class ArtistAvatarHero extends StatelessWidget {
  final JazzArtist artist;

  const ArtistAvatarHero({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: artist.id,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 85,
          backgroundColor: Colors.white24,
          backgroundImage: artist.thumbUrl.isNotEmpty
              ? NetworkImage(webSafeImageUrl(artist.thumbUrl))
              : null,
          child: artist.thumbUrl.isEmpty
              ? const Icon(Icons.person, size: 85, color: Colors.white)
              : null,
        ),
      ),
    );
  }
}

class ArtistNameTitle extends StatelessWidget {
  final String name;

  const ArtistNameTitle({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        name,
        style: const TextStyle(
          fontFamily: 'Adelphe',
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
