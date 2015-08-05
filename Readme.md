#Na 文件夹切换工具“哪”
<p align="center">
<img class="embeded-img" src="na.jpg">
</p>
***
###配置

将脚本放置在$HOME目录下，在.bashrc中添加如下语句:

	. na.sh  //特别注意第一个‘.’
    
别名的配置文件为
	
    $HOME/.kv.conf
    
***
###使用方法

          usage: na [-h|-a|-d] folderName
                      -h      help
                      -a      add alias
                      -d      remove alias
                      -l      list all alias
