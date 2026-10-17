#!/bin/bash

# Every Input reading is color of BCyan
# Every Correct result of BGreen
# every Incorrect result of BRed

source ./functions.sh

greet "$(whoami)"
printf "\n\t     ${On_Red}==============================${Color_Off}\n\t     ${On_Red}        FILE MANAGER          ${Color_Off}\n\t     ${On_Red}==============================${Color_Off}\n\n"


while [[ true ]]
do 

	show_menu 

	read -p "$(printf "\n${BCyan}Enter your choice from menu/which operation you want to perform: ${Color_Off}")" choice

	if [[ "$choice" == 8 ]]
	then
		goodbye "$(whoami)"
		exit 0
	fi

	case "${choice}" in
		1)
			dir="$HOME"
			
			lines="$(find "$dir" -maxdepth 1 -type d ! -name ".*" | wc -l)"

			while [[ "$lines" -ge 1 ]]
			do
				echo -e "\nOption\tDirectory\n"
				echo -e "$(find "$dir" -maxdepth 1 -type d ! -name ".*" | sort | cat -n)\n"
				read -p "$(printf "${BCyan}Enter which directory you want to explore: ${Color_Off}")" opt
				
				if [[ ("$opt" == 1) ]]
				then 
					break
				elif [[ ("$opt" -gt 1) && ("$opt" -le "$lines") ]]
				then
					dir="$(find "$dir" -maxdepth 1 -type d ! -name ".*" | sort | head -n "$opt" | tail -n 1)"
					lines="$(find "$dir" -maxdepth 1 -type d ! -name ".*" | wc -l)"
				else
					continue
				fi
			done

			total_lines="$(find "$dir" -type f | wc -l)"

			if [[ "${total_lines}" == 0 ]]
			then
				printf "${BGreen}There is no file in ${dir}${Color_Off}"
			fi

			options=(
			"\n\t1. Regular files only"
			"\n\t2. Hidden files only"
			"\n\t3. All files (including hidden)\n"
			)
			echo -e "${options[@]}"
			
			while [[ true ]]
			do
				read -p "$(printf "${BCyan}Enter Option: ${Color_Off}")" option
				case "$option" in
					1)	
						# user ask for regular files
						result="$(ls -l "${dir}" | grep '^-' | sort)"
						printf "\n${BGreen}${result}${Color_Off}\n"
						break
						;;
					2)
						# user ask for hidden files
						result="$(ls -l "${dir} " .* | sort)"
						printf "\n${BGreen}${result}${Color_Off}\n"
						break
						;;
					3)
						# user ask for both regular and hidden files
						result="$(ls -la "${dir}" | sort)"
						printf "\n${BGreen}${result}${Color_Off}\n"
						break
						;;
					*)
						# user enter invalid option
						printf "\n${BRed}Enter valid option${Color_Off}\n"
						continue
						;;
				esac
			done
			;;

		2)
			
			while [[ true ]]
			do
				show_searchMenu
				read -p "$(printf "Enter option for file search menu: ")" file_search_opt
				case "$file_search_opt" in
					1)
						read -p "$(printf "Enter file name you want search: ")" file_name
						res="$(find "${HOME}" -type f -name  "*${file_name}*")"
						if [[ -z "${res}" ]]
						then 
							printf "There is no file with name: ${file_name}"
						else
							echo "${res}"
						fi
						;;
					2)
						read -p "$(printf "Enter extension you want search(don't use .): ")" ext_name
						res="$(find "${HOME}" -type f -iname  "*.${ext_name}")"

						if [[ -z "${res}" ]]
						then 
							printf "There is no file with extension: ${ext_name}"
						else
							echo "${res}"
						fi
						;;
					3)
						read -p "$(printf "Enter directory name where you want search file: ")" dir_name
						read -p "$(printf "Enter file name you want search: ")" file_name

						if [ -d "${dir_name}" ]
						then
							res="$(find "${dir_name}" -type f -iname  "*${file_name}*")"
							if [[ -z "$res" ]]
							then 
								printf 'No file found containing "%s" in "%s".\n' "$file_name" "$dir_name"
							else
								printf 'Directory does not exist: %s\n' "$dir_name"
							fi
						else
							echo "${res}"
						fi
						;;
					4)
						;;
					*)
						printf "\n${BRed}Enter valid option${Color_Off}\n"
						continue
						;;
				esac
			done
			;;
			
		*)
			echo -e "\nEnter valid option\n"
			;;
	esac
done 