// Rounds to the closest number
int MathRound(float baseNumber);

// Rounds to the closest number
int MathRound(float baseNumber)
{
  return FloatToInt(baseNumber + 0.509f);
}