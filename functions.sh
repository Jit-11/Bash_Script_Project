#!/bin/bash
# Source - https://stackoverflow.com/a/28938235


# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

# ---------- UI helper functions (presentation only) ----------

# Horizontal divider line
divider() {
    printf "${BBlue}  ────────────────────────────────────────────────────────${Color_Off}\n"
}

# Section title banner
section_title() {
    printf "\n${BYellow}  ▶ %s${Color_Off}\n" "$1"
    divider
}

# Wait for the user before returning to a menu
pause_prompt() {
    read -r -p "$(printf "\n${BCyan}  ⏎  Press Enter to continue...${Color_Off}")"
    printf "\n"
}

greet() {
    local name="$1"
    printf "\n\t${BIYellow}👋 Welcome,${Color_Off} ${BIGreen}%s${Color_Off}\n" "${name:-"$(whoami)"}"
}

goodbye() {
    local name="$1"
    printf "\n\t${BIGreen}👋 Goodbye, %s.${Color_Off} ${BIYellow}Have a nice day! ✨${Color_Off}\n\n" "${name:-"$(whoami)"}"
}

show_menu() {

    local menu=(
    " ╔══════════════════════════════════════╗"
    " ║              MAIN MENU               ║"
    " ╠══════════════════════════════════════╣"
    " ║  1.  List files                      ║"
    " ║  2.  Search files                    ║"
    " ║  3.  Search inside files             ║"
    " ║  4.  File statistics                 ║"
    " ║  5.  Create backup                   ║"
    " ║  6.  View logs                       ║"
    " ║  7.  Clean temporary files           ║"
    " ║  8.  Exit                            ║"
    " ╚══════════════════════════════════════╝"
)
    printf "\n"
    for item in "${menu[@]}"
    do
        printf '\t%b%b%s%b\n' "${On_IYellow}" "${BBlack}" "$item" "${Color_Off}"
    done
}

show_searchMenu()
{
    local Searchmenu=(
    " ╔══════════════════════════════════════╗"
    " ║           FILE SEARCH MENU           ║"
    " ╠══════════════════════════════════════╣"
    " ║  1.  Search by file name             ║"
    " ║  2.  Search by extension             ║"
    " ║  3.  Search in specific directory    ║"
    " ║  4.  Search hidden files             ║"
    " ╚══════════════════════════════════════╝"
)

    printf "\n"
    for item in "${Searchmenu[@]}"
    do 
        printf '\t%b%b%s%b\n' "${On_IYellow}" "${BBlack}" "$item" "${Color_Off}"
    done
}