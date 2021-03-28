#!/bin/bash

ArraySearch() {
    local index match="$1"
    local source=("${!2}")
    for index in "${!source[@]}"; do
       if [[ "${source[$index]}" == "${match}" ]]; then
           _return=$index; return 0
       fi
    done
    return 1
}

ArrayRemove() {
    local index match="$1"
    _return=("${!2}")
    for index in "${!_return[@]}"; do
       if [[ "${_return[$index]}" == "${match}" ]]; then
            _return=("${_return[@]:0:$index}" "${_return[@]:$(($index + 1))}")
           break
       fi
    done
}

title=$(echo -e "\e[32m""Github Custom URL.""\e[39m")
subtitle=$(echo -e "\e[32m""https://git.io/""\e[39m")
subtitle=" ${subtitle}"
list_mandatory=(github_url)
list_optional=(custom)

# Merge variable.
list_all=("${list_mandatory[@]}" "${list_optional[@]}")
list_mandatory_empty=("${list_mandatory[@]}")
# Sef flag.
if ArraySearch "custom" list_all[@];then
    display_custom=1
fi
if ArraySearch "github_url" list_all[@];then
    display_github_url=1
fi
finish=
which_display=all
until [[ $finish == 1 ]]; do
    clear
    [ -n "$title" ] && echo "$title"
    [ -n "$subtitle" ] && echo "$subtitle"
    # github_url
    if [[ $display_github_url == 1 ]];then
        label="Input a URL to shorten."
        is_display=
        if [[ $which_display == all ]];then
            is_display=1
        elif [[ $which_display == empty_only && -z "$github_url" ]];then
            is_display=1
        elif [[ $which_display == required_only && -z "$github_url" ]];then
            if ArraySearch "github_url" list_mandatory[@];then
                echo -ne "\e[31m""Required.""\e[39m"" "
                is_display=1
            fi
        fi
        if [[ $is_display == 1 ]];then
            echo -e "\e[36m""$label""\e[39m"
            if [[ -n "$github_url" ]];then
                    echo -e " "$'\e[33m'"\$github_url"$'\e[39m'": $github_url"
                    echo -e "\e[32m""Option:""\e[39m"
                    echo -e " ""\e[35m""[""\e[33m"e"\e[35m""]""\e[39m"" Edit"
                    echo -e " ""\e[35m""[""\e[33m"d"\e[35m""]""\e[39m"" Delete"
                    echo -e " ""\e[35m""[""\e[33m" "\e[35m""]""\e[39m"" Skip"
                    read -rsn1 -p $'\e[32m'"Select: "$'\e[39m' option
                    echo
                    if [[ $option == "e" ]];then
                        echo -e " ""\e[35m""[""\e[33m"e"\e[35m""]""\e[39m"" Edit"
                        # For WSL 2 or Cygwin.
                        command -v clip.exe >/dev/null && echo -n "$github_url" | clip.exe && echo -e "\e[36m""Copied current value to Clipboard.""\e[33m"
                        command -v xclip >/dev/null && echo -n "$github_url" | xclip -selection clipboard && echo -e "\e[36m""Copied current value to Clipboard.""\e[33m"
                        read -p " "$'\e[33m'"\$github_url"$'\e[39m'": " github_url
                    elif [[ $option == "d" ]];then
                        echo -e " ""\e[35m""[""\e[33m"d"\e[35m""]""\e[39m"" Delete"
                        github_url=
                    else
                        echo -e " ""\e[35m""[""\e[33m" "\e[35m""]""\e[39m"" Skip"
                    fi
            else
                read -p " "$'\e[33m'"\$github_url"$'\e[39m'": " github_url
            fi
        fi
        if ArraySearch "github_url" list_mandatory[@];then
            if [ -n "$github_url" ];then
                if ArraySearch "github_url" list_mandatory_empty[@];then
                    ArrayRemove "github_url" list_mandatory_empty[@]
                    list_mandatory_empty=("${_return[@]}")
                fi
            elif ! ArraySearch "github_url" list_mandatory_empty[@];then
                list_mandatory_empty+=(github_url)
            fi
        fi
    fi
    # custom
    if [[ $display_custom == 1 ]];then
        label="Optional custom name."
        is_display=
        if [[ $which_display == all ]];then
            is_display=1
        elif [[ $which_display == empty_only && -z "$custom" ]];then
            is_display=1
        elif [[ $which_display == required_only && -z "$custom" ]];then
            if ArraySearch "custom" list_mandatory[@];then
                echo -ne "\e[31m""Required.""\e[39m"" "
                is_display=1
            fi
        fi
        if [[ $is_display == 1 ]];then
            echo -e "\e[36m""$label""\e[39m"
            if [[ -n "$custom" ]];then
                    echo -e " "$'\e[33m'"\$custom"$'\e[39m'": $custom"
                    echo -e "\e[32m""Option:""\e[39m"
                    echo -e " ""\e[35m""[""\e[33m"e"\e[35m""]""\e[39m"" Edit"
                    echo -e " ""\e[35m""[""\e[33m"d"\e[35m""]""\e[39m"" Delete"
                    echo -e " ""\e[35m""[""\e[33m" "\e[35m""]""\e[39m"" Skip"
                    read -rsn1 -p $'\e[32m'"Select: "$'\e[39m' option
                    echo
                    if [[ $option == "e" ]];then
                        echo -e " ""\e[35m""[""\e[33m"e"\e[35m""]""\e[39m"" Edit"
                        # For WSL 2 or Cygwin.
                        command -v clip.exe >/dev/null && echo -n "$custom" | clip.exe && echo -e "\e[36m""Copied current value to Clipboard.""\e[33m"
                        command -v xclip >/dev/null && echo -n "$custom" | xclip -selection clipboard && echo -e "\e[36m""Copied current value to Clipboard.""\e[33m"
                        read -p " "$'\e[33m'"\$custom"$'\e[39m'": " custom
                    elif [[ $option == "d" ]];then
                        echo -e " ""\e[35m""[""\e[33m"d"\e[35m""]""\e[39m"" Delete"
                        custom=
                    else
                        echo -e " ""\e[35m""[""\e[33m" "\e[35m""]""\e[39m"" Skip"
                    fi
            else
                read -p " "$'\e[33m'"\$custom"$'\e[39m'": " custom
            fi
        fi
        if ArraySearch "custom" list_mandatory[@];then
            if [ -n "$custom" ];then
                if ArraySearch "custom" list_mandatory_empty[@];then
                    ArrayRemove "custom" list_mandatory_empty[@]
                    list_mandatory_empty=("${_return[@]}")
                fi
            elif ! ArraySearch "custom" list_mandatory_empty[@];then
                list_mandatory_empty+=(custom)
            fi
        fi
    fi
    # Preview
    clear
    [ -n "$title" ] && echo "$title"
    [ -n "$subtitle" ] && echo "$subtitle"
    echo -e "\e[32m""Preview.""\e[39m"
    if [[ $display_github_url == 1 ]];then
        echo -e " ""\e[33m"\$github_url"\e[39m"": $github_url"
    fi
    if [[ $display_custom == 1 ]];then
        echo -e " ""\e[33m"\$custom"\e[39m"": $custom"
    fi
    echo -e "\e[32m""Option:""\e[39m"
    echo -e " ""\e[35m""[""\e[33m"a"\e[35m""]""\e[39m"" Edit all"
    echo -e " ""\e[35m""[""\e[33m"e"\e[35m""]""\e[39m"" Edit empty only"
    echo -e " ""\e[35m""[""\e[33m" "\e[35m""]""\e[39m"" Finish"
    read -rsn1 -p $'\e[32m'"Select: "$'\e[39m' option
    echo
    if [[ $option == "a" ]];then
        echo -e " ""\e[35m""[""\e[33m"a"\e[35m""]""\e[39m"" Edit all"
        which_display=all
    elif [[ $option == "e" ]];then
        echo -e " ""\e[35m""[""\e[33m"e"\e[35m""]""\e[39m"" Edit empty only"
        which_display=empty_only
    else
        echo -e " ""\e[35m""[""\e[33m" "\e[35m""]""\e[39m"" Finish"
        if [[ ${#list_mandatory_empty[@]} == 0 ]];then
            finish=1
        else
            which_display=required_only
        fi
    fi
done
if [ -z "$custom" ];then
    command_string='curl https://git.io/ -i -F "url=$github_url"'
else
    command_string='curl https://git.io/ -i -F "url=$github_url" -F "code=$custom"'
    command_string=$(echo "$command_string" | sed "s|"'$custom'"|$custom|g")
fi
command_string=$(echo "$command_string" | sed "s|"'$github_url'"|$github_url|g")
clear
echo "$title"
echo " ""$command_string"
echo -e "\e[32m""Option:""\e[39m"
echo -e " ""\e[35m""[""\e[33m"Ctrl+c"\e[35m""]""\e[39m"" Cancel"
echo -e " ""\e[35m""[""\e[33m"Enter "\e[35m""]""\e[39m"" Execute"
read -rsn1 -p $'\e[32m'"Select: "$'\e[39m' option
[ -z "$option" ] && echo "$command_string" | sh
