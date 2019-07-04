FROM centos:7

ENV container docker

# minimize systemd
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done) \
 && rm -f /lib/systemd/system/multi-user.target.wants/* \
 && rm -f /etc/systemd/system/*.wants/* \
 && rm -f /lib/systemd/system/local-fs.target.wants/* \
 && rm -f /lib/systemd/system/sockets.target.wants/*udev* \
 && rm -f /lib/systemd/system/sockets.target.wants/*initctl* \
 && rm -f /lib/systemd/system/basic.target.wants/* \
 && rm -f /lib/systemd/system/anaconda.target.wants/* \
 && rm -f /lib/systemd/system/graphical.target.wants/* \
 && rm -f /lib/systemd/system/initrd.target.wants/* \
 && rm -f /lib/systemd/system/poweroff.target.wants/* \
 && rm -f /lib/systemd/system/reboot.target.wants/* \
 && rm -f /lib/systemd/system/rescue.target.wants/* \
 && rm -f /lib/systemd/system/shutdown.target.wants/* \
 && rm -f /lib/systemd/system/sockets.target.wants/dbus.socket \
 && rm -f /lib/systemd/system/sockets.target.wants/systemd-shutdownd.socket \
 && rm -f /lib/systemd/system/timers.target.wants/* \
 && rm -f /etc/systemd/system/sysinit.target.wants/* \
 && rm -f /etc/systemd/system/basic.target.wants/* \
 && rm -f /etc/systemd/system/multi-user.target.wants/* \
 && rm -f /etc/systemd/system/local-fs.target.wants/* \
 && rm -f /etc/systemd/system/default.target/* \
 && touch /etc/sysconfig/network \
 && mkdir -p /var/log/journal \
 && ln -s /dev/null /etc/systemd/system/paths.target \
 && ln -s /dev/null /etc/systemd/system/slices.target \
 && ln -s /dev/null /etc/systemd/system/local-fs.targe \
 && ln -s /dev/null /etc/systemd/system/swap.target \
 && ln -s /dev/null /etc/systemd/system/timers.target \
 && ln -s /dev/null /etc/systemd/system/-.slice \
 && ln -s /dev/null /etc/systemd/system/rhel-configure.service \
 && ln -s /dev/null /etc/systemd/system/rhel-dmesg.service \
 && ln -s /dev/null /etc/systemd/system/rhel-autorelabel.service \
 && ln -s /dev/null /etc/systemd/system/rhel-domainname.service \
 && ln -s /dev/null /etc/systemd/system/rhel-import-state.service \
 && ln -s /dev/null /etc/systemd/system/rhel-loadmodules.service \
 && ln -s /dev/null /etc/systemd/system/rhel-readonly.service \
 && sed -i -e 's/^#ForwardToSyslog=.*/ForwardToSyslog=no/' \
        -e 's/^#ForwardToWell=.*/ForwardToWell=no/' \
        -e 's/^#ForwardToConsole=.*/ForwardToConsole=yes/' \
        -e 's,^#TTYPath=/dev/console,TTYPath=/dev/console,' \
        -e 's/^#*SystemMaxUse=.*/SystemMaxUse=32M/' \
        -e 's/^#*RateLimitInterval=.*/RateLimitInterval=0/' \
        -e 's/^#*RateLimitBurst=.*/RateLimitBurst=0/' \
        /etc/systemd/journald.conf \
 && sed -i -e 's/^#LogLevel=.*/LogLevel=notice/' /etc/systemd/system.conf \
 && sed -i -e 's/^LANG=.*$/LANG=\"ja_JP.UTF-8\"/' /etc/locale.conf \
 && /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && rm -fr /usr/share/doc/* /usr/share/man/* /usr/share/groff/* /usr/share/info/*  \
 && rm -rf /usr/share/lintian/* /usr/share/linda/* /var/cache/man/*  \
 && rm -f /var/lib/rpm/__db*  \
 && rpm --rebuilddb  \
 && yum clean all  \
 && rm -fr /var/cache/*  \
 && rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

ENV LANG ja_JP.UTF-8
ENV LC_ALL C
CMD ["/usr/sbin/init"]
