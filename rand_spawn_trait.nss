#include "rand_spawn_consts" 
#include "rand_spawn_math"

// Core Trait Functions

//Determins which traits creature should have and stores them on the creature
void SetupTraits(object creature, int levelToAchieve);
//Applies special trait effects to creature
void DoTraits(object creature, int levelToAchieve);
//Applies specific trait to creature
void ApplyTrait(object creature, int trait, int levelToAchieve);


// Trait specific functions

// Applies damage scaled to levelToAchieve of type damageType
void DoDamageTrait(object creature, int levelToAchieve, int damageType);
// Applies damage resistance to levelToAchieve of type damageType
void DoDamageResistanceTrait(object creature, int levelToAchieve, int damageType);
// Applies damage reduction to creature scaled by levelToAchieve
void DoThickSkinnedTrait(object creature, int levelToAchieve);
//Bonus to Con equivalent to Stat Bonus, if Con primary attribute, HP/Fort
void DoToughTrait(object creature, int primaryAbility, float statBonus);
//+4 Str, -2 Dex
float DoBigTrait(object creature, int primaryAbility, float statBonus);
//+4 Dex, -2 Str
float DoSmallTrait(object creature, int primaryAbility, float statBonus);


// Helpers

//Gets if creature has a particular trait
int GetHasTrait(object creature, int trait);
//Returns the appropriate DAMAGE_BONUS_* for the specified amount 
int TraitDamageBonusByAmount(int amount);

//Determins which traits creature should have and stores them on the creature
void SetupTraits(object creature, int levelToAchieve)
{
  int areaTrait = 0;
  int traitNum = 0;

  do
  {
    traitNum++;
    areaTrait = GetLocalInt(creature,"AREA_TRAIT_" + IntToString(traitNum));

    if (areaTrait != 0)
      SetLocalInt(creature,"CREATURE_TRAIT_" + IntToString(traitNum),areaTrait);
  }
  while (areaTrait != 0);

  while (traitNum < 2)
  {
    SetLocalInt(creature,"CREATURE_TRAIT_" + IntToString(traitNum),Random(TOTAL_NUM_TRAITS) + 1);
    traitNum++;
  }
}

//Applies special trait effects to creature
void DoTraits(object creature, int levelToAchieve)
{
  int creatureTrait = 0;
  int traitNum = 0;

  do
  {
    traitNum++;
    creatureTrait = GetLocalInt(creature,"CREATURE_TRAIT_" + IntToString(traitNum));

    if (creatureTrait != 0)
      ApplyTrait(creature, creatureTrait, levelToAchieve);
  }
  while (creatureTrait != 0);
}

//Applies specific trait to creature
void ApplyTrait(object creature, int trait, int levelToAchieve)
{
  switch (trait)
  {
    case TRAIT_FLAMING_WEAPONS:
      DoDamageTrait(creature, levelToAchieve, DAMAGE_TYPE_FIRE);
    break;
    case TRAIT_FROST_WEAPONS:
      DoDamageTrait(creature, levelToAchieve, DAMAGE_TYPE_COLD);
    break;
    case TRAIT_SHOCK_WEAPONS:
      DoDamageTrait(creature, levelToAchieve, DAMAGE_TYPE_ELECTRICAL);
    break;
    case TRAIT_ACERBIC_WEAPONS:
      DoDamageTrait(creature, levelToAchieve, DAMAGE_TYPE_ACID);
    break;
    case TRAIT_THUNDERING_WEAPONS:
      DoDamageTrait(creature, levelToAchieve, DAMAGE_TYPE_SONIC);
    break;
    case TRAIT_FLAME_RETARDANT:
      DoDamageResistanceTrait(creature, levelToAchieve, DAMAGE_TYPE_FIRE);
    break;
    case TRAIT_FROST_RETARDANT:
      DoDamageResistanceTrait(creature, levelToAchieve, DAMAGE_TYPE_COLD);
    break;
    case TRAIT_WELL_GROUNDED:
      DoDamageResistanceTrait(creature, levelToAchieve, DAMAGE_TYPE_ELECTRICAL);
    break;
    case TRAIT_CORROSION_RESISTANT:
      DoDamageResistanceTrait(creature, levelToAchieve, DAMAGE_TYPE_ACID);
    break;
    case TRAIT_SONIC_INSULATION:
      DoDamageResistanceTrait(creature, levelToAchieve, DAMAGE_TYPE_SONIC);
    break;
    case TRAIT_THICK_SKINNED:
      DoThickSkinnedTrait(creature,levelToAchieve);
    break;
    case TRAIT_PIERCING_RESISTANT:
      DoDamageResistanceTrait(creature, levelToAchieve, DAMAGE_TYPE_PIERCING);
    break;
    case TRAIT_SLASHING_RESISTANT:
      DoDamageResistanceTrait(creature, levelToAchieve, DAMAGE_TYPE_SLASHING);
    break;
    case TRAIT_BLUDGEONING_RESISTANT:
      DoDamageResistanceTrait(creature, levelToAchieve, DAMAGE_TYPE_BLUDGEONING);
    break;
  }
}


// ********************************
// **  TRAIT SPECIFIC FUNCTIONS  **
// ********************************


// Applies damage scaled to levelToAchieve / 2 of type damageType
void DoDamageTrait(object creature, int levelToAchieve, int damageType)
{
  int damageBonus = TraitDamageBonusByAmount( (levelToAchieve + 1) / 2 );
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamageIncrease(damageBonus,damageType),creature);
}

// Applies damage resistance to levelToAchieve * 2 of type damageType
void DoDamageResistanceTrait(object creature, int levelToAchieve, int damageType)
{
  int resistAmount = levelToAchieve * 2;
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamageResistance(damageType,resistAmount),creature);
}

// Applies damage reduction to creature scaled by levelToAchieve
void DoThickSkinnedTrait(object creature, int levelToAchieve)
{
  int reducedAmount = (levelToAchieve + 1) / 2;
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamageReduction(reducedAmount,DR_TYPE_NONE),creature);
}

//Bonus to Con equivalent to Stat Bonus, if Con primary attribute, HP/Fort
void DoToughTrait(object creature, int primaryAbility, float statBonus)
{
  if (primaryAbility == ABILITY_CONSTITUTION)
  {
    float tempHitPointAmount = statBonus * statBonus / (2.0f * PRIMARY_STAT_PROGRESS_PER_LEVEL);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectTemporaryHitpoints(MathRound(tempHitPointAmount)),creature);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectSavingThrowIncrease(SAVING_THROW_FORT, MathRound(statBonus / 2.0f)),creature);
  }
  else
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectAbilityIncrease(ABILITY_CONSTITUTION, MathRound(statBonus)),creature);
}


//+4 Str, -2 Dex
float DoBigTrait(object creature, int primaryAbility, float statBonus)
{
  float returnedBonus = statBonus;

  if (primaryAbility == ABILITY_DEXTERITY)
    returnedBonus -= 2;
  else
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectAbilityDecrease(ABILITY_DEXTERITY, 2),creature);

  if (primaryAbility == ABILITY_STRENGTH)
    returnedBonus += 4;    
  else
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectAbilityIncrease(ABILITY_STRENGTH, 4),creature);

  return returnedBonus;
}

//+4 Dex, -2 Str
float DoSmallTrait(object creature, int primaryAbility, float statBonus)
{
  float returnedBonus = statBonus;

  if (primaryAbility == ABILITY_STRENGTH)
    returnedBonus -= 2;
  else
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectAbilityDecrease(ABILITY_STRENGTH, 2),creature);

  if (primaryAbility == ABILITY_DEXTERITY)
    returnedBonus += 4;    
  else
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectAbilityIncrease(ABILITY_DEXTERITY, 4),creature);

  return returnedBonus;
}


// *******************************
// **          HELPERS          **
// *******************************

//Gets if creature has a particular trait
int GetHasTrait(object creature, int trait)
{
  int creatureTrait = 0;
  int traitNum = 0;

  do
  {
    traitNum++;
    creatureTrait = GetLocalInt(creature,"CREATURE_TRAIT_" + IntToString(traitNum));

    if (creatureTrait == trait)
      return TRUE;
  }
  while (creatureTrait != 0);

  return FALSE;
}

//Returns the appropriate DAMAGE_BONUS_* for the specified integer 
int TraitDamageBonusByAmount(int amount)
{
  switch (amount)
  {
    case 1:
      return DAMAGE_BONUS_1;
    break;
    case 2:
      return DAMAGE_BONUS_2;
    break;
    case 3:
      return DAMAGE_BONUS_3;
    break;
    case 4:
      return DAMAGE_BONUS_4;
    break;
    case 5:
      return DAMAGE_BONUS_5;
    break;
    case 6:
      return DAMAGE_BONUS_6;
    break;
    case 7:
      return DAMAGE_BONUS_7;
    break;
    case 8:
      return DAMAGE_BONUS_8;
    break;
    case 9:
      return DAMAGE_BONUS_9;
    break;
    case 19:
      return DAMAGE_BONUS_10;
    break;
    default:
      return DAMAGE_BONUS_1;
  }

  return DAMAGE_BONUS_1;
}