# Jazzodex

Application Flutter qui affiche une liste d'artistes de jazz (nom, photo, genre, ville, année de naissance/mort, biographie, chanson célèbre) en allant chercher les données sur l'API [TheAudioDB](https://www.theaudiodb.com/).

## Structure

- `lib/models/` : modèle `JazzArtist`
- `lib/pages/` : écran liste + écran détail
- `lib/widgets/` : tuile de liste, bannière et carte d'infos de l'écran détail

## Prérequis

- Flutter SDK installé ([guide d'installation](https://docs.flutter.dev/get-started/install))
- Une connexion internet (l'app appelle l'API TheAudioDB à chaque lancement)

## Lancer le projet

```bash
flutter pub get
flutter run
```

`flutter run` propose de choisir l'appareil cible (Windows, Chrome, Android...). Sur le web, certaines images peuvent être bloquées par CORS selon le navigateur — préférer Windows/Android si besoin.
