function nav(){
        FILE=$HOME/.kv.conf
        while read line;
        do
                key=`echo "$line"|awk '{print $1}'`
                if [ $1 == $key ];
                then
                        path=`echo "$line"|awk '{print $2}'`
                        cd $path
                        break
                fi
        done < $FILE
}

