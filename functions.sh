#!/bin/bash
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

check_dpm () {
  #TODO -->  observer le montage effectif du lecteur dans /dev/
  echo "ok"
}
