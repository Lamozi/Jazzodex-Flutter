class JazzArtist {
  final String id;
  final String name;
  final String genre;
  final String city;
  final String birthYear;
  final String deathYear;
  final String biography;
  final String thumbUrl;

  JazzArtist({
    required this.id,
    required this.name,
    required this.genre,
    required this.city,
    required this.birthYear,
    required this.deathYear,
    required this.biography,
    required this.thumbUrl,
  });

  factory JazzArtist.fromJson(Map<String, dynamic> json) {
    return JazzArtist(
      id: json['idArtist']?.toString() ?? 'Unknown',
      name: json['strArtist']?.toString() ?? 'Unknown',
      genre: json['strGenre']?.toString() ?? 'Jazz',
      city: json['strCountry']?.toString() ?? 'N/A',
      birthYear: json['intBornYear']?.toString() ?? 'N/A',
      deathYear: json['intDiedYear']?.toString() ?? 'N/A',
      biography: json['strBiography']?.toString() ?? 'Biography not available',
      thumbUrl: json['strArtistThumb']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idArtist': id,
      'strArtist': name,
      'strGenre': genre,
      'strCountry': city,
      'intBornYear': birthYear,
      'intDiedYear': deathYear,
      'strBiography': biography,
      'strArtistThumb': thumbUrl,
    };
  }
}
