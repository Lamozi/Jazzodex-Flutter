import 'package:flutter/material.dart';
import '../models/jazz_artist.dart';
import 'artist_tile.dart';

class LoadingArtistsView extends StatelessWidget {
  final int loaded;
  final int total;

  const LoadingArtistsView({
    super.key,
    required this.loaded,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final progress = total > 0 ? loaded / total : 0.0;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                color: colorScheme.primary,
                backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading artists... $loaded / $total',
              style: TextStyle(color: colorScheme.primary, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class ArtistsErrorView extends StatelessWidget {
  final Object? error;
  final VoidCallback onRetry;

  const ArtistsErrorView({super.key, required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 56),
            const SizedBox(height: 16),
            Text(
              'Oops, something went wrong:\n$error',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArtistsListView extends StatelessWidget {
  final List<JazzArtist> artists;
  final void Function(JazzArtist artist) onArtistTap;

  const ArtistsListView({
    super.key,
    required this.artists,
    required this.onArtistTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: artists.length,
      itemBuilder: (context, index) {
        final artist = artists[index];
        return ArtistTile(
          artist: artist,
          onTap: () => onArtistTap(artist),
        );
      },
    );
  }
}
