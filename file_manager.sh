#!/bin/bash

# Every Input reading is color of BCyan
# Every Correct result of BGreen
# every Incorrect result of BRed

source ./functions.sh

greet "$(whoami)"
banner=(
" ╔══════════════════════════════════════╗"
" ║             FILE MANAGER             ║"
" ╚══════════════════════════════════════╝"
)
printf "\n"
for item in "${banner[@]}"
do
	printf '\t%b%b%s%b\n' "${On_IYellow}" "${BBlack}" "$item" "${Color_Off}"
done


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
			does_user_exit=false
			while [[ "$lines" -ge 1 ]]
			do
				echo -e "\n${BYellow}  Option\tDirectory${Color_Off}\n"
				echo -e "${BWhite}$(find "$dir" -maxdepth 1 -type d ! -name ".*" | sort | cat -n)${Color_Off}\n"
				printf "${BWhite}  ℹ  Enter -1 to exit${Color_Off}\n\n"
				read -p "$(printf "${BCyan}  ➤ Enter which directory you want to explore: ${Color_Off}")" opt
				
				if [[ "$opt" == -1 ]]
				then
					does_user_exit=true
					break
				elif [[ ("$opt" == 1) ]]
				then 
					break
				elif [[ ("$opt" -gt 1) && ("$opt" -le "$lines") ]]
				then
					dir="$(find "$dir" -maxdepth 1 -type d ! -name ".*" | sort | head -n "${opt}" | tail -n 1)"
					lines="$(find "$dir" -maxdepth 1 -type d ! -name ".*" | wc -l)"
				else
					continue
				fi
			done
			
			if [[ "${does_user_exit}" ]]
			then
				continue
			fi

			total_lines="$(find "$dir" -type f | wc -l)"

			if [[ "${total_lines}" == 0 ]]
			then
				printf "${BRed}  ✘ There is no file in ${dir}${Color_Off}\n"
			fi

			listMenu=(
			" ╔══════════════════════════════════════╗"
			" ║           LIST FILES MENU            ║"
			" ╠══════════════════════════════════════╣"
			" ║  1.  Regular files only              ║"
			" ║  2.  Hidden files only               ║"
			" ║  3.  All files (including hidden)    ║"
			" ╚══════════════════════════════════════╝"
			)
			printf "\n"
			for item in "${listMenu[@]}"
			do
				printf '\t%b%b%s%b\n' "${On_IYellow}" "${BBlack}" "$item" "${Color_Off}"
			done
			printf "\n"
			
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
						printf "\n${BRed}  ✘ Enter valid option${Color_Off}\n"
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
				if [[ -z "${file_search_opt}" ]]
				then
					printf "\n${BRed}  ✘ Enter valid option${Color_Off}\n"
					continue
				fi
				case "$file_search_opt" in
					1)
						section_title "SEARCH BY FILE NAME"
						read -p "$(printf "${BCyan}  ➤ Enter file name you want search: ${Color_Off}")" file_name
						if [[ -n "${file_name}" && "${file_name}" != */* ]]
						then 
							res="$(find "${HOME}" -type f -name  "*${file_name}*")"
							echo -e "\n${BGreen}$(printf "%s\n" "${res}" | cat -n)${Color_Off}"
							show_fileMenu	"${res}"
						else
							printf "\n${BRed}  ✘ There is no file with name: ${file_name}${Color_Off}\n"
							printf "\n${BRed}  ✘ Please enter valid filename${Color_Off}\n"
						fi
						pause_prompt
						;;
					2)
						section_title "SEARCH BY EXTENSION"
						read -p "$(printf "${BCyan}  ➤ Enter extension you want search(don't use .): ${Color_Off}")" ext_name

						if [[ "${ext_name}" != +([a-zA-Z]) ]]
						then 
							printf "\n${BRed}  ✘ There is no file with extension: ${ext_name}${Color_Off}\n"
							printf "\n${BRed}  ✘ Please enter valid extension${Color_Off}\n"
						else
							res="$(find "${HOME}" -type f -iname  "*.${ext_name}")"
							printf "\n${BGreen}$(printf "%s\n" "${res}" | cat -n)${Color_Off}"
							show_fileMenu "${res}"
						fi
						pause_prompt
						;;
					3)
						section_title "SEARCH IN SPECIFIC DIRECTORY"
						read -p "$(printf "${BCyan}  ➤ Enter directory name where you want search file: ${Color_Off}")" dir_name
						read -p "$(printf "${BCyan}  ➤ Enter file name you want search: ${Color_Off}")" file_name

						if [ -n "${dir_name}" -d "${dir_name}" ]
						then
							if [[ -n "${file_name}" && "${file_name}" != */* ]]
							then 
								res="$(find "${dir_name}" -type f -iname  "*${file_name}*")"
								if [[ -z "${res}" ]]
								then
									printf "\n${BRed}  ✘ No file found containing \"%s\" in \"%s\".${Color_Off}\n" "${file_name}" "${dir_name}"
								else
									printf "\n${BGreen}$(printf "%s\n" "${res}" | cat -n)${Color_Off}"
									show_filemenu	"${res}"
								fi
							else
								printf "\n${BRed}  ✘ File does not exist: %s${Color_Off}\n" "${file_name}"
							fi
						else
							printf "\n${BRed}  ✘ Invalid directory${Color_Off}\n"
							printf "\n${BRed}  ✘ Please enter valid directory path${Color_Off}\n"
						fi
						pause_prompt
						;;
					4)
						;;
					5)
						break
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