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

    if   ! ls -1 ${card}/*.DS* &>/dev/null
    then
	    echo "pas de dictée à récupérer"
      return 1
    else
	    echo "$(ls -1 ${card} | grep ".DS" | wc -l) dictées sont à transférer"
      echo "$(ls -1 ${card}/*.DS*)"
      sleep 1
      return 0
    fi

}

backup_dictates () {
    backup_ask_window
    echo "copie des dictées"
    if ! cp ${card}/*DS* $backup_dir
    then
      echo "une erreur est survenue. les dictées n'ont pas été copiées" && error_window && exit 1
    fi
    (
    cp ${card}/*DS* $backup_dir 2>>$logfile
    ) | backup_run_window
}

while true
do
	sleep 1
  echo "wait"
  	if [ -d $card ]
  	then
      echo ""$(date +"%d_%m_%Y %H %M") >>$logfile
  		check_dictates 2>>$logfile
      backup_dictates 2>>${logfile} || echo "une erreur est survenue. les dictées n'ont pas été copiées" && exit 1
      echo -e "Les dictées :\n$(ls -1 ${card} | grep ".DS")\nont été tranférées dans le backup" >>${logfile}
  	fi

done
