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

	read -p "$(printf "\n${BCyan}  ➤ Enter your choice from menu/which operation you want to perform: ${Color_Off}")" choice

	if [[ "$choice" == 8 ]]
	then
		goodbye "$(whoami)"
		exit 0
	fi

	case "${choice}" in
		1)
			section_title "LIST FILES  ·  Browse directories"
			dir="$HOME"
			
			lines="$(find "$dir" -maxdepth 1 -type d ! -name ".*" | wc -l)"

			while [[ "$lines" -ge 1 ]]
			do
				echo -e "\n${BYellow}  Option\tDirectory${Color_Off}\n"
				echo -e "${BWhite}$(find "$dir" -maxdepth 1 -type d ! -name ".*" | sort | cat -n)${Color_Off}\n"
				read -p "$(printf "${BCyan}  ➤ Enter which directory you want to explore: ${Color_Off}")" opt
				
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
				printf "${BRed}  ✘ There is no file in ${dir}${Color_Off}\n"
			fi

			options=(
			"\n${BYellow}  Which files do you want to see?${Color_Off}\n"
			"\n\t${BWhite}1.${Color_Off} Regular files only"
			"\n\t${BWhite}2.${Color_Off} Hidden files only"
			"\n\t${BWhite}3.${Color_Off} All files (including hidden)\n"
			)
			echo -e "${options[@]}"
			
			while [[ true ]]
			do
				read -p "$(printf "${BCyan}  ➤ Enter Option: ${Color_Off}")" option
				case "$option" in
					1)	
						# user ask for regular files
						result="$(ls -l "${dir}" | grep '^-' | sort)"
						section_title "Regular files in ${dir}"
						printf "\n${BGreen}${result}${Color_Off}\n"
						break
						;;
					2)
						# user ask for hidden files
						result="$(ls -l "${dir} " .* | sort)"
						section_title "Hidden files in ${dir}"
						printf "\n${BGreen}${result}${Color_Off}\n"
						break
						;;
					3)
						# user ask for both regular and hidden files
						result="$(ls -la "${dir}" | sort)"
						section_title "All files in ${dir}"
						printf "\n${BGreen}${result}${Color_Off}\n"
						break
						;;
					*)
						# user enter invalid option
						printf "\n${BRed}  ✘ Enter valid option${Color_Off}\n\n"
						continue
						;;
				esac
			done
			pause_prompt
			;;

		2)
			
			while [[ true ]]
			do
				show_searchMenu
				read -p "$(printf "\n${BCyan}  ➤ Enter option for file search menu: ${Color_Off}")" file_search_opt
				case "$file_search_opt" in
					1)
						section_title "SEARCH BY FILE NAME"
						read -p "$(printf "${BCyan}  ➤ Enter file name you want search: ${Color_Off}")" file_name
						res="$(find "${HOME}" -type f -name  "*${file_name}*")"
						if [[ -z "${res}" ]]
						then 
							printf "\n${BRed}  ✘ There is no file with name: ${file_name}${Color_Off}\n"
						else
							echo -e "\n${BGreen}${res}${Color_Off}"
						fi
						pause_prompt
						;;
					2)
						section_title "SEARCH BY EXTENSION"
						read -p "$(printf "${BCyan}  ➤ Enter extension you want search(don't use .): ${Color_Off}")" ext_name
						res="$(find "${HOME}" -type f -iname  "*.${ext_name}")"

						if [[ -z "${res}" ]]
						then 
							printf "\n${BRed}  ✘ There is no file with extension: ${ext_name}${Color_Off}\n"
						else
							echo -e "\n${BGreen}${res}${Color_Off}"
						fi
						pause_prompt
						;;
					3)
						section_title "SEARCH IN SPECIFIC DIRECTORY"
						read -p "$(printf "${BCyan}  ➤ Enter directory name where you want search file: ${Color_Off}")" dir_name
						read -p "$(printf "${BCyan}  ➤ Enter file name you want search: ${Color_Off}")" file_name

						if [ -d "${dir_name}" ]
						then
							res="$(find "${dir_name}" -type f -iname  "*${file_name}*")"
							if [[ -z "$res" ]]
							then 
								printf "\n${BRed}  ✘ No file found containing \"%s\" in \"%s\".${Color_Off}\n" "$file_name" "$dir_name"
							else
								printf "\n${BRed}  ✘ Directory does not exist: %s${Color_Off}\n" "$dir_name"
							fi
						else
							echo -e "\n${BGreen}${res}${Color_Off}"
						fi
						pause_prompt
						;;
					4)
						;;
					*)
						printf "\n${BRed}  ✘ Enter valid option${Color_Off}\n"
						continue
						;;
				esac
			done
			;;
			
		*)
			echo -e "\n${BRed}  ✘ Enter valid option${Color_Off}\n"
			;;
	esac
done