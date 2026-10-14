# mod-coa-challenges

AzerothCore (WotLK) module that reimplements the Conquest of Azeroth
**challenges/trials** system server-side: the client's `C_Challenge` UI is
driven entirely by data already present in the game client patch, while this
module supplies the **authority** (activation gates, auras, lives, rules,
objectives, completions, rewards and the Gamemodes state).

> Status: functional and validated live for activation, death/fail, auras,
> lives, shared fate, hunger/fatigue, rules, activation conditions, criteria
> banners, leaderboard, trial creator and reward delivery. See *Scope* below.

## Requirements

- AzerothCore WotLK, branch `coa-challenge-defs` (or `main`) of the CoA fork.
- **Companion core opcode entries** in `src/server/game/Server/Protocol/Opcodes.h`
  (the "CoA extension range" block) — the module uses custom opcodes.
- The **CoA server component** (opcode pass-through).
- The game client patch that ships the `Challenge*.dbc` files and the challenges
  UI addon (definitions + UI live there, not here).
- For achievements: the client `Achievement.dbc` installed in the server
  `Data/dbc` (custom achievement ids exceed the stock range;
  `Achievement_Criteria.dbc` / `Achievement_Category.dbc` stay stock). Because
  the ids exceed `uint16`, the core `AchievementMgr::LoadFromDB` must read
  `character_achievement.achievement` as `uint32` (the module widens the column;
  see the CoA fork), otherwise completions are dropped on relog.

## Layout

```
mod-coa-challenges.cmake          registers helper headers + unit tests
conf/
  mod-coa-challenges.conf.dist    tunables (see "Configuration")
data/sql/
  db-characters/                  character-side schema (versioned)
  db-world/                       challenge definitions schema (versioned)
src/
  CoA.Challenges.*.cpp / Review.h     implementation, split by area
  CoAChallengeParse.h                 pure parsing/matching (host-testable)
  CoAChallengeInternal.h              GM/test-only declarations
  CoAChallengeTests.cpp               in-game e2e/GM harness
tests/
  CoAChallengeParseTest.cpp           host unit tests (core `unit_tests`)
```

## Installation

1. Place the module at `modules/mod-coa-challenges`.
2. Apply the companion core opcode block (see *Requirements*).
3. Reconfigure and build AzerothCore.
4. Copy/keep `conf/*.conf.dist` as `.conf` and tune as needed.

The character and world tables are created by the versioned SQL under `data/sql/`
(applied automatically by the AzerothCore DB updater). On a dev box without the
updater, set `CoAChallenges.AutoCreateSchema = 1` to create them at runtime.

## Data flow

- **Definitions** (rules, conditions, objectives, auras, lives, rewards) originate
  from an **export of the game client** and are imported into the **world
  database** (`coa_challenge_definition`, `coa_challenge_spell`,
  `coa_challenge_reward`) via the generated SQL
  (`coa-analyze-export.ps1 -EmitSql`). The world DB is the single source of
  truth; the module reads it into a memory cache at startup and on
  `.coa challenges reload`.
- **Rewards** are delivered **by mail** on completion. The client only *displays*
  the reward definition; it never sends a "claim". See the Rewards notes in
  `conf/mod-coa-challenges.conf.dist`.
- The **Challenges Store** tab (Trial Masters / Build Masters) is a separate,
  100% server-side Custom Store system and is **out of scope** for this module.

## Configuration

All options are documented inline in `conf/mod-coa-challenges.conf.dist`,
grouped by area: UI tabs, game modes, lifecycle, rewards, announcements/client
state, grouping, hunger/thirst, fatigue, professions and testing.

Any key omitted from a customized `.conf` falls back to the code default; new
keys are appended automatically on deploy.

## GM / admin commands

```
.coa <trial|challenge> <unlock|check> <id> [player]
.coa e2e <player> <id> [intervalMs]
.coa reward <id> [level] [player]
.coa challenges reload
.coa reset [all] <player>
```

## Scope / limitations

- GroupRewards (`ChallengeGroupRewards.dbc`) — semantics not confirmed.
- Custom Store (Trial Masters tab) — separate system, not implemented here.
- Some rules/objectives/conditions are still being mapped; the module applies
  the subset described in `conf/mod-coa-challenges.conf.dist`.

## HXC Old School trials

### Basic quest equipment and profession materials

Old School quest previews, reward selection, inventory-space checks and grants share the
native per-player reward resolver. Its Old School wrapper replaces ordinary magical
equipment rewards with an unrestricted common item of the same equipment family/slot
and no greater item level, usable at the authored reward/quest minimum level. Robes and
chests share a slot; one-handed weapons retain their weapon family. When no suitable
basic item exists, the slot offers a tier-appropriate cloth, leather, ore, gem or enchanting
dust component. Native reward quantities, coin, XP, materials, recipes and learned spells
remain. Harvested camp logs are not granted through this replacement path.

Quest source/required/drop items, quest-bound objects and equipment needed for a
profession, spell or scripted function are protected. The startup cache is built from
loaded native item and quest data. Old School rewards keep authored item budgets;
other modes delegate to the existing reward resolver, including its scaling behavior.
Named and crafted equipment remains the main source of ordinary stat-bearing upgrades.

### Authored Mulgore roaming encounters

Old School participants and their playerbot companions gain an additional encounter phase,
preserving their ordinary quest phases. Trial exit removes that phase; native phase changes
retain it while the trial is active. The three new Mulgore spawns exist only in that phase.
They reuse local creature models and existing native waypoint routes without changing the
original creatures, routes, aggro ranges or assistance rules.

- Ashmane Matriarch: fixed rating 14, rare prowler, The Rake's route, Ashmane Hide Vest.
- Sablewind: fixed rating 18, rare spirit wolf, Ghost Howl's route and howl, Sablewind Mantle.
- Gravetusk: fixed rating 22, elite elder kodo, Arra'chea's route, Gravetusk Band.

Each has a 30-minute respawn and a 25% roll for its specific reward. Rewards preserve
existing item budgets: Fine Leather Tunic, Mystic Shawl and Ring of Iron Will respectively,
with new names and bind-on-equip trading. The vest has the same budget as its craftable
alternative. Existing skinning rewards remain. Named XP multipliers are 1.5x, 2x and 2x,
applied alongside the existing con, rank, challenge pace and party rules. These are initial
authored encounters; gameplay pacing and route behavior remain unverified until Phase 1
testing resumes. Other regions currently have native camp and named profiles, with new
trial-only roaming content still to be authored one zone at a time.

### Authored Barrens roaming encounters

- Cacklemaw: fixed rating 24, rare hyena, Snort's route and toxic spit, Cacklemaw Shroud.
- Sablemane: fixed rating 28, rare lion, a staggered start on Snort's route and Humar's
  native combat ability, Sablemane Hide Harness.
- Thunderhide: fixed rating 34, elite elder kodo, Lakota'mani's route, Thunderhide Signet.

These use the same trial-only phase, 30-minute respawn and 25% specific equipment roll.
Their item budgets match Silver-thread Cloak, craftable Raptor Hide Harness and Ring of
Silver Might. Their named XP multipliers are 1.5x, 2x and 2x before existing pace/con/rank
rules. Both regions' new roamers start at different existing waypoint nodes to avoid
stacking with their native counterparts at the initial spawn point. Native creatures,
path geometry and respawn timers remain intact.

### Authored Tirisfal roaming encounters

- Morrowbone the Cold: fixed rating 14, rare bonecaster, a Rot Hide graveyard path and
  frostbolt, Morrowbone Wand with the craftable Greater Magic Wand budget.
- The Bellwether: fixed rating 18, rare undead road patrol, a Scarlet patrol's existing
  route and Rotting Ancestor's combat ability, Bellwether Burial Cape with the craftable
  Black Whelp Cloak budget.
- Veilwalker: fixed rating 22, elite shade, Fellicent's existing path and combat spells,
  Veilwalker Band with the Heart Ring budget.

Each follows the trial-only phase, 30-minute respawn and 25% specific reward rules.
Starts use distinct native waypoint nodes. New templates retain combat abilities while
excluding the native undead quest-credit and quest-despawn SmartAI rows. Fixed models
give the new named creatures consistent appearances. Native quest creatures remain intact.

### Authored Silverpine roaming encounters

- Moonfang the Pale: fixed rating 22, rare wolf, Gorefang's route and bleed,
  Moonfang Mantle with the craftable Hillman's Shoulders budget.
- Blackbough Widow: fixed rating 28, elite spider, Krethis's route and combat spells,
  Blackbough Silk Cape with the Emblazoned Cloak budget.
- Caldris the Exile: fixed rating 34, rare frost caster, a Dalaran Wizard's existing patrol,
  frost armor, frostbolt, frost nova and ward; Caldris Frostwood Wand with the craftable
  Lesser Mystic Wand budget. The new exile is hostile to both factions.

These use the same encounter phase, staggered path starts, 30-minute respawns and 25%
specific reward rolls. Native Silverpine creatures and their faction relationships remain intact.

Old School (9001) and Old School - Hardcore (9002) are mutually exclusive native trials.
Creature levels display as `??` while a trial is active. Every persistent ordinary creature uses its
template's maximum level as a fixed encounter level; temporary creatures use their assigned level.
Ordinary camp-role and per-entry threat offsets do not change that level. Zone pockets should be
authored as level bands through their creature templates, so the same creature entry has the same con
throughout the pocket. Explicit named-threat offsets and elite/boss rank modifiers remain exceptions.
Con colors compare this fixed level with the player's level: gray at -7 or lower, green at -5/-6,
light blue at -3/-4, dark blue at -1/-2, white at equal level, yellow at +1/+2, gold at +3/+4,
orange at +5/+6, and red at +7 or higher. Con color, neutral/hostile disposition, and combat rank
are separate signals. Native creature levels remain unchanged. Combat uses the creature base health,
armor and weapon-damage budget at its fixed encounter level, normalized against its native template
level. Ordinary health starts at 600% of that fixed base and ordinary damage at 1x; elite and boss
rank modifiers still apply. The values are tunable through `OrdinaryHealthPercent` and
`OrdinaryDamageMultiplier`. Old School applies a configurable 100% XP pace. Kill XP follows the
creature's fixed level and named-encounter reward, then group and rested-camp bonuses; con color does
not add a second arbitrary XP multiplier. Quest turn-ins award three times the challenge-scaled quest
XP; other non-creature XP remains at the configured pace. The pace is configured in basis points
(10000 = 100%), and fractional XP carries between awards. Critters and player-owned units are excluded.
Restricted tapping prevents players in another trial from assisting with the kill or claiming
its rewards.

Across all zones in either Old School trial, poor/common basic armor and weapons
retain their native drop probabilities. Ordinary random uncommon-or-better equipment
retains 1% of already-rolled drops. Authored named encounters and native dungeon/world
bosses retain their native equipment rolls at the default 100% keep setting, so targeted
camp rewards are no longer discarded by an additional 95% suppression roll. Their native
loot chances and rare spawn timers still govern availability. Quest items and crafting
materials remain, and crafted gear is unaffected. Native item scaling is blocked during
the trial, so gear does not automatically grow with the player's level. Profession
skill-ups grant character XP; crafted-item rarity now participates in that XP path.
Native profession recipes, trainers and material tiers form the dependable crafting path;
bespoke recipe/item-stat changes are not included in this pass.

Mulgore's named threats - Ghost Howl (3056), Arra'chea (3058), Mazzranache (3068), Sister Hatelash (5785),
Snagglespear (5786), Enforcer Emilgund (5787), and The Rake (5807) - and the Barrens threats Gesharahan
(3398), Lakota'mani (3474), Humar the Pridelord (5828), Snort
the Heckler (5829), Swiftmane (5831), Azzere the Skyblade (5834), Heggin Stonewhisker (5847), and Dishu
(5865) carry four additional hidden threat levels in Old School. Their authored danger affects con, combat
and named kill rewards without changing native levels or ordinary-mode behavior. Ghost
Howl, Arra'chea, and The Rake use their existing authored roam paths; an isolated gameplay scenario verifies
that each moves at least eight yards from its database spawn while the Old School phase is active. Their rare
spawn timers remain intact; their rolled equipment drops follow the Old School named-threat keep chance.

Camp rosters remain authored world-content metadata, but ordinary camp roles no longer add hidden levels.
This keeps ordinary creatures at the same con wherever their fixed template level is used. Native aggro and
assistance rules still determine whether nearby creatures join combat; named threats and creature rank remain
separate exceptions.

While either trial is active, the CoA client addon hides native numeric creature levels in the target and focus
frames, unit tooltips, and ElvUI nameplates. Players judge a selected creature through `/consider`, which
shows a colored mood/disposition and con without numeric level or combat-stat estimates.

The Stonetalon slice adds Pridewing Patriarch (4015), Sorrow Wing (5928), Sister Riven (5930),
Foreman Rigger (5931), and Taskmaster Whipfang (5932) to the same four-level named-threat rule.
Both Old School trials use this rule only while the named creature is in Stonetalon Mountains.
The existing native levels, random movement, Sorrow Wing waypoint route, spawn counts, loot,
and respawn timers are preserved. Existing creature aggro and assistance behavior is unchanged.

The Barrens slice retains its native Bristleback, Razormane, Kolkar, Witchwing, and Bael'dun camp rosters.
Camp-role danger adjustments are disabled. Barak Kodobane and Verog the Dervish carry eight hidden threat
levels and a 2x named reward; Hezrul Bloodmark carries ten hidden threat levels and a 3x named reward.
Named rewards multiply kill XP after the configured Old School pace and any elite-rank reward.
Their native spawns and patrol movement remain intact. All of these profiles are active only in
either Old School trial.
Stonetalon now includes Venture Co. worksites, Windshear mines, and Bloodfury roosts. Gerenzo Wrenchwhistle
and Sarilus Foulborne receive leader profiles; XT:4, XT:9, and Besseleth join the named threat set.
Ashenvale includes Thistlefur, Foulweald, Saltspittle, and Forsaken camps, with fourteen named encounters.
Thousand Needles includes Galak camps and Grimtotem mesas, with six named encounters.
Desolace includes Gelkis, Magram, Maraudine, and Slitherblade camps, with five named encounters.
Dustwallow Marsh includes Firemane grounds and Mirefin shores, with nine named encounters.
Feralas includes Gordunni compounds, Woodpaw camps, and Frayfeather nesting grounds, with eleven named encounters.
Named encounters in these six zones multiply con-based kill XP by 1.5x, 2x, or 3x according to their
authored threat tier. They also use the named gear retention rule. Native spawn positions, respawn timers,
and movement continue to provide the world ecology. Continue zone authoring in progression order while
player leveling feedback tunes the earlier slices.

Ordinary Old School deaths outside battlegrounds and arenas remove 10% of the experience
needed for the current level; the loss can delevel the character. Releasing revives the character
alive at their bind point with 20% health and mana. Worn equipment stays on a persistent equipment
corpse at the death location. Return alive and out of combat, then click the corpse within five
yards to recover the original item instances, including their enchantments and durability.
Items that cannot fit stay on the corpse. Each equipped death has its own record, so another
corpse run death does not replace earlier equipment corpses. Reconnects and restarts preserve
the records. Bank contents, carried supplies and coin stay with the character in this version.
There is no corpse expiration timer. Hardcore uses one life: death
permanently fails the run, while resurrection remains available under CoA's existing Hardcore
rules. Abandoning a progressed Hardcore run also fails it. Starting either trial requires being
alive and outside combat; Old School cannot be abandoned while dead or during combat.

During Old School, select any visible living creature and use `/consider` (or `.coa consider`).
The response colors the creature name and con, and reports whether it is hostile, neutral or friendly.
It does not reveal numeric level, health, damage or XP estimates.
The client definitions are generated with `C:/Azerothcore/tools/build-coa-old-school.py`
and shipped in CoA's existing `Data/patch-ZZ.MPQ`; the slash command is shipped in its
Homebrew Nourishment addon. Neither trial grants completion items.

Build a real camp using the Campfire ability from the Survivalist spellbook or the needs panel.
During Old School, Campfire consumes two harvested Forestwood Logs; Shelter consumes two Wildwood
Logs and four Light Leather; Hearthstead consumes two Everwood Logs and four Heavy Leather. Outside
Old School, the existing recipes continue to use Simple Wood. The placed fire is also a Cooking fire.
Sit beside it outside combat to receive the
existing camp recovery. In either Old School trial, staying near a live camp replenishes a rested
timer up to 20 minutes; time away from camp spends it while you are online and alive. A creature kill
receives 15% additional XP while the timer has time remaining, after the configured XP pace and named
reward. Quest XP uses the configured pace and its existing quest-source multiplier, without the rested kill bonus. Old School
does not consume the standard WoW rested-XP pool while its trial bonus is active. Sitting remains
necessary for the existing health/mana recovery and Fellowship benefits. The temporary `.coa camp`
claim command was removed; a placed camp is the actual camp marker and benefit source.

An ordinary party adds 20% to each Old School creature-kill XP share at 2 members, 30% at 3,
and 40% at 4-5. A matching visible buff identifies the party-size bonus; actual eligibility still
requires living members in the same trial and phase within native group-reward range. Playerbot
companions qualify. The bonus is applied after native XP splitting and stacks with camp rest.
Solo, distant/dead/offline companions, raids and battleground groups do not qualify. Quest XP is unchanged
by this bonus. The visible party-size buff identifies the active XP bonus.
Ordinary encounters use 6x health and 1x damage at their fixed hidden rating before encounter-rank adjustments.
Con and combat use the same fixed encounter level; ordinary mobs receive no per-entry or camp-role
offset. Melee skills retain a valid minimum; health adjustments support values below ordinary health
without unsigned underflow. Named encounters retain explicit authored offsets and rewards.
Old School blocks Destiny Weaver creature scaling, including for playerbot companions. Native solo and
party XP eligibility use hidden threat rather than native mob level; native aggro and assistance remain
unchanged. Automated gameplay and balance checks are deferred until Phase 1 implementation is complete,
per the user; leveling feedback is the current tuning input.

Tirisfal Glades adds Scarlet outposts, Agamand Mills, Vile Fin shores, and Rot Hide graveyards to the
authored camp registry. Sixteen native named creatures receive fixed danger and reward profiles: the Agamand
family, three Scarlet captains, Maggot Eye, Samuel Fipps, Farmer Solliden, Bayne, Ressan the Needler,
Fellicent's Shade, Gorefang, Old Vicejaw, and Krethis Shadowspinner. Existing spawns and movement remain
in place; this adds trial profiles rather than new routes or respawn timers.

Silverpine Forest adds Moonrage hunting grounds, Rot Hide haunts, Ravenclaw and Dalaran enclaves,
and lakeshore ambush rosters. These camp roles remain content metadata and do not add hidden levels.
Eleven existing named or roaming entries gain fixed threat and reward profiles: Rot Hide Bruiser,
Thule Ravenclaw, Snarlmane, Grimson the Pale, Nightlash, Apothecary Berard, Ravenclaw Regent,
Son of Arugal, Gorefang, Old Vicejaw and Krethis Shadowspinner. Son of Arugal uses a +10 threat
profile with a 3x named reward and a roaming warning; Thule and Berard use +8/2x; other profiles
use +4 or +6/1.5x. Con, rank and the configured XP pace still apply. These encounters also use named
gear retention. Native movement and respawn windows remain in place; this release does not
create new routes or spawn locations. Both Old School variants receive the profiles.

Hillsbrad Foothills adds settlement workers/guards, Azurelode mine, Dun Garok fortress,
Syndicate camps, Daggerspine shores and Torn Fin coastal rosters. Camp leaders retain their authored
roster metadata. Seventeen native named entries gain
fixed threat, extra encounter XP and named gear retention: Farmer Ray/Getz/Kalaba, Captain
Ironhill, Foreman Bonds, Magistrate Burnside, Jailors Eston/Marlgen, Clerk Horrace Whitesteed,
Citizen Wilkes, Miner Hackett, Tamra Stormpike, Scargil, Lady Zephris, Ro'Bark, Creepthess and
Big Samras. Captain Ironhill uses +8 threat/2x encounter XP; other profiles use +2, +4 or +6
threat/1.5x encounter XP. Native factions, spawns, movement and respawn windows remain intact.

Arathi Highlands adds Witherbark village, Boulderfist stronghold, Drywhisker mine,
Stromgarde garrison, Syndicate occupation and Daggerspine reef rosters. Thirteen native
named entries receive fixed threat and encounter rewards. Falconcrest, Galen Trollbane
and Fozruk use +10 threat/3x encounter XP; Darbel Montrose, Ruul Onestone and Marez Cowl
use +8/2x; the other profiles use +4 or +6/1.5x. Fozruk retains the existing waypoint patrol.
No faction, movement, respawn or actual creature-level changes are made.

The Hinterlands adds Witherbark village, Vilebranch foothold, Jintha'Alor fortress,
Razorbeak nests and Silvermane hunting-ground rosters. Fourteen native named entries
receive danger/reward and named gear profiles. Vile Priestess Hexx and Hitah'ya use +10
threat/3x encounter XP; Qiaga, Grimungous and Mith'rethis use +8/2x; the remaining named
profiles use +4 or +6/1.5x. Jintha'Alor guards and spellcasters retain elite rank modifiers.
Existing movement, respawn windows and faction behavior are preserved. No new spawn or
loot tables are added by these profiles; player leveling feedback will determine tuning.

Western Plaguelands adds Scourge ruins, Scarlet worksites, Hearthglen stronghold and
plague-cauldron roster groups. Twenty native named templates use trial danger/reward
profiles, including the four cauldron lords and the Scarlet and Scourge rare encounters.
Araj and Isillien use +10 threat/3x encounter XP; stronger elite leaders use +8/2x;
other encounters use +4 or +6/1.5x. Quest-triggered cauldron lords receive their fixed
profile even without a persistent spawn ID. Native quest spawning, movement, factions,
respawn windows, aggro and assistance remain intact.

Eastern Plaguelands adds Tyr's Hand, Mossflayer marsh, Scourge ruins, crypt lairs,
plaguehound grounds, plaguebat roosts and carrion feeding grounds. Thirteen native
named/roaming entries gain fixed danger/reward profiles. Borelgore, Duskwing and Demetria
use +10 threat/3x encounter XP and display a roaming warning; Abbendis and the Nerubian
Overseer use +8/2x; the other encounters use +4 or +6/1.5x. Native patrols remain in place.
These profiles preserve factions, assistance, respawn windows and ordinary-mode behavior.

## Reference systems and implementation boundary

Old School is intended to reproduce classic EverQuest's shared-world encounter model,
with Monsters & Memories camp recovery and slow equipment advancement. Pantheon's
published template and progression design provides additional concrete implementation
references. CoA combines Pantheon's stable level-difference model with MaM-style readable,
colored consider text and creature disposition. The numerical CoA combat curve remains provisional;
it is not a measured conversion of any other game's NPC statistics.

NPC combat strength belongs to the creature template, authored threat and encounter rank.
It must not depend on the level of the player who considers or first attacks it. Con color
and con-based XP are assessed separately for each player. The creature stores only its
applied combat adjustments, never the first attacker's con. Kill XP follows creature level and named/rank
rewards rather than a per-player con multiplier. Combat health, armor and damage are normalized to fixed native stats at the hidden
rating. The ordinary profile starts at 6x health and 1x damage to support the user-selected
20-40 second blue-con target; class-specific pacing feedback remains required.

The Monsters & Memories new-player guide documents eight harvested wood for a campfire,
one additional wood to rekindle it, a 15% rested bonus, a 20-minute accumulated-rest cap,
and about two minutes near the fire to reach that cap. Rain prevents accumulation unless
sheltered. CoA borrows the bonus, cap and refill pacing, while its Old School Campfire uses two
Forestwood Logs to match the Survivalist tooltip and logging yield. Reusing the matching camp ability
near an owned fire consumes one tier-specific log to refuel it. Native
inns also replenish rest, and rain/storm/snow exposure blocks refill at unsheltered campfires.
Shelter and Hearthstead retain their CoA tier recipes and protect rest accumulation. Refueling
refreshes CoA's configured camp lifetime; the source guide does not publish a fuel-duration value.

The intended loot progression needs coherent named encounter tables, useful basic gear,
small lasting upgrades and craftable alternatives. Ordinary random magical equipment retains a 1% filter; basic gear and native named
rewards are preserved. Native professions provide fixed gear upgrades without item-level
scaling. Quest/vendor reward balance, bespoke crafted item advancement and additional
curated encounter tables remain further content work.

References:

- https://monstersandmemories.com/gameplay
- https://monstersandmemories.com/new-player-guide
- https://www.pantheonmmo.com/news/combat-progression-update-details-part-2-unified-npc-templates/
- https://www.pantheonmmo.com/news/combat-progression-update-details-part-5-leveling-experience-progression-adjustments/
- https://www.pantheonmmo.com/news/combat-progression-update-details-part-8-crafting-gathering/
- https://www.pantheonmmo.com/news/combat-progression-update-details-part-9-itemization-economy-roadmap/

Pantheon references describe published development targets, not proof of its current live
balance. The user's selected classic 1999–2000 EverQuest references and explicit CoA requirements
remain authoritative where the games differ: consider works on any selected living creature, native
assistance remains intact, XP defaults to a full base pace with visible party bonuses, and Survivalist
integrates with CoA lumbering.

## Level 1–60 outdoor zone coverage

Both Old School variants now register authored native creature profiles in every leveling
zone in Eastern Kingdoms and Kalimdor, plus Eversong Woods, Ghostlands, Azuremyst Isle,
Bloodmyst Isle and the Scarlet Enclave introduction. The original fifteen zone rosters remain.
Thirty additional zones add 949 template profiles, with camp roles, named encounter rewards,
named gear retention and native patrol warnings. The registry is indexed by zone and template;
consideration and combat use the same profile lookup. CoA's eight separate starter-zone IDs
resolve to their parent region, including Valley of Trials, Coldridge Valley and Deathknell.

The per-zone data and counts are in `src/old-school-zones/coverage.json`. Camp rosters describe
native hunting sites; the existing Survivalist camp ability provides player recovery, cooking and
the renewable rest timer. Consider evaluates the selected creature without an artificial distance limit;
native aggro and assistance still govern combat. New zone data does not introduce additional NPC spawns,
waypoint routes, respawn timers or bespoke loot tables. Those content passes and leveling
balance remain separate from this complete first-pass profile coverage. Gameplay testing is
deferred until Phase 1 is implemented, following the user's instruction.

## License

GNU General Public License v2.0 — see [LICENSE](LICENSE).
