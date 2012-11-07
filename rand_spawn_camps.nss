void SpawnRandomCamps(object oCamp, string sCamp, location lCamp);

void SpawnRandomCamps(object oCamp, string sCamp, location lCamp)
{
  string MonsterType = GetLocalString(GetArea(OBJECT_SELF),"AREA_CREATURE_TYPE");

	// check the local int for camp type
	
  switch(MonsterType)
	{
	// ****************************************************
	// **					KOBOLDS						***
	// ****************************************************
	case "Kobold": 
		int numCreatures = d4(1) + 1;
		string genericSpawnFlag = "SP_CD60";
	
		//Set Number of Paceables
		SetLocalInt(oCamp, "CampNumP", 1);
		//Set Number of Creatures
		SetLocalInt(oCamp, "CampNumC", numCreatures);
        // Set Radius of Camp
        SetLocalFloat(oCamp, "CampRadius", 1.0);
		
		// Set Placeable 0 to be Camp Center
       	SetLocalString(oCamp, "CampCenter", "P0");
					
        // Set Placeable 0 and Spawn Flags
        // First Placeable always Spawns at Center of Camp
        // If CampCenter Is Not Set
        SetLocalString(oCamp, "CampP0", "plc_mr_campfire2");
        SetLocalString(oCamp, "CampP0_Flags", "SP_SF");
					
      	// Set Creature 0 and Spawn Flags
       	SetLocalString(oCamp, "CampC0", "c_kobold_rand_fighter");
       	SetLocalString(oCamp, "CampC0_Flags", genericSpawnFlag);
		
		string spawnResRef = "";
		int i;
		for (i = 1; i < numCreatures ; i++)
		{
			switch(d4(1))
			{
				case 1	:
					spawnResRef = "c_kobold_rand_fighter";
					break;
				case 2	:
					spawnResRef = "c_kobold_rand_rogue";
					break;
				case 3	:
					spawnResRef = "c_kobold_rand_sorcerer";
					break;
				case 4	:
					spawnResRef = "c_kobold_rand_disciple";
					break;
			}
			
			// Set Creature i and Spawn Flags
			SetLocalString(oCamp, "CampC" + IntToString(i), spawnResRef	);
			SetLocalString(oCamp, "CampC" + IntToString(i) + "_Flags", genericSpawnFlag);
		}
	break;
	
	// ****************************************************
	// **					ORCS						***
	// ****************************************************
	case " " :
	
	
	break;
	}
}