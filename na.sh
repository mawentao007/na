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
        echo "Info:add alias successfully!"
}

function rmAlias(){
        mark=1
        FILE=$HOME/.kv.conf
        tmpFILE=$HOME/.kv.conf~
        touch $tmpFILE
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
                echo "Warning:na can not find and remove alias!"
        else
                echo "Info:remove alias successfully!"
                cat $tmpFILE > $FILE
        fi
        rm $tmpFILE
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
        tmpFILE=$HOME/.kv.match
        touch $tmpFILE
        while read line;
        do
                key=`echo "$line"|awk '{print $1}'`
                if [ $1 = $key ];then
                        #awk 记得是单引号
                        path=`echo "$line"|awk '{print $2}'`
                        cd $path
                        mark=0
                        break
                        #双中括号表示类型匹配
                elif [[ $key = $1* ]];then
                        echo $line >> $tmpFILE
                fi
        done < $FILE
        
        if [ $mark = 1 ]; then
                if [ `cat $tmpFILE|wc -l` = 0 ];then
                        echo "Warning:na can not find alias!"
                elif [ `cat $tmpFILE|wc -l` = 1 ];then
                        cd `cat $tmpFILE|awk '{print $2}'`
                else
                        while read line;
                        do
                                echo $line
                        done < $tmpFILE
                fi
        fi
        rm $tmpFILE
}

function na(){
        if [ $# = 0 ] || [ $1 = $HOME ]; then
                cd $HOME
        elif [ $1 = "-h" ];then
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




