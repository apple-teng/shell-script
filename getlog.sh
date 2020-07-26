#######################################
#author锛歍XM            date:2019/11/28
#V0.5
#######################################

########## name ##########
bug_time=$(date +%Y-%m-%d_%H_%M)
tmp_name="log_log_tmp_"$bug_time".tar.gz"
data_log_name="log_log_data_log_"$bug_time".tar.gz"
data_file_name="log_log_data_file_"$bug_time".tar.gz"
data_bt_name="log_log_data_bt_"$bug_time".tar.gz"

###########udisk name############
udisk=`df -h | grep udisk`
udiskName=${udisk##*-}
echo now you are mount on: $udiskName

########## copy command ##########
tar_tmp_log_command="tar -cvzf /data/log/$tmp_name /tmp/log/*"
#"tar -cvzf /data/log/$data_bt_name /data/bt*"
tar_data_log_command="tar -cvzf /data/log/$data_log_name /data/log/*"
tar_data_file_command="tar -cvzf /data/log/$data_file_name /data/FILES/*"
#cp_tmp_log_command="cp /data/log/$tmp_name /tmp/udisk-"$udiskName"/"
##cp_data_bt_command="cp /data/log/$data_bt_name /tmp/udisk-"$udiskName"/"
#cp_data_log_command="cp /data/log/$data_log_name /tmp/udisk-"$udiskName"/"
#cp_data_file_command="cp /data/log/$data_file_name /tmp/udisk-"$udiskName"/"
cp_command="cp /data/log/log_log* /tmp/udisk-"$udiskName"/"
umount_command="umount /tmp/udisk-"$udiskName"/"
excute_command="/tmp/udisk-"$udiskName"/getLogV05.sh"


tarCommand(){
$@
flag=$?
if [ $flag -eq 0 ]; then
echo tar has done...OK!!!
sleep 1s
else
echo tar has some errors.../銊抩銊?~~
echo plese excute the script again: ${excute_command}
exit $flag;
fi
}

copyCommand(){
$@
flag=$?
if [ $flag -eq 0 ]; then
echo copy has done...OK!!!
sleep 1s
else
echo '------------------------------------------'
echo copy has some errors.../銊抩銊?~~
echo plese excute the script again: ${excute_command}
echo '------------------------------------------'
exit $flag;
fi
}


####delete old log########
ls -l /data/log/ | grep -E 'tmp_log|log_log'
flag=$?
if [ $flag -eq 0 ]; then
 echo 'OK!!! /data/log/logs is deleting'
 rm -r /data/log/log_log*
else
 echo 'OK!!! no log will be delete...'
fi
ls -l /tmp/log/ | grep -E 'log_log'
flag=$?
if [ $flag -eq 0 ]; then
 echo 'OK!!! /tmp/log/ logs is deleting'
 rm -r /tmp/log/log_log*
else
 echo 'OK!!! no log will be delete...'
fi

###########create file#####
#$(create_file)
########tar log#######
tarCommand "${tar_data_log_command}"
tarCommand "${tar_data_file_command}"
tarCommand "${tar_tmp_log_command}"
sleep 1s

########cp log#######
copyCommand "${cp_command}"

# copyCommand "${cp_tmp_log_command}"
# copyCommand "${cp_data_file_command}"
# copyCommand "${cp_data_log_command}"


echo "******your log time is : "$bug_time"********"
echo '------------------------------------------'
echo 'please copy the below command to remove Udisk...'
echo '------------------------------------------'
echo ${umount_command}
echo ${umount_command}
