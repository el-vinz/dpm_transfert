#!/bin/bash

connect_window () {

  zenity --info --title "DPM connecté"

}

backup_window () {
  zenity --forms \
                  --title "Ready ?" \
                  --text "Souhaitez vous copier les dictées ? "
  zenity --progress \
                  --title="Backup" \
                  --text="copie des dictées en local" \
                  --pulsate 

}

transfer_window () {

  zenity --progress \
                  --title="extraction" \
                  --text="téléchargement des dictées en cours" \
                  --pulsate \
                  --auto-close
}

final_window () {

  zenity --info --title "vos dictées sont téléchargées"

}

error_window () {

  zenity --error --title "Echec du téléchargement"


}
