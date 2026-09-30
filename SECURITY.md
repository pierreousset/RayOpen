# Sécurité

RayOpen est un projet jeune. Les correctifs ciblent la dernière version du code sur `main`. Il n'y a actuellement ni version signée ni mécanisme de mise à jour automatique ; utilisez une source de confiance et examinez les changements avant de reconstruire l'application.

## Signaler une vulnérabilité

Merci de ne pas publier d'informations exploitables, de secrets ou de données personnelles dans une issue ou une pull request publique. Sur GitHub, utilisez **Security → Report a vulnerability** pour un signalement privé, lorsque cette fonction est disponible. Si elle ne l'est pas, ouvrez une issue demandant uniquement un canal privé, sans décrire la vulnérabilité.

Indiquez en privé la version ou le commit, les étapes de reproduction, l'impact et une proposition de correction si possible. Aucun délai de réponse garanti n'est annoncé.

## Périmètre et précautions

- RayOpen transmet le texte au serveur LM Studio ou Ollama configuré sur la boucle locale. Le serveur, le modèle, leurs journaux et leurs licences sont sous votre contrôle.
- Gardez ces serveurs accessibles uniquement depuis votre Mac. RayOpen ne prend pas en charge leur authentification.
- Les préférences sont conservées localement ; le presse-papiers macOS peut être lu par d'autres applications. La fermeture par ⌘ Espace peut y copier une traduction complète.
- Un modèle peut inventer du contenu ou suivre une instruction présente dans le texte. La consigne de traduction ne constitue pas une frontière de sécurité ; relisez les résultats.
- Les contributions doivent déclarer tout changement de réseau, permissions, stockage ou dépendances. Les pull requests et la revue réduisent les risques, sans garantir l'absence de vulnérabilité.

Les problèmes de qualité linguistique ordinaires peuvent être signalés publiquement avec un exemple non sensible. Les vulnérabilités de LM Studio, Ollama ou macOS doivent aussi être signalées à leurs mainteneurs respectifs.
