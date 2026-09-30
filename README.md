# RayOpen

Premier MVP open source de lanceur macOS natif avec traduction par IA locale. Gratuit, sans abonnement ni API payante. SwiftUI/AppKit, sans dépendance externe. macOS 14+ et outils Swift 6 requis. Le modèle conserve sa propre licence ; LM Studio et Ollama sont des applications séparées.

## Compiler et ouvrir

Si Swift n'est pas installé : `xcode-select --install` (installation explicite à votre initiative).

```sh
./scripts/build-app.sh
open dist/RayOpen.app
```

Le script crée un bundle local non signé dans `dist/`. Il n'installe, ne distribue et ne modifie aucun réglage système. Pour développement : `swift run`.

RayOpen apparaît dans la barre de menus sous **◈**. **Commande + Espace (⌘ Espace)** ouvre ou masque son panneau. **Échap** le masque. Réglages propose aussi **Option + Espace**, **Contrôle + Option + Espace** et la désactivation ; un conflit d'enregistrement est signalé. Un raccourci déjà traité par une autre app peut néanmoins interférer : utilisez alors le menu. Les raccourcis système ne sont jamais remplacés.

### Libérer ⌘ Espace si Spotlight l’utilise

RayOpen ne modifie pas Spotlight. Dans **Réglages Système → Clavier → Raccourcis clavier → Spotlight**, désactivez **Afficher la recherche Spotlight** ou attribuez-lui une autre combinaison. Revenez dans RayOpen → Réglages et cliquez **Réessayer le raccourci**, ou relancez l’app. Vérifiez également les raccourcis de toute autre app lanceur. Le statut indique si macOS a accepté l’enregistrement ; cela ne prouve pas que la touche a été déclenchée. Les erreurs clavier restent affichées indépendamment des erreurs réseau. [Aide Apple sur les conflits de raccourcis](https://support.apple.com/fr-cf/guide/mac-help/mchlp2864/mac).

Au premier lancement de cette version, l’ancienne préférence **Option + Espace** migre une seule fois vers **Commande + Espace**. Les autres choix existants sont conservés ; vous pouvez ensuite sélectionner de nouveau Option + Espace.

Le panneau sombre sans barre de titre mesure 780 × 520 points. Dans Applications, recherchez une app, naviguez avec **↑ / ↓**, puis appuyez sur **Entrée** pour ouvrir la ligne sélectionnée, ou cliquez sur une ligne. La sélection défile automatiquement dans la liste. La recherche reprend le focus quand le panneau se rouvre. Recherchez **traduction**, **traduire** ou **translate** puis Entrée pour ouvrir la commande Traduction, avec le focus dans le texte source. Les onglets Traduire et Réglages restent accessibles au-dessus des résultats. Inventaire des dossiers `/Applications`, `/System/Applications` et `~/Applications` au démarrage. Relancez RayOpen après avoir installé une nouvelle app. Quittez depuis ◈.

## LM Studio déjà installé

1. Ouvrez LM Studio, sélectionnez un modèle de conversation déjà présent et chargez-le.
2. Dans l'onglet **Developer**, démarrez le serveur local (**Start Server**). Vérifiez l'adresse affichée, habituellement `http://localhost:1234`. Gardez l'écoute locale uniquement. Ce MVP ne gère pas les serveurs nécessitant un jeton d'authentification.
3. Dans RayOpen → Réglages, choisissez **LM Studio**, renseignez l'URL racine **sans `/v1`**, puis **Détecter les modèles**. Choisissez un modèle de conversation chargé.
4. Dans Traduire, saisissez ou collez du texte et choisissez la langue cible. La traduction démarre automatiquement après 500 ms de pause ; toute nouvelle saisie ou modification de langue annule immédiatement la requête précédente. Le texte source est à gauche et le résultat à droite. Le résultat arrive progressivement ; Copier place uniquement le résultat dans le presse-papiers. **Échap** revient au lanceur et annule la requête active sans copier. **⌘ Espace** ferme la traduction et copie automatiquement le résultat complet non vide ; pendant une génération, la requête est annulée sans remplacer le presse-papiers. Un résultat vide ne modifie pas le presse-papiers. Le prochain ⌘ Espace rouvre le lanceur. Un retour discret confirme la copie. Le serveur peut continuer brièvement son calcul après annulation cliente.

RayOpen ne télécharge ni modèle ni runtime. Aucun modèle présent ? Installez vous-même un modèle adapté à votre machine dans LM Studio avant usage. La vitesse dépend du matériel, du modèle, du chargement et de la longueur du texte : aucune latence n'est garantie. La durée affichée est celle de votre requête, chargement inclus. La traduction automatique doit être relue.

## Ollama facultatif

Si Ollama est déjà installé, démarrez son application ou `ollama serve`. Utilisez un modèle déjà installé (`ollama list`). Dans Réglages, choisissez **Ollama**, URL `http://localhost:11434`, puis Détecter les modèles. Aucun appel à Ollama Cloud n'est prévu ; utilisez un modèle local, sans suffixe cloud.

## Données et limites

Les textes restent en mémoire de RayOpen et sont envoyés au serveur sur votre Mac uniquement. Le serveur peut conserver des journaux selon ses propres réglages. L'URL accepte seulement `localhost`, `127.0.0.1` ou `::1`. Les préférences URL/modèle/langue/raccourci sont enregistrées dans UserDefaults, pas les textes. Coller est explicite ; Copier et la fermeture par ⌘ Espace en vue Traduction écrivent le résultat complet non vide dans le presse-papiers. Aucune permission Accessibilité nécessaire pour Carbon.

MVP : pas d'extensions Raycast, recherche fichiers, OCR, démarrage automatique, signature ou mise à jour automatique. Lanceur pilotable avec les flèches et Entrée, ou clic. Les modèles locaux peuvent produire des erreurs de traduction : relisez les résultats avant de les utiliser.

## API officielles

- [LM Studio : modèles](https://lmstudio.ai/docs/developer/openai-compat/models) : `GET /v1/models`.
- [LM Studio : chat](https://lmstudio.ai/docs/developer/openai-compat/chat-completions) : `POST /v1/chat/completions`, stream SSE.
- [Ollama : modèles](https://docs.ollama.com/api/tags) : `GET /api/tags`.
- [Ollama : chat](https://docs.ollama.com/api/chat) : `POST /api/chat`, stream JSON par ligne.

Licence du code : MIT, voir LICENSE.

La vue Traduction vérifie le serveur à chaque entrée et affiche son état avec **Réessayer**. LM Studio : `/api/v1/models` identifie les instances de conversation effectivement chargées ; repli `/api/v0/models` pour les versions plus anciennes. `/v1/models` seul ne permet pas de conclure qu’un modèle est chargé. Aucun modèle chargé, sélection absente ou serveur inaccessible bloque la traduction avec une indication en français. Chargez le modèle ou démarrez le serveur puis Réessayer ; la saisie reprend automatiquement après vérification. Ollama conserve son chargement local à la requête à partir des modèles installés. Pas de polling à chaque frappe. [API officielle LM Studio : état chargé](https://lmstudio.ai/docs/developer/rest/list).

Les nouvelles configurations privilégient `qwen2.5-1.5b-instruct`, la variante officielle Qwen Instruct. Le modèle enregistré est conservé : changer l’interface ou le prompt ne répare pas un modèle mal adapté. Une variante fine-tunée peut avoir un comportement différent du [Qwen2.5-1.5B-Instruct officiel](https://huggingface.co/Qwen/Qwen2.5-1.5B-Instruct) ; choisissez un modèle adapté à la traduction. Le choix et le chargement du modèle restent explicites. RayOpen envoie une consigne de traduction stricte, température 0, et une limite de génération proportionnelle au texte (64 à 4096 tokens). Les limites et ruptures de flux sont signalées ; seuls les résultats terminés peuvent être copiés automatiquement. Cela vérifie la fin technique de la réponse, pas la qualité linguistique.

### Espace traduction

Deux colonnes lisibles, langue cible accessible dans le menu « Vers », collage explicite, compteur de caractères et durée réelle. Une langue personnalisée peut être renseignée dans Réglages → Langue cible. Le bouton retour et Échap reviennent au lanceur. Le bouton engrenage ouvre les réglages. L’état du serveur reste visible ; si aucun modèle n’est chargé, un encart indique comment reprendre. Le résultat reste sélectionnable pendant le flux, mais Copier attend sa fin complète.

Pour le français, un exemple de question traduite accompagne la consigne afin d’aider le petit modèle à conserver qui parle et qui est interrogé. Cette amélioration est issue d’essais locaux ; des contresens restent possibles, notamment sur les pronoms et les temps. La source est délimitée par un encodage JSON qui préserve ses guillemets et retours à la ligne.

### Inverser les langues

Le menu **Source** permet de choisir **Automatique** ou une langue explicite, mémorisée entre les sessions. La double flèche **⇄** échange les langues source et cible. Si une traduction complète est disponible, elle devient le nouveau texte source ; le résultat précédent est effacé et une nouvelle traduction démarre automatiquement. Sans résultat complet, le texte saisi reste en place. Avec **Automatique**, choisissez d’abord une langue source : RayOpen ne devine pas une langue détectée que le modèle n’a pas fournie.
