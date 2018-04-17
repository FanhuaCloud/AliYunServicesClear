#!/bin/bash

function Colorset() {
  #颜色配置
  echo=echo
  for cmd in echo /bin/echo; do
    $cmd >/dev/null 2>&1 || continue
    if ! $cmd -e "" | grep -qE '^-e'; then
      echo=$cmd
      break
    fi
  done
  CSI=$($echo -e "\033[")
  CEND="${CSI}0m"
  CDGREEN="${CSI}32m"
  CRED="${CSI}1;31m"
  CGREEN="${CSI}1;32m"
  CYELLOW="${CSI}1;33m"
  CBLUE="${CSI}1;34m"
  CMAGENTA="${CSI}1;35m"
  CCYAN="${CSI}1;36m"
  CSUCCESS="$CDGREEN"
  CFAILURE="$CRED"
  CQUESTION="$CMAGENTA"
  CWARNING="$CYELLOW"
  CMSG="$CCYAN"
}

function Logprefix() {
  #输出log
  echo -n ${CGREEN}'CraftYun >> '
}

function Uninstall() {
	Logprefix;echo ${CYELLOW}'[INFO]Uninstall AliYun services!'${CEND}
	rm -rf /usr/sbin/aliyun*
	rm -rf /usr/local/share/aliyun-assist/
	rm -rf /etc/systemd/system/aliyun.service
	rm -rf /etc/init.d/agentwatch
	rm -rf /etc/rc.d/rc2.d/S80aegis
	rm -rf /etc/rc.d/rc3.d/S80aegis
	rm -rf /etc/rc.d/rc4.d/S80aegis
	rm -rf /etc/rc.d/rc5.d/S80aegis
	Logprefix;echo ${CMSG}'[SUCCESS]Uninstall AliYun services success!'${CEND}

	Logprefix;echo ${CYELLOW}'[INFO]Install wget!'${CEND}
	yum -y install wget
	Logprefix;echo ${CYELLOW}'[INFO]Uninstall AliYun aegis!'${CEND}
	wget http://update.aegis.aliyun.com/download/uninstall.sh -O /tmp/uninstall.sh
	chmod +x /tmp/uninstall.sh
	/tmp/uninstall.sh
	rm -rf /tmp/uninstall.sh
	Logprefix;echo ${CMSG}'[SUCCESS]Uninstall AliYun aegis success!'${CEND}
	
	Logprefix;echo ${CYELLOW}'[INFO]Uninstall success.Please reboot.'${CEND}
}

Colorset
Uninstall
