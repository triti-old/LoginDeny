include /usr/local/share/luggage/luggage.make

TITLE=LoginDeny
REVERSE_DOMAIN=edu.utexas.its

PAYLOAD=\
	pack-hookscript-masterhook \
	link-hookscript-loginhook \
	pack-hookscript-login-00_logindeny \
	pack-script-postflight

l_etc_hooks_login: l_etc_hooks
	@sudo mkdir -p ${WORK_D}/private/etc/hooks/login
	@sudo chown -R root:wheel ${WORK_D}/private/etc/hooks/login
	@sudo chmod -R 755 ${WORK_D}/private/etc/hooks/login

l_etc_hooks_logout: l_etc_hooks
	@sudo mkdir -p ${WORK_D}/private/etc/hooks/logout
	@sudo chown -R root:wheel ${WORK_D}/private/etc/hooks/logout
	@sudo chmod -R 755 ${WORK_D}/private/etc/hooks/logout

pack-hookscript-login-%: % l_etc_hooks_login
	@sudo ${INSTALL} -m 755 -g wheel -o root $< ${WORK_D}/private/etc/hooks/login

pack-hookscript-logout-%: % l_etc_hooks_logout
	@sudo ${INSTALL} -m 755 -g wheel -o root $< ${WORK_D}/private/etc/hooks/logout

link-hookscript-loginhook: l_etc_hooks
	@sudo ln -s ./masterhook ${WORK_D}/private/etc/hooks/loginhook

link-hookscript-logouthook: l_etc_hooks
	@sudo ln -s ./masterhook ${WORK_D}/private/etc/hooks/logouthook
