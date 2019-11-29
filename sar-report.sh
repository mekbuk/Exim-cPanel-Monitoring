#!/bin/sh
#Sar / Systat must be installed and have enough data
#In this case, the script is build for full month summary
# RnD - Willy Robertus Leonardo


echo "+----------------------------------------------------------------------------------+"
echo "|Average:         CPU     %user     %nice   %system   %iowait    %steal     %idle  |"
echo "+----------------------------------------------------------------------------------+"



userArr=()
niceArr=()
systemArr=()
iowaitArr=()
stealArr=()
count=0

for file in `ls -tr /var/log/sa/sa* | grep -v sar`

do

count=$((count+1))
dat=`sar -f $file | head -n 1 | awk '{print $4}'`

echo -n $dat
sar -f $file  | grep -i Average | sed "s/Average://"
userArr+=(`sar -f $file  | grep -i Average | sed "s/Average://" | awk -F ' ' '{print $2}'`)
niceArr+=(`sar -f $file  | grep -i Average | sed "s/Average://" | awk -F ' ' '{print $3}'`)
systemArr+=(`sar -f $file  | grep -i Average | sed "s/Average://" | awk -F ' ' '{print $4}'`)
iowaitArr+=(`sar -f $file  | grep -i Average | sed "s/Average://" | awk -F ' ' '{print $5}'`)
stealArr+=(`sar -f $file  | grep -i Average | sed "s/Average://" | awk -F ' ' '{print $6}'`)
idleArr+=(`sar -f $file  | grep -i Average | sed "s/Average://" | awk -F ' ' '{print $7}'`)

done

echo "+----------------------------------------------------------------------------------+"
sumUser=$( IFS="+"; bc <<< "${userArr[*]}" )
sumNice=$( IFS="+"; bc <<< "${niceArr[*]}" )
sumSystem=$( IFS="+"; bc <<< "${systemArr[*]}" )
sumIowait=$( IFS="+"; bc <<< "${iowaitArr[*]}" )
sumSteal=$( IFS="+"; bc <<< "${stealArr[*]}" )
sumIdle=$( IFS="+"; bc <<< "${idleArr[*]}" )


avgUser=`echo "scale=2; $sumUser/$count" | bc`
avgNice=`echo "scale=2; $sumNice/$count" | bc`
avgSystem=`echo "scale=2; $sumSystem/$count" | bc`
avgIowait=`echo "scale=2; $sumIowait/$count" | bc`
avgSteal=`echo "scale=2; $sumSteal/$count" | bc`
avgIdle=`echo "scale=2; $sumIdle/$count" | bc`


echo "Average Monthly %user : " $avgUser
echo "Average Monthly %Nice : " $avgNice
echo "Average Monthly %System : " $avgSystem
echo "Average Monthly %IOWait : " $avgIowait
echo "Average Monthly %Steal : " $avgSteal
echo "Average Monthly %Idle : " $avgIdle
