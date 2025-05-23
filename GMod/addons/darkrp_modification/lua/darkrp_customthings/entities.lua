--[[---------------------------------------------------------------------------
DarkRP custom entities
---------------------------------------------------------------------------

This file contains your custom entities.
This file should also contain entities from DarkRP that you edited.

Note: If you want to edit a default DarkRP entity, first disable it in darkrp_config/disabled_defaults.lua
    Once you've done that, copy and paste the entity to this file and edit it.

The default entities can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua

For examples and explanation please visit this wiki page:
https://darkrp.miraheze.org/wiki/DarkRP:CustomEntityFields

Add entities under the following line:
---------------------------------------------------------------------------]]
DarkRP.createEntity("Weapon Shelf", {
    ent = "weapon_shelf",
    cmd = "buywepshelf",
    model = "models/dansgunshelf/dansgunshelf.mdl",
    price = 500,
    max = 3,
    allowed = {
        TEAM_GUNDLR,
        TEAM_STAFF,
        TEAM_CRIMINAL,
        TEAM_TOWNDOCTOR
    },
    category = "Gun Dealer",
})

DarkRP.createEntity("Ammo Kit (Small)", {
    ent = "cw_ammo_kit_small",
    cmd = "buyammokitsmall",
    model = "models/Items/BoxSRounds.mdl",
    price = 100,
    max = 3,
    allowed = {
        TEAM_GUNDLR,
        TEAM_STAFF,
        TEAM_CRIMINAL,
        TEAM_TOWNDOCTOR
    },
    category = "Gun Dealer",
})

DarkRP.createEntity("Ammo Kit (Regular)", {
    ent = "cw_ammo_kit_regular",
    cmd = "buyammokitreg",
    model = "models/Items/BoxMRounds.mdl",
    price = 150,
    max = 3,
    allowed = {
        TEAM_GUNDLR,
        TEAM_STAFF,
        TEAM_CRIMINAL,
        TEAM_TOWNDOCTOR
    },
    category = "Gun Dealer",
})

DarkRP.createEntity("Stove", {
    ent = "eml_stove",
    cmd = "buystove",
    model = "models/props_c17/furnitureStove001a.mdl",
    price = 2500,
    max = 1,
    allowed = {
        TEAM_AIINITIATE,
        TEAM_AIOPERATIVE,
        TEAM_AISENOPERATIVE,
        TEAM_AINCO,
        TEAM_AIOFFICER,
        TEAM_AISNIPER,
        TEAM_AILEADSNIPER,
        TEAM_AIMEDIC,
        TEAM_AILEADMEDIC,
        TEAM_AIHEAVY,
        TEAM_AILEADHEAVY,
        TEAM_AIEXPLO,
        TEAM_AILEADEXPLO,
        TEAM_RIINITIATE,
        TEAM_RIRESEARCHER,
        TEAM_RISENRESEARCHER,
        TEAM_RIOFFICER,
        TEAM_RIINFILTRATOR,
        TEAM_RILEADINFILTRATOR,
        TEAM_SIOPERATIVE,
        TEAM_SISENOPERATIVE,
        TEAM_SISPECIALIST,
        TEAM_SICAPTAIN,
        TEAM_SIK9,
        TEAM_CILEADRESEARCH,
        TEAM_CISUPERVISOR,
        TEAM_CIVICECOMMANDER,
        TEAM_CICOMMANDER,
        TEAM_CITIZEN,
        TEAM_CRIMINAL,
        TEAM_TOWNDOCTOR,
        TEAM_MAYOR,
        TEAM_AIBREACH,
        TEAM_AIBREACHLEAD,
        TEAM_I10FBITRN,
        TEAM_I10FBIOP,
        TEAM_I10FBILD,
        TEAM_EXPCIVI,
        TEAM_RETROCIVI,
        TEAM_STAFF,
    },
    category = "Meth Equipment",
})

DarkRP.createEntity("Meth Pot", {
    ent = "eml_spot",
    cmd = "buympot",
    model = "models/props_c17/metalPot001a.mdl",
    price = 1500,
    max = 2,
    
    allowed = {
        TEAM_AIINITIATE,
        TEAM_AIOPERATIVE,
        TEAM_AISENOPERATIVE,
        TEAM_AINCO,
        TEAM_AIOFFICER,
        TEAM_AISNIPER,
        TEAM_AILEADSNIPER,
        TEAM_AIMEDIC,
        TEAM_AILEADMEDIC,
        TEAM_AIHEAVY,
        TEAM_AILEADHEAVY,
        TEAM_AIEXPLO,
        TEAM_AILEADEXPLO,
        TEAM_RIINITIATE,
        TEAM_RIRESEARCHER,
        TEAM_RISENRESEARCHER,
        TEAM_RIOFFICER,
        TEAM_RIINFILTRATOR,
        TEAM_RILEADINFILTRATOR,
        TEAM_SIOPERATIVE,
        TEAM_SISENOPERATIVE,
        TEAM_SISPECIALIST,
        TEAM_SICAPTAIN,
        TEAM_SIK9,
        TEAM_CILEADRESEARCH,
        TEAM_CISUPERVISOR,
        TEAM_CIVICECOMMANDER,
        TEAM_CICOMMANDER,
        TEAM_CITIZEN,
        TEAM_CRIMINAL,
        TEAM_TOWNDOCTOR,
        TEAM_MAYOR,
        TEAM_AIBREACH,
        TEAM_AIBREACHLEAD,
        TEAM_I10FBITRN,
        TEAM_I10FBIOP,
        TEAM_I10FBILD,
        TEAM_EXPCIVI,
        TEAM_RETROCIVI,
        TEAM_STAFF,
    },
    category = "Meth Equipment",
})

DarkRP.createEntity("Red Pot", {
    ent = "eml_pot",
    cmd = "buyrpot",
    model = "models/props_c17/metalPot001a.mdl",
    price = 1000,
    max = 2,

    allowed = {
        TEAM_AIINITIATE,
        TEAM_AIOPERATIVE,
        TEAM_AISENOPERATIVE,
        TEAM_AINCO,
        TEAM_AIOFFICER,
        TEAM_AISNIPER,
        TEAM_AILEADSNIPER,
        TEAM_AIMEDIC,
        TEAM_AILEADMEDIC,
        TEAM_AIHEAVY,
        TEAM_AILEADHEAVY,
        TEAM_AIEXPLO,
        TEAM_AILEADEXPLO,
        TEAM_RIINITIATE,
        TEAM_RIRESEARCHER,
        TEAM_RISENRESEARCHER,
        TEAM_RIOFFICER,
        TEAM_RIINFILTRATOR,
        TEAM_RILEADINFILTRATOR,
        TEAM_SIOPERATIVE,
        TEAM_SISENOPERATIVE,
        TEAM_SISPECIALIST,
        TEAM_SICAPTAIN,
        TEAM_SIK9,
        TEAM_CILEADRESEARCH,
        TEAM_CISUPERVISOR,
        TEAM_CIVICECOMMANDER,
        TEAM_CICOMMANDER,
        TEAM_CITIZEN,
        TEAM_CRIMINAL,
        TEAM_TOWNDOCTOR,
        TEAM_MAYOR,
        TEAM_AIBREACH,
        TEAM_AIBREACHLEAD,
        TEAM_I10FBITRN,
        TEAM_I10FBIOP,
        TEAM_I10FBILD,
        TEAM_EXPCIVI,
        TEAM_RETROCIVI,
        TEAM_STAFF,
    },
    category = "Meth Equipment",
})

DarkRP.createEntity("Muriatic Acid", {
    ent = "eml_macid",
    cmd = "buyma",
    model = "models/props_junk/garbage_plasticbottle001a.mdl",
    price = 100,
    max = 1,
    
    allowed = {
        TEAM_AIINITIATE,
        TEAM_AIOPERATIVE,
        TEAM_AISENOPERATIVE,
        TEAM_AINCO,
        TEAM_AIOFFICER,
        TEAM_AISNIPER,
        TEAM_AILEADSNIPER,
        TEAM_AIMEDIC,
        TEAM_AILEADMEDIC,
        TEAM_AIHEAVY,
        TEAM_AILEADHEAVY,
        TEAM_AIEXPLO,
        TEAM_AILEADEXPLO,
        TEAM_RIINITIATE,
        TEAM_RIRESEARCHER,
        TEAM_RISENRESEARCHER,
        TEAM_RIOFFICER,
        TEAM_RIINFILTRATOR,
        TEAM_RILEADINFILTRATOR,
        TEAM_SIOPERATIVE,
        TEAM_SISENOPERATIVE,
        TEAM_SISPECIALIST,
        TEAM_SICAPTAIN,
        TEAM_SIK9,
        TEAM_CILEADRESEARCH,
        TEAM_CISUPERVISOR,
        TEAM_CIVICECOMMANDER,
        TEAM_CICOMMANDER,
        TEAM_CITIZEN,
        TEAM_CRIMINAL,
        TEAM_TOWNDOCTOR,
        TEAM_MAYOR,
        TEAM_AIBREACH,
        TEAM_AIBREACHLEAD,
        TEAM_I10FBITRN,
        TEAM_I10FBIOP,
        TEAM_I10FBILD,
        TEAM_EXPCIVI,
        TEAM_RETROCIVI,
        TEAM_STAFF,
    },
    category = "Meth Materials",
})

DarkRP.createEntity("Sulfur", {
    ent = "eml_sulfur",
    cmd = "buysulfur",
    model = "models/props_junk/garbage_glassbottle001a.mdl",
    price = 100,
    max = 2,
    
    allowed = {
        TEAM_AIINITIATE,
        TEAM_AIOPERATIVE,
        TEAM_AISENOPERATIVE,
        TEAM_AINCO,
        TEAM_AIOFFICER,
        TEAM_AISNIPER,
        TEAM_AILEADSNIPER,
        TEAM_AIMEDIC,
        TEAM_AILEADMEDIC,
        TEAM_AIHEAVY,
        TEAM_AILEADHEAVY,
        TEAM_AIEXPLO,
        TEAM_AILEADEXPLO,
        TEAM_RIINITIATE,
        TEAM_RIRESEARCHER,
        TEAM_RISENRESEARCHER,
        TEAM_RIOFFICER,
        TEAM_RIINFILTRATOR,
        TEAM_RILEADINFILTRATOR,
        TEAM_SIOPERATIVE,
        TEAM_SISENOPERATIVE,
        TEAM_SISPECIALIST,
        TEAM_SICAPTAIN,
        TEAM_SIK9,
        TEAM_CILEADRESEARCH,
        TEAM_CISUPERVISOR,
        TEAM_CIVICECOMMANDER,
        TEAM_CICOMMANDER,
        TEAM_CITIZEN,
        TEAM_CRIMINAL,
        TEAM_TOWNDOCTOR,
        TEAM_MAYOR,
        TEAM_AIBREACH,
        TEAM_AIBREACHLEAD,
        TEAM_I10FBITRN,
        TEAM_I10FBIOP,
        TEAM_I10FBILD,
        TEAM_EXPCIVI,
        TEAM_RETROCIVI,
        TEAM_STAFF,
    },
    category = "Meth Materials",
})

DarkRP.createEntity("Water", {
    ent = "eml_water",
    cmd = "buywater",
    model = "models/props_junk/garbage_plasticbottle003a.mdl",
    price = 100,
    max = 2,
    
    allowed = {
        TEAM_AIINITIATE,
        TEAM_AIOPERATIVE,
        TEAM_AISENOPERATIVE,
        TEAM_AINCO,
        TEAM_AIOFFICER,
        TEAM_AISNIPER,
        TEAM_AILEADSNIPER,
        TEAM_AIMEDIC,
        TEAM_AILEADMEDIC,
        TEAM_AIHEAVY,
        TEAM_AILEADHEAVY,
        TEAM_AIEXPLO,
        TEAM_AILEADEXPLO,
        TEAM_RIINITIATE,
        TEAM_RIRESEARCHER,
        TEAM_RISENRESEARCHER,
        TEAM_RIOFFICER,
        TEAM_RIINFILTRATOR,
        TEAM_RILEADINFILTRATOR,
        TEAM_SIOPERATIVE,
        TEAM_SISENOPERATIVE,
        TEAM_SISPECIALIST,
        TEAM_SICAPTAIN,
        TEAM_SIK9,
        TEAM_CILEADRESEARCH,
        TEAM_CISUPERVISOR,
        TEAM_CIVICECOMMANDER,
        TEAM_CICOMMANDER,
        TEAM_CITIZEN,
        TEAM_CRIMINAL,
        TEAM_TOWNDOCTOR,
        TEAM_MAYOR,
        TEAM_AIBREACH,
        TEAM_AIBREACHLEAD,
        TEAM_I10FBITRN,
        TEAM_I10FBIOP,
        TEAM_I10FBILD,
        TEAM_EXPCIVI,
        TEAM_RETROCIVI,
        TEAM_STAFF,
    },
    category = "Meth Materials",
})

DarkRP.createEntity("Salt", {
    ent = "eml_salt",
    cmd = "buysalt",
    model = "models/props_junk/garbage_milkcarton002a.mdl",
    price = 100,
    max = 2,

    allowed = {
        TEAM_AIINITIATE,
        TEAM_AIOPERATIVE,
        TEAM_AISENOPERATIVE,
        TEAM_AINCO,
        TEAM_AIOFFICER,
        TEAM_AISNIPER,
        TEAM_AILEADSNIPER,
        TEAM_AIMEDIC,
        TEAM_AILEADMEDIC,
        TEAM_AIHEAVY,
        TEAM_AILEADHEAVY,
        TEAM_AIEXPLO,
        TEAM_AILEADEXPLO,
        TEAM_RIINITIATE,
        TEAM_RIRESEARCHER,
        TEAM_RISENRESEARCHER,
        TEAM_RIOFFICER,
        TEAM_RIINFILTRATOR,
        TEAM_RILEADINFILTRATOR,
        TEAM_SIOPERATIVE,
        TEAM_SISENOPERATIVE,
        TEAM_SISPECIALIST,
        TEAM_SICAPTAIN,
        TEAM_SIK9,
        TEAM_CILEADRESEARCH,
        TEAM_CISUPERVISOR,
        TEAM_CIVICECOMMANDER,
        TEAM_CICOMMANDER,
        TEAM_CITIZEN,
        TEAM_CRIMINAL,
        TEAM_TOWNDOCTOR,
        TEAM_MAYOR,
        TEAM_AIBREACH,
        TEAM_AIBREACHLEAD,
        TEAM_I10FBITRN,
        TEAM_I10FBIOP,
        TEAM_I10FBILD,
        TEAM_EXPCIVI,
        TEAM_RETROCIVI,
        TEAM_STAFF,
    },
    category = "Meth Materials",
})

DarkRP.createEntity("Iodine Mixer", {
    ent = "eml_jar",
    cmd = "buyim",
    model = "models/props_junk/plasticbucket001a.mdl",
    price = 750,
    max = 1,
    
    allowed = {
        TEAM_AIINITIATE,
        TEAM_AIOPERATIVE,
        TEAM_AISENOPERATIVE,
        TEAM_AINCO,
        TEAM_AIOFFICER,
        TEAM_AISNIPER,
        TEAM_AILEADSNIPER,
        TEAM_AIMEDIC,
        TEAM_AILEADMEDIC,
        TEAM_AIHEAVY,
        TEAM_AILEADHEAVY,
        TEAM_AIEXPLO,
        TEAM_AILEADEXPLO,
        TEAM_RIINITIATE,
        TEAM_RIRESEARCHER,
        TEAM_RISENRESEARCHER,
        TEAM_RIOFFICER,
        TEAM_RIINFILTRATOR,
        TEAM_RILEADINFILTRATOR,
        TEAM_SIOPERATIVE,
        TEAM_SISENOPERATIVE,
        TEAM_SISPECIALIST,
        TEAM_SICAPTAIN,
        TEAM_SIK9,
        TEAM_CILEADRESEARCH,
        TEAM_CISUPERVISOR,
        TEAM_CIVICECOMMANDER,
        TEAM_CICOMMANDER,
        TEAM_CITIZEN,
        TEAM_CRIMINAL,
        TEAM_TOWNDOCTOR,
        TEAM_MAYOR,
        TEAM_AIBREACH,
        TEAM_AIBREACHLEAD,
        TEAM_I10FBITRN,
        TEAM_I10FBIOP,
        TEAM_I10FBILD,
        TEAM_EXPCIVI,
        TEAM_RETROCIVI,
        TEAM_STAFF,
    },
    category = "Meth Equipment",
})

DarkRP.createEntity("Liquid Iodine", {
    ent = "eml_iodine",
    cmd = "buyiodine",
    model = "models/props_junk/plasticbucket001a.mdl",
    price = 100,
    max = 3,
    
    allowed = {
        TEAM_AIINITIATE,
        TEAM_AIOPERATIVE,
        TEAM_AISENOPERATIVE,
        TEAM_AINCO,
        TEAM_AIOFFICER,
        TEAM_AISNIPER,
        TEAM_AILEADSNIPER,
        TEAM_AIMEDIC,
        TEAM_AILEADMEDIC,
        TEAM_AIHEAVY,
        TEAM_AILEADHEAVY,
        TEAM_AIEXPLO,
        TEAM_AILEADEXPLO,
        TEAM_RIINITIATE,
        TEAM_RIRESEARCHER,
        TEAM_RISENRESEARCHER,
        TEAM_RIOFFICER,
        TEAM_RIINFILTRATOR,
        TEAM_RILEADINFILTRATOR,
        TEAM_SIOPERATIVE,
        TEAM_SISENOPERATIVE,
        TEAM_SISPECIALIST,
        TEAM_SICAPTAIN,
        TEAM_SIK9,
        TEAM_CILEADRESEARCH,
        TEAM_CISUPERVISOR,
        TEAM_CIVICECOMMANDER,
        TEAM_CICOMMANDER,
        TEAM_CITIZEN,
        TEAM_CRIMINAL,
        TEAM_TOWNDOCTOR,
        TEAM_MAYOR,
        TEAM_AIBREACH,
        TEAM_AIBREACHLEAD,
        TEAM_I10FBITRN,
        TEAM_I10FBIOP,
        TEAM_I10FBILD,
        TEAM_EXPCIVI,
        TEAM_RETROCIVI,
        TEAM_STAFF,
    },
    category = "Meth Materials",
})

DarkRP.createEntity("Galaxy Gas", {
    ent = "eml_gas",
    cmd = "buygas",
    model = "models/props_c17/canister01a.mdl",
    price = 250,
    max = 1,
    allowed = {
        TEAM_AIINITIATE,
        TEAM_AIOPERATIVE,
        TEAM_AISENOPERATIVE,
        TEAM_AINCO,
        TEAM_AIOFFICER,
        TEAM_AISNIPER,
        TEAM_AILEADSNIPER,
        TEAM_AIMEDIC,
        TEAM_AILEADMEDIC,
        TEAM_AIHEAVY,
        TEAM_AILEADHEAVY,
        TEAM_AIEXPLO,
        TEAM_AILEADEXPLO,
        TEAM_RIINITIATE,
        TEAM_RIRESEARCHER,
        TEAM_RISENRESEARCHER,
        TEAM_RIOFFICER,
        TEAM_RIINFILTRATOR,
        TEAM_RILEADINFILTRATOR,
        TEAM_SIOPERATIVE,
        TEAM_SISENOPERATIVE,
        TEAM_SISPECIALIST,
        TEAM_SICAPTAIN,
        TEAM_SIK9,
        TEAM_CILEADRESEARCH,
        TEAM_CISUPERVISOR,
        TEAM_CIVICECOMMANDER,
        TEAM_CICOMMANDER,
        TEAM_CITIZEN,
        TEAM_CRIMINAL,
        TEAM_TOWNDOCTOR,
        TEAM_MAYOR,
        TEAM_AIBREACH,
        TEAM_AIBREACHLEAD,
        TEAM_I10FBITRN,
        TEAM_I10FBIOP,
        TEAM_I10FBILD,
        TEAM_EXPCIVI,
        TEAM_RETROCIVI,
        TEAM_STAFF,
    },
    category = "Meth Equipment",
})

DarkRP.createEntity("Heist Drill", {
    ent = "tbfy_pdr_drill",
    cmd = "buydrill",
    model = "models/moonbasealpha/welder.mdl",
    price = 1500,
    max = 4,
    allowed = {
        TEAM_CRIMINAL,
        TEAM_STAFF,
    },
    category = "Heist Gear",
})

DarkRP.createEntity("Scanner EMP", {
    ent = "tbfy_pdr_emp",
    cmd = "buyemp",
    model = "models/alyx_emptool_prop.mdl",
    price = 750,
    max = 4,
    allowed = {
        TEAM_CRIMINAL,
        TEAM_STAFF,
    },
    category = "Heist Gear",
})

DarkRP.createEntity("Bank Explosive", {
    ent = "tbfy_pdr_explosives",
    cmd = "buyexplo",
    model = "models/weapons/w_c4_planted.mdl",
    price = 5000,
    max = 4,
    allowed = {
        TEAM_CRIMINAL,
        TEAM_STAFF,
    },
    category = "Heist Gear",
})