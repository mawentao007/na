#!/bin/bash

#必须先定义，后调用
function usage(){
        echo " usage: na [-h|-a|-d] folderName"
        echo "            -h      help"
        echo "            -a      add alias"
        echo "            -d      remove alias"
        echo "            -l      list all alias"
}

function add(){
        FILE=$HOME/.kv.conf
        echo "$1  $PWD" >> $FILE
#todo check whether exist.
        echo "Info:   add alias successfully!"
}

function rmAlias(){
        mark=1
        FILE=$HOME/.kv.conf
        tmpFILE=$HOME/.kv.conf~
        while read line;
        do
                key=`echo "$line"|awk '{print $1}'`
                if [ $1 = $key ];
                then
                        mark=0
                else
                        echo $line >> $tmpFILE
                fi
        done < $FILE
        
        if [ $mark = 1 ]; then
                echo "Warning:   na can not find and remove alias!"
                rm $tmpFILE
        else
                echo "Info:   remove alias successfully!"
                cat $tmpFILE > $FILE
                rm $tmpFILE
        fi
}

function list(){
        FILE=$HOME/.kv.conf
        while read line;
        do
             echo "$line"
        done < $FILE
}

function redirectTo(){
        mark=1
        FILE=$HOME/.kv.conf
        while read line;
        do
                key=`echo "$line"|awk '{print $1}'`
                if [ $1 = $key ];
                then
                        path=`echo "$line"|awk '{print $2}'`
                        cd $path
                        mark=0
                        break
                fi
        done < $FILE
        
        if [ $mark = 1 ]; then
                echo "Warning:   na can not find alias!"
        fi
}

function na(){
        if [ $# = 0 ] || [ $1 = "-h" ];then
                usage
        elif [ $1 = "-a" ]; then
                add $2
        elif [ $1 = "-d" ]; then
                rmAlias $2
        elif [ $1 = "-l" ]; then
                list
        else 
                redirectTo $1
        fi
}




