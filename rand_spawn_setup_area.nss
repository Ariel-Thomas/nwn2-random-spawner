#include "rand_spawn_consts" 

//Sets up the area variables so random creatures will spawn here
void SetupAreaForRSS(object area);

//Returns a level for the area, based on constraints
int DetermineAreaLevel(object area);
//Returns a string with the creature type for the area
string DetermineAreaCreatureType(object area, int areaLevel);
//Returns "" if camp does not meet Mix or Max requirements provided.  Otherwise returns the camp name
string CreatureTypeMinMax(string creatureType, int min, int max, int areaLevel);

//Returns a string with the tribe name for the creature type in the area
string DetermineCreatureTypeTribe(string creatureType);

void SetupAreaForRSS(object area)
{
  int areaLevel = DetermineAreaLevel(area);
  SetLocalInt(area, "AREA_CREATURE_LEVEL", areaLevel);

  string creatureType = DetermineAreaCreatureType(area, areaLevel);
  SetLocalString(area, "AREA_CREATURE_TYPE", creatureType);

  string creatureTribe = DetermineCreatureTypeTribe(creatureType);
  SetLocalString(area, "AREA_CREATURE_TRIBE","");

  int areaTrait = TRAIT_TOUGH;
}


//Returns a level for the area, based on constraints
int DetermineAreaLevel(object area)
{
  int alwaysLevel = GetLocalInt(area,"AREA_CREATURE_LEVEL_ALWAYS")
  if (alwaysLevel >= 0)
    return alwaysLevel;

  int minCR = GetLocalInt(area, "MIN_LEVEL");
  if (minCR <= 0)
    minCR = 1;

  int maxCR = GetLocalInt(area, "MAX_LEVEL");
  if (maxCR <= 0)
    maxCR = 20;

  if (maxCR < minCR)
    maxCR = minCR;

  return minCR + Random(maxCR - minCR + 1)
}

//Returns a string with the creature type for the area
string DetermineAreaCreatureType(object area, int areaLevel)
{
  string creatureType = GetLocalString(area,"AREA_CREATURE_TYPE_ALWAYS");

  while (creatureType == "")
  {
    switch(Random(TOTAL_NUM_CAMPS))
    {
      case 0:
        creatureType = CreatureTypeMinMax(CAMP_KOBOLD, CAMP_KOBOLD_MIN_LEVEL, CAMP_KOBOLD_MAX_LEVEL, areaLevel);
      break;
      case 1:
        creatureType = CreatureTypeMinMax(CAMP_ORC, CAMP_ORC_MIN_LEVEL, CAMP_ORC_MAX_LEVEL, areaLevel);
      break;
      case 2:
        creatureType = CreatureTypeMinMax(CAMP_DROW, CAMP_DROW_MIN_LEVEL, CAMP_DROW_MAX_LEVEL, areaLevel);
      break;
      case 3:
        creatureType = CreatureTypeMinMax(CAMP_WOLF, CAMP_WOLF_MIN_LEVEL, CAMP_WOLF_MAX_LEVEL, areaLevel);
      break;
    }
  }

  return creatureType;
}

//Returns "" if camp does not meet Mix or Max requirements provided.  Otherwise returns the camp name
string CreatureTypeMinMax(string creatureType, int min, int max, int areaLevel)
{
  if ((areaLevel < min) || (areaLevel > max))
    return "";

  return creatureType;
}


//Returns a string with the tribe name for the creature type in the area
string DetermineCreatureTypeTribe(string creatureType)
{
  string creatureTribe = GetLocalString(area,"AREA_CREATURE_TRIBE_ALWAYS");
  if (creatureTribe != "")
    return creatureTribe;

  return "Default";
}