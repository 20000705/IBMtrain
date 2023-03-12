#!/bin/bash
shopt -s xpg_echo

#hostname
hostname=$hostname

#short data
short_data=$(date "+%Y-%m-%d-%A")

#time
Time=$(date '+%H-%M-%S')

#shell_user
shell_username=$whoami

#Environment Variable

filenametime1=$(date "+%m%d%Y%M%S")
filenametime2=$(date "+%Y-%m-%d %H-%M-%S")
export basefolder='/home/hqxx/Desktop/wcd_assignments'
export scriptfolder='/home/hqxx/Desktop/wcd_assignments/scripts'
export logsdir='/home/hqxx/Desktop/wcd_assignments/logs'
export inputfile='/home/hqxx/Desktop/wcd_assignments/input'
export outputfile='/home/hqxx/Desktop/wcd_assignments/output'

export script='script'
export log_file=${logsdir}/${script}_${filenametime1}.log
export python_log_file=${logsdir}/${script}_python_${filenametime1}.log

#go to script folder
cd ${scriptfolder}

#set log rules
exec > >(tee ${logsfile}) 2>&1

#download data
echo "start downloading data"

for year in {2020..2022}; # or use (seq 2019 2022)
do wget -N --content-disposition "https://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=48549&Year=${year}&Month=2&Day=14&timeframe=1&submit= Download+Data" -O ${inputfile}/${year}.csv;
done;

#test code
RC1=$?
if [ ${RC1} != 0 ];
then
   echo "download failed"
   echo "[ERROR:] return code: ${RC1}"
   echo "[ERROR:] refer to the log for the reason for the failure"
   exit 1
fi

#run python

cd ${scriptfolder}
echo "start running python"

python3 ${scriptfolder}/python_script.py

RC1=$1
if [ ${RC1} != 0 ];
then
   echo "run failed"
   echo "[ERROR:] return code: ${RC1}"
   echo "[ERROR:] refer to the log for the reason for the failure"
   exit 1
fi

echo "program succeeded"

exit 0
