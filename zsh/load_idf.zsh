##########################
# Update idf is a function that updates the
# espressidf repo and iff it has bean updated
# it installs the update automaticaly.
#
# Created by Magnus Sörensen 20231025.
#
##########################
#

# alias status_idf='if [[ "$(tmux show-window-option @run_idf_onpannel)" == "0" ]]; then echo "Auto IDF on new pannel is ${F_STOP}ed." ; else echo "Auto IDF on new pannel is ${F_RUN}ing." ; fi'
# alias get_idf='echo "No update update_idf" ; . $ESPRESSIF_EXPORT_SCRIPT ;  tmux set-window-option @run_idf_onpannel 1'
# alias get_idf='   $ESPRESSIF_EXPORT_SCRIPT  ;  tmux set-window-option @run_idf_onpannel 1'
# alias stop_idf='tmux set-window-option @run_idf_onpannel 0 ; if [[ "$(tmux show-window-option -v @run_idf_onpannel)" == "0" ]]; then echo "${F_STOP}ing IDF"; else echo "${F_FAIL}ed to stop IDF"; fi '

# Check the status of the auto run of the espressif IDE.
status_idf(){
    if [[ -z "$(tmux show-window-option -v @run_idf_onpannel 2>/dev/null)" || "$(tmux show-window-option -v @run_idf_onpannel 2>/dev/null)" == "0" ]];
    then
        echo "${F_STOP} Auto IDF on new pannel is stoped."
    else
        echo "${F_RUN} Auto IDF on new pannel is running."
    fi
}

# Get the IDE and then set auto run on new panel.
get_idf(){
    update_idf
    . $ESPRESSIF_EXPORT_SCRIPT
    tmux set-window-option @run_idf_onpannel 1
}

# Stop setting starting on new panels.
stop_idf(){
    # Set TMUX variable to 0 to not run on new pannels
    tmux set-window-option @run_idf_onpannel 0
    # Check if stopped
    if [[ -z "$(tmux show-window-option -v @run_idf_onpannel 2>/dev/null)" || "$( tmux show-window-option -v @run_idf_onpannel 2>/dev/null)" == "0" ]];
    then
        echo "${F_STOP}ed the auto run of the IDF"
    else
        echo "${F_FAIL}ed to stop autorun of the IDF"
    fi
}


# Function to auto install and auto update the espressif IDE.
# @input: None.
# @return: 1 if failed, 0 if things worked out as expected.
update_idf(){
    repo_dir="$HOME/extrepos/esp-idf/"
    echo "Start? $repo_dir"
    # Sub Function auto install IDF.
    # @return: 1 fail, 0 OK.
    install_idf(){
	    if [ -f "install.sh" ]; then
			echo "Installing the update"
	      	chmod +x install.sh
	      	./install.sh all
			echo "Done"
            return 0
	    else
	      	echo "install.sh not found."
            return 1
	    fi
    }
    # Sub Function auto clone espressidf.
    # @return: 1 fail, 0 OK.
    clone_idf(){
        if [[ ! -d "$repo_dir" ]]; then
            vared -p "`$repo_dir` did not exist. Clone the repo [y/n] " -c ans
            if [[ "$ans" == "n" || "$ans" == "N" ]]; then
                echo "Did not clone repo exiting."
                exit 1
            fi
            currdir=$(pwd)
            cd "$HOME/extrepos/"
            git clone --recursive https://github.com/espressif/esp-idf.git
            install_idf
            if [ $? -eq 0];then
                echo "Done with all"
                exit 0
            else
                echo "There was a error. Running checks."
                test ! -z "$repo_dir" && echo "OK" || echo "ERROR \$repo_dir is empty"
                test -f "$repo_dir" && echo "OK" || echo "ERROR directory in \$repo_dir=$repo_dir did not exist"
                test -f "$repo_dir/install.sh" && echo "OK" || echo "ERROR could not find install.sh"
                exit 1
            fi
        else
            echo "Repo existed"
            return 0
        fi
        return 1
    }

    if [[ -z "$repo_dir" ]]; then
        echo "repo_dir variable was empty."
        exit 1
    fi

    # Auto clone espressif repo
    clone_idf

    cd $repo_dir || return 1

    # Fetch the latest changes withot merging.
    git fetch origin
   	if git diff --quiet  HEAD..origin/master ; then
    	echo "Repo is up to date. No need to pull."
  	else
	    # Pull the latest changes
	    git pull
		git submodule update --init --recursive

	    # Run the install script
        install_idf
  	fi
	cd - || return 1

    # Forget about the internal functions
    unset -f install_idf
    unset -f clone_idf
}
