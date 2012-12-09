// Random Spawn System Constants

// Percentage chance of spawning a camp each hour
const int DEFAULT_CHANCE_OF_SPAWN = 10;
// Percentage chance of existing camps despawning each hour
const int DEFAULT_CHANCE_OF_DESPAWN = 10;
// The number of traits an area will have by defaut
const int DEFAULT_NUM_AREA_TRAITS = 1;
// The percentage of spawns in an area that must be cleared for it to be considered cleared
const int DEFAULT_CLEAR_PERCENTAGE = 80;


// Adjust these constants to affect how much of a bonus creatures recieve each level in various areas
const float ARMOR_PROGRESS_PER_LEVEL = 1.0f;
const float PRIMARY_STAT_PROGRESS_PER_LEVEL = 0.4f;
const float WEAPON_PROGRESS_PER_LEVEL = 0.333f;


// *********************
// **   Spawn Chance  **
// *********************
const int NO_SPAWN = -1;
const int AREA_USES_DEFAULT_SPAWN_CHANCE = 0;
const int NO_DESPAWN = -1;
const int AREA_USES_DEFAULT_DESPAWN_CHANCE = 0;

// *********************
// ** CREATURE RARITY **
// *********************

const int RARITY_COMMON = 0;
const int RARITY_UNCOMMON = 1;
const int RARITY_RARE = 2;

const int RARITY_COMMON_RATIO = 10;
const int RARITY_UNCOMMON_RATIO = 4;
const int RARITY_RARE_RATIO = 1;


// ********************
// ** CAMP CONSTANTS **
// ********************
const string CAMP_INVALID       = "";
const int TOTAL_NUM_CAMPS = 4;

const string CAMP_KOBOLD        = "Kobold";
const int CAMP_KOBOLD_MIN_LEVEL = 1;
const int CAMP_KOBOLD_MAX_LEVEL = 12;

const string CAMP_ORC        = "Orc";
const int CAMP_ORC_MIN_LEVEL = 1;
const int CAMP_ORC_MAX_LEVEL = 20;

const string CAMP_DROW        = "Drow";
const int CAMP_DROW_MIN_LEVEL = 5;
const int CAMP_DROW_MAX_LEVEL = 20;

const string CAMP_WOLF        = "Wolf";
const int CAMP_WOLF_MIN_LEVEL = 3;
const int CAMP_WOLF_MAX_LEVEL = 13;

// *********************
// ** TRAIT CONSTANTS **
// *********************

// Rdandom Spawn System Trait Constants
// DO NOT TOUCH UNLESS ADDING NEW TRAITS

// Set NUM_AREA_TRAITS on area to this to have no traits
const int NO_AREA_TRAITS                =  -1;

// Not a trait
const int TRAIT_INVALID                 =   0;
//Negative integer traits will not be randomly added
const int TRAIT_TAINTED                 =  -1;

//Positive integer traits that will be randomly added
const int TOTAL_NUM_TRAITS = 17;
const int TRAIT_FLAMING_WEAPONS         =   1;
const int TRAIT_FROST_WEAPONS           =   2;
const int TRAIT_SHOCK_WEAPONS           =   3;
const int TRAIT_ACERBIC_WEAPONS         =   4;
const int TRAIT_THUNDERING_WEAPONS      =   5;
const int TRAIT_FLAME_RETARDANT         =   6;
const int TRAIT_FROST_RETARDANT         =   7;
const int TRAIT_WELL_GROUNDED           =   8;
const int TRAIT_CORROSION_RESISTANT     =   9;
const int TRAIT_SONIC_INSULATION        =  10;
const int TRAIT_BIG                     =  11;
const int TRAIT_SMALL                   =  12;
const int TRAIT_TOUGH                   =  13;
const int TRAIT_THICK_SKINNED           =  14;
const int TRAIT_PIERCING_RESISTANT      =  15;
const int TRAIT_SLASHING_RESISTANT      =  16;
const int TRAIT_BLUDGEONING_RESISTANT   =  17;
// DO NOT TOUCH UNLESS ADDING NEW TRAITS