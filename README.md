# Dokumentation
Die Seite kann unter [barrakuda.de/admin](https://barrakuda.de/admin) inhaltlich geändert werden.
Dazu ist ein Github-Account mit den entsprechenden Berechtigungen nötig.

**Bilder dürfen <ins>nicht</ins> auf Github hochgeladen werden (siehe "[Bilder hochladen](#Bilder-hochladen)")**


# Bilder hochladen
Bilder für die Webseite können auf der [Nextcloud](https://cloud.barrakuda.de) im Ordner `WebBilder` abgelegt werden (dazu sind entsprechende Berechtigungen nötig).
Diese Bilder werden dann über [`sync_images`-Action](https://github.com/stamm-barrakuda/barrakuda-de/actions/workflows/sync-images.yml) synchronisiert.
Diese läuft automatisch bei jeder Änderung und kann zusätzlich manuell gestartet werden (`Run workflow`).
Die Bilder sind dann unter `/images` verfügbar und können im Admin-Interface über die Schaltflächen "Von URL hinzufügen" verwendet werden (z.B. `/images/Lilie.png`).

Bilder, die für die Webseite hochgeladen werden sollten eine moderate Auflösung haben (z.B. 1920x1080) und entsprechend komprimiert sein.


# Lokal laufen lassen
Die Webseite kann mit [Nix](https://nixos.org/download/) lokal gebaut und deployed werden:
```sh
# Webseite bauen - liegt hinterher in ./result
nix build .?submodules=1#default

# Webseite auf den Server deployen
nix run .\#login-web      # Nur beim ersten Mal
nix run .?submodules=1#deploy

# Bilder aus der Cloud synchronisieren
nix run .\#login-web      # Nur beim ersten Mal
nix run .\#login-cloud    # Nur beim ersten Mal
nix run .\#imgsync
```

Hier zu müssen "Flakes" unter Nix enabled sein: https://nixos.wiki/wiki/flakes#Other_Distros.2C_without_Home-Manager


