#include "ginc_math"
#include "x2_inc_itemprop" 
#include "rand_spawn_consts" 
#include "rand_spawn_trait"

//Changes the creature's FirstName to that of the local tribe name.
void DoTribeName(object creature);

//Levels creature up to levelToAchieve based on class in position 1
void DoLevelUp(object creature, int levelToAchieve);
//Levels up the creature based on what is in position 1
void LevelUpCreatureDefault(object creature);
//Levels up the creature based on its tag returns FALSE if no level up took place
//set justCheck to TRUE if you want to avoid leveling the creature up.
int LevelUpCreatureSpecial(object creature, int justCheck=FALSE);

//Adds an armor bonus to the creature based on levelToAchieve
void DoArmorBonus(object creature, int levelToAchieve);
//Adds a bonus to the creature's primary stat based on levelToAchieve
void DoStatBonus(object creature, int levelToAchieve);
//Adds a bonus to the creature's weapons based on levelToAchieve
void DoWeaponBonus(object creature, int levelToAchieve);

// Returns highest ability score, favors STR>DEX>CON>INT>WIS>CHA
int GetPrimaryAbility(object targetCreature);
// Rounds to the closest number
int MathRound(float baseNumber);


//Changes the creature's FirstName to that of the local tribe name.
void DoTribeName(object creature)
{
  string tribeName = GetLocalString(GetArea(creature),"AREA_CREATURE_TRIBE");
  SetFirstName(creature, tribeName);
}

//Levels creature up to levelToAchieve based on class in position 1
void DoLevelUp(object creature, int levelToAchieve)
{  
  int isSpecial = LevelUpCreatureSpecial(creature, TRUE);
  int i;
  for (i = GetHitDice(creature); i < levelToAchieve; i++)
  {
    if (isSpecial)
      LevelUpCreatureSpecial(creature);
    else
      LevelUpCreatureDefault(creature);    
  }
}

//Levels up the creature based on its tag returns FALSE if no level up took place
//set justCheck to TRUE if you want to avoid leveling the creature up.
int LevelUpCreatureSpecial(object creature, int justCheck)
{
  //Determine which class we're leveling up. TODO: Make custom leveling sequences
  string creatureTag = GetTag(creature);

  // KOBOLD DRAGON DISCIPLE
  if (creatureTag == "c_kobold_rand_disciple")
  {
    if (justCheck) return TRUE;

    //Level up Dragon Disciple when bard has reached level 5 and we have not finished the class
    if (GetLevelByPosition(1) >= 5 && GetLevelByPosition(2) < 10)
      LevelUpHenchman(creature, CLASS_TYPE_DRAGONDISCIPLE, TRUE, PACKAGE_DRAGON_DISCIPLE);
    else
      LevelUpHenchman(creature, CLASS_TYPE_BARD, TRUE, PACKAGE_BARD_BLADE);

    return TRUE;
  }
  if (creatureTag == "c_orc_rand_berserker")
  {
    if (justCheck) return TRUE;

    //Level up Frenzied Berserker when barbarian has reached level 6 and we have not finished the class
    if (GetLevelByPosition(1) >= 6 && GetLevelByPosition(2) < 10)
      LevelUpHenchman(creature, CLASS_TYPE_FRENZIEDBERSERKER, TRUE, 135); //Base Frenzied Berserker Package
    else
      LevelUpHenchman(creature, CLASS_TYPE_BARBARIAN, TRUE, 18); //Barbarian, Berserker

    return TRUE;
  }
  if (creatureTag == "c_drow_rand_archer")
  {
    if (justCheck) return TRUE;

	//Level up Wizard when we have reached Ranger 6 and have no wizard levels
	if (GetLevelByPosition(1) == 6 && GetLevelByPosition(2) == 0)
      LevelUpHenchman(creature, CLASS_TYPE_WIZARD, TRUE, PACKAGE_WIZARDGENERALIST); 
    else
    { //Level up Arcane Archer when we reached Ranger 6 / Wizard 1 and have not completed the class
	  if (GetLevelByPosition(1) >= 6 && GetLevelByPosition(3) < 10)
	    LevelUpHenchman(creature, CLASS_TYPE_ARCANE_ARCHER, TRUE, PACKAGE_ARCANE_ARCHER); 
      else //Otherwise level up Ranger	
        LevelUpHenchman(creature, CLASS_TYPE_RANGER, TRUE, PACKAGE_RANGER_ARCANEARCHER);
    }	

    return TRUE;
  }


  return FALSE;
}

//Levels up the creature based on what is in position 1
void LevelUpCreatureDefault(object creature)
{
//Default class leveling
  switch (GetClassByPosition(1))
  {
    case CLASS_TYPE_FIGHTER  :
	  if (GetPrimaryAbility(creature) == ABILITY_DEXTERITY)
      	LevelUpHenchman(creature, CLASS_TYPE_FIGHTER, TRUE, 151); //NPC_SHANDRA package
      else
	    LevelUpHenchman(creature, CLASS_TYPE_FIGHTER, TRUE, PACKAGE_FIGHTER);
	break;
    
    case CLASS_TYPE_BARBARIAN  :
      LevelUpHenchman(creature, CLASS_TYPE_BARBARIAN, TRUE, PACKAGE_BARBARIAN);
    break;

    case CLASS_TYPE_RANGER  :
      LevelUpHenchman(creature, CLASS_TYPE_RANGER, TRUE, PACKAGE_RANGER);
    break;

    case CLASS_TYPE_ROGUE  :
      LevelUpHenchman(creature, CLASS_TYPE_ROGUE, TRUE, PACKAGE_ROGUE);
    break;
    
    case CLASS_TYPE_DRUID  :
      LevelUpHenchman(creature, CLASS_TYPE_DRUID, TRUE, PACKAGE_DRUID);
    break;
	
    case CLASS_TYPE_CLERIC  :
      LevelUpHenchman(creature, CLASS_TYPE_CLERIC, TRUE, PACKAGE_CLERIC);
    break;

    case CLASS_TYPE_SPIRIT_SHAMAN  :
      LevelUpHenchman(creature, CLASS_TYPE_SPIRIT_SHAMAN, TRUE, 181); //Spirit Shaman Elementalist
    break;

    case CLASS_TYPE_SORCERER  :
      LevelUpHenchman(creature, CLASS_TYPE_SORCERER, TRUE, PACKAGE_SORCERER_EVOCATION);
    break;
    
    case CLASS_TYPE_WIZARD  :
      LevelUpHenchman(creature, CLASS_TYPE_WIZARD, TRUE, PACKAGE_WIZARD_EVOCATION);
    break;

    case CLASS_TYPE_BARD  :          
      LevelUpHenchman(creature, CLASS_TYPE_BARD, TRUE, PACKAGE_BARD);
    break;
    
    case CLASS_TYPE_ANIMAL:
      LevelUpHenchman(creature, CLASS_TYPE_ANIMAL, TRUE, PACKAGE_ANIMAL);
    break;

    case CLASS_TYPE_HUMANOID  :
      LevelUpHenchman(creature, CLASS_TYPE_HUMANOID, TRUE, PACKAGE_HUMANOID);
    break;
    
    case CLASS_TYPE_VERMIN  :
      LevelUpHenchman(creature, CLASS_TYPE_VERMIN, TRUE, PACKAGE_VERMIN);
    break;

    case CLASS_TYPE_MAGICAL_BEAST  :
      LevelUpHenchman(creature, CLASS_TYPE_MAGICAL_BEAST, TRUE, PACKAGE_MAGICBEAST);
    break;

	case CLASS_TYPE_OOZE  :
      LevelUpHenchman(creature,CLASS_TYPE_OOZE, TRUE, 68); // General Ooze Package
    break;
	
	case CLASS_TYPE_SHAPECHANGER  :
      LevelUpHenchman(creature,CLASS_TYPE_SHAPECHANGER, TRUE, PACKAGE_SHAPECHANGER);
    break;
	
    default:
      LevelUpHenchman(creature, CLASS_TYPE_FIGHTER, TRUE, PACKAGE_FIGHTER);
  }
}

//Adds an armor bonus to the creature based on levelToAchieve
void DoArmorBonus(object creature, int levelToAchieve)
{
  float armorBonus = ARMOR_PROGRESS_PER_LEVEL * IntToFloat(levelToAchieve);
  
  //Apply armor bonus instantly so it can't be removed
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectACIncrease(MathRound(armorBonus)),creature);
}


//Adds a bonus to the creature's primary stat based on levelToAchieve
void DoStatBonus(object creature, int levelToAchieve)
{
  float statBonus = PRIMARY_STAT_PROGRESS_PER_LEVEL * IntToFloat(levelToAchieve);
  int primaryAbility = GetPrimaryAbility(creature);

  //Traits
  if (GetHasTrait(creature, TRAIT_TOUGH))
    DoToughTrait(creature,primaryAbility,statBonus);
  if (GetHasTrait(creature, TRAIT_BIG))
    statBonus = DoBigTrait(creature,primaryAbility,statBonus);

  if (GetHasTrait(TRAIT_BIG))
  {
    if (primaryAbility == ABILITY_DEXTERITY)
      statBonus -= 2;
    else
      ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectAbilityDecrease(ABILITY_DEXTERITY, 2),creature);

    if (primaryAbility == ABILITY_STRENGTH)
      statBonus =+ 4;    
    else
      ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectAbilityIncrease(ABILITY_STRENGTH, 4),creature);
  }

  //Apply ability bonus instantly so it can't be removed
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectAbilityIncrease(primaryAbility, MathRound(statBonus)),creature);
}


//Adds a bonus to the creature's weapons based on levelToAchieve
void DoWeaponBonus(object creature, int levelToAchieve)
{
  float weaponBonus = WEAPON_PROGRESS_PER_LEVEL * IntToFloat(levelToAchieve);  
  
  //Cycle through inventory
  int bFoundWeapon = FALSE;
  object curItem = GetFirstItemInInventory(creature);
  while (GetIsObjectValid(curItem))
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
      
    curItem = GetNextItemInInventory(creature);
  }
  
  //No items?  Buff its natural attack
  if (bFoundWeapon == FALSE)
  {
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectAttackIncrease(MathRound(weaponBonus)),creature);
  }
}

// Rounds to the closest number
int MathRound(float baseNumber)
{
  return FloatToInt(baseNumber + 0.509f);
}

// Returns highest ability score, favors STR>DEX>CON>INT>WIS>CHA
int GetPrimaryAbility(object targetCreature)
{
  //setup to start
  int curHighestAbility = ABILITY_STRENGTH;
  int curHighestScore = GetAbilityScore(targetCreature,ABILITY_STRENGTH,TRUE);
  
  //loop through the rest looking for our best choice.  Ability scores are numerally from 0 to 5
  int i, testScore = 0;
  for (i = 1; i < 6; i++)
  {
    testScore = GetAbilityScore(targetCreature,i,TRUE);
    // Check to see the current ability score we are looking at is higher than what has come before
    if (testScore > curHighestScore)
    {
      curHighestAbility = i;  
      curHighestScore = testScore;
    }
  }
  
  return curHighestAbility;
}