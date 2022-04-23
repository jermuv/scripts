$aika = get-date
write-host $aika.year,'-',$aika.Month
{
    $var1 = 1
    $var2 = 2
    write-host $var1, $var2
    $var1, $var2 = $var2, $var1
    write-host $var1, $var2
}