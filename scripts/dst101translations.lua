-- =============================================================================
-- dst 101 translations
--
-- lists each handbook translation by language code, with the topics it
-- translates. dst101data.lua keeps English for every topic and string a
-- translation leaves out.
--
-- a translation lives in scripts/dst101translations/<code>/:
-- - strings.lua returns the interface strings it translates, keyed as in
--   dst101data.lua's ENGLISH_STRINGS.
-- - <topic>.lua is a translated copy of scripts/dst101topics/<topic>.lua
--   with the same id. its tags are searched in that language.
--
-- codes follow the game's own (LOC.GetLocaleCode(): fr, de, ru, ...), so the
-- "Game language" option finds them. a language the game does not offer,
-- such as nb, needs its own entry in modinfo.lua's language option.
-- docs/development.md covers fonts and fit.
-- =============================================================================

return {
    -- nb = { "setting_out", "survivors" },
}
