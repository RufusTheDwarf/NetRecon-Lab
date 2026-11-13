# Commandes et vérifications

Toutes les commandes ci-dessous doivent viser **uniquement** `10.99.0.10` à `10.99.0.14`.

## Préparation

```bash
ip -br a
ip route
nmap --version
```

Noter l'interface Kali connectée au lab. Ne pas inférer que l'autre interface est nécessairement un accès Internet sans l'observer.

## Découverte d'hôtes

```bash
nmap -sn 10.99.0.10-14
```

`-sn` désactive le scan de ports. Sur le LAN, Nmap utilise souvent ARP pour découvrir les hôtes.
Comparer avec une approche sans découverte ARP (selon permissions/environnement) :

```bash
sudo nmap -sn -PE --disable-arp-ping 10.99.0.10-14
```

En cas d'absence de réponse, `-Pn` permet d'essayer le scan de ports **sans préalable de découverte** :

```bash
nmap -Pn -p 22,80,443 10.99.0.10
```

Une absence de réponse ne démontre pas à elle seule que l'hôte est éteint.

## TCP

```bash
nmap 10.99.0.10
nmap -p- 10.99.0.10
nmap -sV -p- 10.99.0.10
sudo nmap -O 10.99.0.10
```

Un scan TCP par défaut vérifie généralement les **1000 ports TCP les plus fréquents**, pas l'ensemble des 65535 ports.

- `open` : un service répond sur le port.
- `closed` : la machine est joignable, mais le port refuse la connexion.
- `filtered` : un filtrage réseau ou autre obstacle empêche Nmap de trancher.

La détection de version/OS est une estimation : identifier la confiance et les limites.

## Services inattendus et bannières

Après avoir identifié **un port ouvert sur une cible autorisée** :

```bash
nc 10.99.0.10 12345
curl -i --max-time 5 http://10.99.0.10:8080/
```

`12345` et `8080` sont **des exemples de syntaxe**, pas des ports observés.
Ne pas lancer de tests sur ces ports sans avoir d'abord déterminé la cible réelle.
Reporter uniquement ce qui a été observé. Ne pas inventer le code `LAB{...}`.

## UDP

```bash
sudo nmap -sU -p 53,67,137,161 10.99.0.10
```

À comparer sur les cinq serveurs autorisés.
`open|filtered` signifie que Nmap ne peut pas distinguer un service ouvert et un filtrage dans les conditions de ce scan.

## Export

```bash
nmap -sV -p- -oA results/nmap/scan-10.99.0.10 10.99.0.10
```

`-oA` crée notamment `.nmap`, `.xml` et `.gnmap` (ne pas modifier les preuves brutes).
Pour chaque constat du rapport, noter le chemin du fichier et la ligne ou le port associé.
