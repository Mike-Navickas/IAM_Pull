#!/bin/ksh

# 04/09/16 MN - modified script to pull both *.out and *.mef3 files from list of servers

export PATH=/bin:/usr/bin:$PATH

function get_iam_file
{
  print "$host: Copying URT extract file from target"
  scp -p $o_user@$host:/tmp/iam_extract_*.out /gfs/misc/former/iam_2016_upload_gb/.
      if [ $? -ne 0 ]; then
        scp -p $o_user@$host:/tmp/iam_extract_*.mef3 /gfs/misc/former/iam_2016_upload_gb/.
      fi
  if [ $? -ne 0 ]; then
    echo "$host: UNSUCCESSFUL"
    echo "$host RERUN $o_user" >> rerun_server_list.lst
  else
    echo "$host: SUCCESSFUL"
  fi
}

#initialize rerun file
> rerun_server_list.lst;

#set -x
while read host db o_user
do
  print "Host: $host"
  print "Database: $db"
  print "User: $o_user"
  get_iam_file
done < server_list.lst