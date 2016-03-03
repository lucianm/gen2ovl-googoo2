#! /bin/sh
set +o noclobber
#
#   $1 = scanner device
#   $2 = friendly name
#

#   
#       100,200,300,400,600
#
resolution=100
device=$1
mkdir -p ~/brscan
if [ "`which usleep  2>/dev/null `" != '' ];then
    usleep 100000
else
    sleep  0.1
fi
output_file=`mktemp ~/brscan/brscan.XXXXXX`
#echo "scan from $2($device) to $output_file"
scanimage --device-name "$device" --resolution $resolution> $output_file 2>/dev/null
if [ ! -s $output_file ];then
  if [ "`which usleep  2>/dev/null `" != '' ];then
    usleep 1000000
  else
    sleep  1
  fi
  scanimage --device-name "$device" --resolution $resolution> $output_file 2>/dev/null
fi
echo gimp -n $output_file  2>/dev/null \;rm -f $output_file | sh & 
