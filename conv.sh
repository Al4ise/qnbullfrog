#!/bin/bash
rm -f bfj
curl -sS https://qnblackcat.github.io/AltStore/apps.json > taltrepo.json

echo "{
    \"sourceDesc\": \"BF Version of Qn's AltStore Repo\",
    \"sourceURL\": \"https://api.ios222.com/appstore/apps\",
    \"sourceApps\": [ " >> bfj

n=0
while [[ "$(jq -r ".apps[$n]" taltrepo.json)" != "null" ]]; do
    appUpdateTime="$(jq -r ".apps[$n].versionDate" taltrepo.json)"
    appDesc="$(jq -r ".apps[$n].localizedDescription" taltrepo.json)"
    appSize="$(jq -r ".apps[$n].size" taltrepo.json)"
    appID=$((n + 20000))
    appName="$(jq -r ".apps[$n].name" taltrepo.json)"
    appBID="$(jq -r ".apps[$n].bundleIdentifier" taltrepo.json)"
    appDownloadURL="$(jq -r ".apps[$n].downloadURL" taltrepo.json)"
    appVersion="$(jq -r ".apps[$n].version" taltrepo.json)"
    appIconURL="$(jq -r ".apps[$n].iconURL" taltrepo.json)"
    echo "{
        \"appUpdateTime\": \"$appUpdateTime\",
        \"appDesc\": \"j\",
        \"appType\": 0,
        \"appSize\": $appSize,
        \"appID\": $appID,
        \"appName\": \"$appName\",
        \"appIsLock\": false,
        \"appBID\": \"$appBID\",
        \"appDownloadURL\": \"$appDownloadURL\",
        \"appVersion\": \"$appVersion\",
        \"appIconURL\": \"$appIconURL\"" >> bfj

    if [[ "$(jq -r ".apps[$n+1]" taltrepo.json)" == "null" ]]; then
        echo "  }" >> bfj
        break
    else
        echo "  }," >> bfj
    fi
    n=$((n + 1))
done

echo "
],
    \"sourceLogoURL\": \"https://api.ios222.com/logo60x60.png\",
    \"sourceName\": \"Alaise BF Repo\",
    \"sourceUnlockURL\": \"\",
    \"sourceGetCodeURL\": \"\"
}" >> bfj

rm -f taltrepo.json
