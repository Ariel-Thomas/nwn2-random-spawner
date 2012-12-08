#include "rand_spawn_consts"
#include "rand_spawn_setup_area"

//rand_spawn_heartbeat

//This function serves as a pseudoheartbeat
void RSSHeartbeat();

//Returns the chance out of a 100 that this area should be set up to spawn creatures
int GetSpawnChance(object area);
//Returns the chance out of a 100 that this area should be torn down to despawn creatures
int GetDespawnChance(object area);

void main()
{
  RSSHeartbeat();
}

void RSSHeartbeat()
{
  if (GetLocalString(area, "AREA_SPAWN_READY") == TRUE) 
  {
    int despawnArea = FALSE;

    //Has area been cleared?
    void IsAreaClear(OBJECT_SELF)


    //Should we despawn?
    if (d100(1) <= GetDespawnChance(OBJECT_SELF))
      despawnArea = TRUE;

    if (despawnArea == TRUE)
      TearDownAreaForRSS(OBJECT_SELF);
  }
  else
  {
    //Should we spawn?
    if (d100(1) <= GetSpawnChance(OBJECT_SELF))
      SetupAreaForRSS(OBJECT_SELF);
  }

  //float timeUntilNextBeat = 2700 + Random(1800); // 60 min +- 15 min
  float timeUntilNextBeat = 60 // Short duration for testing
  DelayCommand(IntToFloat(timeUntilNextBeat), RSSHeartbeat());
}


//Returns the chance out of a 100 that this area should be set up to spawn creatures
int GetSpawnChance(object area)
{
  int chanceOfSpawn = GetLocalInt(area, "AREA_SPAWN_CHANCE");

  if (chanceOfSpawn == AREA_USES_DEFAULT_SPAWN_CHANCE)
    chanceOfSpawn = DEFAULT_CHANCE_OF_SPAWN;

  if (chanceOfSpawn == NO_SPAWN)
    chanceOfSpawn = 0;

  return chanceOfSpawn
}

//Returns the chance out of a 100 that this area should be torn down to despawn creatures
int GetDespawnChance(object area)
{
  int chanceOfDespawn = GetLocalInt(area, "AREA_DESPAWN_CHANCE");

  if (chanceOfDespawn == AREA_USES_DEFAULT_DESPAWN_CHANCE)
    chanceOfDespawn = DEFAULT_CHANCE_OF_DESPAWN;

  if (chanceOfDespawn == NO_DESPAWN)
    chanceOfDespawn = 0;

  return chanceOfDespawn
}