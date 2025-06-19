# Uber End to End Data Analytics

# First make the raw column text Right‑click Start_Date ▸ Change Type ▸ Text (this removes any partial conversions) ▸ Add Column ▸ Custom Column ▸ Paste the M code ▸ Change Type of the new column to Date/Time.
'let
    usParse   = try DateTime.FromText([Start_Date], "en-US"),
    finalDate = if usParse[HasError]
                then DateTime.FromText([Start_Date], "en-GB")
                else usParse[Value]
in
    finalDate'

# First make the raw column text Right‑click End_Date ▸ Change Type ▸ Text (this removes any partial conversions).
'let
    usParse   = try DateTime.FromText([End_Date], "en-US"),
    finalDate = if usParse[HasError]
                then DateTime.FromText([End_Date], "en-GB")
                else usParse[Value]
in
    finalDate'

# To calculate duration (in minutes or hours) from Start_Hour, Start_Minute, End_Hour, End_Minute columns in Power Query.
Add Custom Column (Duration in Minutes)
'let
    startTime = #time([Start_Hour], [Start_Minute], 0),
    endTime   = #time([End_Hour], [End_Minute], 0),
    duration  = Duration.TotalMinutes(endTime - startTime)
in
    duration'

# To calculate Speed = Distance / Time in Power BI (e.g., in miles per hour).
'[Miles] / ([Duration] / 60)'

# To calculate the Day time using Start_Hour
'= Table.AddColumn(#"Inserted Day Name", "Custom", each
    if      [Start_Hour] >=  6 and [Start_Hour] <= 11 then "Morning"
    else if [Start_Hour] >= 12 and [Start_Hour] <= 17 then "Afternoon"
    else if [Start_Hour] >= 18 and [Start_Hour] <= 21 then "Evening"
    else "Night"
)'
