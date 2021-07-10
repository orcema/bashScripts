display_usage() {
    echo "Missing arguments. Scan folder is mandatory and ignore flag is optional "
    echo -e "\nThe . is place holder for current folder"
    echo -e "\nUsage: => duc absolut_folder_path flag_ignore_media_folder([y|n]) \n"
}

# if less than two arguments supplied, display usage
if [ $# -eq 0 ]; then
    display_usage
    exit 1
fi

# replace all blanks
folderToAnalyse="$1"
skipMediaFolder="$2"

if [ $folderToAnalyse = "." ]; then
    folderToAnalyse=$PWD
fi

ouputFileName="/tmp/fa-${folderToAnalyse//\//_}.log"
du -d1 -h $folderToAnalyse --exclude='/media/*'|sort -hr > $ouputFileName
if [[ $skipMediaFolder != "n" ]]; then
    echo "skipping media folder"
    du -d1 -h $folderToAnalyse --exclude='/media/*'|sort -hr > $ouputFileName
else
    du -d1 -h $folderToAnalyse|sort -hr > $ouputFileName
fi

# show link to output file
echo $ouputFileName

