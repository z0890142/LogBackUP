#!/bin/sh

backup_folder=backup_$(date +%Y%m%d)
service_name=()
find ./logs -type d -maxdepth 1 -print0 >tmpfile
while IFS=  read -r -d $'\0'; do
    service_name+=("$REPLY")
done <tmpfile
rm -f tmpfile 
for ((i=1; i < ${#service_name[@]}; i++))
do
    IFS='/' read -ra name <<< "${service_name["$i"]}"
    
    if [ ! -d ./backup/${name[-1]} ]
    then
        mkdir ./backup/${name[-1]}
    fi
    find ./logs/${name[-1]} -type f -name "*.log"  -exec cp {} ./backup/${name[-1]}/$backup_folder \;
done