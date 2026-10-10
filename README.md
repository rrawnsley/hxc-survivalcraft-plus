# HXC SurvivalCraft+ CoA source

This checkout is the HXC CoA realm source. It includes the HXC integration of CoA Custom 1.4 race appearance and
creation support, combined with the current HXC AzerothCore and CoA Bots code.

The standalone package under `apps/coa-custom` targets the separate Jealous-Sound CoA repack. Its installer replaces
that repack's server binary and applies a world database snapshot for an older base; it is not the deployment path
for the HXC realm. HXC server changes use this source tree and the migrations under `data/sql/updates/`.

The client race files are distributed through the signed CoA profile in the HXC launcher repository. Do not copy the
standalone release's prebuilt server binary over the HXC live server.
