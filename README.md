# ⚔ Forge of Heroes

A complete **Dungeons & Dragons 5th Edition character generator** in a single, self-contained HTML file. No build step, no dependencies, no internet required — just open `index.html` in any browser.

Built on the **SRD 5.1** rules and data.

## Features

**Seven-step creation workflow** with expanding drill-down details for every choice:

1. **Abilities** — roll 4d6-drop-lowest, Standard Array, or 27-point Point Buy (with correct cost table and budget enforcement); live modifiers and racial bonuses
2. **Race** — all 9 SRD races with full trait text, Dragonborn ancestry selection, Half-Elf flexible ability bonuses and Skill Versatility
3. **Class** — all 12 classes with level-1 features, saves, and proficiencies; Fighter fighting styles; Ranger favored enemy/terrain; skill pickers that enforce class lists and lock already-granted skills
4. **Background** — six backgrounds with skills, tools, equipment, and roleplay features
5. **Equipment** — class equipment choices with weapon details, plus armor/shield selection with live Armor Class calculation (including Unarmored Defense variants)
6. **Details** — name (with race-flavored suggestions), alignment grid, personality/ideals/bonds/flaws
7. **Character Sheet** — printable parchment-styled sheet computing saves, all 18 skills, initiative, passive perception, spell save DC, HP, and AC — with a completeness checklist, Print, and Download-JSON

**Spellcasting** — 59 SRD spells with descriptions; correct cantrip/spell counts per class, prepared-caster counts computed from your actual ability modifier, and Life Domain auto-prepared spells.

**Virtual dice tray** — floating d20 button opens a roller for d4–d100 with count, modifier, advantage/disadvantage, natural 20/1 callouts, and roll history.

Progress auto-saves to `localStorage`, so a refresh never loses your hero.

## Usage

```
open index.html
```

That's it.

## License note

Game content is drawn from the [Systems Reference Document 5.1](https://dnd.wizards.com/resources/systems-reference-document), used under the Creative Commons Attribution 4.0 International License (CC-BY-4.0).
