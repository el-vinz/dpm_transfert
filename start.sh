#!/bin/bash

card="/media/$USER/PHILIPS"
backup_dir="$HOME/temp_dictates"
logdir="$HOME/log_dictate"
logfile=${logdir}/log_dict.log

#TODO --> export de la liste des dictées en bsename pour comparatif une fois la copie effectuée.
[ ! -d $backup_dir ] && mkdir $backup_dir
[ ! -d $logdir ] && mkdir $logdir


. ./windows.sh

echo $card

check_card () {

    [ ! -d $card ]
    sleep 1

}

check_dictates () {

    echo "vérification de la présence de dictées"

    sleep 1

    if   ! ls -1 ${card}/*.DS*
    then
	    echo "pas de dictée à récupérer"
    else
	    echo "$(ls -1 ${card} | grep ".DS" | wc -l) dictées sont à transférer"
      echo "$(ls -1 ${card}/*.DS*)"
      sleep 1
      return 0
    fi

}

backup_dictates () {
  echo "copie des dictées"
  (
  cp ${card}/*DS* $backup_dir
  ) | backup_window
}

while true
do
	sleep 1
  echo "wait"
	if [ -d $card ]
	then
		check_dictates && backup_dictates

	fi

done


#check_dictates && echo "pas de dictée à récupérer" && exit 0
