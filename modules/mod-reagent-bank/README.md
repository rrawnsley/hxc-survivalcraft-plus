# CoA Reagent Bank

Ling the Reagent Banker provides personal reagent storage in Stormwind and Orgrimmar. The service stores trade goods and gems from a character's bags, lets the character withdraw available stacks, and keeps each character's contents in `custom_reagent_bank`.

The module is enabled by `ReagentBank.Enable`. Its character and world database migrations are in the matching `pending_db_*` directories. Apply them with the normal worldserver updater before starting the service.
