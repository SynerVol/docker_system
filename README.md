# SynerVol Docker System

Ce dépôt contient l'architecture micro-services du projet **SynerVol**. Ces services sont conçus pour être exécutés dans des conteneurs Docker, permettant un développement fluide sur **Ubuntu** et un déploiement final sur cible embarquée via **Yocto** (Raspberry Pi 4).

---

## Aperçu des Services

Le système s'appuie sur 5 modules interconnectés :
* **vite-app** : Interface utilisateur (Frontend).
* **python-back** : Middleware de gestion et communication (Backend).
* **mavproxy** : Relais pour la télémétrie et le contrôle du drone.
* **ai-app** : Module de vision (YOLO) pour la détection en temps réel.
* **cloudflare-tunnel** : Permet l'accès sécurisé à l'interface du drone via internet.

---

## Installation sur Ubuntu 

Suivez ces étapes pour préparer votre machine hôte sous Ubuntu.

### 1. Mise à jour du système
Ouvrez un terminal et exécutez :
```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Installation de Docker et Docker Compose
Docker est l'outil qui permet de créer les "bulles" (conteneurs) pour chaque service.

```bash
sudo apt install docker.io docker-compose -y
```
Optionnel : Pour ne pas avoir à taper sudo à chaque commande Docker :

```bash
sudo usermod -aG docker $USER
```
(Il faudra fermer et réouvrir votre session utilisateur pour que cela fonctionne).

### 3. Configuration du jeton Cloudflare (.env)
Pour que le tunnel Cloudflare fonctionne, vous devez lui fournir votre clé secrète (Token) via un fichier caché nommé .env.

| Étape | Description |
|-------|-------------|
| 1. Accéder au tableau de bord Cloudflare | Log in to your Cloudflare Zero Trust Dashboard. |
| 2. Ouvrir la section Tunnels | Navigate to **Access → Tunnels**. |
| 3. Créer un tunnel | Click **Create a tunnel**, give it a name, and proceed. |
| 4. Choisir Docker comme connecteur | After creating the tunnel, select **Docker** as the environment. |
| 5. Récupérer la commande Docker | Cloudflare affichera une commande similaire à :<br>`docker run cloudflare/cloudflared:latest tunnel --no-autoupdate run --token <YOUR_TUNNEL_TOKEN>` |
| 6. Sauvegarder le token | The string after `--token` is your **Tunnel Token** — copy and save it securely. |

Créez le fichier à la racine du dossier :

```bash
touch .env
```
Ouvrez-le avec l'éditeur de texte (ex: Nano) :

```bash
nano .env
```
Copiez la ligne suivante et remplacez la valeur par votre jeton :

```Code snippet
TUNNEL_TOKEN=votre_token_secret_ici
```
Sauvegardez (Ctrl+O, puis Entrée) et quittez (Ctrl+X).

## Lancement du projet
Pour construire les images et démarrer tous les services en même temps, utilisez la commande suivante :

```bash
docker-compose up --build
```
Accès locaux :
Interface Web : http://localhost:5173

API Backend : http://localhost:8080

## Matériel et Périphériques
Le système est configuré pour interagir avec le matériel réel du drone :

USB/Série : Le backend cherche un adaptateur sur /dev/ttyUSB0.

Caméras : Le module IA scanne les ports vidéo de /dev/video0 à /dev/video31.

MAVLink : Le service MAVProxy utilise /dev/video_drone (ou /dev/ttyACM0).

[!IMPORTANT]
Si vous testez sans matériel branché, certains conteneurs (comme ai-app ou mavproxy) peuvent afficher des erreurs de type "File not found" ou redémarrer.

## Pipeline de déploiement (Yocto)
Conformément au schéma de production :

Les services sont buildés sur cette machine (x86_64) pour l'architecture cible (arm64).

Les images sont exportées en fichiers .tar.

Ces fichiers sont intégrés dans la recette Yocto meta-synervol.

L'OS final généré par Bitbake inclura Docker et lancera automatiquement ces services au démarrage de la Raspberry Pi.
