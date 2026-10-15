#!/bin/bash

source ./functions.sh

printf "${On_Red}==============================${Color_Off}\n${On_Red}        FILE MANAGER          ${Color_Off}\n${On_Red}==============================${Color_Off}\n"

menu='Menu:\n\t1. List files
\t2. Search files
\t3. Search inside files
\t4. File statistics
\t5. Create backup
\t6. View logs
\t7. Clean temporary files
\t8. Exit\n'

greet "$(whoami)"

echo -e "${menu}"

read -p "Enter your choice from menu/which operation you want to perform: " choice

case "${choice}" in
	1)
		dir="$HOME"
		
		lines="$(find "$dir" -mindepth 1 -maxdepth 1 -type d ! -name ".*" | wc -l)"

		while [[ "$lines" -ge 1 ]]
		do
			echo -e "\nOption\tDirectory\n"
			echo -e "$(find "$dir" -mindepth 1 -maxdepth 1 -type d ! -name ".*" | sort | cat -n)\n"
			read -p "Enter number of option which you want to explore: " opt
			
			if [[ ("$opt" -ge 0) && ("$opt" -le "$lines") ]]
			then
				dir="$(find "$dir" -mindepth 1 -maxdepth 1 -type d ! -name ".*" | sort | head -n "$opt" | tail -n 1)"
				lines="$(find "$dir" -mindepth 1 -maxdepth 1 -type d ! -name ".*" | wc -l)"
			else
				continue
			fi
		done

		lines="$(find "$dir" -type f ! -name ".*" | wc -l)"

		if [[ ("$lines" -ge 1) ]]
		then
			printf "\n$(ls -l "$dir")\n"
		else
			printf "\nThere is no file in this directory\n"
		fi

		;;

	2)
		echo "do you want to seach file" 
		;;
	8)
		goodbye "$(whoami)"
		;;
	*)
		exit 0
		;;
esac