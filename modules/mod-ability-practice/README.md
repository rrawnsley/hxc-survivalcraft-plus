# Ability practice â€” development foundation

This module is under development on `codex/ability-practice`. It implements the deterministic
practice policy, explicit catalog model, bounded original-action accounting and a development observation path.
The module and addon are staged in this checkout. Nothing is installed or activated in production.


## Current state — 5 October 2026

- Native prototype: three Pyromancer class-grant profiles, with draft tuning. The full rollout still targets
  all 21 CoA classes. An optional startup-only sample catalog adds 20 ranked class-grant profiles for the other
  classes, for 23 profiles across all 21 classes. An optional broader ranked catalog selects 106 profiles and
  888 authored ranks across all 21 classes, taking priority over class samples. Periodic observation adds two
  profiles to the selected catalog (five/25/108 respectively). All development settings default off.
- Outcomes: resolved direct damage/healing, successful interruption, dispel and beneficial-aura steal.
  Each profile requires its own outcome route. The existing client-cast callback records numeric class/spell
  identity; preparation requires that identity and rejects item/aura-triggered sources. Script-created casts
  cannot mint the request identity. Optional native periodic damage/percent-damage/healing shares one receipt
  with the original cast, including direct results and multiple targets. Repeat-fire, summoned/pet/helper
  attribution and scripted replacement ticks remain unfinished; periodic runtime behavior is unqualified.
- Ranks/storage: cached versioned settings, once-only learned-rank seeding, monotonic writes, exact saved-row
  restoration scope and stronger-rank learning guards. Corrupt or incompatible progress stays blocked.
  Shared native race/racial and faction-rift eligibility is checked at preparation, award and new upgrades;
  class/race/talent-set/custom-specialization changes refresh the owner state. Normal database save/reload/failure
  behavior and broader acquisition entitlements remain unqualified.
- Menu: addon 0.4.10-development; unpublished protocol 4 includes B7 instance identity, T9 kind/session/rules,
  mandatory C future-cap metadata, packed D parts and F8 unreadable-progress responses. Typed delivery is
  bounded/paced; saved views/ages/session totals are labeled. Existing schema 1/2/3 formats are preserved.
- All-class preparation: 847 unapproved source-consistent class-grant definition drafts, including 244 ranked
  and 603 standalone groups. 179 have common current native outcomes across all 21 classes. Definitions,
  caps, practice rates and rewards are not automatically approved or installed.
- Verification on this resumed run: source checks, isolated native builds, C++ lint, whitespace and Lua 5.1
  syntax compilation only. No behavioral tests or live play checks ran. Earlier harness results below do not
  qualify the new changes. A validation-scope question is pending; explicit testing authorization is needed.
- Release work: reviewed all-class definitions, final balance, unranked rewards, remaining attribution and
  acquisition ownership, isolated runtime acceptance and a coordinated production opportunity compatible
  with the player's continued live use. No production deployment/restart/configuration/DB/client change.

Later sections are chronological implementation notes. Their older protocol/addon shapes are historical;
the current unpublished shape above takes precedence. Source checking/building is not release acceptance.

## Client-request attribution checkpoint — 5 October 2026

The module registers the existing `MISCHOOK_VALIDATE_SPELL_AT_CAST_SPELL_RESULT` observer. Its current core
caller is `WorldSession::HandleCastSpellOpcode`, after the cast has its resolved spell identity and before
preparation. An enabled profiled human casting as themselves receives a numeric class/spell request stamp on
that Spell. Preparation requires the matching stamp in addition to the earlier item/aura/trigger/original-caster
checks. The observer does not mutate targets, spell identities, validation results or normal casting.

Ordinary script-created spells, even without trigger flags, lack the request stamp. Item-use and pet command
paths do not issue it. Queued casts return through the same handler; downranked positive casts use the actual
Spell identity. Those source paths were inspected; they have not been exercised in a running client/server.
No stamp propagates to helper spells or repeat-fire instances. Explicit attribution for those and periodic
auras remains future work. This is a trusted internal source marker, not a client authentication mechanism.

Source checks and the isolated native build passed in `.cache/verify-all/20261005-134326/report.json`;
C++ lint, whitespace and five addon Lua 5.1 syntax compilations passed. No behavioral tests ran. Candidate
and draft discovery artifacts were regenerated against the changed native source hashes. Production remains
untouched and the draft tuning and three prototype profiles are unchanged.

## Representative all-class catalog — 5 October 2026

`AbilityPractice.AllowDevelopmentClassSamples = 1` selects an expanded development catalog at startup,
provided the existing enable and observation flags are also enabled. It does not enable rank learning; that
still requires its independent flag. Reloading configuration does not change the selected static catalog.
The default remains the original three Pyromancer profiles. No configuration or server was changed live.

`AbilityPracticeDevelopmentSamples.h` contains 20 explicit ranked samples for custom class IDs 12–23 and
25–32. Each has a source-consistent root class grant and complete generated rank chain, and a common raw
native damage or healing route. IDs and character levels came from the current provenance-checked draft
artifact. Existing native startup validation still checks the complete source grant chain and each effective
SpellInfo's supported direct outcome and nonpassive status. Any rejected selected sample leaves observation
and rank learning inactive. Startup has not yet been exercised with the expanded catalog.

Proficiency requirements follow the existing illustrative 1/10/20/40/60 sequence; the existing draft training
bands and capped five-points-per-character-level curve are reused. These are development values, not approved
class balance. Native character-level requirements are preserved, including Call Lightning's last rank at 84;
the module does not raise the realm level limit. Pyromancer's three existing definitions remain unchanged.
These samples do not constitute a complete ability catalog, reviewed acquisition entitlement, utility/pet/
periodic support, or unranked mastery rewards.

Discovery provenance now also hashes both development catalog headers. Candidate and unapproved draft artifacts
were regenerated; the 847 draft groups and 179 common-outcome candidates are unchanged. Source checks and the
isolated native build passed in `.cache/verify-all/20261005-134959/report.json`; changed C++ lint and whitespace
passed. No behavioral tests or live client/server checks ran.

## Typed roadmap consistency — 5 October 2026

The unpublished protocol-4 encoder and addon model now check roadmap records together. Rank numbers must be
contiguous from one, introductory proficiency must be one, and the selected ability kind must match its rank
count. The displayed spell and learned-rank number must match the highest rank marked learned. The next-rank
record must equal the rank immediately following it, or be absent when the final rank is learned.

Availability must agree with the introductory level, learned ownership, current cap and next-point forecast.
Previously learned higher ranks with missing lower rows remain representable: the highest learned rank still
controls the display and next rank. Requirements of retained learned ranks are not retrospectively enforced.
Invalid typed snapshots are refused rather than replacing the previous validated client view. Legacy schemas
1/2/3 are unchanged. This is cross-record validation, not a new practice or acquisition policy.

Source checks and the isolated native build passed in `.cache/verify-all/20261005-135617/report.json`;
C++ lint, whitespace and five Lua 5.1 syntax compilations passed. Malformed/valid snapshot behavioral
acceptance remains pending explicit testing authorization. Production remains untouched.

## Effective rank-chain consistency — 5 October 2026

Startup now refuses a selected profile if its class-grant root has duplicate source grant rows, even when one
row happens to match the requested level. When SpellMgr supplies native rank-chain nodes, every profile rank
must have a node with the same first/last spell, rank number and preceding/following spell. Partial native
chains and foreign, reordered or extended chains refuse the selected catalog before observation/learning.

An ability with no native chain nodes remains supported by its independently checked CoA source progression.
The module does not assume generated CoA ranks require database `spell_ranks` rows, and does not manufacture
or rewrite such rows. This guard checks present effective chains for contradictions; it does not prove absent
chains are runtime-correct, or complete acquisition ownership. It is startup-only; rank-data reload after
activation remains unqualified. No production database was queried or changed.

Source checks and the isolated native build passed in `.cache/verify-all/20261005-140040/report.json`;
changed C++ lint and whitespace passed. Discovery artifacts were regenerated for the changed native hash.
No behavioral tests or expanded-catalog startup ran. Production remains untouched.

## Shared acquisition and owner-state refresh — 5 October 2026

`AscensionSpellEligibility.h` extracts the existing native racial/faction-rift acquisition check into a shared
inline helper. AscensionCompat's existing grant path uses the same check through its old wrapper. Practice
preparation and actual awards require eligible root and cast spells; new higher-rank learning requires eligible
root and desired spells. Already learned ranks are retained, and previously earned proficiency is not removed.
The new helper is a cached SkillLineAbility lookup, with no database query or casting mutation.

The menu applies the root acquisition state and marks ineligible unlearned roadmap ranks as missing
prerequisites, keeping its next-rank record consistent. Acquisition wait text now covers normal acquisition
requirements rather than naming only talents/specs. Native talent/item/specialization profile types remain
unsupported; this check does not claim complete acquisition entitlement.

Owner updates detect class, race, native active talent set and the cached CoA active specialization setting.
Detection schedules idempotent progress initialization, rank checks and a fresh snapshot without resetting
session awards. The CoA setting is read with FindPlayerSettings, avoiding the mutating/possibly database-backed
GetPlayerSetting fallback. Sending a snapshot no longer changes the initialized-class identity, so a request
received during a class transition cannot suppress the next owner initialization.

Candidate provenance additionally includes the shared eligibility, racial, Felsworn and AscensionCompat sources.
Discovery artifacts were regenerated, retaining 847 unapproved drafts and 179 common-outcome candidates.
Source/native build passed in `.cache/verify-all/20261005-151230/report.json`; changed C++ lint, whitespace and
five Lua 5.1 syntax compilations passed. An earlier build also passed at 151004 before the final preparation
eligibility check. No behavioral tests ran. Race/spec/slot/class transition and menu acceptance remain pending.
Production server/client/configuration/DB were not changed.

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
Only non-triggered, learned direct casts with effective hostile creature damage or friendly healing qualify.
Damage uses the hostile opponent directly, including lethal hits. Healing requires a live eligible hostile opponent
in the recipient's unsuppressed PvE combat references. Human sessions only; player opponents are excluded. The cast-owned marker limits multi-target hits to one award. Successful awards queue authoritative views
for the three abilities, coalesced to at most one snapshot every two seconds. Opening `/practice` requests a fresh snapshot; malformed, foreign and stale messages fail
closed. No rank is learned, removed or replaced; no combat power is modified. Utility/periodic/pet attribution,
training-exploit protection, final acquisition gates, owner-thread/cache lifecycle and network pacing still need runtime
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

## Paced refresh and availability

The development module stores menu timing and dirty flags by character GUID only, clears them on logout and
reinitializes them on login. Practice awards, character level changes and learning/forgetting a reviewed spell
queue a refresh; player updates flush the latest complete view when the two-second interval permits. Requests
share the same snapshot limit. Failed view construction stays dirty for a bounded retry. Unrelated actors, spells
and chat are filtered before taking the module lock. Observation requires an initialized menu session.

The addon requests a fresh view every ten seconds while open. A six-second unanswered request changes the menu
to unavailable and identifies retained data as a saved view. Only a complete validated snapshot clears that state.
Subsequent milestones add class-switch resynchronization and session totals; the full launch catalog remains pending.

Native source/build passed at `.cache/verify-all/20261005-042638/report.json`; the addon files compile as Lua 5.1
syntax. Timing, disconnect/reconnect, load/forget ordering and in-game presentation still need runtime acceptance.

## Authoritative session totals

Version-two snapshots add one mandatory `S|revision|available|uses|proficiencyGained` record before the end frame.
The addon validates decimal uint64 strings without converting them to floating-point numbers and refuses duplicate,
missing or malformed session parts before applying the complete snapshot. Version-one requests still receive the
original format; the new addon requests version two and can read both versions. Existing abilities retain their
version-one record layout. The existing transport fixture's expected request was updated; no new cases were added.

Session totals count only original casts which actually earned practice and proficiency gained after migration.
Starting proficiency seeded from learned ranks, capped uses and repeated hits do not increase them. Totals clear
on login/logout and are not persisted. Overflow explicitly makes totals unavailable rather than wrapping or showing
an exact saturated value. These totals currently cover only the three reviewed development abilities.

Source/native build passed at `.cache/verify-all/20261005-043328/report.json`; C++ lint, whitespace and Lua 5.1
syntax compilation passed. Protocol round-trip, counter behavior and gameplay acceptance remain unqualified.

## Search and tracked abilities

The menu includes My Skills, Upcoming and Tracked views. Its bounded search field filters displayed ability names
with a plain substring match. The detail pane toggles tracking for the selected ability; preferences are saved per
character and keyed by class and stable ability ID. They do not store or modify authoritative practice progress.
Login resets search/view selection while retaining tracking preferences. Hidden panels release keyboard focus.

The addon version is now `0.2.0-development`. The existing widget fixture gained only the edit-box methods needed
by the controls, without new cases. Source checks passed at `.cache/verify-all/20261005-043620/report.json` and
Lua 5.1 syntax compiled. Search/tracking behavior, persistence and client layout still need runtime acceptance.
No addon was installed, cataloged or published.

## Development encounter qualification

Opponent level uses `getLevelForTarget(player)` so the existing scaled encounter level is respected, using
the existing XP gray threshold (without requiring an XP award). Player-controlled creatures, pets, totems, critters and the two named core training
or target-dummy scripts do not qualify. Healing checks an actual live eligible opponent of its recipient instead
of using the friendly recipient's level or a generic caster combat flag. Effective hostile damage does not require
combat state after impact, so a killing blow is not excluded solely because that state ended. The original-cast
marker still deduplicates multi-target outcomes.

Source/native build passed at `.cache/verify-all/20261005-044148/report.json`; C++ lint and whitespace passed.
Lethal-hit, scaled/gray target, healing combat references and dummy behavior remain pending gameplay qualification.
These are conservative development rules, not approved PvP, encounter, frequency or deliberate-training policy.

## Raw action and pacing review evidence

The read-only all-class inventory now retains labeled effects/auras, triggered spell IDs, implicit target IDs and
raw cast/cooldown timing. Labels come from the existing reviewed inspector's native enum parser. Candidate groups
summarize direct, periodic, utility, scripted, pet/summon and triggered-attribution review traits without merging
helper spells into player abilities or approving classification. Raw cooldowns are not measured play frequency.

The current export covers all 21 classes and 4,969 candidates: 410 direct-outcome, 362 periodic-attribution,
76 utility-outcome, 105 pet/summon, 645 scripted-behavior and 1,934 triggered-attribution review candidates.
Traits overlap. There are also 134 candidates with unknown raw aura labels and 25 with unknown raw effect labels;
these remain explicit review gaps. Every candidate remains unapproved. Spell provenance still has a stale extraction
manifest and no observed SQL/runtime layer. No source metadata is promoted to effective gameplay evidence.

Source checks passed at `.cache/verify-all/20261005-044531/report.json`. The read-only exporters completed against
`C:/Azerothcore-CoA/server-data/dbc`, writing only this checkout's ignored cache. No new tests or runtime actions ran.

## Class-switch resynchronization

Tracked menu sessions watch the current class by GUID during player updates. A changed class queues a paced
snapshot. Other human classes can request an authoritative empty catalog, with session totals unavailable,
without receiving practice awards. Returning to Pyromancer restores its reviewed view and this login's retained
Pyromancer counters. No ability/progress settings are created for unsupported classes by viewing the menu.

Only a complete, validated, newer self-whisper server snapshot can reset the menu for a changed class. The
ordinary `ApplySnapshot` entry point still rejects class mismatches; transport uses a separate authoritative
entry point. Reset clears transient selection/search and keeps class-scoped tracked preferences. Empty catalog
and saved/unavailable views have explicit text. All default-off paths still return before practice work. While
development observation is enabled, human player updates check the GUID session map to detect class changes;
no player pointers are retained. The release catalog and multi-class session accounting remain future work.

Source/native build passed at `.cache/verify-all/20261005-044931/report.json`; C++ lint and Lua 5.1 syntax passed.
Slot/class switching, stale changed-class packets and relog/in-game behavior still require runtime qualification.

## Experimental rank-learning connection

`AbilityPractice.AllowDevelopmentRankLearning = 0` is an additional switch. Observation remains unchanged with
that switch off. All three enable/development/rank switches plus validated startup data are required for rank rules.
The module registers an optional atomic provider. Without an active provider, all ranks are unmanaged and normal
learning continues. Only stronger ranks of the three source-reviewed Pyromancer class-grant abilities are managed;
introductory spells, other abilities/classes and bots retain their normal acquisition behavior.

The provider reads cached practice, preserves currently known ranks or higher ranks, and evaluates level, practice
and the previous rank. Corrupt/incompatible records block new managed ranks. Normal `Player::learnSpell` consults
the provider before adding a new rank. Ascension class/generated progression consults it before counted grants.
Spellbook rows for unlearned managed ranks are unavailable before purchase/bulk learning; forged book requests
cannot fall through to another trainer path. Trainers also reject managed ranks, including direct learn-effect
targets, before charging. On the next eligible player update the module automatically learns ready ranks without a book fee.
The three introductory roots are class grants with no raw advancement-node references in the current review export;
this does not approve the same ownership rule for other abilities.

A narrow shared provider and three core learning/progression/trainer sites were needed because existing module
learn hooks run after the grant and cannot veto it or protect trainer charges. No Player header/ABI change, SQL,
per-cast query or launcher change was added. The public header belongs to the existing game Player include surface;
the first native build exposed an incorrect placement under CoA, corrected before the passing build.

**Not ready for activation:** load-time default/temporary helper routes, specialization/prestige restoration,
talent ownership/point charging, wrapped/nested trainer learning and all-class definitions still need integration
and runtime qualification. A saved inactive class has not yet had a full migration before restoration; do not enable
rank rules for a live character. The switch is intended only for future isolated qualification fixtures.

Source/native build passed at `.cache/verify-all/20261005-050036/report.json`; the failed placement attempt remains
`.cache/verify-all/20261005-045747/report.json`. C++ lint and whitespace passed. No runtime rank grants, trainer fee
checks, class changes or other gameplay cases were run. No server was installed, started or restarted.

## Menu interest and separate rank updates

A valid self-whisper request grants thirty seconds of snapshot interest. The open menu's ten-second requests
renew it; after interest expires the server retains dirty progress but stops automatic menu packets. Login does
not push unsolicited snapshots. Practice awards and session counters continue regardless of menu interest.
Snapshot sends still share the two-second interval, and opening the menu rebuilds the current full view.

Rank checks are separate dirty work scheduled by login, config changes, level/spell/class changes and awarded
practice. Only player updates perform automatic upgrades. Requests and effective-hit callbacks do not learn ranks.
The module releases its mutex before calling normal learning and reacquires the session by GUID afterward; it
holds no map iterator or session reference across learning callbacks. New learn events can queue another check.
Rank progress therefore works without the addon, with no per-tick catalog scan after the dirty work is handled.

Source/native build passed at `.cache/verify-all/20261005-052123/report.json`; C++ lint and whitespace passed.
Interest expiry/reopen, closed-menu advancement, reentrant callbacks and owner-context behavior still need runtime
qualification. The class-change module inspected here strips other class kits and clears specialization slots;
the reviewed slot structure stores class-scoped talent entries/actions, not a separate inactive class spellbook.
Further migration/restore work should follow these actual sources rather than assume an unobserved storage model.

## Gray targets and retained progress display

Effective damage to neutral or hostile creatures can qualify; friendly creatures remain excluded. Opponent level
uses the server's existing gray threshold and scaled target level. Healing requires a live eligible PvE opponent
with neither side of its combat reference suppressed. Dummy and player-controlled creature exclusions remain.
These are development qualification rules; PvP and deliberate training policy remain undecided.

The menu keeps learned trainable proficiency visible even when current level or prerequisites prevent practice.
Retained proficiency above a reduced cap is explicitly labeled saved, with a full cap bar. Availability text
separates practice restrictions from a new ability's unlock and does not promise a cap increase at every level.
Session totals are labeled class skills rather than implying the selected ability alone.

Source/native build passed at `.cache/verify-all/20261005-055814/report.json`; C++ lint, whitespace and Lua 5.1
syntax passed. Actual neutral/gray fights, healing reference suppression and retained-progress rendering remain
pending runtime qualification. No production server, database, launcher or active client was changed.

## Direct runtime grants

`Player::_addSpell` now consults the same optional rank provider before runtime spell-map changes or temporary
learn packets. This closes direct `addSpell` and recursive temporary-helper routes for the three managed
abilities while keeping the existing `learnSpell` check. Character loading is exempt: saved spells load before
practice settings, and blocking that restoration would conflict with preservation of existing ranks.

The loading exemption also means load-time default/baseline/skill helper grants require separate review; it is
not a complete acquisition boundary. Talent point and wrapped trainer fee validation must still happen before
costs, rather than relying on a low-level blocked grant. The default-off provider leaves ordinary learning alone.
Runtime temporary grants, restoration and cost behavior remain unqualified.

Source/native build passed at `.cache/verify-all/20261005-060450/report.json`; C++ lint and whitespace passed.
No runtime tests, installation or production changes were performed.

## Complete rank roadmap transport

Development addon `0.3.0-development` requests `HELLO|3`. The server retains version 1/2 responses for their
respective requests; version 3 carries mandatory session totals plus a declared per-ability rank count and one
record per rank. Every record includes server-derived level/proficiency requirements, acquisition/readiness state
and a cap-aware exact-use forecast. No character progress or rank grants occur when the roadmap is requested.

Encoding/assembly/model validation bound each ability to 64 ranks and the snapshot to 2,048 ranks, retain the
512-ability/240-byte record limits, reject duplicate/missing/out-of-range entries, and preserve uint64 counts as
strings. The model copies dense ordered roadmaps, checks unique spell IDs/nondecreasing requirements and matches
the next-rank view to its roadmap entry. The existing five-second assembly timeout remains; large all-class payload
throughput requires runtime qualification. Old snapshots omit roadmap data and hide the control.

The taller menu offers All ranks/Next rank views and three scrollable roadmap rows. Learned ranks, future level
requirements, prerequisite waits and available practice forecasts are visible. Known fixed abilities explicitly
show no practice requirement. Search, class tracking and retained-progress display remain. Future ranks can need
an earlier rank even when their proficiency threshold is already satisfied; that restriction is displayed.

Source/native build passed at `.cache/verify-all/20261005-073325/report.json`; C++ lint and whitespace passed.
Lua 5.1 syntax compiled using the previously cached runtime; the first syntax attempt omitted its import path and
was corrected. No new cases or behavioral tests ran. Packet round trips, incomplete version-3 snapshots, scrolling,
small-screen layout and in-game rendering still require acceptance. No production payload was installed/published.

## Nested trainer acquisition checks

A second optional provider checks trainer purchases before pricing/charging. The module returns immediately when
development rank rules are inactive or the actor is outside the reviewed slice. Active checks follow explicit
LEARN_SPELL targets through at most 128 unique spell IDs, deduplicate cycles, refuse missing references/overflow,
and reject purchases that reach an unlearned managed rank even when its practice requirements are ready (ready
managed ranks are learned automatically). Already-known managed targets can coexist with other legitimate grants.
Trainer listing and purchase share this state check; the previous immediate-only checks use this provider now.

This follows literal nested learn effects, not arbitrary scripts, triggered casts, runtime-selected spell IDs or
item learning. Those remain review gaps. It does not change talent buying or specialization restoration: paid
entitlements and preservation need an independent design before the broader catalog can manage such abilities.
Normal trainer behavior remains default with no purchase provider or with all module flags off.

Source/native build passed at `.cache/verify-all/20261005-074256/report.json`; C++ lint and whitespace passed.
The first build failed because an atomic variable shared the provider type alias's name; renaming the atomic
fixed compilation. That failed report is `.cache/verify-all/20261005-074109/report.json`. No runtime fee, cycle,
nested wrapper or off-mode cases ran, and no server was installed/started/restarted.

## Partial native acquisition filtering evidence

The raw advancement review now annotates the native loader's basic custom-class, class range and three-rank
filters, and distinguishes a reference belonging to another candidate class. Matching records remain pending:
class/tab specialization joins, identity-level overrides, byte-width normalization and dependency rules are
explicitly unresolved. No raw record is declared a character entitlement or production-approved ability.

The current export retains all 4,969 candidates across 21 classes. Of 3,956 candidate/node references, 15 refer to
non-custom class types and 10 to another custom class; 3,931 still need native review, across 3,929 candidates.
Counts refer to candidate/node references and can repeat the same raw node; they are not unique talent counts.
The exporter remains read-only and writes only ignored cache files. The menu now describes forecasts as using
current training rules, since its exact calculation can cross rate bands rather than use one constant rate.

Source checks passed at `.cache/verify-all/20261005-074726/report.json`; Lua 5.1 syntax passed. Raw exports completed;
no new behavioral cases or tests ran and no production data changed.

## Class-scoped profiles and sessions

Native integration now looks up class/spell profiles rather than a hard-coded class ID. Each immutable profile
owns its definition version, training policy and expected direct damage/healing outcome. Validation checks class
identity, catalog uniqueness within the class, policy/requirements, eventual rank reachability and wire bounds.
The same spell IDs can belong to different classes without merging their proficiency. Unreviewed/talent/spec/item
acquisition sources are rejected; only reviewed class grants are currently supported. The three existing
Pyromancer definitions remain the sole entries; no new abilities, rates or classes were approved by this refactor.

Startup also checks every effective SpellInfo for the declared direct outcome and logs mismatched class/ability/
spell IDs. Awards require that profile's expected outcome. Login seeding, menu views, rank checks and effective
awards use the profile's own policy/version. Fixed views skip migration/storage, although the native observation
slice still supports only the reviewed direct-outcome profiles and does not implement utility/passive mastery.

Enabled observation creates transient GUID sessions for all human logins, including unsupported classes, so a
later class change can begin progression without an addon request. Unsupported classes get no settings or awards.
Session counters are stored per class and displayed only for the current class; switching back retains that
class's login totals. Logout clears them. No Player pointers are retained.

Source/native build passed at `.cache/verify-all/20261005-075453/report.json`; C++ lint and whitespace passed.
Initial profile-only build also passed at `.cache/verify-all/20261005-075251/report.json`. No behavioral tests ran.
Multi-class duplicate IDs, independent policies, wrong effective outcomes, class switching without the addon and
session totals remain runtime qualification work. Production remains untouched and all three flags default off.

## Initialization independent of addon requests

Cached learned-rank migration is shared by login and first eligible owner update, and runs again on a class change.
An initialized flag distinguishes a menu-created transient session from one initialized by the owner lifecycle.
Already-online humans can therefore begin practice after re-enabling previously startup-validated observation
without an addon request. First eligible hits can create transient counters; they still use the authoritative
per-ability migration/award path. Loading-time updates/hits are excluded. Menu requests remain read-only.

Initial startup with observation off still needs an isolated restart to validate data; config reload alone does
not turn an unvalidated catalog on. Existing progress/session counters are retained when observation is toggled
within a login. Unsupported classes create no practice records. No extra query or per-tick catalog scan was added
after initialization/class change.

Source/native build passed at `.cache/verify-all/20261005-080044/report.json`; C++ lint/whitespace passed.
No behavioral tests ran. Re-enable without an addon, first-hit/update ordering, map/loading lifecycle and class
migration remain runtime acceptance work. No production actions occurred.

## Indexed profile lookup

When startup observation is requested, the validated immutable catalog builds an index by class/spell and a
per-class list in source order. Class membership and spell event lookup use that index; menu building, seeding
and rank updates visit only the actor's class. Keys include both 32-bit identifiers, retaining separate ownership
for shared spell IDs. Invalid catalogs yield no index entries. The source profile array, rank/cap data and policy
bands must outlive the index; native integration uses immutable static data and never replaces the index on reload.

Inactive learn/forget hooks return before lookup. An initially disabled module does not construct the index;
re-enabling startup-validated data retains it. No Player pointers or cast objects are stored in the index.
The registry still contains only the three reviewed development entries, not the full release catalog.

Source/native build passed at `.cache/verify-all/20261005-080446/report.json`; C++ lint and whitespace passed.
Final cleanup build passed at `.cache/verify-all/20261005-080724/report.json`. Throughput, shared-ID isolation and startup/
reload behavior remain runtime qualification work. No behavioral tests or production actions ran.

## End training at a defined benefit

Development caps retain the illustrative level curve but are bounded separately by each ability's final rank
requirement: Lava Shard/Cinderheart 160, Kindle 100. These are derived from the existing draft thresholds, not
new balance approvals. Learned-rank preservation and stored above-cap progress remain intact; no proficiency is
reduced or erased. Rank upgrades still need their separate character-level gates. The menu labels a capped,
fully learned ability Training complete instead of suggesting more benefit from additional uses.

Native profile validation now requires at least two ranks for Ranked and a final cap equal to the final rank
threshold. Mastery profiles are refused until explicit rewards and their integration exist. The generic pure
catalog/progression APIs remain unchanged; this does not invent rewards or reclassify any production ability.

Source/native build passed at `.cache/verify-all/20261005-081526/report.json`; C++ lint, whitespace and Lua 5.1
syntax passed. No new cases or behavioral tests ran. Final-cap awards, retained excess progress, level waits and
complete-state rendering remain runtime qualification work. The feature is still off and not deployed.

## Progress freshness and viewport fit

Development addon `0.3.1-development` timestamps only completed validated snapshots and shows their age while
current, refreshing or unavailable. One-second listener updates refresh the age label only while the panel is
shown; relog/class reset clears the timestamp. Client time measures receipt age, not server clock time.

The taller window scales to the available UIParent width/height with margins, clamps dragging to the screen and
refits when shown or display size changes. Nine ability rows use native spell icons with a question-mark fallback;
Upcoming rows show the next rank/new ability's level requirement directly. The widget fixture gained only the
viewport/scale methods required by these changes, with no new behavioral cases.

Source checks passed at `.cache/verify-all/20261005-082424/report.json`; whitespace and Lua 5.1 syntax passed.
No behavioral tests ran. Actual font wrapping, resize/dragging, age updates and in-game layout remain acceptance
work. Nothing was installed or published, and native protocol 3 is unchanged.

## Refuse malformed stored numeric tokens

Practice settings now use strict unsigned integer token parsing at both character login and offline settings
loads. Invalid syntax or overflow refuses the record instead of silently skipping tokens. Login retains a
present empty cache entry so the module refuses migration, training and new rank grants; normal saving skips
that entry and preserves the original database row. The diagnostic identifies the setting and character.
Offline updates stop on a failed numeric parse. Other settings retain their existing tolerant parser.

This checks numeric tokens only. The module still validates field count, schema, definition and migration
versions and progress bounds. It does not add generic offline schema validation, persistence acknowledgements
or recovery. No SQL or public parser interface changed.

Source/native build passed at `.cache/verify-all/20261005-083435/report.json`; C++ lint and whitespace passed.
No behavioral tests ran. Corrupt-row login, preservation and offline update behavior require isolated runtime
qualification. No live data was inspected or changed.

## Compare all-class candidates with current direct routes

The read-only candidate exporter compares every member's raw effect IDs against the native adapter's current
SCHOOL_DAMAGE (2) and HEAL (10) startup requirements. It records common routes across the entire claimed group,
blocked member IDs/reasons and per-class counts. Passive, missing, malformed or unsupported member evidence
prevents a common route. A chain whose members use different supported routes also needs adapter review.
These IDs are grounded in `src/server/shared/SharedDefines.h`; this is not a broader direct-effect classifier.

The current raw export contains 288 candidate groups with common routes across all 21 classes: 237 damage,
53 healing, with two groups having both. Of those groups, 175 are claimed rank groups. Existing three development
entries retain their expected raw routes. All 4,969 groups remain pending and productionApproved=false.
Raw route agreement does not prove effective SQL/C++ behavior, player acquisition, suitable practice rates,
original-action ownership or runtime qualification. It neither generates profiles nor enables more abilities.

Source checks passed at `.cache/verify-all/20261005-084424/report.json`; whitespace passed. Export generation
was read-only against the existing extracted DBC/inventory and wrote only ignored cache files. No tests ran.

## Fixed utility and passive profile support

Profiles can now declare Fixed with DirectOutcome::None. Validation requires this pairing, keeps a single
rank and no proficiency caps through the existing definition rules, and still limits acquisition to explicitly
reviewed ClassGrant. Native startup checks the fixed spell exists without requiring damage/healing or rejecting
its passive flag. Ranked profiles retain the existing nonpassive direct-outcome checks; None cannot be used
for a trainable profile, and Mastery is still refused until explicit rewards exist.

Fixed outcomes return before encounter checks, session creation and progress reads/writes. Existing menu
building exposes normal acquisition/level states, and a learned fixed entry uses the no-practice presentation.
No fixed production ability was classified or added; the three sample ranked profiles are unchanged. Protocol
3 has no persistent kind field, so an unlearned fixed entry currently uses normal introductory presentation;
full kind-specific upcoming labels remain future menu work.

Source/native build passed at `.cache/verify-all/20261005-084624/report.json`; C++ lint and whitespace passed.
No tests ran. Runtime fixed acquisition/display and passive behavior remain unqualified. No deployment occurred.

## Authoritative ability types in menu version 4

Development addon 0.4.0-development requests HELLO|4. Each ability requires a T record carrying its type
(1 Ranked, 2 Mastery, 3 Fixed); all version-3 roadmap/session records remain mandatory. The server still
answers HELLO|1/2/3 in their original formats, and the new parser accepts those snapshot formats. An older
server that does not recognize HELLO|4 requires its matching older addon; request fallback is not implemented.

Missing, duplicate, unknown and out-of-range type records refuse the whole snapshot. Typed fixed records
must have a single rank, proficiency/cap 1, zero training points/rate, unavailable practice forecasts and normal
learned/acquisition/level states. Nonfixed records cannot claim fixed availability. Existing numeric bounds,
rank/message/ability limits, exact string counters and atomic snapshot assembly remain unchanged. Native
AbilityView defaults to Ranked for existing callers; BuildAbilityView assigns the actual definition kind.

Unlearned fixed entries now say normal acquisition/no practice required, including their character-level wait.
Learned fixed entries say Learned ability/Fixed ability, omit the practice bar and hide the rank-roadmap toggle.
Normal ranked views keep their rank roadmap. No Mastery profile or reward is enabled by this metadata.
The existing request fixture expectation was updated to HELLO|4; no cases were added or executed.

Source/native build passed at `.cache/verify-all/20261005-085250/report.json`; C++ lint/whitespace passed.
All four addon files passed Lua 5.1 syntax compilation after a corrected missing closing parenthesis in menu
editing. Final addon source checks passed at `.cache/verify-all/20261005-085212/report.json`. No behavioral or
in-game tests ran; type transport, compatibility, fixed rendering and throughput remain runtime acceptance.
No active client/server/launcher files were changed.

## Match class-grant profiles to native acquisition data

Requested startup observation now verifies a profile's introductory spell and exact character-level gate
against AscensionCompatData::ClassSpells. Every native generated rank for that class/root must appear with
its exact spell ID and level in the profile, and every higher profile rank must have exactly one native entry.
An incomplete, extra, duplicate or foreign rank chain refuses catalog activation. Fixed class grants require
no generated higher ranks. Logs identify the rejected class/ability. Checks run only at requested startup;
no per-cast scan, query or player ownership pointer was added.

This is a narrow proof against the two active source arrays used by AscensionCompat progression. It does not
approve raw advancement/talent/item entries, rank numbering, effective spell behavior, runtime ownership,
racial conditions or future policy changes. Existing root ownership and per-rank prerequisite checks remain.
No new profiles were added; the three development definitions match the inspected native source rows.

Source/native build passed at `.cache/verify-all/20261005-085619/report.json`; C++ lint and whitespace passed.
No tests ran. Startup rejection and effective acquisition behavior remain isolated runtime qualification.
No production changes occurred.

## Per-ability session progress

Unreleased menu protocol 4's T record now includes the ability type plus availability, use count and proficiency
gained for that individual ability: T|revision|index|kind|available|uses|proficiencyGained. Addon version is
0.4.1-development. The earlier four-field development T shape is superseded; nothing using it was published.
Version 1/2/3 responses stay unchanged, and their parsed ability session totals are explicitly unavailable.

Native GUID sessions retain separate class totals and per-ability totals across class changes during a login.
Only OutcomeStatus::Awarded records one use and the actual proficiency gained; migration/seeding, capped,
rejected and duplicate outcomes do not inflate counters. Logout clears them. Individual counters retain their
own overflow availability independently of the class total. Fixed entries never award practice.
Typed views require validated per-ability session counters; uint64 values stay exact strings in the client.
The selected trainable ability displays This session practice uses and proficiency gained beside tracking.
The pure view builder defaults totals to unavailable; native Send supplies actual session data or known zero.
No per-ability history is persisted and no query was added.

Source/native build passed at `.cache/verify-all/20261005-085938/report.json`; final addon source checks passed
at `.cache/verify-all/20261005-090100/report.json`. C++ lint, whitespace and all four Lua 5.1 syntax compilations
passed. No cases added or behavioral tests ran. Award/class-switch/overflow/transport and in-game text layout
remain runtime qualification; production is untouched.

## Broader resolved direct effect support

The native adapter now recognizes direct school damage and all four weapon-damage effect forms, plus normal,
percentage and maximum-health heals. These effects feed the existing resolved damage/healing path inspected
in SpellEffects.cpp and Spell.cpp; the hook uses resolved damage and post-HealBySpell gain. No coefficient,
cast frequency, balance rate or core spell calculation changed. The existing positive-result, actor/ownership,
PvE and original-cast deduplication rules remain, with no helper/periodic/pet inference added.

The read-only comparison uses matching SharedDefines IDs: damage 2/17/31/58/121 and healing 10/67/136.
The current raw export now finds 404 groups across all 21 classes, including 234 claimed rank groups;
349 have damage and 57 healing routes, with two overlapping. This supersedes the narrow raw comparison's
288 count. All groups remain pending; raw support does not qualify acquisition/effective scripts/runtime.
No more than the existing three development profiles is enabled.

Source/native build passed at `.cache/verify-all/20261005-090344/report.json`; C++ lint/whitespace passed.
Read-only export generation wrote ignored cache files only. No tests ran. Individual weapon/heal routes,
script interactions, encounter outcomes and live rendering remain unqualified. Production is untouched.

## Successful interrupt outcome support

Profile outcome enum is now OutcomeKind (Damage, Healing, Interrupt, None). Trainable Interrupt profiles
must contain the native interrupt effect; fixed entries still require None. The existing successful-interrupt
hook fires after at least one interruptible cast is actually stopped. The module accepts eligible live PvE
opponents only and funnels awards through the same cached progress, known spell, actor, triggered-cast,
cap and once-per-original-cast checks as damage/healing. Idle targets do not produce this callback.
Damage/healing hit callbacks explicitly ignore utility profiles, preventing cross-route awards.

Common AwardOutcome centralizes counting, dirty state and paced refresh across outcomes. No core hook,
spell effect, interrupt duration or combat calculation was edited. No Interrupt profile was classified or added;
Mastery profiles/rewards remain unsupported and the three sample definitions retain their original routes.

Source/native build passed at `.cache/verify-all/20261005-090714/report.json`; C++ lint/whitespace passed.
No tests ran. Actual interrupt, idle/immune/miss cases, original-cast deduplication and PvE qualification remain
runtime acceptance. All development activation flags remain off by default; production is untouched.

## Successful dispel and beneficial-aura steal support

OutcomeKind adds Dispel and Steal through existing post-success callbacks. Trainable profiles require native
DISPEL or STEAL_BENEFICIAL_BUFF effects respectively. A positive native success count is required; multiple
removals/targets/effect slots still award at most once through the original cast marker. Ordinary hit processing
ignores utility routes. Interrupt, dispel and steal share AwardUtilityOutcome and the cached award path.

Defensive dispels require a friendly live recipient with a live, unsuppressed qualifying PvE encounter;
offensive dispels/steals and interrupts require eligible live PvE opponents. Actor, learned-spell, loading,
triggered-cast, passive, cap and corruption protections remain. Native success means its success list was
applied; per-spell script interactions still need qualification. Mechanic-only dispels, resurrection, absorbs,
periodic support and pets are not inferred from this callback. No core behavior or dispel/steal calculations
changed, and no utility profile or mastery reward was enabled.

Source/native build passed at `.cache/verify-all/20261005-091054/report.json`; C++ lint/whitespace passed.
No tests ran. Actual removals/transfers, resists/empty lists, PvE support, deduplication and script behavior remain
isolated runtime qualification. Development flags default off and production remains untouched.

## Selected rank's character-level requirement

Addon 0.4.2-development shows the selected display spell's required character level beside its learned rank
(or fixed ability label), using the authoritative roadmap entry. Unlearned legacy views can use their next-rank
requirement; learned legacy views without a roadmap omit this value instead of guessing. This is the rank's
character-level requirement, not a raw DBC effect/scaling level. Protocol 4 and counters remain unchanged.

Source checks passed at `.cache/verify-all/20261005-091320/report.json`; whitespace and all four Lua 5.1
syntax compilations passed. No tests ran. Text layout and display during upgrades remain in-game acceptance.
No active client or launcher payload was updated.

## Spellbook entry point

Addon 0.4.3-development adds a Practice button to AscensionSpellbookFrame when present, with SpellBookFrame
as a fallback. Read-only inspection of the saved CoA SpellBookFrame stub and launcher ElvUI skin established
that the custom Ascension frame is the relevant parent; no active client file was modified. The entry listens
for login, addon load and combat exit, defers creation/reparenting during combat and reuses one button if the
custom frame becomes available after the fallback. No polling, secure action mutation or server request is
performed by attachment. Clicking uses the existing menu toggle/request path; /practice remains available.

The top-right header placement is a development position that still needs acceptance with CoA/ElvUI skins.
Source checks passed at `.cache/verify-all/20261005-091901/report.json`; whitespace and all five Lua 5.1 syntax
compilations passed. No tests ran. Load order, combat deferral, custom/fallback parent, click behavior and actual
layout remain unqualified. The addon is not installed or published.

## Narrow saved-rank restoration during login

The private spell-add guard no longer exempts every action while Player::isBeingLoaded is true. Only an exact
spell row restored by _LoadSpells gets the saved-rank exemption. A scoped SavedSpellRestoration records the
nonzero character GUID and spell ID on the loading thread, supports nested restoration by restoring previous
values at scope exit and retains no Player/Spell pointers. The private guard requires both loading state and
an exact saved-row match. Default/custom/skill/helper additions with other IDs consult the active rank policy.
The public spell-add signatures and character settings/DB load order are unchanged.

This preserves explicit saved ranks without treating loading as general authorization for new stronger ranks.
Absent/inactive providers still allow ordinary behavior. Derived talent/equipment ownership, saved helper
reconstruction and future non-ClassGrant profiles remain separate integration work; this does not blanket
approve helpers merely because their parent is saved. Current three profiles remain class grants only.
The source gap was established from _addSpell's broad loading exemption and LearnCustomSpells direct additions;
no live exploit or runtime reproduction was observed.

Source/native build passed at `.cache/verify-all/20261005-092402/report.json`; final nonzero-context guard build
passed at `.cache/verify-all/20261005-092728/report.json`. C++ lint and whitespace passed. No tests ran.
Actual login/restoration/default/skill/helper interactions, nested/thread isolation and feature-off equivalence
remain runtime acceptance. No production server, data or active client was changed.

## Versioned per-ability practice explanations

Addon 0.4.4-development adds a selected-ability help tooltip. Unreleased protocol 4 T now has nine fields:
T|revision|index|kind|available|uses|proficiencyGained|route|ruleSet. Earlier development T shapes are superseded;
none was published. Native Send maps the validated profile outcome explicitly to stable routes 1..6 and stamps
HumanPvERuleSet=1. Unknown rules/routes or fixed/type mismatches refuse typed encoding and client validation.
The pure builder defaults rules/route unknown; it cannot invent a rule for an arbitrary definition.

The tooltip describes the selected current route: effective damage, effective encounter healing, actual
interrupt, native successful dispel or beneficial-aura steal; fixed entries say no practice. It explains the
shared low-level/player-controlled/pet/totem/critter opponent exclusions, learned/triggered-cast rules,
once-per-cast accounting and cap. Saved views are marked explicitly; older formats with unknown rules show
unavailable rather than guessing. The tooltip closes when its owner hides. Recognized dummy-script exclusion
is still a native qualification rule; the explanatory text does not enumerate every creature-specific filter.
This is the current human/PvE development rule set, not approval of final bot/PvP/training policy.

Source/native build passed at `.cache/verify-all/20261005-093333/report.json`; final addon source checks passed
at `.cache/verify-all/20261005-093503/report.json`. C++ lint, whitespace and all five Lua 5.1 syntax compilations
passed. No tests ran. Rule transport, tooltip accuracy against real outcomes, rendering and skin/owner behavior
remain runtime acceptance. No active client/server/launcher changes occurred.


## Next character level for more practice capacity

Addon 0.4.5-development shows the next character level that permits additional proficiency and its cap.
Unreleased protocol 4 adds mandatory C per ability: C|revision|index|0, or
C|revision|index|1|characterLevel|proficiency. Missing, duplicate, invalid or fixed-ability cap metadata is
refused. Earlier development shapes were not published. Older protocol formats are preserved.

The authoritative builder searches above both the current cap and retained proficiency, adjusts eligibility
for the introductory rank's level and evaluates the cap at that actual level. This avoids promising further
training when retained progress already exceeds the next cap. Capped wait text shows the level/cap; help also
shows future capacity. Terminal definitions distinguish a highest cap with room remaining from no further
practice capacity. No thresholds, caps, rates or stored progress changed.

Source/native build passed at `.cache/verify-all/20261005-094252/report.json`; final addon source checks passed
at `.cache/verify-all/20261005-094400/report.json`. C++ lint, whitespace and all five Lua 5.1 syntax compilations
passed. No tests ran. Sparse/plateau caps, introductory levels, reduced levels, retained excess, terminal
states, transport and rendering remain runtime acceptance. Production server/client/launcher are untouched.


## Explicit unreadable-progress menu response

Addon 0.4.6-development receives unreleased protocol-4 F|4|revision|class|ability|introSpell|1 when the native
menu cannot safely migrate/read a selected profile's cached progress. This replaces a generic timeout for
that condition; old protocol formats retain the existing unavailable path. The response has bounded numeric
identities and a single stable issue code, contains no stored payload and does not perform recovery or DB writes.
Native Send stops before emitting a partial snapshot; the first affected definition is reported.

Wire validates failure metadata independently of snapshot assembly, refuses stale failures, clears incomplete
assembly on accepted failure and passes a separately validated DTO to the menu. Transport clears its request
deadline. The menu retains same-class saved data and its last successful timestamp, records the failure's
revision to refuse older later updates, clears the view on class changes and clears the issue after a newer
valid snapshot. Retry/age behavior remains. The text says saved progress could not be read safely rather than
claiming corruption; it identifies the ability and asks the player to report the issue. Affected practice/rank
mutation remains refused; other valid abilities are not globally paused. No stored record is replaced.

Source/native build passed at `.cache/verify-all/20261005-095928/report.json`; C++ lint/whitespace and five
Lua 5.1 syntax compilations passed. No tests ran. Failure/recovery, ordering/expiry, saved age, class changes,
layout and DB preservation need runtime acceptance. All defaults remain off; production remains untouched.


## All-class native outcome comparison

Candidate discovery retains its direct-only fields and adds nativeOutcomeReview for the current five native
routes. Shared raw-member validation refuses missing/invalid evidence and passive members; a route must occur
in every member. Native effect IDs for utility routes were read from SharedDefines.h (dispel38, interrupt68,
steal126). Mechanic-only dispel, resurrection, leech, periodic and scripted/helper behavior are not inferred.

Read-only regeneration found 444 common-route groups across the 21-class inventory, compared with 404
direct-only groups. Route counts (overlap possible): damage349, healing57, dispel26, interrupt17, steal2.
All classifications and effective acquisition/outcome behavior remain unreviewed, productionApproved=0.
No runtime profiles, thresholds or class coverage were enabled by this discovery output. The ignored artifact
is `.cache/ability-practice/catalog-candidates.json`. Source checks passed at
`.cache/verify-all/20261005-100224/report.json`; Python syntax and whitespace passed. No tests ran; this was
source/data discovery only. Production was untouched.


## Bounded typed-menu delivery

Protocol-4 snapshots and progress failures now queue only numeric/string messages in the GUID-keyed native
session and send at most eight messages per100ms. Batch timing carries across snapshot completion/cancellation
so immediate replacement cannot create a second batch in the same interval. No Player/Spell pointer is retained.
The queue is bounded by the encoder's512abilities/2048ranks/240-byte-line limits and5123messages, with a90s
absolute lifetime. Completion/cancellation releases its vector storage. Already-started snapshots may finish
past the30s interest window; new snapshots still require interest. Practice changes during delivery mark a
new snapshot dirty and do not restart the current stable capture. Old protocols preserve immediate delivery.

Class changes, protocol changes, config reload/disable and logout/login cancel queued data. Expired queues
leave dirty state for a later eligible refresh. The receiving addon0.4.7-development uses a6s idle deadline and
90s absolute assembly deadline for typed snapshots; older schemas retain5s total. Only accepted messages
advance idle time. Transport follows assembly deadlines and marks the saved view refreshing; malformed/stale/
unrelated messages do not prolong assembly. A complete validated snapshot is still the only progress update.
Pacing changes no practice, rank, session counters or storage. Maximum-size snapshots can take about64s even
at the intended batch cadence; this is a bound, not an acceptable final all-class latency target. A compact or
delta format may still be needed after actual size/throughput measurement.

Source/native build passed at `.cache/verify-all/20261005-100646/report.json`; C++ lint/whitespace and five
Lua5.1 syntax compilations passed. No tests ran. Tick cadence, cancellation, ordering/idle/absolute timeouts,
changed progress during delivery, memory/packet cost and maximum real-class latency remain runtime acceptance.
Production server/client/database/launcher are untouched; development flags default off.


## Source-consistent class-grant review candidates

Candidate discovery adds nativeClassGrantReview with exact source rows/levels and raw rank order. Root grants
must have one non-reference ClassSpells row; higher members must each have one generated-progression row.
Levels must fit native/profile1..255, ranked raw numbers must be contiguous1..N with the grant first and
nondecreasing native levels, and chains fit64ranks. Missing/duplicate/conflicting rows and order are blocking
flags. sourceChainConsistent denotes only this source comparison, never runtime entitlement or balance approval.
Standalone groups explicitly still need fixed/mastery classification and effective behavior review.

Read-only regeneration found847source-consistent grant groups:244ranked and603standalone, with4122groups
lacking a class-grant root.179groups also have a common current native outcome (106ranked,73standalone),
covering all21classes. Their route counts overlap: damage131/healing26/dispel15/interrupt7/steal2.
This narrows review work without expanding the three native development profiles, approving rewards/rates,
or bypassing talent/spec/item/other acquisition routes. ProductionApproved remains0. Source checks passed
at `.cache/verify-all/20261005-101017/report.json`; Python syntax/whitespace passed. No tests ran; no runtime
or production change occurred. Effective SQL/scripts/DBC normalization and real ownership remain unqualified.


## Compact typed-menu packets

Unreleased protocol4 can carry D|revision|kind|fields;kind|fields... envelopes for ability/rank records
(A,C,P,R,T,K,L). Repeated revision values are supplied by the envelope. Header, session, snapshot end and
failure records remain individual, preserving the atomic completion boundary. Native packing retains order,
bounds each packet to240bytes and32subrecords, and sends individually any record too large for an envelope.
Older schemas are unchanged. Native pacing operates on physical packed packets; queue count/byte/time bounds
remain. This reduces redundant framing and combines small records, without a claimed runtime speedup.

Addon0.4.8-development validates envelope size, canonical revision, current typed assembly and subrecord
kind/count, then routes each reconstructed part through the existing strict parser. Empty/nested/boundary/
malformed/duplicate parts refuse and discard the whole pending assembly. An unrelated revision does not
extend deadlines; only a wholly accepted envelope advances idle time. No complete snapshot can be committed
inside an envelope, and all model/roadmap/cap/rule/counter validation remains at the separate snapshot end.
Unpacked typed messages still work. The superseded development formats were never published.

Final source/native build passed at `.cache/verify-all/20261005-101411/report.json` (initial build101317);
C++ lint/whitespace and five Lua5.1 syntax compilations passed. No tests ran. Packing/unpacking/boundaries/
malformation/order/timeout, exact counters and real packet/latency reduction need runtime acceptance.
No production changes or active addon installation occurred.


## Provenance-checked definition draft export

`tools/profile_drafts.py` exports source-consistent class-grant groups into structured unapproved drafts.
Before export it checks every inventory source hash/path within the chosen repo, the Spell.dbc directory/hash
and native DBC schema source hash. Changed/foreign/missing evidence refuses export. It validates bounded
unique class/ability/rank identities, source level/rank order, raw outcome names and contradictory approval/
consistency markers. This verifies artifact provenance and structure, not effective runtime ownership.

Each draft carries source rank IDs/character levels/raw names, available outcome routes and review flags.
Definition version, kind, selected outcome and proficiency requirements remain null; caps, training bands and
mastery rewards remain empty. It explicitly requires effective-data/classification/acquisition/outcome/rates/
migration/menu/gameplay review; standalone entries also need mastery-or-fixed design. There is no runtime
profile writer, loader, auto-approval or default balance tuning. Export does not change server behavior.

Actual source/data export produced847drafts across21classes:244ranked source groups,603standalone and179
with a current common outcome. Output `.cache/ability-practice/profile-drafts.json` is ignored. Example:
`py -B modules/mod-ability-practice/tools/profile_drafts.py --candidates .cache/ability-practice/catalog-candidates.json
--dbc C:/Azerothcore-CoA/server-data/dbc --output .cache/ability-practice/profile-drafts.json`.

Final source checks passed `.cache/verify-all/20261005-102154/report.json` (initial102105); Python syntax and
whitespace passed. No tests ran. Provenance-rejection paths and eventual reviewed-profile import remain
qualification; export is a planning/source artifact only. Production remains untouched.


## Server-instance-scoped menu revisions

Native observation initializes a nonzero64-bit server-instance nonce at enabled startup using the existing
urand uint32 distribution; it stays fixed across config reloads. This is an ordering identifier, not an auth
secret or a persisted character value. Unreleased protocol4 B gains a seventh generation field and F gains
an eighth generation field. Typed encoding refuses zero identity; older formats preserve their shapes.

Addon0.4.9-development validates the identity as a canonical nonzero uint64 decimal string, preserving exact
values beyond Lua's integer range. Header/failure stale checks use revision ordering within the same identity;
a new instance permits a low revision and discards old pending assembly. Transport and menu reset their
revision floors on an accepted new identity, retain the same-class saved view/last-success age and mark it
refreshing. Only a full valid snapshot or explicit failure completes the new response. Class changes still
clear incompatible saved data. Same-instance stale updates remain refused. Login resets the client identity;
config reload does not reset it. Saved class/ability session totals are explicitly labeled saved until current.

This addresses the source-level restart counter-reset issue; no server restart/reconnect was performed.
Random nonce collision is theoretically possible; no stronger uniqueness or authentication property is claimed.
Protocol4's earlier development shapes were never published and are superseded. D packed records inherit the
current header's instance context. No character progress, counters, learning or DB schema changed.

Source/native build passed `.cache/verify-all/20261005-102712/report.json`; final addon source checks passed
`.cache/verify-all/20261005-102842/report.json`. C++ lint/whitespace/five Lua5.1 syntax compilations passed.
No tests ran. Real restart/reconnect, new-instance failure first, partial assembly, same-instance stale/class/
reload behavior, exact64-bit identities and saved labels require runtime acceptance. Production untouched.


## Route-specific mixed-result qualification

Direct result qualification now takes the profile's selected outcome. Damage profiles require effective
damage against the eligible PvE opponent; healing profiles require effective healing of a friendly recipient
in a qualifying live encounter. A mixed damage/healing callback cannot use its other result to bypass the
configured route's target/encounter requirements. Utility routes still use their separate successful callbacks.
Per-cast deduplication, current eligibility and progression behavior are unchanged.

This closes a source-level OR-condition gap; no live exploit or reproduction was observed. Source/native
build passed `.cache/verify-all/20261005-103115/report.json`; C++ lint/whitespace passed. No tests ran.
Mixed-result/friend/enemy/zero-effect behavior remains runtime acceptance. The same three development profiles
remain, all development flags default off, and production was untouched.


## Early cast-source qualification

The existing CanPrepare hook records eligible profiled human cast source before reagent/item consumption and
instant execution. OnSpellPrepare was unsuitable because instant spells can already have resolved at that
point. The module always returns true and does not change cast validation/gameplay. Its distinct Spell script
key stores only the preparing class/spell pair, or a refusal sentinel; no pointers or DB work are retained.
Eligible preparation has no cast item/GUID, no aura-trigger argument, no triggered flag and the same original
caster GUID. All native award routes require a matching class/spell stamp before the existing outcome adapter.
Unknown preparations (including casts begun while disabled), item casts, aura helpers and cross-class casts
are refused for practice. Current ownership/effective outcome/cap/corruption/dedup checks still apply.

This preserves origin evidence before m_CastItem/m_castItemGUID can be cleared. It does not prove a client
opcode initiated the cast: arbitrary scripts creating ordinary casts without item/aura/trigger metadata still
need helper attribution review. It adds no periodic/parent-cast grouping, mastery rewards or new profiles.
Addon0.4.10-development help explicitly excludes item casts/aura helpers. No final deliberate training/PvP/
bot policy is implied. Source hook ordering was inspected; no live exploit or runtime reproduction observed.

Source/native build passed `.cache/verify-all/20261005-103605/report.json`; C++ lint/whitespace and five
Lua5.1 syntax compilations passed. No tests ran. Instant/delayed/item/reagent/aura/triggered/class-change/
disable transitions, script interaction and original-action attribution remain runtime acceptance.
Production server/client/database/launcher untouched; all flags default off.


## Avoid script-name copies during encounter qualification

The opponent filter now reads ObjectMgr's current script-name reference using Creature::GetScriptId, matching
Creature::GetScriptName's implementation while avoiding that wrapper's string-by-value copy per check.
It compares the same two dummy-script names, keeps the reference local and changes no eligibility policy.
No startup name cache, pointers retained beyond the callback or new DB calls are introduced. No runtime
performance improvement is claimed. Source/native build passed at
`.cache/verify-all/20261005-103935/report.json`; C++ lint/whitespace passed. No tests ran; runtime equivalence
and cost still require qualification. Production untouched.


## Keep menu identity separate from gameplay randomness

Server-instance nonce initialization now uses the existing CryptoRandom eight-byte utility, folded into a
uint64 with zero mapped to1. It does not consume native gameplay urand draws. Enabled-startup-only creation,
reload stability, public ordering-only use, theoretical collision and exact-string protocol semantics remain.
The prior urand implementation above is historical and superseded. No character/progress/network auth logic
changed. Source/native build passed `.cache/verify-all/20261005-104244/report.json`; C++ lint/whitespace
passed. No tests ran; instance creation/restart/lifecycle remains runtime qualification. Production untouched.


## Native adapter provenance in review artifacts

Candidate output now records nativeOutcomeSources hashes for AbilityPracticeServer.cpp, AbilityPracticeProfiles.h
and SharedDefines.h. Draft export requires exactly those paths, validates their current bytes alongside the
inventory/DBC provenance and retains them in output. A later native edit requires candidate regeneration;
older artifacts without these hashes cannot export. This is provenance checking, not proof of effective
routing or entitlement. Real read-only regeneration retained444outcome candidates/179class-grant outcome
candidates/847unapproved drafts across21classes. No runtime profile or balance was activated.
Source checks passed `.cache/verify-all/20261005-104729/report.json`; Python syntax/whitespace passed.
No tests ran; rejection cases remain qualification. Production untouched.


## Original-cast periodic development path — 5 October 2026

A startup-only `AbilityPractice.AllowDevelopmentPeriodicObservation` flag enables optional native periodic
observation and selects two additional development profiles: Cindergrip (Pyromancer, class 24, root 805476) and
Shadra's Prayer (Venomancer, class 29, root 800870). Their five and ten authored rank levels come from the complete
source class-grant/progression chains. Requirements, caps and training bands reuse illustrative development
values; they are not final balance. Selected effective SpellInfo and chain checks still gate activation at startup.
Observation/rank learning retain independent enable flags; every supplied default remains disabled.

A numeric shared cast receipt is created only for eligible profiled human client casts in this mode. Spell and
Aura own it without retaining Player/Spell pointers. Native direct results and eligible periodic damage, percent
damage and healing consume the same receipt once. Multiple targets/effects/ticks cannot create extra practice
uses for that original cast. A capped qualifying result also consumes the receipt. No global action registry,
time-based deduplication expiry or DB query was added. A null shared pointer adds storage to each Spell/Aura,
even when disabled; no runtime performance/cost measurement is claimed.

The receipt is passed into native aura create/refresh before application or reapplication processing, including
persistent area auras. Refresh from an unqualified source clears earlier provenance. Tick observers snapshot the
receipt before result callbacks so reentrant refresh cannot relabel that completed tick. Numeric login/context
epochs reject pending awards after logout, class/race/talent-set/custom-specialization changes or config reload.
Saved/restored auras do not acquire fresh-cast provenance. Helper spells and leech/funnel/regen replacements are
not silently credited. Runtime application/refresh/death/reentrancy behavior still requires qualification.

Shadra's Prayer's native healing effect can qualify while its auxiliary effect remains excluded. Inspected
AscensionVenomancerContracts.cpp changes its auxiliary effect to a periodic dummy and clears its trigger;
AscensionVenomancerAuras.cpp handles that slot separately. Manafeed was deliberately excluded: inspected
AscensionFelswornAuras.cpp prevents the default tick and directly performs a mana drain/heal. This demonstrates
why raw DBC periodic traits alone do not prove effective routing. No replacement-tick observer is implemented.

The menu accepts rule set 2 and describes periodic eligibility/one use per original cast. Rule set 1 remains
direct-only. Unpublished protocol-4 record shapes and addon version 0.4.10-development are unchanged. Discovery
provenance covers the receipt, spell/aura/unit plumbing and periodic sample header; automatic candidate routing
remains conservative and does not approve periodic definitions.

Main worktree source commit `a5ea9902f` has source/style/whitespace/Lua syntax passes and its native build is
still running at `.cache/verify-all/20261005-153458/report.json`; its first build was stopped after a missing
AuraEffect friend declaration, corrected before the retry. Catalog additions are developed separately while
that checkout remains stable. Their source-only checks passed in the catalog worktree at
`.cache/verify-all/20261005-155041/report.json`; native integration/build remains pending. No behavioral tests
were added or run. No production server/client/configuration/database/launcher change was made.


## Broader ranked development catalog — 5 October 2026

`AbilityPractice.AllowDevelopmentRankedCatalog = 1` selects 106 source-consistent ranked class-grant profiles
covering 888 authored ranks across all 21 custom classes. It takes priority over the representative sample flag;
otherwise the three-profile or 23-profile modes remain available. Adding periodic observation yields 108
profiles. The new flag defaults off and is read only at startup. It never enables observation or learning by
itself. Native exact grant/chain/effective-outcome checks still guard every selected profile; one invalid
selected definition keeps the module inactive rather than silently running a partial catalog.

`tools/ranked_development.py` verifies current source/DBC provenance, builds existing unapproved drafts, then
selects ranked groups with a raw common outcome route. It requires all 21 custom class IDs. Route priority is
damage, healing, interrupt, dispel, steal; the two mixed damage/utility groups deliberately use their damage
route. The resulting 82 damage and 24 healing profiles share the existing illustrative training schedule.
Authored character levels are retained; proficiency follows 1/10/20/40/60/... and caps reuse the existing draft
curve. Earlier representative profiles use the same definitions/rates. Neither generated code nor a successful
startup validates balance, complete ownership or actual outcome behavior. Raw/effective differences can still
reject definitions, and scripted replacements can still need individual review.

`AbilityPracticeDevelopmentRanked.h` is a saved deterministic development artifact, with its generator included
in native provenance. Candidate regeneration is required after native/header/generator changes. Regenerate
the header from the newly verified candidates, then refresh candidates again if the emitted bytes changed.
This authoring path does not mark drafts production-approved. Standalone/unranked/passive/pet/helper and blocked
ranked groups are excluded. Remaining class abilities still require individual classification and implementation.

Source-only checks passed `.cache/verify-all/20261005-155720/report.json` in the catalog worktree; changed C++
style and whitespace passed. Discovery regeneration retains 847 unapproved drafts/179 outcome candidates,
with 22 native source provenance entries. The original native rebuild remains running in the frozen main
worktree. Integration and incremental native build of these catalog additions remain pending. No behavioral
tests ran and no production server, config, database, launcher or client was changed.
