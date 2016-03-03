#! /bin/sh
set +o noclobber
#
#   $1 = scanner device
#   $2 = friendly name
#   $3 = email address 

#   
#       100,200,300,400,600
#

SENDMAIL="`which sendmail   2> /dev/null`"
if [ "$SENDMAIL" = '' ];then
    SENDMAIL="/usr/sbin/sendmail"
fi
if [ ! -e  ];then
    echo "sendmail is not available."
fi

#-----------------------
debug_log=''
scanimage_disable='no'
sendmail_disable='no'
sendmail_log='0'
#-----------------------
log=''
resolution=100
device=$1
mkdir -p ~/brscan
if [ "`which usleep  2>/dev/null `" != '' ];then
    usleep 100000
else
    sleep  0.1
fi
output_file=~/brscan/brscan_"`date +%Y-%m-%d-%H-%M-%S`"".pnm"
#echo "scan from $2($device)"

if [ -e "`which pnmtojpeg  2>/dev/null `" ];then
 FILTER=pnmtojpeg
 FILENAME=brscan_skey.jpg
else
 FILTER=cat
 FILENAME=brscan_skey.pnm
fi

email_debug_option=''

if [ "$scanimage_disable" != 'yes' ];then
    tmpscnfile=`mktemp ~/brscan/brscan-tmp.XXXXXX`
    if [ "$device" = '' ];then
	scanimage --resolution $resolution  2>/dev/null > $tmpscnfile
    else
	scanimage --device-name "$device" --resolution $resolution 	    2>/dev/null  > $tmpscnfile
    fi

    if [ ! -s $tmpscnfile ];then
      if [ "`which usleep  2>/dev/null `" != '' ];then
        usleep 1000000
      else
        sleep  1
      fi
      if [ "$device" = '' ];then
	scanimage --resolution $resolution  2>/dev/null > $tmpscnfile
      else
	scanimage --device-name "$device" --resolution $resolution 	    2>/dev/null  > $tmpscnfile
      fi
    fi

    cat $tmpscnfile | $FILTER> $output_file 
else
    echo DEBUG DATA :012345678901234567890123456789 > $output_file
fi



FLABEL='^FROM'
TLABEL='^TO'
CLABEL='^CC'
BLABEL='^BCC'
MLABEL='^MESSAGE'
SLABEL='^SUBJECT'

CONF=~/.brscan/'brscan_mail.config'
if [ ! -e $CONF ];then
  CONF=/opt/brother/scanner/brscan-skey//'brscan_mail.config'
fi

DEBUG="`grep 'DEBUG=1' $CONF`"
if [ "$DEBUG" != '' ];then
    sendmail_disable='silent'
fi

FADR="`grep $FLABEL=  $CONF | sed s/$FLABEL=//g`" 
TADR="`grep $TLABEL=  $CONF | sed s/$TLABEL=//g`" 
CADR="`grep $CLABEL=  $CONF | sed s/$CLABEL=//g`" 
BADR="`grep $BLABEL=  $CONF | sed s/$BLABEL=//g`" 

MSGT="`grep $MLABEL=  $CONF | sed s/$MLABEL=//g`" 
if [ "$MSGT" != '' ];then
    MESG=$MSGT
    if [ ! -e "$MESG" ];then
	MESG=~/.brscan/"$MSGT"
	if [ ! -e "$MESG" ];then
	    MESG=/opt/brother/scanner/brscan-skey/"$MSGT"
	fi
    fi
else
    MESG="''"
fi
SUBJECT="`grep $SLABEL=  $CONF | sed s/$SLABEL=//g`" 

if [ "$3" != '' ];then
    TADR="`echo $3 | sed -e s/:.*$//`"
fi


if [ "$TADR" = '' ] || [ ${#TADR} -gt 256 ];then
    echo "E-mail Address Error:"
    echo "   E-mail address setting is not valid."
    echo "   E-mail address is not defined or the setting"
    echo "   might be larger than 256 characters."
    exit 0;
fi

if [ "$FADR" = '' ];then
    FADR="`whoami | sed s/\" .*$\"//g`"
fi
if [ "$FADR" = '' ];then
    FADR="''"
fi

if [ "$FILENAME" = '' ];then
    FILENAME="''"
fi

command_line="$SENDMAIL -t $TADR"
command_flog="$SENDMAIL -t $TADR"
case "$sendmail_log" in
    "0") email_debug_option='';;
    "1") email_debug_option='--debug-mode L';command_line="cat";;
    "2") email_debug_option='--debug-mode M';command_line="cat";;
    "4") email_debug_option='--debug-mode H';command_line="cat";;
    "5") email_debug_option='--debug-mode l';command_line="cat";;
    "6") email_debug_option='--debug-mode m';command_line="cat";;
    "3") email_debug_option='--debug-mode h';command_line="cat";;
    *  ) email_debug_option='';;
esac

if [ $sendmail_disable = 'yes' ];then
    command_line="cat";
elif [ $sendmail_disable = 'silent' ];then
    command_line="head  -6";
fi

if [ -e "/opt/brother/scanner/brscan-skey/script/brscan_scantoemail"-"0.2.4-0" ];then
      if [ "$debug_log" != '' ];then
	echo -----------------------------
	echo /opt/brother/scanner/brscan-skey/script/brscan_scantoemail-"0.2.4-0" \
	    -t "$TADR" \
	    -r "$FADR" \
	    -c "$CADR" \
	    -b "$BADR" \
	    -f "$FILENAME" \
	    -M "$MESG" \
	    -S "$SUBJECT" \
	    $output_file  \|  $command_flog
	echo to  : $TADR
	echo from: $FADR
	echo cc  : $CC
	echo bcc : $BCC
	echo subject: $SUBJECT
	echo name: $FILENAME
	echo img : $output_file
	echo -----------------------------
     fi
     /opt/brother/scanner/brscan-skey/script/brscan_scantoemail-"0.2.4-0" \
	-t "$TADR" \
	-r "$FADR" \
	-c "$CADR" \
	-b "$BADR" \
	-f "$FILENAME" \
	-M "$MESG" \
	-S "$SUBJECT" \
        $email_debug_option \
	$output_file    |  $command_line

     if [ "$log" != '' ];then
	touch $log
	echo ''
	echo ----------------------------- >> $log
	echo to  : $TADR                  >> $log
	echo from: $FADR                  >> $log
	echo cc  : $CC                    >> $log
	echo bcc : $BCC                   >> $log
	echo subject: $SUBJECT            >> $log
	echo name: $FILENAME              >> $log
	echo mesg: $MESG                  >> $log
	echo img : $output_file           >> $log
	echo ----------------------------- >> $log
     fi

else
    echo ERROR: /opt/brother/scanner/brscan-skey/script/brscan_scantoemail-"0.2.4-0" \
	-t $TADR \
	-r $FADR \
	-f $FILENAME \
	-M $MESG \
	$output_file  \| $command_flog
fi

rm -f $output_file

