#!/bin/bash
# Developed By WillyRL
# Version 1.0
# Please use this carefully !!
# This script will enable Nixstats as root user to view proccess
# The purpose is to allow Nixstats to check if services up or down and send notifications



echo "IDCloudHost Nixstats - View Proccess Enabled"
echo "............................................"
echo "Get Service Typed Systemd Or Init.D"

systemd="/etc/systemd/system/nixstatsagent.service"
initd="/etc/init.d/nixstatsagent"

if [ -f "$systemd" ]; then

        nxservices="systemd"
        echo "Service Nixstats running below : Systemd"

elif [ -f "$initd" ]; then

        nxservices="initd"
        echo "Service Nixstats running below : initd"
else
    	"Errorr !! Kemungkinan nixstats belum terinstall"
fi

if [ "$nxservices" == "systemd" ]; then
        echo "Editing Nixstats Systemd Services File"
        sed -i 's/User=nixstats/User=root/g' $systemd
        echo "Success, Result : "
        cat "$systemd"

elif [ "$nxservices" == "initd" ]; then
        echo "Editing Nixstats Iniitd Services File"
        sed -i 's/proguser=nixstats/proguser=root/g' $initd
        echo "Success, Result :"
        cat "$initd"
else
    	echo "Error !!"
fi

echo "SELESAI !!"
echo "Lanjutkan proses dengan set label server nixstats dengan tambahan label Service-Monitor"
echo "============================ Thank You =================================="

