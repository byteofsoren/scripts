##########################
# Update idf is a function that updates the
# espressidf repo and iff it has bean updated
# it installs the update automaticaly.
#
# Created by Magnus Sörensen 20231025.
#
##########################


update_idf(){
    repo_dir="$HOME/extrepos/esp-idf/"
    echo "Start? $repo_dir"
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

    # echo "Start?"

    if [[ -z "$repo_dir" ]]; then
        echo "repo_dir variable was empty."
        exit 1
    fi
    # clone idf
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
