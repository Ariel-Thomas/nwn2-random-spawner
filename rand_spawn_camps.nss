#include "rand_spawn_consts" 

// Sets up random camps to spawn via the NESS camp spawns
void SpawnRandomCamps(object oCamp, string sCamp, location lCamp);

// Helpers
// Sets up basics for the random camp
void InitializeCamp(object oCamp, float radius=1.0f);
// Adds a placeable to the camp
void AddPlaceableToCamp(string resRef, object oCamp, string flags="SP_SF");
// Adds a creature to the camp
void AddCreatureToCamp(string resRef, object oCamp, string flags="SP_PC60_CD60");
// Gets a random trap resref
string GetRandomTrapByLocalLevel();

//Returns RARITY_* denoting how rare of a creature is spawned
int GetCreatueRarity();

// *****************
// *** FUNCTIONS ***
// *****************


// Sets up random camps to spawn via the NESS camp spawns
void SpawnRandomCamps(object oCamp, string sCamp, location lCamp)
{
	// check the local string for camp type
  string MonsterType = GetLocalString(GetArea(OBJECT_SELF),"AREA_CREATURE_TYPE");

  // ****************************************************
	// **										KOBOLDS											***
	// ****************************************************
	if (MonsterType == "Kobold")
	{ 
		int numCreatures = d4(1) + 1;
	
		InitializeCamp(oCamp);
			
    // Always have a campfire at the center of the camp
		AddPlaceableToCamp("plc_mr_campfire2",oCamp);
  	// Always have a kobold fighter present
    AddCreatureToCamp("c_kobold_rand_fighter", oCamp);

    int i;
		for (i = 1; i < numCreatures ; i++)
		{ 
			switch( GetCreatueRarity() )
			{
				case RARITY_COMMON :
					switch(Random(3))
					{
						case 0	:
		    			AddCreatureToCamp("c_kobold_rand_fighter", oCamp);
						break;
						case 1	:
		    			AddCreatureToCamp("c_kobold_rand_rogue", oCamp);
	    			break;
						case 2	:
		    			AddCreatureToCamp("c_kobold_rand_sorcerer", oCamp);
						break;
	    		}
				break;

				case RARITY_UNCOMMON:
					switch(Random(2))
					{
						case 0	:
		    			AddCreatureToCamp("c_kobold_rand_disciple", oCamp);
						break;
						case 1  :
		    			AddCreatureToCamp("c_kobold_rand_dire_weasel", oCamp);
		    			AddCreatureToCamp("c_kobold_rand_dire_weasel", oCamp);
						break;
					}
				break;

				case RARITY_RARE:
					switch(Random(1))
					{
						case 0  :
		    			AddCreatureToCamp("c_kobold_rand_trapmaster", oCamp);
							AddPlaceableToCamp(GetRandomTrapByLocalLevel(), oCamp);
						break;
					}
				break;
			}
		}
	}
	
	// ****************************************************
	// **											ORCS											***
	// ****************************************************
	if (MonsterType == "Orcs")
	{
		int numCreatures = d4(1) + 1;
	
		InitializeCamp(oCamp);
			
    // Always have a campfire at the center of the camp
		AddPlaceableToCamp("plc_mr_campfire2",oCamp);
  	// Always have a kobold fighter present
    AddCreatureToCamp("c_orc_rand_barbarian", oCamp);

    int i;
		for (i = 1; i < numCreatures ; i++)
		{ 

			switch( GetCreatueRarity() )
			{
				case RARITY_COMMON :
					switch(Random(3))
					{
						case 0	:
		    			AddCreatureToCamp("c_orc_rand_barbarian", oCamp);
						break;
						case 1	:
		    			AddCreatureToCamp("c_orc_rand_fighter", oCamp);
		    		break;
						case 2	:
		    			AddCreatureToCamp("c_orc_rand_goblin", oCamp);
		    			AddCreatureToCamp("c_orc_rand_goblin", oCamp);
						break;
					}
				break;

				case RARITY_UNCOMMON:
					switch(Random(2))
					{
						case 0	:
		    			AddCreatureToCamp("c_orc_rand_berserker", oCamp);
						break;
						case 1  :
		    			AddCreatureToCamp("c_orc_rand_shaman", oCamp);
						break;
					}
				break;

				case RARITY_RARE:
					switch(Random(1))
					{
						case 0  :
		    			AddCreatureToCamp("c_orc_rand_oozemaster", oCamp);
		    			AddCreatureToCamp("c_orc_rand_ooze", oCamp);
						break;
					}
				break;
			}

		}
	}
	
	// ****************************************************
	// **											DROW											***
	// ****************************************************
	if (MonsterType == "Drow")
	{ 
		int numCreatures = d4(1) + 1;
	
		InitializeCamp(oCamp);
			
    // Always have a campfire at the center of the camp
		AddPlaceableToCamp("plc_mr_campfire2",oCamp);
  	// Always have a kobold fighter present
    AddCreatureToCamp("c_drow_rand_fighter", oCamp);

    int i;
		for (i = 1; i < numCreatures ; i++)
		{ 
			switch( GetCreatueRarity() )
			{
				case RARITY_COMMON :
					switch(Random(3))
					{
						case 0	:
		    			AddCreatureToCamp("c_drow_rand_fighter", oCamp);
						break;
						case 1	:
		    			AddCreatureToCamp("c_drow_rand_archer", oCamp);
	    			break;
						case 2	:
		    			AddCreatureToCamp("c_drow_rand_spider", oCamp);
		    			AddCreatureToCamp("c_drow_rand_spider", oCamp);
						break;
	    		}
				break;

				case RARITY_UNCOMMON:
					switch(Random(2))
					{
						case 0	:
		    			AddCreatureToCamp("c_drow_rand_priest", oCamp);
						break;
						case 1  :
		    			AddCreatureToCamp("c_drow_rand_wizard", oCamp);
						break;
					}
				break;

				case RARITY_RARE:
					switch(Random(1))
					{
						case 0  :
		    			AddCreatureToCamp("c_drow_rand_drider", oCamp);
						break;
					}
				break;
			}
		}
	}

	// ****************************************************
	// **											WOLF											***
	// ****************************************************
	if (MonsterType == "Wolf")
	{ 
		int numCreatures = d4(1) + 1;
	
		InitializeCamp(oCamp);
			
    // Always have a campfire at the center of the camp
		AddPlaceableToCamp("plc_mr_campfire2",oCamp);
  	// Always have a kobold fighter present
    AddCreatureToCamp("c_wolf_rand_beta", oCamp);

    int i;
		for (i = 1; i < numCreatures ; i++)
		{ 
			switch( GetCreatueRarity() )
			{
				case RARITY_COMMON :
					switch(Random(3))
					{
						case 0	:
		    			AddCreatureToCamp("c_wolf_rand_beta", oCamp);
						break;
						case 1	:
		    			AddCreatureToCamp("c_wolf_rand_winter", oCamp);
	    			break;
						case 2	:
		    			AddCreatureToCamp("c_wolf_rand_omega", oCamp);
		    			AddCreatureToCamp("c_wolf_rand_omega", oCamp);
						break;
	    		}
				break;

				case RARITY_UNCOMMON:
					switch(Random(2))
					{
						case 0	:
		    			AddCreatureToCamp("c_wolf_rand_druid", oCamp);
						break;
						case 1  :
		    			AddCreatureToCamp("c_wolf_rand_fiendish", oCamp);
						break;
					}
				break;

				case RARITY_RARE:
					switch(Random(2))
					{
						case 0  :
		    			AddCreatureToCamp("c_wolf_rand_werewolf", oCamp);
						break;
						case 1  :
		    			AddCreatureToCamp("c_wolf_rand_den_mother", oCamp);
						break;

					}
				break;
			}
		}
	}
}

// Sets up basics for the random camp
void InitializeCamp(object oCamp, float radius){
		//Set Number of Paceables
		SetLocalInt(oCamp, "CampNumP", 0);
		//Set Number of Creatures
		SetLocalInt(oCamp, "CampNumC", 0);
    // Set Radius of Camp
    SetLocalFloat(oCamp, "CampRadius", radius);
		
		// Set Placeable 0 to be Camp Center
   	SetLocalString(oCamp, "CampCenter", "P0");
}

// Adds a placeable to the camp
void AddPlaceableToCamp(string resRef, object oCamp, string flags)
{
	int curPlaceableNum =  GetLocalInt(oCamp, "CampNumP");
	SetLocalInt(oCamp, "CampNumP",  curPlaceableNum + 1);

	// Set Creature ResRef and Spawn Flags
	SetLocalString(oCamp, "CampP" + IntToString(curPlaceableNum), resRef	);
	SetLocalString(oCamp, "CampP" + IntToString(curPlaceableNum) + "_Flags", flags);
}


// Adds a random trap placeable to the area to be spawned
void AddCreatureToCamp(string resRef, object oCamp,string flags)
{
	int curCreatureNum =  GetLocalInt(oCamp, "CampNumC");
	SetLocalInt(oCamp, "CampNumC", curCreatureNum + 1);

	// Set Creature ResRef and Spawn Flags
	SetLocalString(oCamp, "CampC" + IntToString(curCreatureNum), resRef	);
	SetLocalString(oCamp, "CampC" + IntToString(curCreatureNum) + "_Flags", flags);
}

// Gets a random trap resref
string GetRandomTrapByLocalLevel()
{
	string trapResRef;
	trapResRef = "nw_mspiketrap001";

	return trapResRef;
	//TODO: More traps
}

//Returns RARITY_* denoting how rare of a creature is spawned
int GetCreatueRarity()
{
	int result = Random(RARITY_COMMON_RATIO + RARITY_UNCOMMON_RATIO + RARITY_RARE_RATIO);

	if (result < RARITY_COMMON_RATIO)
		return RARITY_COMMON;
	else if (result < RARITY_UNCOMMON_RATIO + RARITY_UNCOMMON_RATIO)
		return RARITY_UNCOMMON;
	else
		return RARITY_RARE;
}