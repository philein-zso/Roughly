#> proposal for interest rates
#
# Tenor struct handles the fact that interest rates have a compounding frequency
# since Tenor inherits from the Dates.Period type, one can safely build interest
# rates upon that thing.
# We need some conventions about the compouding frequency.
# Valid frequencies are:
#  - Day, Month, Week, Year
# 
#
