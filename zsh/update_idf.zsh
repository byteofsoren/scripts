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

    if [[ -z "$repo_dir" ]]; then
        echo "repo_dir variable was empty."
        exit 1
    fi
    if [[ ! -d "$repo_dir" ]]; then
        echo "repo_dir did not exist."
        exit 1
    fi

    cd $repo_dir || return 1

    # Fetch the latest changes withot merging.
    git fetch
   	if git diff --exit-code HEAD..origin/main; then
    	echo "Repo is up to date. No need to pull."
  	else
	    # Pull the latest changes
	    git pull
		git submodule update --init --recursive

	    # Run the install script
	    if [ -f "install.sh" ]; then
			echo "Installing the update"
	      	chmod +x install.sh
	      	./install.sh
			echo "Done"
	    else
	      	echo "install.sh not found."
	    fi
  	fi
	cd - || return 1

}
