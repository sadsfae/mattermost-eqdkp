#!/bin/bash
# simple script to scrape DKP site and report value
# usage: sh report_dkp PLAYERNAME
player_name=$1
dkp_url="https://exampleguild.org/eqdkp/index.php/Points/?mdkpid=0&filter=&show_inactive=1&lbc=0"

# minimal sanitization of input
# print usage if not specified
if [[ $# -eq 0 ]]; then
        echo "USAGE: report-dkp.sh PLAYERNAME (case sensitive) "
        echo "                                                 "
        exit 1
fi

function gather_dkp_value {
        obtain_dkp=$(curl --silent $dkp_url | egrep -A1 -i $player_name \
        | sed 's/<[^>]*>//g' | egrep -v "Main|--" | awk 'NR==3')
        dkp_value=$(echo $obtain_dkp | tr -d '[:blank:]')
        echo $player_name currently has $dkp_value points
}

gather_dkp_value
