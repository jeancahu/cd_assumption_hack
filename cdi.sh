# source bash

unalias cd

if [ "$1" == ',,' ] || [ "$1" == '--' ] # Alias { ,, -- } = ..
then
    cd ..
fi

if [ "$1" != '/' ] && [ "$1" != '-' ] && [ "$( echo $1 | grep ' ' )" == '' ]
then
    DIR=$( echo $1 | sed -e 's/\/$//' )
    if [ "$( echo $DIR | grep \/ )" == '' ]
    then
	      ARRAY=$( /usr/bin/ls -la | grep ^[dl] | sed -e 's/ * /\t /g' | cut -f 9 | sed -e 's/ //g' | grep ^"$DIR" | head -n 1 )
	      if [ "$1" == '' ]
	      then
	          cd
	      else
	          if [ "$ARRAY" == '' ]
	          then
		            DIR=$( echo $DIR | tr 'A-Z' 'a-z' )
		            ARRAY="$( /usr/bin/ls -la | grep ^[dl] | sed -e 's/ * /\t /g' | cut -f 9 | sed -e 's/ //g' | tr 'A-Z' 'a-z' )"
		            POS_DIR=$( echo $ARRAY | tr ' ' '\n' | egrep "^$DIR" )
		            POS_DIR=$( echo $ARRAY | tr ' ' '\n' | cat -n | egrep "$POS_DIR" )
		            cd $( /usr/bin/ls -la | grep ^[dl] | sed -e 's/ * /\t /g' | cut -f 9 | sed -e 's/ //g' | tr ' ' '\n' | head -n $( echo $POS_DIR | cut -f 1 --delimiter=' ' ) | tail -n 1 )
	          else
		            cd $ARRAY
	          fi
	      fi
    else
	      cd $DIR
    fi
else
    cd "$1"
fi
