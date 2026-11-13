#!/usr/bin/env bash
# Scans Nmap strictement limités aux cinq IP autorisées par l'exercice.
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ./scripts/scan-lab.sh {discover|default|full|versions|verify|os|udp} [--dry-run]

Modes:
  discover  Découverte d'hôtes, sans scan de ports
  default   Scan TCP par défaut, un fichier par serveur
  full      Tous les ports TCP, un fichier par serveur
  versions  Tous les ports TCP + détection des versions
  verify    -Pn avec ports TCP 22,80,443 (pas de découverte préalable)
  os        Détection OS (sudo nécessaire)
  udp       UDP sur 53,67,137,161 (sudo nécessaire)
EOF
}

if (( $# < 1 || $# > 2 )); then
  usage >&2
  exit 2
fi

mode="$1"
dry_run=false

if (( $# == 2 )); then
  if [[ "$2" != "--dry-run" ]]; then
    usage >&2
    exit 2
  fi
  dry_run=true
fi

case "$mode" in
  discover|default|full|versions|verify|os|udp) ;;
  *) usage >&2; exit 2 ;;
esac

# Liste codée en dur : aucune autre machine ne peut être ciblée via ce script.
readonly -a TARGETS=(
  10.99.0.10
  10.99.0.11
  10.99.0.12
  10.99.0.13
  10.99.0.14
)

PROJECT_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_DIR="${PROJECT_ROOT}/results/nmap"
STAMP="$(date +%Y%m%d-%H%M%S)"
NEED_SUDO=false
[[ "$mode" == "os" || "$mode" == "udp" ]] && NEED_SUDO=true

if [[ "$dry_run" == false ]]; then
  command -v nmap >/dev/null 2>&1 || { echo "Erreur : nmap est introuvable." >&2; exit 1; }
  if [[ "$NEED_SUDO" == true && "$(id -u)" -ne 0 ]]; then
    command -v sudo >/dev/null 2>&1 || { echo "Erreur : sudo est introuvable." >&2; exit 1; }
  fi
  mkdir -p -- "$OUTPUT_DIR"
fi

run_scan() {
  local basename="$1"
  shift
  local -a cmd=(nmap -n "$@" -oA "${OUTPUT_DIR}/${STAMP}-${mode}-${basename}")

  if [[ "$NEED_SUDO" == true && "$(id -u)" -ne 0 ]]; then
    cmd=(sudo "${cmd[@]}")
  fi

  printf 'Commande : '
  printf '%q ' "${cmd[@]}"
  printf '\n'

  if [[ "$dry_run" == false ]]; then
    "${cmd[@]}"
  fi
}

case "$mode" in
  discover)
    run_scan "hosts" -sn "${TARGETS[@]}"
    ;;
  default)
    for target in "${TARGETS[@]}"; do
      run_scan "${target##*.}" "$target"
    done
    ;;
  full)
    for target in "${TARGETS[@]}"; do
      run_scan "${target##*.}" -p- "$target"
    done
    ;;
  versions)
    for target in "${TARGETS[@]}"; do
      run_scan "${target##*.}" -sV -p- "$target"
    done
    ;;
  verify)
    for target in "${TARGETS[@]}"; do
      run_scan "${target##*.}" -Pn -p 22,80,443 "$target"
    done
    ;;
  os)
    for target in "${TARGETS[@]}"; do
      run_scan "${target##*.}" -O "$target"
    done
    ;;
  udp)
    for target in "${TARGETS[@]}"; do
      run_scan "${target##*.}" -sU -p 53,67,137,161 "$target"
    done
    ;;
esac

if [[ "$dry_run" == false ]]; then
  echo "Résultats enregistrés dans : $OUTPUT_DIR"
fi
