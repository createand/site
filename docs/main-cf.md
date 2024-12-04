	# See /usr/share/postfix/main.cf.dist for a commented, more complete version
	
	
	# Debian specific:  Specifying a file name will cause the first
	# line of that file to be used as the name.  The Debian default
	# is /etc/mailname.
	#myorigin = /etc/mailname
	
	smtpd_banner = $myhostname ESMTP $mail_name (Ubuntu)
	biff = no
	
	# appending .domain is the MUA's job.
	append_dot_mydomain = no
	
	# Uncomment the next line to generate "delayed mail" warnings
	#delay_warning_time = 4h
	
	readme_directory = no
	
	# See http://www.postfix.org/COMPATIBILITY_README.html -- default to 2 on
	# fresh installs.
	compatibility_level = 2
	
	mailbox_transport = lmtp:unix:/var/spool/postfix/private/dovecot-lmtp
	
	
	# TLS parameters
	#smtpd_tls_cert_file=/etc/ssl/certs/server.crt
	#smtpd_tls_key_file=/etc/ssl/private/server.key
	
	smtpd_tls_cert_file = /etc/letsencrypt/live/mail.createand.net/fullchain.pem
	smtpd_tls_key_file = /etc/letsencrypt/live/mail.createand.net/privkey.pem
	smtp_tls_CAfile = /etc/letsencrypt/live/mail.createand.net/chain.pem
	
	smtpd_tls_security_level=may
	smtpd_tls_auth_only=yes
	smtpd_sasl_auth_enable=yes
	smtpd_sasl_type=dovecot
	smtpd_sasl_path=private/auth
	#smtpd_sasl_path=/var/spool/postfix/private/auth
	#smtpd_recipient_restrictions=permit_mynetworks,permit_sasl_authenticated,reject_unauth_destination
	smtpd_recipient_restrictions=permit_sasl_authenticated,reject_unauth_destination
	smtp_tls_CApath=/etc/ssl/certs
	smtp_tls_security_level=may
	smtpd_use_tls=yes
	smtpd_tls_session_cache_database = btree:${data_directory}/smtpd_scache
	smtp_tls_session_cache_database = btree:${data_directory}/smtp_scache
	#smtpd_tls_mandatory_protocols = !SSLv2, !SSLv3
	smtpd_tls_protocols = !SSLv2, !SSLv3
	
	message_size_limit = 52428800
	mailbox_size_limit = 104857600
	
	
	smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated defer_unauth_destination
	myhostname = mail.createand.net
	mydomain = createand.net
	alias_maps = hash:/etc/aliases
	alias_database = hash:/etc/aliases
	myorigin = /etc/mailname
	#mydestination = $myhostname, createand.net, mail.createand.net, localhost.createand.net, localhost
	mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain
	#mydestination = localhost, localhost.localdomain
	relay_domains = $mydestination
	relayhost = 
	mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 37.148.210.0/32
	mailbox_command = procmail -a "$EXTENSION"
	mailbox_size_limit = 0
	recipient_delimiter = +
	inet_interfaces = all
	inet_protocols = all
	virtual_mailbox_base = /var/mail/vhosts
	#transport_maps = hash:/etc/postfix/transport
	
	########
	
	# Sanal alan ayarları
	#virtual_transport = lmtp:unix:private/dovecot-lmtp
	#virtual_transport = virtual
	#virtual_mailbox_domains = pgsql:/etc/postfix/pgsql-virtual-mailbox-domains.cf
	#virtual_mailbox_maps = pgsql:/etc/postfix/pgsql-virtual-mailbox-maps.cf
	#virtual_alias_maps = pgsql:/etc/postfix/pgsql-virtual-alias-maps.cf
	
	# Virtual Mailbox Domain Settings
	
	relay_domains = $mydestination, proxy:pgsql:/etc/postfix/pgsql/relay_domains.cf
	
	#choose this or the below
	# For non-alias domains functionality uncomment the one line below
	#virtual_alias_maps = proxy:pgsql:/etc/postfix/pgsql/virtual_alias_maps.cf
	
	#choose this or the above
	# For alias domains functionality uncomment the two lines below
	virtual_alias_maps = proxy:pgsql:/etc/postfix/pgsql/virtual_alias_maps.cf
	virtual_alias_domains = proxy:pgsql:/etc/postfix/pgsql/virtual_alias_domains.cf
	
	virtual_mailbox_domains = proxy:pgsql:/etc/postfix/pgsql/virtual_domains_maps.cf
	virtual_mailbox_maps = proxy:pgsql:/etc/postfix/pgsql/virtual_mailbox_maps.cf
	
	
	virtual_mailbox_limit = 104857600
	virtual_minimum_uid = 5000
	virtual_uid_maps = static:5000
	virtual_gid_maps = static:5000
	virtual_mailbox_base = /home/vmail
	virtual_transport = lmtp:unix:private/dovecot-lmtp
	#virtual_transport = dovecot
	#dovecot_destination_recipient_limit
	local_transport = virtual
	#local_transport = lmtp:unix:private/dovecot-lmtp
	local_recipient_maps = $virtual_mailbox_maps
	#transport_maps = lmdb:/etc/postfix/transport
	
	
	
	#virtual_mailbox_domains = proxy:pgsql:/etc/postfix/pgsql-virtual-domains.cf
	#virtual_mailbox_domains = createand.net
	#virtual_mailbox_maps = proxy:pgsql:/etc/postfix/pgsql-virtual-users.cf
	#virtual_alias_maps = proxy:pgsql:/etc/postfix/pgsql-virtual-aliases.cf
	#smtpd_sasl_security_options = noanonymous,noplaintext
	
	##### SPAM kontrolü için 
	#mailbox_command = /usr/bin/procmail
	
