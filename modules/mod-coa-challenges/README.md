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

Old School (9001) and Old School - Hardcore (9002) are mutually exclusive native trials.
Creature levels remain fixed internally and display as `??` while the trial is active. In the trial, their power and kill experience follow the
participant's con. Ordinary persistent spawns have a stable hidden threat offset from -8 to +65 levels,
so a zone can contain approachable prey and severe threats even when its native creature levels are
clustered. This includes non-elite persistent spawns. `/consider`, health, damage, melee skill, spell-hit
level difference, and kill experience use that hidden threat rating; the rating is fixed per database
spawn and never scales to the player. Native creature levels remain unchanged. Temporary creatures
without a spawn ID skip the random spread; authored named-threat and Mulgore camp-role bonuses still
apply. Elite and boss ranks retain their combat-stat multipliers. Grey creatures have
1x health, 1x damage and 0.50x con-tier kill XP; green 1.5x/1x/0.75x; blue 2x/1x/0.90x;
white 3x/2x/1x; yellow 5x/3x/1.5x; red 8x/5x/2x; and purple 12x/8x/3x.
Elites and bosses multiply those values further. Old School applies a configurable 50% pace to all XP
sources, then applies the creature con multiplier to kill XP; a white kill therefore awards 0.5x the
ordinary creature XP, a red kill 1x, and a purple kill 1.5x before the rested-camp bonus. Quest and
other non-creature XP awards are 50% of normal. The pace is configured in basis points (5000 = 50%),
and fractional XP carries between awards. Critters and
player-owned units are excluded. Restricted tapping prevents players in another trial from
assisting with the kill or claiming its rewards.

Across all zones in either Old School trial, only 1% of rolled ordinary-creature armor and weapon drops
survive loot generation; authored named threats in Mulgore, the Barrens, and Stonetalon use a 5% keep
chance. Quest items and crafting materials are preserved, and crafted gear is unaffected. This makes
professions a dependable route to incremental upgrades while dropped equipment remains rare. Both
rates can be configured globally for the two Old School trials.

Mulgore's named threats - Ghost Howl (3056), Arra'chea (3058), Mazzranache (3068), Sister Hatelash (5785),
Snagglespear (5786), Enforcer Emilgund (5787), and The Rake (5807) - and the Barrens threats Gesharahan
(3398), Lakota'mani (3474), Humar the Pridelord (5828), Snort
the Heckler (5829), Swiftmane (5831), Azzere the Skyblade (5834), Heggin Stonewhisker (5847), and Dishu
(5865) carry four additional hidden threat levels in Old School. `/consider` identifies these threats, and the
hidden rating affects con, combat and kill XP without changing native levels or ordinary-mode behavior. Ghost
Howl, Arra'chea, and The Rake use their existing authored roam paths; an isolated gameplay scenario verifies
that each moves at least eight yards from its database spawn while the Old School phase is active. Their rare
spawn timers remain intact; their rolled equipment drops follow the Old School named-threat keep chance.

Mulgore's Bristleback, Palemane, Venture Co., and Windfury Ridge camps use authored role bonuses on top
of the stable spawn rating. Guards, workers, tanners, and skinners receive smaller bonuses; shamans,
battleboars, poachers, taskmasters, supervisors, casters, and matriarchs receive larger bonuses. `/consider`
identifies the camp role and reports living members of the same camp within the 40-yard inspection range.
Its added hidden threat contributes to the same con, combat scaling, and kill XP estimate. This is proximity
information only; native aggro and assistance rules determine who joins combat. These role bonuses apply only
inside Mulgore and only during either Old School trial.

While either trial is active, the CoA client addon hides native numeric creature levels in the target and focus
frames, unit tooltips, and ElvUI nameplates. Players judge a creature through `/consider`; its con and power
estimate use the same hidden threat profile as combat.

The Stonetalon slice adds Pridewing Patriarch (4015), Sorrow Wing (5928), Sister Riven (5930),
Foreman Rigger (5931), and Taskmaster Whipfang (5932) to the same four-level named-threat rule.
Both Old School trials use this rule only while the named creature is in Stonetalon Mountains.
The existing native levels, random movement, Sorrow Wing waypoint route, spawn counts, loot,
and respawn timers are preserved. Existing creature aggro and assistance behavior is unchanged.

The Barrens slice assigns hidden camp-role danger to its native Bristleback, Razormane, Kolkar,
Witchwing, and Bael'dun rosters. Consider reports nearby living members of the same roster in the
40-yard inspection range; the readout does not change native aggro or assistance. Barak Kodobane
and Verog the Dervish carry eight hidden threat levels and a 2x encounter reward; Hezrul Bloodmark
carries ten hidden threat levels and a 3x encounter reward. The named bonus multiplies the same
con-based kill XP used by `/consider`, on top of the 50% Old School pace and any elite-rank reward.
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
needed for the current level; the loss can delevel the character. Resurrection requires
returning to the character's corpse as a spirit. Worn equipment is removed from the ghost and
persisted on the corpse record; reaching and resurrecting at the body restores the same item
instances, including after reconnect. The standard corpse remains at its death location and
displays the character's equipment during the run. Hardcore uses one life: death
permanently fails the run, while resurrection remains available under CoA's existing Hardcore
rules. Abandoning a progressed Hardcore run also fails it. Starting either trial requires being
alive and outside combat; Old School cannot be abandoned while dead or during combat.

During Old School, target a hostile creature within 40 yards (center to center) and use `/consider`
(or `.coa consider`). This is only the range for inspecting a target; it does not change aggro,
assist, or social-pull behavior. The response reports its con and the same health, damage and kill XP
multipliers used by that creature. It also warns that gear, abilities, companions and adds can change
the outcome. `challenges-old-school-consider-inspection-range` verifies a selected target at 39 yards
is inspectable and one at 41 yards is outside the range.
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
 receives 15% additional XP while the timer has time remaining, after the trial's 50% XP pace and con
 multiplier. Quest XP uses the 50% trial pace without the rested kill bonus. Old School
does not consume the standard WoW rested-XP pool while its trial bonus is active. Sitting remains
necessary for the existing health/mana recovery and Fellowship benefits. The temporary `.coa camp`
claim command was removed; a placed camp is the actual camp marker and benefit source.

An ordinary party adds 10% to each Old School creature-kill XP share when another living member
in the same trial is in the same phase and native group-reward range. Playerbot companions qualify.
The bonus applies once regardless of party size, after native XP splitting, and stacks with camp rest.
Solo, distant/dead/offline companions, raids and battleground groups do not qualify. Quest XP is unchanged
by this bonus. `/consider` reports an eligible party bonus separately from the mob's base kill reward.
The first-play combat profiles above replace the earlier 8x-health/5x-damage white baseline.
Con uses a signed hidden threat rating, so green and blue targets are available at character level 1.
Melee skills retain a valid minimum; health adjustments support values below ordinary health without
unsigned underflow. Unnamed persistent level-1/2 prey uses a smaller fixed spread (-3 to +10), with
approachable candidates and a minority of dangerous outliers. Higher-level spawns retain -8 to +65.
Old School blocks Destiny Weaver creature scaling, including for playerbot companions. Native solo and
party XP eligibility use hidden threat rather than native mob level; native aggro and assistance remain
unchanged. Automated gameplay and balance checks are deferred until Phase 1 implementation is complete,
per the user; leveling feedback is the current tuning input.

Tirisfal Glades adds Scarlet outposts, Agamand Mills, Vile Fin shores, and Rot Hide graveyards to camp
consider readouts. Sixteen native named creatures receive fixed danger and reward profiles: the Agamand
family, three Scarlet captains, Maggot Eye, Samuel Fipps, Farmer Solliden, Bayne, Ressan the Needler,
Fellicent's Shade, Gorefang, Old Vicejaw, and Krethis Shadowspinner. Existing spawns and movement remain
in place; this adds trial profiles rather than new routes or respawn timers.

Silverpine Forest adds Moonrage hunting grounds, Rot Hide haunts, Ravenclaw and Dalaran enclaves,
and lakeshore ambush rosters. `/consider` identifies each role and nearby living roster members.
Eleven existing named or roaming entries gain fixed threat and reward profiles: Rot Hide Bruiser,
Thule Ravenclaw, Snarlmane, Grimson the Pale, Nightlash, Apothecary Berard, Ravenclaw Regent,
Son of Arugal, Gorefang, Old Vicejaw and Krethis Shadowspinner. Son of Arugal uses a +10 threat
profile with a 3x named reward and a roaming warning; Thule and Berard use +8/2x; other profiles
use +4 or +6/1.5x. Con, rank and the 50% XP pace still apply. These encounters also use named
gear retention. Native movement and respawn windows remain in place; this release does not
create new routes or spawn locations. Both Old School variants receive the profiles.

Hillsbrad Foothills adds settlement workers/guards, Azurelode mine, Dun Garok fortress,
Syndicate camps, Daggerspine shores and Torn Fin coastal rosters. Camp leaders share the
nearby-member consideration readout with their guards. Seventeen native named entries gain
fixed threat, extra encounter XP and named gear retention: Farmer Ray/Getz/Kalaba, Captain
Ironhill, Foreman Bonds, Magistrate Burnside, Jailors Eston/Marlgen, Clerk Horrace Whitesteed,
Citizen Wilkes, Miner Hackett, Tamra Stormpike, Scargil, Lady Zephris, Ro'Bark, Creepthess and
Big Samras. Captain Ironhill uses +8 threat/2x encounter XP; other profiles use +2, +4 or +6
threat/1.5x encounter XP. Native factions, spawns, movement and respawn windows remain intact.

Arathi Highlands adds Witherbark village, Boulderfist stronghold, Drywhisker mine,
Stromgarde garrison, Syndicate occupation and Daggerspine reef rosters. Thirteen native
named entries receive fixed threat and encounter rewards. Falconcrest, Galen Trollbane
and Fozruk use +10 threat/3x encounter XP; Darbel Montrose, Ruul Onestone and Marez Cowl
use +8/2x; the other profiles use +4 or +6/1.5x. Fozruk's consideration includes a roaming
warning and preserves the existing waypoint patrol. Leaders share camp proximity readouts.
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

## License

GNU General Public License v2.0 — see [LICENSE](LICENSE).
