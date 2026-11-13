# Réponses à l'exercice Nmap

**Date :** À compléter  
**Machine Kali / interface lab :** À compléter  
**Version Nmap :** À compléter

> Pour toute affirmation factuelle, noter la commande, l'IP, la date et le fichier de preuve.

## Partie 0 — Préparation

1. Adresse IP et interface de Kali : À compléter.
2. Différence avec l'autre interface : À compléter.

## Partie 1 — Découverte

1. Option de découverte sans scan de ports : À compléter.
2. Nombre de machines actives et adresses : À compléter.
3. Hôte ne répondant pas à la découverte : deux méthodes, comparaison : À compléter.
4. MAC, fabricant et déduction sur les machines : À compléter.

**Preuve(s) :** `results/nmap/...`

## Partie 2 — Ports TCP

1. Ports ouverts de chacune des cinq machines : À compléter (`docs/inventaire.md`).
2. Ports vérifiés par défaut, méthode de scan complet, différences : À compléter.
3. Explication `open` / `closed` / `filtered` : À compléter.
4. Hôte au comportement différent et hypothèse justifiée : À compléter.

**Preuve(s) :** `results/nmap/...`

## Partie 3 — Services et OS

1. Logiciels/versions observés : À compléter (`docs/inventaire.md`).
2. Nom de service deviné différent de la détection réelle : À compléter.
3. Service sur port non standard, utilité et limite de sécurité : À compléter.
4. Résultats de `curl` pour les ports web observés : À compléter.
5. Détection OS et niveau de confiance : À compléter.

**Preuve(s) :** `results/nmap/...`

## Partie 4 — Enquête complémentaire

1. Service non identifié : IP, port, protocole : À compléter.
2. Méthode de vérification (commande `nc` ou `curl`) : À compléter.
3. Code `LAB{...}` réellement observé et preuve : À compléter.
4. Service d'accès anonyme aux fichiers, risque et observation **sans authentification** : À compléter.

**Preuve(s) :** `results/nmap/...` / `results/preuves/...`

## Partie 5 — UDP

1. Commande et périmètre de scan UDP : À compléter.
2. Pourquoi l'UDP est moins concluant ; interprétation de `open|filtered` : À compléter.
3. Services UDP identifiés sur les cinq machines : À compléter.

**Preuve(s) :** `results/nmap/...`

## Partie 6.4 — Réflexion

1. Visibilité du scan dans les journaux d'un administrateur : À compléter.
2. Autorisations et périmètre nécessaires en entreprise : À compléter.
3. Ce qui m'a surpris : À compléter.
