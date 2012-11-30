// rand_spawn_level_creature
/*
  Levels creature up as appropriate for the area it spawns in
*/
// 

#include "NW_I0_GENERIC"
#include "ginc_event_handlers"

//additional includes
#include "rand_spawn_level_helpers"
#include "rand_spawn_trait"

void main()
{
  //LOG: WriteTimestampedLogEntry("Starting Leveling Up Process");
  object spawnedCreature = OBJECT_SELF;  
  //Area should have AREA_CREATURE_LEVEL already set
  int levelToAchieve = GetLocalInt(GetArea(spawnedCreature),"AREA_CREATURE_LEVEL");
  
  //LOG: WriteTimestampedLogEntry("Area Level " + IntToString(levelToAchieve));
  
  //Sets the creature's name so it matches other in the area.
  DoTribeName(spawnedCreature);

  //Figure out which traits we want on this creature.
  SetupTraits(spawnedCreature, levelToAchieve);

  //Level up our creature
  //SetUnrestrictedLevelUp(spawnedCreature);
  DoLevelUp(spawnedCreature, levelToAchieve);

  //Handle buffs and inventory  
  DoArmorBonus(spawnedCreature, levelToAchieve);

  //Apply Primary Stat bonus instantly so it can't be removed
  DoStatBonus(spawnedCreature, levelToAchieve);
  
  //Apply Weapon bonus, or just straight Attack Bonus if none is found.
  DoWeaponBonus(spawnedCreature, levelToAchieve);

  //TODO: Resolve special traits
  DoTraits(spawnedCreature, levelToAchieve);
}