// rand_spawn_level_creature
/*
  Levels creature up as appropriate for the area it spawns in

*/
// 

#include "NW_I0_GENERIC"
#include "ginc_event_handlers"
#include "ginc_math"

//additional includes
#include "x2_inc_itemprop"  

#include "rand_spawn_level_helpers"


void main()
{
  
  //LOG: WriteTimestampedLogEntry("Starting Leveling Up Process");
  object spawnedCreature = OBJECT_SELF;  
  //Area should have AREA_CREATURE_LEVEL already set
  int levelToAchieve = GetLocalInt(GetArea(spawnedCreature),"AREA_CREATURE_LEVEL");
  
  //LOG: WriteTimestampedLogEntry("Area Level " + IntToString(levelToAchieve));
  
  //TODO: Resolve special traits

  //First, level up our creature
  //SetUnrestrictedLevelUp(spawnedCreature);
  DoLevelUp(spawnedCreature, levelToAchieve);

  //Second, handle buffs and inventory  
  DoArmorBonus(spawnedCreature, levelToAchieve);

  //Apply Primary Stat bonus instantly so it can't be removed
  float statBonus = GetLocalFloat(GetModule(),"PRIMARY_STAT_PROGRESS_PER_LEVEL");
  //Remove Later?
  if ( statBonus == 0.0f ) statBonus = 0.4f;
  statBonus *= levelToAchieve;  
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectAbilityIncrease(GetPrimaryAbility(spawnedCreature),
    MathRound(statBonus)),spawnedCreature);
  
  //Apply Weapon bonus, or just straight Attack Bonus if none is found.
  float weaponBonus = GetLocalFloat(GetModule(),"WEAPON_PROGRESS_PER_LEVEL");
  //Remove Later?
  if ( weaponBonus == 0.0f ) weaponBonus = 0.333f;
  weaponBonus *= levelToAchieve;  
  
  //Cycle through inventory
  int bFoundWeapon = FALSE;
  object curItem = GetFirstItemInInventory(spawnedCreature);
  while (curItem != OBJECT_INVALID)
  {
    // Attack bonus to our melee weapons
    if (IPGetIsMeleeWeapon(curItem))
    {
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(MathRound(weaponBonus)),curItem);
      bFoundWeapon = TRUE;
    }    
    
    //Attack bonus to our ranged weapons
    if (GetWeaponRanged(curItem))
    {
      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(MathRound(weaponBonus)),curItem);
      bFoundWeapon = TRUE;
    }
    
    //Damage bonus to our arrows and bolts and such
    if (IPGetIsProjectile(curItem))
    {
      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,MathRound(weaponBonus)),curItem);
    }
      
    curItem = GetNextItemInInventory(spawnedCreature);
  }
  
  //No items?  Buff its natural attack
  if (bFoundWeapon == FALSE)
  {
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectAttackIncrease(MathRound(weaponBonus)),spawnedCreature);
  }
}