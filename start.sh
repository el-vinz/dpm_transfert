#!/bin/bash

card="/media/$USER/PHILIPS"
backup_dir="$HOME/temp_dictates"
logdir="$HOME/log_dictate"
logfile=${logdir}/log_dict.log

#TODO --> export de la liste des dictées en bsename pour comparatif une fois la copie effectuée.
[ ! -d $backup_dir ] && mkdir $backup_dir
[ ! -d $logdir ] && mkdir $logdir


. ./windows.sh
. ./functions.sh

echo $card



while true
do
	sleep 1
  echo "wait"
  	if [ -d $card ]
  	then
      echo ""$(date +"%d_%m_%Y %H %M") >>$logfile
  		check_dictates &&  backup_dictates
      echo -e "Les dictées :\n$(ls -1 ${card} | grep ".DS")\nont été tranférées dans le backup" >>${logfile}
    else
      echo "vérifiez la connectique du DPM" && error_window
  	fi

done
