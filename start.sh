#!/bin/bash

card="/media/$USER/PHILIPS"

echo $card

check_card () {

    #mount -l | grep PHILIPS || return 1
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
    fi

    echo "Des dictées ont été trouvées $(ls -1 ${card}/*.DS*)"
    sleep 1
    return 0


}

while true
do
	sleep 1
	if [  -d $card ]
	then
		check_dictates

	fi

done


#check_dictates && echo "pas de dictée à récupérer" && exit 0
