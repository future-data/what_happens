
@outputSchema("value: int")
def discretize_tod(val):
  hour = int(val[:2])
  if hour < 8:
    return 0
  if hour < 16:
    return 1
  return 2

@outputSchema("date: chararray")
def to_date(year, month, day):
  s = "%04d%02d%02d" % (year, month, day)
  return s
