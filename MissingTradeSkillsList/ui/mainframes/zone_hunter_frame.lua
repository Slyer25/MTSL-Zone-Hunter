-- Zone Hunter: cross-profession view for Vanilla 1.12 / TradeSkillsData.
-- No additional database required. Source attribution uses the original MTSL data.
MTSLUI_ZONE_HUNTER = { zone_index = 1, page = 1, rows = {}, zones = {}, show_all = false, selected_id = nil, detail_page = 1 }

function MTSLUI_ZONE_HUNTER:Name(record)
    if not record then return "Unknown" end
    if type(record.name) == "table" then
        return record.name[MTSLUI_CURRENT_LANGUAGE] or record.name.English or "Unknown"
    end
    return record.name or "Unknown"
end

function MTSLUI_ZONE_HUNTER:AddSource(sources, kind, name)
    local text = kind .. ": " .. name
    for _, v in ipairs(sources) do if v == text then return end end
    table.insert(sources, text)
end

function MTSLUI_ZONE_HUNTER:NPCZone(npc)
    -- Separate, editable correction: Caryssia is at the Feralas / Thousand Needles border.
    if npc and self:Name(npc) == "Caryssia Moonhunter" then
        for _, zone in pairs(TRADE_SKILLS_DATA.zones) do
            if self:Name(zone) == "Feralas" then return zone.id end
        end
    end
    return npc and npc.zone_id
end

-- Instance vendors/mobs are grouped under the outdoor parent for zone-first browsing.
-- Keep original instance names in acquisition details.
function MTSLUI_ZONE_HUNTER:SourceInZone(source_zone_id, selected_zone_id)
    if source_zone_id == selected_zone_id then return true end
    if not source_zone_id or not selected_zone_id then return false end
    local source_name = MTSL_LOGIC_WORLD:GetZoneNameById(source_zone_id)
    local selected_name = MTSL_LOGIC_WORLD:GetZoneNameById(selected_zone_id)
    local parent_zones = {
        ["Blackrock Depths"] = "Blackrock Mountain",
        ["Blackrock Spire"] = "Blackrock Mountain",
        ["Dire Maul"] = "Feralas",
        ["Uldaman"] = "Badlands",
        ["Scholomance"] = "Western Plaguelands",
        ["Stratholme"] = "Eastern Plaguelands",
        ["Gnomeregan"] = "Dun Morogh",
        ["Scarlet Monastery"] = "Tirisfal Glades",
        ["Maraudon"] = "Desolace",
        ["Razorfen Kraul"] = "The Barrens",
        ["Razorfen Downs"] = "The Barrens",
        ["Wailing Caverns"] = "The Barrens",
        ["The Deadmines"] = "Westfall",
        ["Deadmines"] = "Westfall",
        ["The Stockade"] = "Stormwind City",
        ["The Temple of Atal'Hakkar"] = "Swamp of Sorrows",
        ["Sunken Temple"] = "Swamp of Sorrows",
        ["Blackfathom Deeps"] = "Ashenvale",
        ["Shadowfang Keep"] = "Silverpine Forest",
        ["Ragefire Chasm"] = "Orgrimmar",
        ["Zul'Farrak"] = "Tanaris"
    }
    return parent_zones[source_name] == selected_name
end

function MTSLUI_ZONE_HUNTER:AddNPCs(sources, ids, kind, zone_id)
    if not ids then return end
    for _, id in pairs(ids) do
        local npc = MTSL_LOGIC_PLAYER_NPC:GetNpcById(id)
        if npc and self:SourceInZone(self:NPCZone(npc), zone_id) then
            self:AddSource(sources, kind, self:Name(npc))
        end
    end
end

function MTSLUI_ZONE_HUNTER:AddObjects(sources, ids, kind, zone_id)
    if not ids then return end
    for _, id in pairs(ids) do
        local obj = MTSL_LOGIC_ITEM_OBJECT:GetObjectById(id)
        if obj and self:SourceInZone(obj.zone_id, zone_id) then self:AddSource(sources, kind, self:Name(obj)) end
    end
end

function MTSLUI_ZONE_HUNTER:AddQuests(sources, ids, zone_id)
    if not ids then return end
    for _, id in pairs(ids) do
        local quest = MTSL_LOGIC_QUEST:GetQuestById(id)
        if quest then
            local locations = {}
            self:AddNPCs(locations, quest.npcs, "NPC", zone_id)
            self:AddObjects(locations, quest.objects, "Object", zone_id)
            if table.getn(locations) > 0 then
                for _, loc in ipairs(locations) do
                    self:AddSource(sources, "Quest " .. self:Name(quest), loc)
                end
            end
        end
    end
end

function MTSLUI_ZONE_HUNTER:GetSources(skill, profession, zone_id)
    local sources = {}
    if skill.trainers then self:AddNPCs(sources, skill.trainers.sources, "Trainer", zone_id) end
    self:AddQuests(sources, skill.quests, zone_id)
    self:AddObjects(sources, skill.objects, "Object", zone_id)
    if skill.items then
        for _, item_id in pairs(skill.items) do
            local item = MTSL_LOGIC_ITEM_OBJECT:GetItemForProfessionById(item_id, profession)
            if item then
                self:AddQuests(sources, item.quests, zone_id)
                if item.vendors then self:AddNPCs(sources, item.vendors.sources, "Vendor", zone_id) end
                if item.drops then
                    if item.drops.range then
                        local z = MTSL_LOGIC_WORLD:GetZoneId(zone_id)
                        local r = item.drops.range
                        if z and z.levels and tonumber(z.levels.min) and tonumber(z.levels.max)
                            and tonumber(r.min_xp_level) and tonumber(r.max_xp_level)
                            and tonumber(z.levels.min) <= tonumber(r.max_xp_level)
                            and tonumber(z.levels.max) >= tonumber(r.min_xp_level) then
                            self:AddSource(sources, "Possible world drop", "mobs level " .. r.min_xp_level .. "-" .. r.max_xp_level)
                        end
                    else
                        self:AddNPCs(sources, item.drops.sources, "Mob drop", zone_id)
                    end
                end
                self:AddObjects(sources, item.objects, "Object", zone_id)
            end
        end
    end
    return sources
end

function MTSLUI_ZONE_HUNTER:IsLearned(profession, skill_id)
    local trades = MTSL_CURRENT_PLAYER and MTSL_CURRENT_PLAYER.TRADESKILLS
    local trade = trades and trades[profession]
    if not trade or trade == 0 then return false, false end
    if trade.LEARNED_SKILLS then
        for _, id in pairs(trade.LEARNED_SKILLS) do if tonumber(id) == tonumber(skill_id) then return true, true end end
    end
    return false, true
end

function MTSLUI_ZONE_HUNTER:Requirements(profession, skill)
    local trade = MTSL_CURRENT_PLAYER and MTSL_CURRENT_PLAYER.TRADESKILLS and MTSL_CURRENT_PLAYER.TRADESKILLS[profession]
    local current = trade and tonumber(trade.SKILL_LEVEL)
    local needed = tonumber(skill.min_skill) or 0
    local spec_id = skill.specialisation
    local spec_name, spec_known = nil, false
    if spec_id then
        spec_name = MTSL_LOGIC_PROFESSION:GetNameSpecialisation(profession, spec_id)
        if not spec_name or spec_name == "" then spec_name = "Specialisation ID " .. tostring(spec_id) end
        if trade and trade.SPELLIDS_SPECIALISATION then
            for _, id in pairs(trade.SPELLIDS_SPECIALISATION) do
                if tonumber(id) == tonumber(spec_id) then spec_known = true; break end
            end
        end
    end
    return current, needed, spec_name, spec_known
end

function MTSLUI_ZONE_HUNTER:ClassAllows(profession, skill)
    local class = MTSL_CURRENT_PLAYER and MTSL_CURRENT_PLAYER.CLASS
    if profession == "Poisons" and class ~= "rogue" then return false end
    if profession == "Lockpicking" and class ~= "rogue" then return false end
    if skill.classes then
        return class ~= nil and MTSL_TOOLS:ListContainsKeyIgnoreCasingAndSpaces(skill.classes, class) == true
    end
    return true
end

function MTSLUI_ZONE_HUNTER:BuildRows()
    self.rows = {}
    local zone = self.zones[self.zone_index]
    if not zone then return end
    for profession, skills in pairs(TRADE_SKILLS_DATA.skills) do
        for _, skill in pairs(skills) do
            local learned, trained = self:IsLearned(profession, skill.id)
            -- Untrained professions are included, marked as such; avoid claiming learned status.
            if self:ClassAllows(profession, skill) and (self.show_all or not learned) then
                local sources = self:GetSources(skill, profession, zone.id)
                if table.getn(sources) > 0 then
                    table.sort(sources)
                    table.insert(self.rows, {
                        name = self:Name(skill), profession = profession, skill = skill, identity = profession .. ":" .. tostring(skill.id),
                        sources = sources, learned = learned, trained = trained,
                        min_skill = skill.min_skill or 0
                    })
                end
            end
        end
    end
    table.sort(self.rows, function(a, b)
        if a.profession ~= b.profession then return a.profession < b.profession end
        return a.name < b.name
    end)
end

-- Detailed acquisition records. No external NPC-drop rates or quest chains are invented.
function MTSLUI_ZONE_HUNTER:Location(record)
    if not record then return "Unknown location" end
    local z = MTSL_LOGIC_WORLD:GetZoneNameById(self:NPCZone(record) or record.zone_id)
    if not z or z == "" then z = "Unknown zone" end
    if record.location and record.location.x and record.location.x ~= "-" and record.location.x ~= "" then
        z = z .. " (" .. tostring(record.location.x) .. ", " .. tostring(record.location.y or "?") .. ")"
    end
    return z
end

function MTSLUI_ZONE_HUNTER:WorkflowLines(spec)
    local db = MTSL_ZONE_WORKFLOWS
    local key = db and db.aliases and db.aliases[spec] or spec
    local w = db and db.specialisations and db.specialisations[key]
    if not w then return nil end
    local lines = {"UNLOCK WORKFLOW: " .. spec, "  " .. w.confidence}
    for i, step in ipairs(w.steps or {}) do table.insert(lines, "  " .. i .. ". " .. step) end
    if w.reference then table.insert(lines, "  Reference: " .. w.reference) end
    table.insert(lines, "  Progress is not automatically verified; check quest log.")
    return lines
end

function MTSLUI_ZONE_HUNTER:DetailLines(entry)
    local out = {}
    local function add(s) table.insert(out, s) end
    local function npc_list(ids, heading)
        if not ids then return end
        local local_npcs, other_npcs = {}, {}
        local zone = self.zones[self.zone_index]
        for _, id in pairs(ids) do
            local npc = MTSL_LOGIC_PLAYER_NPC:GetNpcById(id)
            if npc then
                if zone and self:SourceInZone(self:NPCZone(npc), zone.id) then table.insert(local_npcs, npc)
                else table.insert(other_npcs, npc) end
            end
        end
        local function show_npc(npc, here)
            local name = self:Name(npc)
            add("  " .. heading .. (here and " (HERE): " or ": ") .. name .. " - " .. self:Location(npc))
            local db = MTSL_ZONE_WORKFLOWS
            local access = db and db.source_access and db.source_access[name]
            if access and access.kind == heading then
                add("  SOURCE ACCESS [" .. (access.status or "UNVERIFIED") .. "]:")
                for i, step in ipairs(access.steps or {}) do add("    " .. i .. ". " .. step) end
                if access.reference then add("  Reference: " .. access.reference) end
            end
        end
        for _, npc in ipairs(local_npcs) do show_npc(npc, true) end
        for _, npc in ipairs(other_npcs) do show_npc(npc, false) end
    end
    local function object_list(ids)
        if not ids then return end
        for _, id in pairs(ids) do
            local obj = MTSL_LOGIC_ITEM_OBJECT:GetObjectById(id)
            if obj then add("  Object: " .. self:Name(obj) .. " - " .. self:Location(obj)) end
        end
    end
    local visited = {}
    local function quests(ids)
        if not ids then return end
        for _, id in pairs(ids) do
            if not visited[id] then
                visited[id] = true
                local q = MTSL_LOGIC_QUEST:GetQuestById(id)
                if q then
                    add("QUEST: " .. self:Name(q) .. " [ID " .. tostring(id) .. "]")
                    if q.min_xp_level then add("  Minimum character level: " .. tostring(q.min_xp_level)) end
                    npc_list(q.npcs, "Quest NPC")
                    object_list(q.objects)
                    local qdb = MTSL_ZONE_WORKFLOWS and MTSL_ZONE_WORKFLOWS.quest_conditions
                    local flow = qdb and (qdb[tonumber(id)] or qdb[self:Name(q)])
                    if flow then
                        add("  WORKFLOW [" .. (flow.status or "UNVERIFIED") .. "]:")
                        for n, step in ipairs(flow.steps or {}) do add("    " .. n .. ". " .. step) end
                        if flow.reference then add("  Reference: " .. flow.reference) end
                    else
                        add("  Quest prerequisites not verified; earlier steps may be required")
                    end
                end
            end
        end
    end
    add("SELECTED ZONE: " .. self:Name(self.zones[self.zone_index]))
    add("PROFESSION: " .. entry.profession .. "  |  Skill: " .. tostring(entry.min_skill))
    add(entry.learned and "STATUS: Learned" or (entry.trained and "STATUS: Missing" or "STATUS: Profession not learned"))
    local current, needed, spec, known = self:Requirements(entry.profession, entry.skill)
    if not entry.trained then
        add("REQUIREMENT: Learn the profession first")
    elseif current and current < needed then
        add("LOCKED - SKILL: " .. tostring(current) .. "/" .. tostring(needed))
    elseif current then
        add("SKILL: " .. tostring(current) .. "/" .. tostring(needed) .. " (requirement met)")
    else
        add("SKILL: current level unavailable; required " .. tostring(needed))
    end
    if spec then
        if known then
            add("SPECIALISATION: " .. spec .. " (learned)")
        else
            add("LOCKED - SPECIALISATION: " .. spec)
        end
    end
    add(" ")
    local skill = entry.skill
    if skill.trainers then add("TRAINERS:"); npc_list(skill.trainers.sources, "Trainer") end
    quests(skill.quests)
    object_list(skill.objects)
    if skill.items then
        for _, item_id in pairs(skill.items) do
            local item = MTSL_LOGIC_ITEM_OBJECT:GetItemForProfessionById(item_id, entry.profession)
            if item then
                add("RECIPE ITEM: " .. self:Name(item))
                if item.vendors then
                    npc_list(item.vendors.sources, "Vendor")
                    local workflows = MTSL_ZONE_WORKFLOWS
                    local conditions = workflows and workflows.vendor_conditions
                    local by_item = conditions and conditions[self:Name(item)]
                    local found_requirement = false
                    -- Several quartermasters can sell the same recipe at the same reputation.
                    -- Show all vendor locations, but each shared requirement only once.
                    local shown_reputation = {}
                    for _, vid in pairs(item.vendors.sources or {}) do
                        local vendor = MTSL_LOGIC_PLAYER_NPC:GetNpcById(vid)
                        if vendor then
                            local vendor_name = self:Name(vendor)
                            local cond = by_item and by_item[vendor_name]
                            local item_access = workflows and workflows.item_vendor_access
                            local access_by_vendor = item_access and item_access[self:Name(item)]
                            local access = access_by_vendor and access_by_vendor[vendor_name]
                            if access then
                                found_requirement = true
                                add("VENDOR ACCESS: " .. vendor_name .. " [" .. (access.status or "UNVERIFIED") .. "]")
                                for i, step in ipairs(access.steps or {}) do add("  " .. i .. ". " .. step) end
                                if access.reference then add("  Reference: " .. access.reference) end
                            end
                            if cond then
                                found_requirement = true
                                add("VENDOR UNLOCK: " .. vendor_name .. " [" .. (cond.status or "UNVERIFIED") .. "]")
                                for n, step in ipairs(cond.steps or {}) do add("  " .. n .. ". " .. step) end
                                if cond.reference then add("  Reference: " .. cond.reference) end
                            end
                            local cenarion = workflows and workflows.reputation_vendor_conditions
                            local cenarion_condition = cenarion and cenarion[self:Name(item)]
                            if cenarion_condition and vendor_name == cenarion_condition.vendor then
                                found_requirement = true
                                local key = cenarion_condition.faction .. ":" .. cenarion_condition.rank
                                if not shown_reputation[key] then
                                    shown_reputation[key] = true
                                    add("VENDOR REQUIREMENT: " .. cenarion_condition.faction .. " - " .. cenarion_condition.rank .. " reputation")
                                    add("  DOCUMENTED in Classic guides; not yet verified in this 1.12 client.")
                                    if cenarion_condition.reference then add("  Reference: " .. cenarion_condition.reference) end
                                end
                            end
                            local argent = workflows and workflows.argent_dawn_vendor_conditions
                            local argent_vendors = workflows and workflows.argent_dawn_vendors
                            local argent_rank = argent and argent[self:Name(item)]
                            if argent_rank and argent_vendors and argent_vendors[vendor_name] then
                                found_requirement = true
                                local key = "Argent Dawn:" .. argent_rank
                                if not shown_reputation[key] then
                                    shown_reputation[key] = true
                                    add("VENDOR REQUIREMENT: Argent Dawn - " .. argent_rank .. " reputation")
                                    add("  Earn reputation through Argent Dawn quests, Scourgestones, and undead dungeon activities.")
                                    -- Argent Dawn reputation thresholds confirmed in-game at Miranda Breechlock.
                                end
                            end
                            local rep = workflows and workflows.thorium_brotherhood_reputation
                            local required = rep and rep[self:Name(item)]
                            if vendor_name == (workflows and workflows.thorium_brotherhood_vendor) and required then
                                found_requirement = true
                                local key = "Thorium Brotherhood:" .. required
                                if not shown_reputation[key] then
                                    shown_reputation[key] = true
                                    add("VENDOR REQUIREMENT: Thorium Brotherhood - " .. required .. " reputation")
                                    add("  Vendor: Lokhtos Darkbargainer, Grim Guzzler, Blackrock Depths.")
                                    add("  Build reputation through Thorium Point turn-ins (Searing Gorge)")
                                    add("  and later Molten Core material turn-ins at Lokhtos.")
                                    add("  DOCUMENTED in Classic references; not yet confirmed in this 1.12 client.")
                                end
                            end
                        end
                    end
                    if not found_requirement then
                        add("VENDOR AVAILABILITY: unlocks/stock not verified; quest or reputation may be required")
                    end
                end
                quests(item.quests)
                object_list(item.objects)
                if item.drops then
                    if item.drops.range then
                        local r = item.drops.range
                        add("WORLD DROP: mob levels " .. tostring(r.min_xp_level or "?") .. "-" .. tostring(r.max_xp_level or "?"))
                        add("  Potential zone based on zone level overlap only")
                        add("  Individual mob drop table is not verified")
                    else
                        add("KNOWN MOB DROPS (all recorded zones):")
                        npc_list(item.drops.sources, "Mob")
                    end
                end
            end
        end
    end
    if spec and not known then
        add(" ")
        local workflow = self:WorkflowLines(spec)
        if workflow then
            for _, line in ipairs(workflow) do add(line) end
        else
            add("SPECIALISATION UNLOCK: Relevant specialization trainer or quest.")
            add("  Workflow not verified; prerequisite steps may exist.")
        end
    end
    -- Drop uncertainty is already stated beside estimated world-drop sources.
    -- Do not append a generic drop disclaimer to vendors, quests or trainers.
    return out
end

-- Break acquisition instructions at the *rendered* font width, not at a
-- fixed character count. WoW 1.12 FontStrings do not scroll horizontally.
-- Continuation lines are indented and count toward normal details pagination.
function MTSLUI_ZONE_HUNTER:WrapDetailLines(lines)
    local wrapped = {}
    local font = self.detail_measure
    local max_width = 415 -- Detail labels are 425px; keep a right-side margin.
    local function fits(value)
        font:SetText(value)
        return font:GetStringWidth() <= max_width
    end
    for _, value in ipairs(lines) do
        local original = tostring(value or "")
        if original == "" or string.find(original, "^%s+$") then
            table.insert(wrapped, " ")
        else
            -- Preserve indentation and a readable hanging indent for long steps.
            local indent = string.match(original, "^(%s*)") or ""
            local continuation = indent .. "    "
            local current = indent
            local words = {}
            for word in string.gfind(string.sub(original, string.len(indent) + 1), "%S+") do
                table.insert(words, word)
            end
            for _, word in ipairs(words) do
                local sep = (current == indent or current == continuation) and "" or " "
                local candidate = current .. sep .. word
                if fits(candidate) then
                    current = candidate
                else
                    if current ~= indent and current ~= continuation then
                        table.insert(wrapped, current)
                        current = continuation
                    end
                    -- Long URLs/identifiers may not contain any spaces.
                    local rest = word
                    while rest ~= "" do
                        local prefix = current
                        local take = 0
                        for j = 1, string.len(rest) do
                            if fits(prefix .. string.sub(rest, 1, j)) then
                                take = j
                            else
                                break
                            end
                        end
                        if take == 0 then take = 1 end
                        current = prefix .. string.sub(rest, 1, take)
                        rest = string.sub(rest, take + 1)
                        if rest ~= "" then
                            table.insert(wrapped, current)
                            current = continuation
                        end
                    end
                end
            end
            if current ~= indent and current ~= continuation then table.insert(wrapped, current) end
        end
    end
    return wrapped
end

function MTSLUI_ZONE_HUNTER:UpdateDetails()
    local entry = nil
    for _, candidate in ipairs(self.rows) do
        if candidate.identity == self.selected_id then entry = candidate; break end
    end
    if not entry and self.rows[1] then
        entry = self.rows[1]
        self.selected_id = entry.identity
    end
    self.selected_entry = entry
    local lines = self:WrapDetailLines(entry and self:DetailLines(entry) or {"No recipes in this zone."})
    local max_page = math.max(1, math.ceil(table.getn(lines) / 14))
    if self.detail_page > max_page then self.detail_page = max_page end
    self.detail_title:SetText(entry and entry.name or "Recipe details")
    self.detail_counter:SetText("Details " .. self.detail_page .. "/" .. max_page)
    for i=1,14 do
        local t = self.detail_lines[i]
        local line = lines[(self.detail_page-1)*14+i]
        t:SetText(line or "")
    end
end

-- Keep a glanceable local acquisition source on the left; full sources remain in details/tooltip.
-- Prefer definite local sources over approximate world-drop level overlaps.
function MTSLUI_ZONE_HUNTER:ShortSource(entry)
    local priority = {"Vendor:", "Quest ", "Mob drop:", "Trainer:", "Object:", "Possible world drop:"}
    for _, prefix in ipairs(priority) do
        for _, source in ipairs(entry.sources) do
            if string.sub(source, 1, string.len(prefix)) == prefix then
                -- Avoid overlong source strings covering the right-hand panel.
                if string.len(source) > 59 then return string.sub(source, 1, 56) .. "..." end
                return source
            end
        end
    end
    return entry.sources[1] or "Unknown acquisition source"
end

function MTSLUI_ZONE_HUNTER:Refresh()
    self:BuildRows()
    local zone = self.zones[self.zone_index]
    self.heading:SetText("Zone Hunter - " .. (zone and self:Name(zone) or "Unknown"))
    local start = (self.page - 1) * 12
    local pages = math.max(1, math.ceil(table.getn(self.rows) / 12))
    if self.page > pages then self.page = pages; start = (self.page - 1) * 12 end
    self.counter:SetText(table.getn(self.rows) .. " recipes | page " .. self.page .. "/" .. pages)
    self.mode:SetText(self.show_all and "Show missing only" or "Show learned too")
    for i = 1, 12 do
        local row = self.lines[i]
        local entry = self.rows[start + i]
        if entry then
            local state = entry.learned and "[Learned] " or (entry.trained and "" or "[Untrained] ")
            local color = entry.learned and "|cff66cc66" or (entry.trained and "|cffffdd66" or "|cff999999")
            row.recipe_label:SetText(color .. state .. entry.name .. "|r")
            local current, needed, spec, known = self:Requirements(entry.profession, entry.skill)
            local flags = ""
            if entry.trained and current and current < needed then flags = flags .. " |cffff9955[Skill " .. current .. "/" .. needed .. "]|r" end
            if spec and not known then flags = flags .. " |cffff9955[Locked: " .. spec .. "]|r" end
            row.source_label:SetText("|cffdddddd" .. self:ShortSource(entry) .. "|r" .. flags)
            row.entry = entry
            row:Show()
        else
            row.entry = nil
            row.recipe_label:SetText("")
            row.source_label:SetText("")
            row:Hide()
        end
    end
    self:UpdateDetails()
end

-- Skip completed and truly empty zones. We scan lazily on navigation rather
-- than precomputing the whole world on every click.
function MTSLUI_ZONE_HUNTER:SeekNonemptyZone(delta)
    local n = table.getn(self.zones)
    if n == 0 then return end
    local original = self.zone_index
    for i = 1, n do
        self.zone_index = self.zone_index + delta
        if self.zone_index < 1 then self.zone_index = n end
        if self.zone_index > n then self.zone_index = 1 end
        self:BuildRows()
        if table.getn(self.rows) > 0 then return end
    end
    self.zone_index = original
    self:BuildRows()
end

function MTSLUI_ZONE_HUNTER:ChangeZone(delta)
    self:SeekNonemptyZone(delta)
    self.page = 1
    self.selected_id = nil; self.detail_page = 1
    self:Refresh()
end

function MTSLUI_ZONE_HUNTER:Show()
    if not self.frame then self:Initialise() end
    self.frame:Show()
    self:BuildRows()
    if table.getn(self.rows) == 0 then self:SeekNonemptyZone(1) end
    self:Refresh()
end

function MTSLUI_ZONE_HUNTER:Initialise()
    for _, z in pairs(TRADE_SKILLS_DATA.zones) do
        if z.cont_id and z.cont_id < 3 then table.insert(self.zones, z) end
    end
    table.sort(self.zones, function(a,b) return self:Name(a) < self:Name(b) end)
    local current = GetRealZoneText()
    for i, z in ipairs(self.zones) do
        if self:Name(z) == current then self.zone_index = i; break end
    end
    local frame = CreateFrame("Frame", "MTSLZoneHunterFrame", UIParent)
    frame:SetWidth(940); frame:SetHeight(510)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:SetFrameStrata("DIALOG")
    frame:SetMovable(true); frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function() this:StartMoving() end)
    frame:SetScript("OnDragStop", function() this:StopMovingOrSizing() end)
    frame:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize=32, edgeSize=32, insets={left=11,right=12,top=12,bottom=11}})
    frame:Hide()
    self.frame = frame
    local function button(label, x, y, width, click)
        local b = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        b:SetWidth(width); b:SetHeight(23); b:SetPoint("TOPLEFT", frame, "TOPLEFT", x, y)
        b:SetText(label); b:SetScript("OnClick", click)
        return b
    end
    local function label(x, y, width, height, font)
        local f = frame:CreateFontString(nil, "OVERLAY", font or "GameFontNormal")
        f:SetWidth(width); f:SetHeight(height)
        f:SetPoint("TOPLEFT", frame, "TOPLEFT", x, y)
        f:SetJustifyH("LEFT"); f:SetJustifyV("MIDDLE")
        return f
    end
    self.heading = label(28, -18, 500, 25, "GameFontNormalLarge")
    button("X", 885, -21, 30, function() frame:Hide() end)
    button("< Zone", 28, -54, 90, function() MTSLUI_ZONE_HUNTER:ChangeZone(-1) end)
    button("Zone >", 125, -54, 90, function() MTSLUI_ZONE_HUNTER:ChangeZone(1) end)
    button("Current zone", 221, -54, 112, function()
        local name = GetRealZoneText()
        for i,z in ipairs(MTSLUI_ZONE_HUNTER.zones) do
            if MTSLUI_ZONE_HUNTER:Name(z) == name then MTSLUI_ZONE_HUNTER.zone_index = i; break end
        end
        MTSLUI_ZONE_HUNTER.page=1; MTSLUI_ZONE_HUNTER.selected_id=nil
        MTSLUI_ZONE_HUNTER.detail_page=1
        MTSLUI_ZONE_HUNTER:BuildRows()
        if table.getn(MTSLUI_ZONE_HUNTER.rows) == 0 then MTSLUI_ZONE_HUNTER:SeekNonemptyZone(1) end
        MTSLUI_ZONE_HUNTER:Refresh()
    end)
    self.mode = button("Show learned too", 342, -54, 162, function()
        MTSLUI_ZONE_HUNTER.show_all = not MTSLUI_ZONE_HUNTER.show_all
        MTSLUI_ZONE_HUNTER.page=1; MTSLUI_ZONE_HUNTER.selected_id=nil
        MTSLUI_ZONE_HUNTER.detail_page=1
        MTSLUI_ZONE_HUNTER:BuildRows()
        if table.getn(MTSLUI_ZONE_HUNTER.rows) == 0 then MTSLUI_ZONE_HUNTER:SeekNonemptyZone(1) end
        MTSLUI_ZONE_HUNTER:Refresh()
    end)
    self.counter = label(689, -54, 225, 22)
    label(30, -91, 395, 24):SetText("RECIPE  /  LOCAL SOURCE (click for details)")
    label(474, -91, 430, 24):SetText("ACQUISITION DETAILS")
    local divider = frame:CreateTexture(nil, "ARTWORK")
    divider:SetTexture(0.45, 0.36, 0.19, 0.7)
    divider:SetWidth(1); divider:SetHeight(340)
    divider:SetPoint("TOPLEFT", frame, "TOPLEFT", 455, -111)
    self.lines = {}
    for i=1,12 do
        local line = CreateFrame("Button", nil, frame)
        line:SetWidth(410); line:SetHeight(26)
        line:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -120 - (i-1)*27)
        local t = line:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        t:SetPoint("TOPLEFT", line, "TOPLEFT", 0, 0)
        t:SetWidth(405); t:SetHeight(13); t:SetJustifyH("LEFT")
        local source = line:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        source:SetPoint("TOPLEFT", line, "TOPLEFT", 12, -13)
        source:SetWidth(393); source:SetHeight(12); source:SetJustifyH("LEFT")
        line.recipe_label = t
        line.source_label = source
        line:SetScript("OnClick", function()
            if this.entry then
                MTSLUI_ZONE_HUNTER.selected_id=this.entry.identity
                MTSLUI_ZONE_HUNTER.detail_page=1
                MTSLUI_ZONE_HUNTER:UpdateDetails()
            end
        end)
        line:SetScript("OnEnter", function()
            if this.entry then
                GameTooltip:SetOwner(this, "ANCHOR_CURSOR")
                GameTooltip:AddLine(this.entry.name .. " (" .. this.entry.profession .. ")", 1, .82, 0)
                for _, source in ipairs(this.entry.sources) do GameTooltip:AddLine(source, 1, 1, 1, 1) end
                local current, needed, spec, known = MTSLUI_ZONE_HUNTER:Requirements(this.entry.profession, this.entry.skill)
                if current and current < needed then GameTooltip:AddLine("Skill: " .. current .. "/" .. needed, 1, .55, .2) end
                if spec and not known then GameTooltip:AddLine("Requires " .. spec, 1, .55, .2) end
                GameTooltip:Show()
            end
        end)
        line:SetScript("OnLeave", function() GameTooltip:Hide() end)
        self.lines[i] = line
    end
    self.detail_title=label(474,-119,425,26,"GameFontNormalLarge")
    self.detail_measure=frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    self.detail_measure:Hide()
    self.detail_lines={}
    for i=1,14 do
        self.detail_lines[i]=label(477, -155-(i-1)*21, 425, 20, "GameFontHighlightSmall")
    end
    button("Previous page", 73, -460, 145, function()
        if MTSLUI_ZONE_HUNTER.page > 1 then MTSLUI_ZONE_HUNTER.page=MTSLUI_ZONE_HUNTER.page-1 end
        MTSLUI_ZONE_HUNTER:Refresh()
    end)
    button("Next page", 236, -460, 145, function()
        if MTSLUI_ZONE_HUNTER.page*12 < table.getn(MTSLUI_ZONE_HUNTER.rows) then MTSLUI_ZONE_HUNTER.page=MTSLUI_ZONE_HUNTER.page+1 end
        MTSLUI_ZONE_HUNTER:Refresh()
    end)
    button("< Details", 482, -460, 100, function()
        if MTSLUI_ZONE_HUNTER.detail_page > 1 then MTSLUI_ZONE_HUNTER.detail_page=MTSLUI_ZONE_HUNTER.detail_page-1 end
        MTSLUI_ZONE_HUNTER:UpdateDetails()
    end)
    button("Details >", 592, -460, 100, function()
        MTSLUI_ZONE_HUNTER.detail_page=MTSLUI_ZONE_HUNTER.detail_page+1
        MTSLUI_ZONE_HUNTER:UpdateDetails()
    end)
    self.detail_counter=label(713,-459,190,23)
end
