README
======

Popis
-----

Tento skript umožňuje vytvořit 3x3 mřížku z různých YouTube streamů pomocí `streamlink` a `ffmpeg`. Výstup je směrován přímo do `tvheadend` pomocí `pipe://`.

Požadavky
---------

*   `streamlink`
*   `ffmpeg`
*   `tvheadend`

Instalace
---------

1.  Ujistěte se, že máte nainstalované `streamlink` a `ffmpeg`.
2.  Uložte následující skript do souboru `/usr/local/bin/script.sh`:

    
    #!/bin/bash
    
    # Definujte zdrojové streamy
    SOURCE1="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=cMukxZRThvk"
    SOURCE2="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=another_video_id"
    SOURCE3="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=another_video_id"
    SOURCE4="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=another_video_id"
    SOURCE5="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=another_video_id"
    SOURCE6="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=another_video_id"
    SOURCE7="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=another_video_id"
    SOURCE8="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=another_video_id"
    SOURCE9="/usr/bin/env streamlink --stdout --default-stream best --url https://www.youtube.com/watch?v=another_video_id"
    
    # Vytvořte 3x3 mřížku a výstup na stdout
    /usr/bin/ffmpeg \
    -i <($SOURCE1) -i <($SOURCE2) -i <($SOURCE3) -i <($SOURCE4) -i <($SOURCE5) -i <($SOURCE6) -i <($SOURCE7) -i <($SOURCE8) -i <($SOURCE9) \
    -filter_complex \
    "[0:v]scale=320:240[tile1]; [1:v]scale=320:240[tile2]; [2:v]scale=320:240[tile3]; \
     [3:v]scale=320:240[tile4]; [4:v]scale=320:240[tile5]; [5:v]scale=320:240[tile6]; \
     [6:v]scale=320:240[tile7]; [7:v]scale=320:240[tile8]; [8:v]scale=320:240[tile9]; \
     [tile1][tile2][tile3]hstack=3[top]; \
     [tile4][tile5][tile6]hstack=3[middle]; \
     [tile7][tile8][tile9]hstack=3[bottom]; \
     [top][middle][bottom]vstack=3[out]" \
    -map "[out]" -c:v libx264 -f mpegts pipe:1
        

3.  Udělejte skript spustitelným:

    chmod +x /usr/local/bin/script.sh

Konfigurace tvheadend
---------------------

1.  Otevřete `tvheadend` a přidejte novou síť typu IPTV Network
2.  Nastavení následující : Povoleno (ano) Název síťě (Youtube) Vytvořit buket (ano) Název s´tě poskytovatele (Youtube) Ignorovat čísla programů od poskytovatele (ano) Znaková sada (UTF-8) Skenovat po vytvoření (ne) Skip startup scan (ano) ID služby (2)
3.  Přejdeme na záložky Muxy a vytvoříme Mux
4.  Nastavení následující : EPG (Zakázat) URL : (pipe:///usr/local/bin/script.sh) Jméno Muxu (Libovolné jméno) číslo programu (Takové jako ještě nepoužíváte) Název služby (Libovolné jméno) Znaková sada (UTF-8) Accept zero value for TSID:(ano). Volitelné URL ikony a štítky programů
5.  Přejdeme do Program/Bukety zaškrkneme youtube a dáme Ulož
6.  Nyní se nám namapují muxy na konkrétní programy a jsou k dispozici v přehrávání pod danným číslem kanálů

Použití
-------

Po konfiguraci `tvheadend` bude skript automaticky spouštěn a výstup bude směrován do `tvheadend` jako 3x3 mřížka různých YouTube streamů.
