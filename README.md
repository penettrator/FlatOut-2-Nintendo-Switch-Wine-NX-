# FlatOut 2 — Nintendo Switch (Wine-NX)

**Автор:** [github.com/penettrator](https://github.com/penettrator)
**Поддержать автора:** [boosty.to/itgenius](https://boosty.to/itgenius) — донаты помогают выпускать новые порты.

[English version below](#english)

## Требования

- Установленный и настроенный **Wine-NX**:
  - **Build 5** — протестировано, игра работает как с **FEX**, так и с **Box64**;
  - **Test Build 4** — см. [отдельный раздел](#test-build-4).
- **FlatOut 2**, версия из GOG, установленная на компьютере с Windows.

## Установка

1. Скопируйте файлы `patch-flatout2.bat` и `patch-flatout2.ps1` из этого репозитория
   в папку с игрой из GOG **на компьютере** (не на SD-карту) — в ту папку, где лежит
   `FlatOut2.exe`.

2. Запустите `patch-flatout2.bat` двойным щелчком. Если игра установлена в
   `Program Files`, запустите его от имени администратора (правый клик →
   «Запуск от имени администратора»).

3. Дождитесь сообщения **«Готово»** и нажмите любую клавишу, чтобы закрыть окно.
   Скрипт пропатчит `FlatOut2.exe` (оригинал сохранится рядом как
   `FlatOut2.exe.original`) и скопирует из Windows библиотеку `d3dx9_30.dll`, без которой
   игра не запустится. Если скрипт попросит установить DirectX — установите
   [DirectX End-User Runtime](https://www.microsoft.com/en-us/download/details.aspx?id=8109)
   и запустите `patch-flatout2.bat` ещё раз.

4. Подключите SD-карту Switch к компьютеру и создайте на ней папку
   `switch/wine/drive_c/flatout2/`.

5. Скопируйте в эту папку всё содержимое папки с игрой — так, чтобы `FlatOut2.exe`
   лежал прямо в `switch/wine/drive_c/flatout2/`.

6. Скопируйте папку `switch` из этого репозитория в корень SD-карты. Если система
   спросит про совпадающие файлы — нажмите **«Заменить»**.

7. Вставьте карту в Switch, откройте лаунчер Wine-NX и запустите **FlatOut 2**.

## Test Build 4

Установка выполняется так же (шаги 1–7), но с двумя отличиями:

- Игре нужен **32-битный ярлык** (forwarder), который лаунчер устанавливает только на
  **emuMMC**. При первом запуске лаунчер предложит его сам («32-bit forwarder needed» →
  «Install now»). Его также можно создать заранее: **X** → Settings →
  «Make a 32-bit forwarder». Без ярлыка игра остаётся на чёрном экране.
- Первый запуск занимает больше времени: Wine-NX один раз настраивает компоненты Windows.

> [!NOTE]
> На Test Build 4 игра пока не проверялась.

---

## English

**Author:** [github.com/penettrator](https://github.com/penettrator)
**Support the author:** [boosty.to/itgenius](https://boosty.to/itgenius) — donations help release new ports.

### Requirements

- An installed and configured **Wine-NX**:
  - **Build 5** — tested, the game runs with both **FEX** and **Box64**;
  - **Test Build 4** — see the [separate section](#test-build-4-1).
- **FlatOut 2**, the GOG version, installed on a Windows PC.

### Installation

1. Copy `patch-flatout2.bat` and `patch-flatout2.ps1` from this repository into your GOG
   game folder **on your PC** (not on the SD card) — the folder where `FlatOut2.exe` is.

2. Double-click `patch-flatout2.bat`. If the game is installed in `Program Files`, run it
   as administrator (right-click → "Run as administrator").

3. Wait for the **"Done"** message and press any key to close the window. The script
   patches `FlatOut2.exe` (the original is kept next to it as `FlatOut2.exe.original`) and
   copies `d3dx9_30.dll`, which the game cannot start without, from Windows. If it asks
   you to install DirectX, install the
   [DirectX End-User Runtime](https://www.microsoft.com/en-us/download/details.aspx?id=8109)
   and run `patch-flatout2.bat` again.

4. Connect the Switch SD card to your PC and create the folder
   `switch/wine/drive_c/flatout2/` on it.

5. Copy everything from your game folder into that folder, so that `FlatOut2.exe` sits
   directly in `switch/wine/drive_c/flatout2/`.

6. Copy the `switch` folder from this repository to the root of the SD card. If asked
   about existing files, choose **Replace**.

7. Put the card back into the Switch, open the Wine-NX launcher and start **FlatOut 2**.

### Test Build 4

Installation is the same (steps 1–7), with two differences:

- The game needs a **32-bit forwarder**, which the launcher installs on **emuMMC** only.
  On the first launch the launcher offers it itself ("32-bit forwarder needed" →
  "Install now"). You can also create it beforehand: **X** → Settings →
  "Make a 32-bit forwarder". Without it the game stays on a black screen.
- The first launch takes longer: Wine-NX sets up its Windows components once.

> [!NOTE]
> The game has not been tested on Test Build 4 yet.
