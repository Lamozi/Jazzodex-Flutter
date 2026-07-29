import 'package:flutter/material.dart';
import '../models/jazz_artist.dart';

class ArtistStatsCard extends StatelessWidget {
  final JazzArtist artist;
  final Color accentColor;
  final Future<String> futureFamousSong;

  const ArtistStatsCard({
    super.key,
    required this.artist,
    required this.accentColor,
    required this.futureFamousSong,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InfoRow(
                icon: Icons.piano,
                label: 'Genre',
                value: artist.genre,
                color: accentColor,
              ),
              const Divider(height: 1, indent: 20, endIndent: 20),
              InfoRow(
                icon: Icons.location_city,
                label: 'City',
                value: artist.city,
                color: accentColor,
              ),
              const Divider(height: 1, indent: 20, endIndent: 20),
              InfoRow(
                icon: Icons.cake,
                label: 'Born',
                value: artist.birthYear,
                color: accentColor,
              ),
              const Divider(height: 1, indent: 20, endIndent: 20),
              InfoRow(
                icon: Icons.event,
                label: 'Died',
                value: artist.deathYear == 'N/A' ? 'Alive' : artist.deathYear,
                color: accentColor,
              ),
              const Divider(height: 1, indent: 20, endIndent: 20),
              TextSection(title: 'Biography', text: artist.biography),
              FutureBuilder<String>(
                future: futureFamousSong,
                builder: (context, snapshot) {
                  final song = snapshot.data;
                  if (song == null || song.isEmpty || song == 'Unknown') {
                    return const SizedBox.shrink();
                  }
                  return TextSection(title: 'Famous song', text: song);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          SizedBox(
            width: 44,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontStyle: FontStyle.italic,
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  final String title;
  final String text;

  const TextSection({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'RobotoCondensed',
              fontStyle: FontStyle.italic,
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 14, height: 1.4),
          ),
        ],
      ),
    );
  }
}
