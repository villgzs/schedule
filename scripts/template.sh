#!/bin/bash

# Ellenőrizzük, hogy megadták-e a célkönyvtárat paraméterként
if [ -z "$1" ]; then
    echo "Használat: $0 <célkönyvtár>"
    exit 1
fi

TARGET_DIR="$1"

# Meghatározzuk a szkript saját könyvtárát (függetlenül attól, honnan indítjuk)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_FILE="${SCRIPT_DIR}/template/timing.template.yml"

# Ellenőrizzük, hogy létezik-e a sablonfájl
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Hiba: A sablonfájl nem található itt: $TEMPLATE_FILE"
    exit 1
fi

# Célkönyvtár létrehozása, ha még nem létezik
mkdir -p "$TARGET_DIR"

# Ciklus 00-tól 23-ig (kétjegyű formátum)
for i in {00..23}; do
    OUTPUT_FILE="${TARGET_DIR}/timing.${i}.yml"
    
    # Az összes "-index-" előfordulás cseréje az aktuális kétjegyű számra
    sed "s/-index-/${i}/g" "$TEMPLATE_FILE" > "$OUTPUT_FILE"
done

echo "Kész! 24 fájl sikeresen legenerálva kétjegyű sorszámmal a következő mappába: $TARGET_DIR"
