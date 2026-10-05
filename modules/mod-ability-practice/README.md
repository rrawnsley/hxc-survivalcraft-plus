# Ability practice — development foundation

This module is under development on `codex/ability-practice`. It implements the deterministic
practice policy, explicit catalog model and bounded original-action accounting. There is no loader, player hook, database
migration, installed addon, runtime configuration or production activation in this checkpoint.

`src/AbilityPracticeProgression.h` provides configurable training bands, progression after a qualifying action,
exact action forecasts across catch-up/rate changes, cap handling and separate character-level/practice eligibility.
Definitions contain no final balance constants: proficiency caps and policy bands are supplied by the caller.

Each band starts at a proficiency and defines points required per proficiency point and points awarded per qualifying
use. Changes take effect at that boundary. An action earns points using its starting band's rate; carried points
continue through later bands. Reaching the current cap discards newly excess points. An already trained value above
a temporarily reduced cap is preserved and cannot earn additional practice. Corrupt policy/state inputs are rejected.
Forecasts report complete, trainable, beyond current cap or invalid; beyond-cap is never represented as a trainable
zero-use result. Large intervals are calculated by bands rather than simulated cast by cast.

The function name `ApplyQualifyingUse` requires its future caller to establish eligibility and deduplicate the
original action. This header does not claim to identify casts, effective healing or anti-grind rules. Event policy,
live cast attribution, persistence, acquisition enforcement, migration and versioned addon snapshots remain future stages.

`src/AbilityPracticeCatalog.h` defines class-scoped stable ability identities, explicit rank requirements, ranked/mastery/
fixed kinds, and level-cap schedules. Validation rejects duplicate ability/spell ownership, malformed ranks and caps.
`DescribeRank` returns learned, acquire introductory ability, prerequisite, practice, level and ready states alongside
an exact forecast where current caps allow one. Introductory abilities always retain their normal acquisition route.
`SeedLearnedRanks` raises proficiency to support already learned ranks without reducing stronger existing progress;
the persistence layer must apply that migration once, rather than reseeding on every login. Fixtures use synthetic IDs,
not approved production class mappings. The effective all-class inventory remains outstanding.

`src/AbilityPracticeActions.h` tracks a bounded number of original actions per player session using opaque tokens.
One qualifying outcome consumes an action once; subsequent targets, outcomes and ticks cannot award it again.
Unqualified outcomes leave it eligible for a later qualifying outcome. Closed actions and prior-session tokens are
rejected, and a full ledger refuses new actions rather than evicting an action that could earn twice. Runtime integration
must assign unique session IDs, identify original actions, close their complete outcome lifetime, exclude triggered/
passive actions where appropriate, and establish meaningful-use qualification. No current player hook provides all
of that attribution by itself. Neither API stores live player pointers or performs database writes.

`src/AbilityPracticeState.h` provides a per-ability load/dirty/save state machine. Awards wait for a valid load;
only one save is in flight for that ability. Snapshots carry session, class, ability, revision, attempt and definition
version. Successful older saves do not clear newer practice, failed saves remain dirty, and retry attempts reject
callbacks from a previous attempt of the same revision. This is save coordination, not a database adapter: actual
prepared statements, bounded async scheduling, transactional migration and logout/shutdown drains remain outstanding.
Callers must resolve callbacks to the correct live session rather than retaining a raw player pointer.

`tools/inventory.py --output <path>` produces a deterministic read-only inventory of six class/spellbook sources,
including hashes and the meaning of each rank reference. It records all 21 classes and 7,678 class/spell identities
without conflating acquisition predecessors with ability roots. These are source candidates, including talent,
passive and support spells; no entry is yet approved as trainable or verified against effective DBC/SQL/runtime data.
Optional `--dbc <directory>` reuses the repository's reviewed read-only DBC parser to add names, raw rank labels,
levels, passive flags and effect IDs while preserving source evidence. Same-name/rank groups are candidates only;
they do not become ability identities. Missing records, field errors and stale/unknown extraction provenance stay
explicit. The current local Spell data produced 761 name/rank candidates and 3,286 passive review flags; its extraction
manifest is stale relative to the actual file hash. SQL corrections, scripted behavior and live runtime remain unobserved.

`src/AbilityPracticeMenu.h` builds authoritative per-ability view data from the same calculation/catalog APIs,
including learned rank, proficiency, current cap, next-point forecast and upcoming rank state. It preserves earned
above-cap progress and leaves fixed abilities without practice requirements. `MenuSchemaVersion` is 1.

`client/HXCAbilityPractice` contains a staged WoW 3.3.5 addon window with My Skills/Upcoming views, scrollable ability
selection, a next-point progress bar, exact qualifying-use text and character-level/rank requirement states. `/practice`
opens it. Without server data it displays a waiting state; there are no demo values or client-calculated awards.
The model validates and copies complete snapshots, rejects stale/class-mismatched updates and preserves large
use counts as decimal strings rather than imprecise Lua floating-point numbers. The server transport is not wired,
so this addon is not functional against production and is not installed or listed in any launcher payload/catalog.
Session summaries, tracking preferences, filters/search, final visual polish and in-game acceptance remain future work.

The snapshot adapter must send the C++ view fields as the camel-case Lua model fields, with numeric enum states,
`uses` as an unsigned decimal string, and an enclosing `schemaVersion`, increasing `revision`, `classId`,
`characterLevel`, and dense `abilities` array. Accept updates only from the authenticated server transport and apply
them atomically after complete assembly; Lua validation does not authenticate a sender. No client request may change
proficiency or learn a rank. Revision rollover/reconnect behavior must be defined when transport is integrated.

`src/AbilityPracticeWire.h` encodes validated complete snapshots as bounded ASCII records, and client `Wire.lua`
assembles them atomically before model validation. The format is `B|schema|revision|class|level|count`, followed by
one each of `A` (ability), `P` (next-point forecast) and `R` (rank or absent marker) per one-based ability index,
then `E|revision`. Records are at most 240 bytes; snapshots contain at most 512 abilities. Enum values are explicit
and counts remain decimal strings. Duplicate parts and incomplete/expired snapshots are rejected; stale unrelated
frames do not replace newer pending data. The receiver has a five-second assembly deadline. Live transport must
bound/throttle delivery to meet it or revise the protocol coherently. There is no network listener/sender yet; a
C++ encoded snapshot is round-tripped into the actual Lua 5.1 reader by the isolated harness.

The future menu will distinguish character level, learned rank and trained proficiency, with exact qualifying uses
to the next point/milestone. No random fizzles, magic-school categories or automatic upgrades on unrelated abilities
are part of the accepted design. Existing learned abilities must survive migration. Unranked rewards and numerical
training profiles still need balance review.

Verification runs through `python -B tools/verify_all.py --stages source,harness --base 36117f3e9
--harness ability_practice --jobs 1`. This focused harness compiles the actual header and exercises forecast/award
agreement, changing bands, over-cap retention, malformed inputs, large counts, catalog/acquisition states, migration
seeding, action deduplication/session isolation, save retries/stale callbacks, deterministic source inventory,
authoritative menu views and the addon model in Lua 5.1. The Lua UI smoke uses mocked WoW frame APIs; it is not
in-game visual acceptance. The harness requires MSVC/C++20 and `lupa` with Lua 5.1 support. The development runtime
is isolated in `.cache/ability-practice/lua-runtime` (installed with `py -m pip install --target
.cache/ability-practice/lua-runtime lupa`, version 2.8 at this checkpoint). It neither
builds a worldserver nor accesses any server/database. Full build and gameplay qualification remain required before
integration or deployment. Keep all development in this checkout while the user plays.
