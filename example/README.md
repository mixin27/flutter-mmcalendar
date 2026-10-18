# flutter_mmcalendar gallery

Every flutter_mmcalendar 4.0 widget in one app.

The gallery has five sections:

- **Calendar:** the month calendar with its five cell styles, today's card
  and the week strip. Wide windows add a sidebar with a mini month and the
  coming holidays, and an inspector with the day's details.
- **Views:** the year, the Myanmar month by fortnight with its quarter
  moons, and the agenda.
- **Pickers:** the date, Myanmar wheel, range and multi-date pickers, the
  inline picker and the form field.
- **Day:** today's card, the moon countdown, holidays, astrology and the
  Nagahle compass.
- **Tools:** the converter, date arithmetic, AI prompts and chronicles.

The settings button (top right) switches style (Automatic, Material,
Cupertino, Glass), theme, language, platform, week start and colour.

## Run

```bash
flutter run
```

## Screenshots

The gallery can start on a given section and settings, which is how the
package's screenshots are taken:

```bash
flutter run --dart-define=GALLERY_SECTION=1 --dart-define=GALLERY_STYLE=glass --dart-define=GALLERY_THEME=light --dart-define=GALLERY_LANGUAGE=my
```

`GALLERY_SECTION` counts from 0 (Calendar). `GALLERY_STYLE` is `material`,
`cupertino` or `glass`. `GALLERY_THEME` is `light` or `dark`.
`GALLERY_LANGUAGE` is a language code such as `my` or `shn`.
