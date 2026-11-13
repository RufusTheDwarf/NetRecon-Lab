# Module 184 // Audit réseau avec Nmap

Projet pédagogique : **reconstituer la documentation d'une succursale** à partir d'observations réseau sur Kali Linux.

> **Périmètre autorisé : `10.99.0.10` à `10.99.0.14` exclusivement.**
>
> Ne pas scanner le `/24` entier : à partir de `.100`, les machines appartiennent à d'autres élèves.
> Aucun brute force, aucune exploitation, aucune tentative d'accès non autorisé.
> Utiliser seulement Nmap, `ping`, `nc` et `curl` pour l'exercice.

## Objectifs

1. Identifier les machines actives, leurs adresses MAC et, si disponible, leurs fabricants.
2. Comparer scan TCP standard et scan TCP complet.
3. Identifier les services, leurs versions et les systèmes d'exploitation probables.
4. Vérifier certains résultats manuellement (`nc`, `curl`) et trouver le code `LAB{...}`.
5. Examiner les ports UDP 53, 67, 137 et 161.
6. Documenter les cinq serveurs, conserver les preuves et proposer **trois mesures de sécurité**.

**Les résultats ne sont pas préremplis** : ils doivent provenir de vos propres scans.

## Arborescence

```text
module184-nmap-lab/
├── README.md
├── .gitignore
├── .editorconfig
├── scripts/
│   └── scan-lab.sh          # Scans limités aux cinq IP autorisées
├── docs/
│   ├── commandes.md         # Aide-mémoire et vérifications manuelles
│   ├── reponses.md          # Parties 0 à 5 et réflexion
│   ├── inventaire.md        # Inventaire par machine
│   └── rapport.md           # Tableau + 3 constats sécurité
└── results/
    ├── nmap/                # Exports -oA générés par le script
    └── preuves/             # Éléments complémentaires (sans identifiants)
```

## Prérequis (Kali Linux)

```bash
command -v nmap
command -v git
command -v curl
command -v nc
ip -br a
```

Vérifier avant tout scan que Kali est connectée au réseau du laboratoire. Ne pas lancer l'exercice depuis le réseau domestique ou un autre environnement.

## Utilisation

```bash
chmod +x scripts/scan-lab.sh

# Visualiser les commandes SANS les exécuter
./scripts/scan-lab.sh discover --dry-run

# Découverte d'hôtes, sans scan de ports
./scripts/scan-lab.sh discover

# Scans individuels, un fichier par hôte
./scripts/scan-lab.sh default

# Comparaison avec tous les ports TCP
./scripts/scan-lab.sh full

# Versions de service, y compris sur ports TCP non standard
./scripts/scan-lab.sh versions

# Vérification ciblée d'un hôte qui ne répond pas à la découverte
./scripts/scan-lab.sh verify

# Détection OS (privilèges root / sudo)
./scripts/scan-lab.sh os

# UDP : 53, 67, 137 et 161 (privilèges root / sudo)
./scripts/scan-lab.sh udp
```

Chaque exécution crée des exports datés dans `results/nmap/` : `.nmap`, `.xml`, `.gnmap`.
Les scans complets, l'UDP et les ports filtrés peuvent prendre du temps.
Les modes `os` et `udp` déclenchent `sudo` si nécessaire.
Le script **n'accepte aucune cible fournie en argument** : son périmètre est fixe.

> `verify` utilise `-Pn`, qui désactive la découverte préalable ; cela **ne prouve pas** qu'un hôte fonctionne ou qu'un port est ouvert. Comparer avec les autres méthodes et consigner les incertitudes.

## Travail à compléter

- [ ] `docs/reponses.md` : préparation, parties 1–5 et réflexion.
- [ ] `docs/inventaire.md` : toutes les machines, services, versions et rôles probables.
- [ ] `docs/rapport.md` : tableau récapitulatif, **3 risques** appuyés par des preuves et mesures adaptées.
- [ ] `results/nmap/` : au minimum un export complet par machine.
- [ ] Code `LAB{...}` et méthode de découverte documentés.
- [ ] Relecture : commandes, date, contexte, hypothèses et interprétations.

**Confidentialité :** créer de préférence un dépôt GitHub **privé**. Vérifier tout export avant publication :
adresses MAC, bannières et autres informations sur l'infrastructure peuvent être sensibles.
Ne jamais committer de mots de passe, jetons, clés privées ou données personnelles.
Ne pas ajouter les supports de cours originaux sans autorisation de redistribution.

## Création du dépôt GitHub (avec GitHub CLI)

Depuis le dossier extrait, avec Git et [GitHub CLI](https://cli.github.com/) installés :

```bash
gh auth login
git init -b main
git add .
git commit -m "chore: initialize nmap lab documentation"
gh repo create module184-nmap-lab --private --source=. --remote=origin --push
```

Cette commande crée **un nouveau dépôt privé** et y publie le commit local. Si le dépôt existe déjà, il faut plutôt configurer son remote avec `git remote add origin`.

## Références

- Consignes fournies : *E-184-ALL-UtiliserNmap.md*.
- Cours : *S-184-Semaine_1.pdf* et *S-184-Semaine_2.pdf*.
- [Manuel officiel Nmap](https://nmap.org/book/man.html).

*Projet pédagogique // les observations et conclusions doivent être vérifiées dans le lab.*
