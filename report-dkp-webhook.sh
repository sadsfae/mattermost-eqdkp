#!/bin/bash
# simple script to scrape DKP site and report value
# usage: sh report_dkp PLAYERNAME
args=$1
player_name=$(echo $args | awk '{ print $2 }')
dkp_url="https://example.com/eqdkp/index.php/Points/"
botname="dkpbot"

function gather_dkp_value {
        obtain_dkp=$(curl --silent $dkp_url | egrep -A1 -i $player_name \
        | sed 's/<[^>]*>//g' | egrep -v "Main|--" | awk 'NR==3')
        dkp_value=$(echo $obtain_dkp | tr -d '[:blank:]')
        echo "$player_name currently has $dkp_value points"
}

playerdkp=$(gather_dkp_value)

cat <<EOF
{"response_type": "ephemeral", "username": "$botname", "text": "$(echo $playerdkp)"}
EOF
