#!/bin/bash
#安装、卸载fvwm的配置文件
# -i安装
# -r卸载
# -h帮助

hash dirname || { echo "ERROR: 需要安装dirname"; exit 1; }
INSTALL_PATH=~/.myconfigures
CURR_PATH=`dirname $0`/..
FVWM_PATH=$INSTALL_PATH/fvwm
BACKUP_PATH=$INSTALL_PATH/backups/fvwm
STATES_PATH=$INSTALL_PATH/states/fvwm
INSTALL_SCRIPT=$INSTALL_PATH/install/fvwm.sh
Help() {
	echo "Usage: $0 [-i]|[-r]|[-h]"
	echo -e "\t-i install, 安装"
	echo -e "\t-r remove, 卸载"
	echo -e "\t-h 显示这个页面"
}
Install() {
	echo "开始配置fvwm..."
	if [ -f $STATES_PATH ]; then
		echo "fvwm的配置文件已经安置好了"
		exit 0
	fi
	#备份
	mkdir -p $BACKUP_PATH 2> /dev/null
	mv ~/.fvwm $BACKUP_PATH/fvwm 2> /dev/null
	mv ~/.fvwm2rc $BACKUP_PATH/fvwm2rc 2> /dev/null
	#复制配置文件
	cp -r $CURR_PATH/fvwm $INSTALL_PATH/fvwm
	#建立链接
	ln -sf $FVWM_PATH ~/.fvwm
	#复制安装脚本
	mkdir -p $INSTALL_PATH/install 2> /dev/null
	cp $CURR_PATH/install/fvwm.sh $INSTALL_SCRIPT
	cp -f $CURR_PATH/install.sh $INSTALL_PATH/install.sh
	#生成安装信息
	mkdir -p $INSTALL_PATH/states 2> /dev/null
	touch $STATES_PATH
	echo "fvwm配置完成"
}
Remove() {
	echo "开始卸载fvwm配置文件..."
	rm -rf $FVWM_PATH 2> /dev/null
	rm ~/.fvwm ~/.fvwm2rc 2> /dev/null
	mv $BACKUP_PATH/fvwm ~/.fvwm 2> /dev/null
	mv $BACKUP_PATH/fvwm2rc ~/.fvwm2rc 2> /dev/null
	rm $STATES_PATH 2> /dev/null
	rm $INSTALL_SCRIPT 2> /dev/null
	echo "fvwm配置卸载完成"
}
if [ 1 -ne $# ]; then
	Help
	exit 1
fi
case "$1" in
	"-i") Install ;;
	"-r") Remove ;;
	"-h") Help ;;
	*) Help; exit 1;;
esac
