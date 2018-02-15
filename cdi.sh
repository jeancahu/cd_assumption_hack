# Autocomplete cd
# Jeancarlo Hidalgo <jeancahu@gmail.com>

#DIR=${1::-1}
#echo "$1"
unalias cd

if [ "$1" == ',,' ] || [ "$1" == '--' ] # Alias { ,, -- } = ..
then
    cd ..
fi
    
if [ "$1" != '/' ] && [ "$1" != '-' ] && [ "$( echo $1 | grep ' ' )" == '' ]
then
    DIR=$( echo $1 | sed -e 's/\/$//' )
    #echo $DIR
    if [ "$( echo $DIR | grep \/ )" == '' ]
    then
	ARRAY=$( ls -la | grep ^[dl] | sed -e 's/ * /\t /g' | cut -f 9 | sed -e 's/ //g' | grep ^"$DIR" | head -n 1 )
	#echo $ARRAY
	#echo $1
	if [ "$1" == '' ]
	then
	    cd
	else
	    if [ "$ARRAY" == '' ]
	    then
		DIR=$( echo $DIR | tr 'A-Z' 'a-z' )
		ARRAY="$( ls -la | grep ^[dl] | sed -e 's/ * /\t /g' | cut -f 9 | sed -e 's/ //g' | tr 'A-Z' 'a-z' )"
		#echo $ARRAY
		POS_DIR=$( echo $ARRAY | tr ' ' '\n' | egrep "^$DIR" )
		POS_DIR=$( echo $ARRAY | tr ' ' '\n' | cat -n | egrep "$POS_DIR" )
		#echo $POS_DIR
		#echo $DIR
		#echo 'Caso sin correspondencia'
		#if [ "$POS_DIR" == '' ]
		#then
		#    echo "No coincidences"
		#else		    
		    #echo $POS_DIR
		    #echo $( ls -la | grep ^[dl] | sed -e 's/ * /\t /g' | cut -f 9 | sed -e 's/ //g' | tr ' ' '\n' | head -n $( echo $POS_DIR | cut -f 1 --delimiter=' ' ) | tail -n 1 )
		cd $( ls -la | grep ^[dl] | sed -e 's/ * /\t /g' | cut -f 9 | sed -e 's/ //g' | tr ' ' '\n' | head -n $( echo $POS_DIR | cut -f 1 --delimiter=' ' ) | tail -n 1 )
		#fi
	    else
		#echo $ARRAY
		cd $ARRAY
	    fi
	fi
    else
	#echo $DIR
	cd $DIR    
    fi
else
    cd "$1"
fi
alias cd='source ~/.bash/cdi.sh'
