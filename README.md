#Random Spawn System

### What is it?

A series of scripts that make use of the NESS camp feature to populate a dungeon with a random types and level of creatures. e.g. a dungeon could be populated with 10th level kobolds at one point and 7th level drow at another. The system also includes a trait mechanic which will offer some variety to creature composition by enhancing them in particular ways.


### Why have it?

The system rewards scouting out dungeons, meaning player who spend time investigating the various dungeons will be rewarded with new experiences. It also adds a certain ecology to the area and sense of accomplishment when wiping out an orc tribe occupying an area means they are actually gone. Additionally, monster diversity overall is increased, so the server doesn't become heavy in just one creature type.

## Setting Up the Random Spawn System

###Setting Up the Module

It is helpful to have a working version of NESS, but not required. Import the files from the erb into the module.

Add the following to your OnModuleLoad script
```
ExecuteCode("rand_spawn_initialize", OBJECT_SELF);
```

Add the following to the end of whatever OnSpawn script you are using for the creatures if you don't want to use the provided rand_spawn_onspawn script
```
DelayCommand(1.0f,ExecuteScript("rand_spawn_level_creature",OBJECT_SELF));
```

If you have a previous installation of NESS:
Add the following line to the top of your spawn_cfg_camp script.
```
#include "rand_spawn_camps"
```

Add the following to your SetCampSpawn function in the same script
```
if (sCamp == "rand_spawner_camp")
  SpawnRandomCamps(oCamp, sCamp, lCamp);
```

###Setting Up Areas

> RANDOM_SPAWN_AREA, Integer : Set to 1 to activate the system for this area.

Now place "spawn_rss_creatures" waypoint from module blueprints for each place you would like monsters to appear in the area.

The area should spawn creatures now. See below for area constants you can set to refine its behavior.

## Customization
### Area Constants

Areas have the following constants that can be set to regulate what spawns there. Note that none are actually required for the system to work.

####Spawn Chance
> AREA_SPAWN_CHANCE, Integer : The percentage chance, out of 100 that this area will have creatures this hour. Set to -1 to disable.

> AREA_DESPAWN_CHANCE, Integer : The percentage chance, out of 100 that if this area has a spawn set up that it will be removed. Set to -1 to disable.`

####Level Related
> AREA_CREATURE_LEVEL_ALWAYS, Integer : If set, creatures spawned in this area will always be of the set level.

> MIN_LEVEL, Integer : Sets the minimum level random creatures in the area can be. Otherwise 1.

> MAX_LEVEL, Integer : Sets the maximum level random creatures in the area can be. Otherwise 20.

####Type Related
> AREA_CREATURE_TYPE_ALWAYS, String : If set, creatures in the area will always been of the set type.

####Tribe Related
> AREA_CREATURE_TRIBE_ALWAYS, String : If set, creatures in the area will always have this tribe name.

####Trait Related
> NUM_AREA_TRAITS, Int : If set, the area will have this number of traits, which it will apply to creatures that spawn within it. Set to -1 to disable traits, as 0 will spawn the default number set in the constants file.
 
> AREA_TRAIT_#_ALWAYS, Int : Where # is a sequential number starting with 1 and incrementing by 1 for each additional trait added. If set, creatures in this area will always have this trait. Consult the constants file for which traits correspond to which integers. Some traits are only accessible via this means.
