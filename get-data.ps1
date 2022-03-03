$header = '
# 2022 Russian invasion of Ukraine
## Approximate loses
'
$footer ='
## Source [Wikipedia] (https://uk.wikipedia.org/wiki/%D0%A0%D0%BE%D1%81%D1%96%D0%B9%D1%81%D1%8C%D0%BA%D0%B5_%D0%B2%D1%82%D0%BE%D1%80%D0%B3%D0%BD%D0%B5%D0%BD%D0%BD%D1%8F_%D0%B2_%D0%A3%D0%BA%D1%80%D0%B0%D1%97%D0%BD%D1%83_(2022)#%D0%92%D1%96%D0%B9%D1%81%D1%8C%D0%BA%D0%BE%D0%B2%D1%96_%D0%B2%D1%82%D1%80%D0%B0%D1%82%D0%B8_%D0%BE%D0%BA%D1%83%D0%BF%D0%B0%D0%BD%D1%82%D1%96%D0%B2)
'


$data = (invoke-webrequest "https://uk.wikipedia.org/wiki/%D0%A0%D0%BE%D1%81%D1%96%D0%B9%D1%81%D1%8C%D0%BA%D0%B5_%D0%B2%D1%82%D0%BE%D1%80%D0%B3%D0%BD%D0%B5%D0%BD%D0%BD%D1%8F_%D0%B2_%D0%A3%D0%BA%D1%80%D0%B0%D1%97%D0%BD%D1%83_(2022)#%D0%92%D1%96%D0%B9%D1%81%D1%8C%D0%BA%D0%BE%D0%B2%D1%96_%D0%B2%D1%82%D1%80%D0%B0%D1%82%D0%B8_%D0%BE%D0%BA%D1%83%D0%BF%D0%B0%D0%BD%D1%82%D1%96%D0%B2").Content -Split "<"


$data1 = ($data | select-string "особового складу&#160;—").Line |select-object -first 1
$pos = $data1.IndexOf(":")
$cutoff = $data1.Substring($pos+1)


$trimdata = $cutoff -replace "\.","," -replace "&#160;—","" -replace "осіб","`r`n" -replace ";","`r`n" -split "," 
$finalResults = @()
$finalResults += $header
foreach ($line in $trimdata) {
    if ($line -match "особового складу") { 
        $RAF_units_Name = "Russian Armed Forces Soldiers"
        $RAF_units_count = $line -replace '\D+([0-9]*).*','$1'
        $finalResults += "$RAF_units_Name - $RAF_units_count "
    }
    if ($line -match "літаків") { 
        $RAF_flight_Name = "Russian Armed Forces Flights"
        $RAF_flight_count = $line -replace '\D+([0-9]*).*','$1'
        $finalResults += "$RAF_flight_Name - $RAF_flight_count"
    }
    if ($line -match "гелікоптерів") { 
        $RAF_helly_Name = "Russian Armed Forces Hellycopters"
        $RAF_helly_count = $line -replace '\D+([0-9]*).*','$1'
        $finalResults += "$RAF_helly_Name - $RAF_helly_count"
    }
    if ($line -match "танків") { 
        $RAF_tanks_Name = "Russian Armed Forces Tanks"
        $RAF_tanks_count = $line -replace '\D+([0-9]*).*','$1'
        $finalResults += "$RAF_tanks_Name - $RAF_tanks_count"
    }
    if ($line -match "бронемашин") { 
        $RAF_amv_Name = "Russian Armed Forces AMV"
        $RAF_amv_count = $line -replace '\D+([0-9]*).*','$1'
        $finalResults += "$RAF_amv_Name - $RAF_amv_count"
    }
    if ($line -match "артилерійських систем") { 
        $RAF_artilery_Name = "Russian Armed Forces Artilerry"
        $RAF_artilery_count = $line -replace '\D+([0-9]*).*','$1'
        $finalResults += "$RAF_artilery_Name - $RAF_artilery_count"
    }
    if ($line -match "РСЗВ") { 
        $RAF_mrl_Name = "Russian Armed Forces Multiple Rocket Launcers"
        $RAF_mrl_count = $line -replace '\D+([0-9]*).*','$1'
        $finalResults += "$RAF_mrl_Name - $RAF_mrl_count"
    }
    if ($line -match "цистерн") { 
        $RAF_fueltanks_Name = "Russian Armed Forces Fuel Tanks"
        $RAF_fueltanks_count = $line -replace '\D+([0-9]*).*','$1'
        $finalResults += "$RAF_fueltanks_Name - $RAF_fueltanks_count"
    }
    if ($line -match "засобів ППО") { 
        $RAF_aaw_Name = "Russian Armed Forces Anti-aircraft warfare"
        $RAF_aaw_count = $line -replace '\D+([0-9]*).*','$1'
        $finalResults += "$RAF_aaw_Name - $RAF_aaw_count"
    }
    if ($line -match "БПЛА оперативно-тактичного рівня") { 
        $RAF_UAV_Name = "Russian Armed Forces UAV"
        $RAF_UAV_count = $line -replace '\D+([0-9]*).*','$1'
        $finalResults += "$RAF_UAV_Name - $RAF_UAV_count"
    }
    if ($line -match "катери") { 
        $RAF_ws_Name = "Russian Armed Forces Warships"
        $RAF_ws_count = $line -replace '\D+([0-9]*).*','$1'
        $finalResults += "$RAF_ws_Name - $RAF_ws_count"
    }
    if ($line -match "автомобільної техніки") { 
        $RAF_gv_Name = "Russian Armed Forces Vehicle"
        $RAF_gv_count = $line -replace '\D+([0-9]*).*','$1'
        $finalResults += "$RAF_gv_Name - $RAF_gv_count"
    }

} 
$finalResults += $footer
$finalResults| Out-File Readme.md 