# ⚔ Forge of Heroes

A complete **fifth-edition-compatible tabletop character generator** in a single, self-contained HTML file. No build step, no dependencies, no internet required — just open `index.html` in any browser.

**▶ [Play it here](https://lowrevolution.github.io/forge-of-heroes/)**

Supports characters from **level 1 to 20**, with experience thresholds, hit points, spell slots, subclasses, ability score improvements, and feats all tied to level.

## Contents

| | |
|---|---|
| Races | 19 (9 core + 10 expansion) |
| Classes | 22 (12 core + 10 expansion) |
| Subclasses | 3 per class |
| Spells | 139, cantrips through 9th level |
| Feats | 35 |
| Magic items | 40 |
| Backgrounds | 6 |

## The workflow

Eight steps, each with expanding drill-down detail for every choice:

1. **Abilities** — roll 4d6-drop-lowest, then drag each die onto the ability you want it in (drop onto an occupied slot to swap)
2. **Race** — full trait text, racial ability bonuses, and sub-choices like draconic ancestry or celestial revelation
3. **Class** — features, proficiencies, skill picker enforcing class lists, and a level-aware spell picker covering every spell level you can cast
4. **Advancement** — level and XP (each drives the other), hit points by fixed average or rolled hit dice, subclass selection gated at the correct level, spell slots, and an ability-improvement-or-feat choice at every ASI level
5. **Background** — skills, tools, equipment, and roleplay features
6. **Equipment** — class gear choices, armor and shield with live AC, plus a magic item hoard with attunement tracking
7. **Details** — name, alignment, race-tuned physical description dropdowns with free-text options, personality, and a character art upload
8. **Character Sheet** — printable parchment sheet computing saves, all 18 skills, attack lines, spell DCs, and every feature gained across all levels

## Rules engine

Everything is computed rather than hardcoded:

- **Proficiency bonus** scales 2 → 6 across levels
- **Spell slots** follow the full / half / third / pact-magic progressions
- **Prepared casters** recompute their count from ability modifier and level; wizard spellbooks grow two spells per level
- **Hit points** take the max hit die at level 1, then average or rolled per level, plus per-level racial and feat bonuses
- **Attacks** derive to-hit and damage from ability modifiers, proficiency, and fighting styles
- **Armor Class** handles armor, shields, unarmored defense variants, touch AC, and flat-footed AC
- **Ability scores** cap at 20 and combine rolls, racial bonuses, ASIs, and feat bonuses

A floating dice tray rolls d4–d100 with modifiers, advantage/disadvantage, and roll history. Progress auto-saves to `localStorage`.

## Usage

```
open index.html
```

That's it.

## Privacy

There is no backend and no telemetry. The page makes **zero external requests** — no CDN, no fonts, no analytics — so it runs fully offline once loaded. Characters are saved to your browser's `localStorage` and never leave your machine; an uploaded portrait is stored as a data URI in that same local storage and is never sent anywhere.

## Licensing

The generator software is released under the [MIT License](LICENSE).

Game content is drawn from openly licensed sources. Required attribution:

> This work includes material taken from the System Reference Document 5.1 (“SRD 5.1”) and the System Reference Document 5.2 (“SRD 5.2”) by Wizards of the Coast LLC and available at https://www.dndbeyond.com/srd. The SRD 5.1 and SRD 5.2 are licensed under the [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/legalcode).

Expansion classes, subclasses, and lineages outside those documents are original implementations of widely used community archetypes, and all descriptive prose in this project was written for it rather than reproduced from any publisher's books. See [NOTICE](NOTICE) for the full attribution and scope.

Forge of Heroes is an independent fan tool. It is **not affiliated with, endorsed, sponsored, or approved by Wizards of the Coast LLC**. All trademarks are the property of their respective owners.
