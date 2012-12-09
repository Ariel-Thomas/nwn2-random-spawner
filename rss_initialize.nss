#include "rss_consts"

//On module loads, fire this script to start the delayed heartbeat.

void main()
{
  //Cycle through mod and set the ball rolling for each area
  object currentArea = GetFirstArea();

  while (GetIsObjectValid(currentArea))
  {
    if (GetLocalInt(area,"RANDOM_SPAWN_AREA") == TRUE)
      ExecuteScript("rand_spawn_heartbeat", area);

    currentArea = GetNextArea();
  }
}