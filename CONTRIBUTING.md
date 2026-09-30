# Contribuer à RayOpen

RayOpen est ouvert à toutes et tous : corrections, traduction, accessibilité, documentation ou nouvelles idées. La licence MIT permet d'utiliser, modifier et redistribuer le code, en conservant la notice de licence. Les modèles et outils tiers gardent leurs propres licences.

## Proposer une amélioration

1. Pour un changement important, ouvrez une issue afin de discuter du besoin. Ne publiez pas de vulnérabilité dans une issue publique : consultez [SECURITY.md](SECURITY.md).
2. Créez un fork, puis une branche dédiée depuis `main`.
3. Faites une modification ciblée, sans secrets, données personnelles, textes de traduction privés ni fichiers générés.
4. Compilez avec `./scripts/build-app.sh`. Exécutez `swift test` et vérifiez manuellement les interactions concernées sur macOS.
5. Ouvrez une pull request vers `main` avec un résumé et les contrôles réellement effectués.

Les changements passent par une pull request et la revue du mainteneur. Les pushes directs vers `main` ne font pas partie du processus de contribution. Une fusion dans `main` ne déclenche pas, à elle seule, une publication automatique aux utilisateurs.

## Points de vigilance

Préservez le fonctionnement local et gratuit, la restriction des serveurs à la boucle locale, l'annulation des requêtes et les préférences existantes. Signalez tout nouveau accès réseau, permission macOS, stockage de texte ou changement du presse-papiers. Documentez les limites plutôt que de promettre une traduction fiable ou instantanée.

En soumettant une contribution, vous acceptez sa distribution sous la licence MIT du projet. Merci de rester respectueux et de faciliter la revue avec de petites PR.
