//Levels creature up to levelToAchieve based on class in position 1
void DoLevelUp(object creature, int levelToAchieve);
//Adds and armor bonus to the creature based on levelToAchieve
void DoArmorBonus(object creature, int levelToAchieve);


// Rounds to the closest number
int MathRound(float baseNumber);

// Returns highest ability score, favors STR>DEX>CON>INT>WIS>CHA
int GetPrimaryAbility(object targetCreature);



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


//Levels creature up to levelToAchieve based on class in position 1
void DoLevelUp(object creature, int levelToAchieve)
{
  int classType,packageType;
  
  int i;
  for (i = GetHitDice(creature); i < levelToAchieve; i++)
  {
    //Determine which class we're leveling up.  TODO: Make custom leveling sequences
    switch (GetClassByPosition(1))
    {
      case CLASS_TYPE_FIGHTER  :
        classType = CLASS_TYPE_FIGHTER; 
        packageType = PACKAGE_FIGHTER_FINESSE;
          break;
      case CLASS_TYPE_ROGUE  :
        classType = CLASS_TYPE_ROGUE;
        packageType = PACKAGE_ROGUE;
          break;
      case CLASS_TYPE_SORCERER  :
        classType = CLASS_TYPE_SORCERER;
        packageType = PACKAGE_SORCERER_EVOCATION;
          break;
      case CLASS_TYPE_BARD  :
        if (GetLevelByPosition(1) >= 5 &&
            GetLevelByPosition(2) <= 10)
        {
          classType = CLASS_TYPE_DRAGONDISCIPLE;
          packageType = PACKAGE_DRAGON_DISCIPLE;
        }
        else
        {
          classType = CLASS_TYPE_BARD;
          packageType = PACKAGE_BARD_BLADE;  
        }    
          break;
      default:
        classType = CLASS_TYPE_FIGHTER; 
        packageType = PACKAGE_FIGHTER_FINESSE;
    }
    
    LevelUpHenchman(creature, classType, TRUE,packageType);
  }
}

//Adds and armor bonus to the creature based on levelToAchieve
void DoArmorBonus(object creature, int levelToAchieve)
{
  //Apply Armor bonus instantly so it can't be removed
  float armorBonus = GetLocalFloat(GetModule(),"ARMOR_PROGRESS_PER_LEVEL");
  //Remove Later?
  if ( armorBonus == 0.0f ) armorBonus = 1.0f;
  armorBonus *= IntToFloat(levelToAchieve);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectACIncrease(MathRound(armorBonus)),creature);
}
