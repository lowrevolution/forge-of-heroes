# ⚔ Forge of Heroes

A complete **tabletop character generator** for two game systems — **fifth edition** (the d20 SRD) and **13th Age 2nd Edition** — in a single, self-contained HTML file. No build step, no dependencies, no internet required — just open `index.html` in any browser.

The first step asks which system the hero is for; everything after it, from ability scores to the printable sheet and the level-up walkthrough, is built for that system. Switching keeps the hero's name, appearance, personality and portrait, and each system keeps its own build so you can switch back.

**▶ [Play it here](https://lowrevolution.github.io/forge-of-heroes/)**

## Fifth edition

Supports characters from **level 1 to 20**, with experience thresholds, hit points, spell slots, subclasses, ability score improvements, and feats all tied to level.

### Contents

| | |
|---|---|
| Races | 19 (9 core + 10 expansion) |
| Classes | 22 (12 core + 10 expansion) |
| Subclasses | 3 per class |
| Spells | 139, cantrips through 9th level |
| Feats | 35 |
| Magic items | 40 |
| Backgrounds | 6 |

### The workflow

After choosing the system, eight steps, each with expanding drill-down detail for every choice:

1. **Abilities** — roll 4d6-drop-lowest and drag each die onto the ability you want it in (drop onto an occupied slot to swap), or switch to manual entry and type the scores in (point buy, standard array, table rolls, or a hero copied from paper)
2. **Race** — full trait text, racial ability bonuses, and sub-choices like draconic ancestry or celestial revelation
3. **Class** — features, proficiencies, skill picker enforcing class lists, and a level-aware spell picker covering every spell level you can cast
4. **Advancement** — level and XP (each drives the other), hit points by fixed average or rolled hit dice, subclass selection gated at the correct level, spell slots, and an ability-improvement-or-feat choice at every ASI level
5. **Background** — skills, tools, equipment, and roleplay features
6. **Equipment** — class gear choices, armor and shield with live AC, plus a magic item hoard with attunement tracking
7. **Details** — name, alignment, race-tuned physical description dropdowns with free-text options, personality, and a character art upload
8. **Character Sheet** — printable parchment sheet computing saves, all 18 skills, attack lines, spell DCs, and every feature gained across all levels, with a **Level Up** button that opens a guided walkthrough

## 13th Age 2nd Edition

Supports heroes from **level 1 to 10** across the adventurer, champion and epic tiers, with every number computed from the second-edition rules.

| | |
|---|---|
| Kin | 13, with 37 kin powers and their feats |
| Classes | 9 — barbarian, bard, cleric, fighter, paladin, ranger, rogue, sorcerer, wizard |
| Talents | 93, with their adventurer, champion and epic feats |
| Spells, powers & maneuvers | 156, each with its level-by-level effect |
| Feats | every talent, power, spell, kin and class feat, plus the universal feats |
| Icons | 12 (and the optional Orc Lord) |

### The workflow

1. **Abilities** — the two standard arrays, 28-point buy, roll 'em, roll four, or typed scores, then +2 to any two abilities (drag scores onto abilities, as in fifth edition)
2. **Kin** — kin power choice and sub-choices (magicker's cantrips or magic missile, half-elf concordance with its power history), and kin feats
3. **Class** — class choices (Strength or Dexterity melee, Armor or Vestments, Rush or Sneak Attack), class features with their feats, and the weapon table
4. **Advancement** — level 1–10; talents with tier gating, requirements and sub-choices (domains, animal companion, familiar abilities, Spell Fist, borrowed spells); spells, powers or maneuvers chosen by slot and cast at your level; ability bonuses at 4th, 7th and 10th; one feat per level, matched to tier slots (Resourceful and Prodigious Learner included); and optional incremental advances
5. **Unique Hero** — One Unique Thing, backgrounds with their point budget, and icon relationships with per-icon limits
6. **Gear** — armor and shield with live defenses, melee, off-hand and ranged weapons with attack lines, kit and coin, and true magic items with default bonuses and the attunement limit
7. **Details** — name, physical description tuned to the kin, portrait and personality
8. **Character Sheet** — AC/PD/MD from the middle of three modifiers, hit points and staggered value, recoveries and recovery roll, initiative, every attack at your level, talents, spells at their current-level effect, feats, backgrounds, icons, gear, and a **Level Up** button

The 13th Age level-up walkthrough covers the new level's gains, ability bonuses, a new talent at 5th and 8th, new spells or powers, the level's feat, a concordance kin power, and a before/after review. Cancel restores the hero exactly.

## Character files

**💾 Save Character File** writes the whole hero (scores, classes, every choice, gear, description and portrait) to one `.json` file; **📂 Load Character File** (on the Game System step and the Character Sheet) brings it back exactly, in whichever system it was made. Files are read in the browser and never uploaded. A short hand-written file also works for bringing in a hero from paper:

```json
{
  "name": "Brienne Ashford",
  "race": "Human",
  "class": "Fighter",
  "level": 5,
  "abilities": { "str": 15, "dex": 13, "con": 14, "int": 8, "wis": 12, "cha": 10 },
  "background": "Soldier",
  "alignment": "Lawful Good"
}
```

A hand-written 13th Age hero adds `"system": "13th Age"` and uses its own names:

```json
{
  "system": "13th Age",
  "name": "Larkyn Dryden",
  "kin": "Human",
  "kinPower": "Quick to Fight",
  "class": "Paladin",
  "level": 3,
  "abilities": { "str": 17, "con": 14, "dex": 12, "int": 10, "wis": 13, "cha": 15 },
  "plus2": ["str", "cha"],
  "talents": ["Bastion", "Bold", "Paladin's Challenge"],
  "feats": ["Smite (adventurer)", "Toughness"],
  "oneUniqueThing": "I hear the Cathedral's bells in my sleep.",
  "backgrounds": { "Concord city guard": 4, "Cathedral bell-ringer": 4 },
  "icons": { "Priestess": "positive 2", "Lich King": "negative 1" }
}
```

Names are matched forgivingly ("elf" finds "Elf (High)"), anything unknown is left out with a note saying what, and markup in text fields is stripped so a shared file cannot inject anything into the page.

## Leveling up

The **⬆ Level Up** button on the Character Sheet works in both systems. In fifth edition it walks through one level at a time: pick the class that gains it (or multiclass, prerequisites checked), take average hit points or roll the die, then only the choices that level brings — subclass, ability improvement or feat, multiclass skill, new spells — and a before/after review. Cancel puts the hero back exactly as they were. The 13th Age walkthrough is described above.

## Rules engine

Everything is computed rather than hardcoded. In fifth edition:

- **Proficiency bonus** scales 2 → 6 across levels
- **Spell slots** follow the full / half / third / pact-magic progressions
- **Prepared casters** recompute their count from ability modifier and level; wizard spellbooks grow two spells per level
- **Hit points** take the max hit die at level 1, then average or rolled per level, plus per-level racial and feat bonuses
- **Attacks** derive to-hit and damage from ability modifiers, proficiency, and fighting styles
- **Armor Class** handles armor, shields, unarmored defense variants, touch AC, and flat-footed AC
- **Ability scores** cap at 20 and combine rolls, racial bonuses, ASIs, and feat bonuses

In 13th Age:

- **Defenses** take the middle of three ability modifiers (AC: Con/Dex/Wis, PD: Str/Con/Dex, MD: Int/Wis/Cha) plus class base, armor, shield, level and item bonuses, with class and talent overrides (Blessing of Heaven, Mental Phenomenon, Heavy Iron)
- **Hit points** are (class base + Con) × the level multiplier, ×3 at 1st up to ×24 at 10th
- **Recoveries** count and roll follow class, melee choice, kin power and feats, with the modifier doubled at champion and quadrupled at epic tier, plus the epic bonus
- **Weapon attacks** roll ability + level against the class's weapon penalties, and deal one Weapon die per level plus the scaled modifier
- **Spells and powers** are cast at your level and show that level's effect; slots, required at-wills and borrowed spells are checked
- **Feats** are matched to tier slots by the level table, with bonus slots and prerequisites checked

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

Game content is drawn from openly licensed sources. Fifth-edition attribution:

> This work includes material taken from the System Reference Document 5.1 (“SRD 5.1”) and the System Reference Document 5.2 (“SRD 5.2”) by Wizards of the Coast LLC and available at https://www.dndbeyond.com/srd. The SRD 5.1 and SRD 5.2 are licensed under the [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/legalcode).

The 13th Age path uses game mechanics from *13th Age Second Edition* by Rob Heinsoo and Jonathan Tweet (Fire Opal Media, Inc.; published by Pelgrane Press), which are Open Game Content under the Open Game License v1.0a. The license text and copyright notices are in [NOTICE](NOTICE) and in the page footer. Every description of those mechanics is a summary written for this project.

Expansion classes, subclasses, and lineages outside the SRD documents are original implementations of widely used community archetypes, and all descriptive prose in this project was written for it rather than reproduced from any publisher's books. See [NOTICE](NOTICE) for the full attribution and scope.

Forge of Heroes is an independent fan tool. It is **not affiliated with, endorsed, sponsored, or approved by Wizards of the Coast LLC, Fire Opal Media, Inc., or Pelgrane Press Ltd**. 13th Age is a trademark of Fire Opal Media, Inc. All trademarks are the property of their respective owners.
