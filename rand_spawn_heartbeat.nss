#include "rand_spawn_consts"
#include "rand_spawn_setup_area"

//rand_spawn_heartbeat

//This function serves as a pseudoheartbeat
void RSSHeartbeat();

//Returns TRUE if the area has any creatures in it
int DoesAreaHaveCreatures(object area);
//Returns TRUE if the area has had enough camps killed to be cleared.  Also reactivates spawns in the area.
int IsAreaCleared(object area);

//Returns the chance out of a 100 that this area should be set up to spawn creatures
int GetSpawnChance(object area);
//Returns the chance out of a 100 that this area should be torn down to despawn creatures
int GetDespawnChance(object area);
// Returns the percentage of spawns in the area that must be killed for it to be considered cleared
float GetAreaClearedPercentage(object area);

void main()
{
  RSSHeartbeat();
}

void RSSHeartbeat()
{
  if (GetLocalInt(OBJECT_SELF, "AREA_SPAWN_READY")) 
  {
    int despawnArea = FALSE;

    //Has area been cleared?
    //void IsAreaClear(OBJECT_SELF)


    //Should we despawn?
    if (d100(1) <= GetDespawnChance(OBJECT_SELF))
      despawnArea = TRUE;

    if (despawnArea == TRUE)
      TeardownAreaForRSS(OBJECT_SELF);
  }
  else
  {
    //Should we spawn?
    if (d100(1) <= GetSpawnChance(OBJECT_SELF))
      SetupAreaForRSS(OBJECT_SELF);
  }

  //float timeUntilNextBeat = 2700 + Random(1800); // 60 min +- 15 min
  float timeUntilNextBeat = 60.0f; // Short duration for testing
  DelayCommand(timeUntilNextBeat, RSSHeartbeat());
}


//Returns the chance out of a 100 that this area should be set up to spawn creatures
int GetSpawnChance(object area)
{
  int chanceOfSpawn = GetLocalInt(area, "AREA_SPAWN_CHANCE");

  if (chanceOfSpawn == AREA_USES_DEFAULT_SPAWN_CHANCE)
    chanceOfSpawn = DEFAULT_CHANCE_OF_SPAWN;

  if (chanceOfSpawn == NO_SPAWN)
    chanceOfSpawn = 0;

  return chanceOfSpawn;
}

//Returns the chance out of a 100 that this area should be torn down to despawn creatures
int GetDespawnChance(object area)
{
  int chanceOfDespawn = GetLocalInt(area, "AREA_DESPAWN_CHANCE");

  if (chanceOfDespawn == AREA_USES_DEFAULT_DESPAWN_CHANCE)
    chanceOfDespawn = DEFAULT_CHANCE_OF_DESPAWN;

  if (chanceOfDespawn == NO_DESPAWN)
    chanceOfDespawn = 0;

  return chanceOfDespawn;
}

//Returns TRUE if the area has any creatures in it
int DoesAreaHaveCreatures(object area)
{
  object areaObject = GetFirstObjectInArea(area);

  while (GetIsObjectValid(areaObject))
  {
    if (GetObjectType(areaObject) == OBJECT_TYPE_CREATURE)
      return TRUE;

    areaObject = GetNextObjectInArea(area);
  }

  return FALSE;
}

//Returns TRUE if the area has had enough camps killed to be cleared. Also reactivates spawns in the area.
int IsAreaCleared(object area)
{
  object areaObject = GetFirstObjectInArea(area);
  int clearedCount = 0;
  int totalCount = 0;

  while (GetIsObjectValid(areaObject))
  {
    if (GetObjectType(areaObject) == OBJECT_TYPE_WAYPOINT)
    {
      totalCount++;
      if (GetLocalInt(curObj, "SpawnDeactivated"))
      {
        clearedCount++;
        GetLocalInt(curObj, "SpawnDeactivated", FALSE);
      }
    }

    areaObject = GetNextObjectInArea(area);
  }

  float clearedPercentage = IntToFloat(clearedCount) / IntToFloat(totalCount + clearedCount) * 100.0f;
  if (clearedPercentage >= GetAreaClearedPercentage(area))
    return TRUE;

  return FALSE;
}

// Returns the percentage of spawns in the area that must be killed for it to be considered cleared
float GetAreaClearedPercentage(object area)
{
  int clearPercentage = GetLocalInt(area, "AREA_CLEAR_PERCENTAGE");

  if (clearPercentage == 0)
    return DEFAULT_CLEAR_PERCENTAGE

  return clearPercentage;
}