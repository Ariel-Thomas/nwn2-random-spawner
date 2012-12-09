#include "rss_consts" 
#include "rss_camps_helper"

// Sets up random camps to spawn via the NESS camp spawns
void SpawnRandomCamps(object oCamp, string sCamp, location lCamp);

// AddCamp function
// Adds kobold members to the camp
void AddKoboldsToCamp(object oCamp);
// Adds orc members to the camp
void AddOrcsToCamp(object oCamp);
// Adds drow members to the camp
void AddDrowToCamp(object oCamp);
// Adds wolf members to the camp
void AddWolvesToCamp(object oCamp);

// *****************
// *** FUNCTIONS ***
// *****************


// Sets up random camps to spawn via the NESS camp spawns
void SpawnRandomCamps(object oCamp, string sCamp, location lCamp)
{
	// check the local string for camp type
  string MonsterType = GetLocalString(GetArea(OBJECT_SELF),"AREA_CREATURE_TYPE");

	if (MonsterType == CAMP_KOBOLD)
		AddKoboldsToCamp(oCamp);

	if (MonsterType == CAMP_ORC)
		AddOrcsToCamp(oCamp);

	if (MonsterType == CAMP_DROW)
		AddDrowToCamp(oCamp);

	if (MonsterType == CAMP_WOLF)
		AddWolvesToCamp(oCamp);
}


// AddCamp function

// Adds kobold members to the camp
void AddKoboldsToCamp(object oCamp)
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

// Adds orc members to the camp
void AddOrcsToCamp(object oCamp)
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


// Adds drow members to the camp
void AddDrowToCamp(object oCamp)
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

// Adds wolf members to the camp
void AddWolvesToCamp(object oCamp)
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
