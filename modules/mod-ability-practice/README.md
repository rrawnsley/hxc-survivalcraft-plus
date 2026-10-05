# Ability practice — development foundation

This module is under development on `codex/ability-practice`. It implements the deterministic
practice policy, explicit catalog model, bounded original-action accounting and a development observation path.
The module and addon are staged in this checkout. Nothing is installed or activated in production.

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
original action. This header does not claim to identify casts, effective healing or anti-grind rules. The development path handles direct cast outcomes; complete event qualification, periodic attribution and
acquisition enforcement remain future stages.

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

`src/AbilityPracticePersistence.h` adapts versioned practice records to the existing player-settings cache using
`FindPlayerSettings` and `UpdatePlayerSetting`. Keys are class/ability scoped under `core.hxc.ability_practice.`
and fit the existing 40-character database source column. Five uint32 fields store schema, definition and migration
versions, proficiency and partial points. Unknown/corrupt versions are refused; writes cannot reduce cached practice
or undo a migration marker. Learned-rank seeding runs once. Reads do not create missing settings or execute queries;
writes change only the player cache. The existing character save appends these settings through prepared statements
alongside learned spells in the character transaction, including with optional player preferences disabled. No new
table or SQL migration is required for this backend. The development player/outcome hooks call this adapter;
normal autosave/logout reliability and load-failure behavior still require integration qualification. The separate
save-coordination state API remains available if an independent async backend becomes necessary.

`src/AbilityPracticeOutcome.h` joins the calculation, one-time migration and cache persistence APIs at a qualifying
outcome. It refuses disabled/ineligible contexts, triggered/passive/foreign casts, unlearned spells, class mismatches
and version conflicts. The cast-owned script value key `0x41505243` (APRC) is reserved by this module, separate from
existing spell-ID keys, and marks one award across delayed/multiple target outcomes without retaining cast pointers.
It does not use the shared 32-bit script event mask (whose upper slots already serve Ranger mechanics). The callback
must establish meaningful effective outcomes and serialize player-cache access on its owning execution context.
No rank is granted by this helper. The development outcome hook calls it for effective direct damage/healing.
The isolated harness compiles the actual adapter using mock Player/Spell interfaces; event/lifecycle qualification
remains required in addition to native compilation.

`tools/inventory.py --output <path>` produces a deterministic read-only inventory of six class/spellbook sources,
including hashes and the meaning of each rank reference. It records all 21 classes and 7,678 class/spell identities
without conflating acquisition predecessors with ability roots. These are source candidates, including talent,
passive and support spells; no entry is yet approved as trainable or verified against effective DBC/SQL/runtime data.
Optional `--dbc <directory>` reuses the repository's reviewed read-only DBC parser to add names, raw rank labels,
levels, passive flags and effect IDs while preserving source evidence. Same-name/rank groups are candidates only;
they do not become ability identities. Missing records, field errors and stale/unknown extraction provenance stay
explicit. The current local Spell data produced 761 name/rank candidates and 3,286 passive review flags; its extraction
manifest is stale relative to the actual file hash. SQL corrections, scripted behavior and live runtime remain unobserved.
Candidate groups also flag duplicate rank labels, absent rank-one labels and gaps instead of silently repairing them.
Seventeen local groups (113 class/spell entries) carry at least one of these review flags.

`tools/catalog_candidates.py --inventory <inventory.json> --output <candidates.json>` groups only the source's
explicit claimed-root relationships. Acquisition references are retained as prerequisites and never treated as
ability roots; same-name spells are not merged. Membership conflicts, uncertain rank order, repeated levels and
raw rank disagreement remain explicit review flags. Records outside a claimed chain stay separate pending
classification as ranked, mastery, fixed, passive, pet or support actions. Every candidate has
`productionApproved: false`; this file is review evidence, not a runtime catalog. The current inventory yields
456 claimed-root groups and 4,513 standalone source records across all 21 classes, without losing any source identity.
Optional `--dbc <directory>` uses the reviewed DBC reader to include advancement entry levels, AE/TE costs,
required entry IDs, rank spells and class/tab context. Table hashes and extraction provenance are retained separately.
The current local data gives 3,943 candidates at least one raw advancement reference. Native class/spec filtering,
identity-level normalization and dependency exceptions are not reproduced or asserted by this export; source levels
are never silently replaced with raw tree levels. Those nodes are acquisition evidence, not character entitlement.

`src/AbilityPracticeMenu.h` builds authoritative per-ability view data from the same calculation/catalog APIs,
including learned rank, proficiency, current cap, next-point forecast and upcoming rank state. It preserves earned
above-cap progress and leaves fixed abilities without practice requirements. `MenuSchemaVersion` is 1.

`client/HXCAbilityPractice` contains a staged WoW 3.3.5 addon window with My Skills/Upcoming views, scrollable ability
selection, a next-point progress bar, exact qualifying-use text and character-level/rank requirement states. `/practice`
opens it. Without server data it displays a waiting state; there are no demo values or client-calculated awards.
The model validates and copies complete snapshots, rejects stale/class-mismatched updates and preserves large
use counts as decimal strings rather than imprecise Lua floating-point numbers. A self-whisper request/response transport is staged for the development slice. It is not installed or listed
in any production launcher payload/catalog.
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
bound/throttle delivery to meet it or revise the protocol coherently. The development listener resets revisions on
login, rate-limits requests and accepts only self-whispers with prefix HXAP. A C++ encoded snapshot is round-tripped
through the actual Lua 5.1 event listener by the isolated harness.

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

## Development observation slice

`AbilityPracticeServer.cpp` and the standard module loader register config/startup, login/logout, addon request
and actual hit-result hooks. Both `AbilityPractice.Enable` and `AbilityPractice.AllowDevelopmentObservation`
default to zero in `conf/AbilityPractice.conf.dist`. With either off, the frequent outcome/chat/login paths return
without touching practice or sending snapshots. Enabling after an initially disabled startup requires a restart
of an isolated development server so its spell validation can run. Do not enable this slice in production.

`AbilityPracticeDevelopment.h` explicitly defines Lava Shard, Cinderheart and Kindle for Pyromancer (class 24).
Their 27 rank IDs and character levels are checked against the committed source inventory. Proficiency milestones,
cap schedule, catch-up bands and the ten-level target window are illustrative development settings, not approved
production balance. The release scope remains all 21 CoA classes.

The slice seeds already learned ranks once and records qualifying practice through the existing settings cache.
Only non-triggered, learned direct casts with effective hostile damage or friendly healing qualify, while the player
is in combat and the target meets the development level window. Human sessions only; damaging player targets are
excluded. The cast-owned marker limits multi-target hits to one award. Successful awards send authoritative views
for the three abilities. Opening `/practice` requests a fresh snapshot; malformed, foreign and stale messages fail
closed. No rank is learned, removed or replaced; no combat power is modified. Utility/periodic/pet attribution,
training-exploit protection, final acquisition gates, owner-thread/cache lifecycle and network pacing still need
qualification before full progression integration.

The isolated native build uses a checkout-specific build directory and one build worker at reduced process priority.
Its process tree is limited to two logical processors; Visual Studio can otherwise spawn multiple compiler workers.
Verification never installs or restarts a server. In-game rendering, effective SQL-adjusted spell data and gameplay
acceptance are still outstanding.

The combined `--stages source,build,harness --base 36117f3e9 --harness ability_practice --jobs 1` run passed
at `.cache/verify-all/20261005-034752/report.json`. Both native module files were compiled and the isolated
worldserver linked. The Windows test dependency needs `-Dgtest_force_shared_crt=ON` to match the server runtime;
that option is recorded only in this checkout's ignored build settings. Unit executables were built, but the unit
stage was not run. No gameplay test server, database, installed client or launcher was accessed by this run.

## Character settings load safeguard

The existing cache could not distinguish a legitimate empty settings result from a failed query. Its prepared
read now includes a synthetic NULL-source row, which both readers skip without storing it. An empty table therefore
still has a successful result; a failed read remains null. `Player::LoadFromDB` refuses that failure before creating
the player object state or running load/login hooks. The offline settings helper also refuses an update after a
failed read rather than constructing a replacement from empty defaults. This required three narrow shared-loader
changes because the module receives only the cache/login callback, not the original query outcome. No new table,
SQL migration, extra query or player-header/ABI change was added.

Source/native build passed at `.cache/verify-all/20261005-035958/report.json`. MySQL empty-result and failure-path
runtime qualification remains outstanding; this build does not establish those runtime outcomes.
