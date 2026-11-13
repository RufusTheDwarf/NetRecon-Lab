# Inventaire réseau — succursale

Périmètre examiné : `10.99.0.10` à `10.99.0.14` (les autres adresses sont hors scope).

Pour chaque machine, distinguer les **observations** des **hypothèses**.

| Adresse IP | Répond à -sn ? | MAC | Fabricant MAC | OS estimé (confiance) | Rôle probable | Preuve |
|---|---|---|---|---|---|---|
| 10.99.0.10 | À relever | À relever | À relever | À relever | À déterminer | `results/nmap/...` |
| 10.99.0.11 | À relever | À relever | À relever | À relever | À déterminer | `results/nmap/...` |
| 10.99.0.12 | À relever | À relever | À relever | À relever | À déterminer | `results/nmap/...` |
| 10.99.0.13 | À relever | À relever | À relever | À relever | À déterminer | `results/nmap/...` |
| 10.99.0.14 | À relever | À relever | À relever | À relever | À déterminer | `results/nmap/...` |

## Services observés

Créer **une ligne par port observé** (TCP et UDP) et relever les versions lorsque Nmap peut les identifier.

| IP | Port | Protocole | État Nmap | Service observé | Logiciel / version | Commentaire / preuve |
|---|---|---|---|---|---|---|
| À relever | À relever | TCP/UDP | À relever | À relever | À relever | `results/nmap/...` |

## Écarts ou incertitudes

- [ ] Port non standard : hypothèse / vérification.
- [ ] Port `filtered` ou UDP `open|filtered` : ne pas conclure qu'il est ouvert.
- [ ] Bannières ou systèmes d'exploitation non fiables : limite / preuve.
- [ ] Différences entre scan standard et scan complet : documentées.
