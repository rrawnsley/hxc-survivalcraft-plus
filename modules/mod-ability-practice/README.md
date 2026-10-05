# Ability practice — development foundation

This module is under development on `codex/ability-practice`. Its first checkpoint implements the deterministic
practice policy shared by future server awards and menu forecasts. There is no loader, player hook, database
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
rank identity, persistence, acquisition enforcement, migration and versioned addon snapshots remain future stages.

The future menu will distinguish character level, learned rank and trained proficiency, with exact qualifying uses
to the next point/milestone. No random fizzles, magic-school categories or automatic upgrades on unrelated abilities
are part of the accepted design. Existing learned abilities must survive migration. Unranked rewards and numerical
training profiles still need balance review.

Verification runs through `python -B tools/verify_all.py --stages source,harness --base 36117f3e9
--harness ability_practice --jobs 1`. This focused harness compiles the actual header and exercises forecast/award
agreement, changing bands, over-cap retention, malformed inputs, large counts and milestone wait states. It neither
builds a worldserver nor accesses any server/database. Full build and gameplay qualification remain required before
integration or deployment. Keep all development in this checkout while the user plays.
