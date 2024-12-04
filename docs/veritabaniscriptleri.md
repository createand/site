[Yapılandırmalar için yardım alınan sayfa](https://www.drassal.net/wp/setting-up-an-email-server-with-postfix-dovecot-postfixadmin-and-roundcube/)

	# relay_domains.cf
	# postgresql
	user = user
	password = password
	hosts = localhost
	dbname = postfix
	query = SELECT domain FROM domain WHERE domain='%s' and backupmx = true

	# virtual_alias_domains.cf
	# postgresql
	user = user
	password = password
	hosts = localhost
	dbname = postfix
	query = SELECT alias_domain FROM alias_domain WHERE alias_domain='%s' AND active = '1'

	# virtual_alias_domains_maps.cf
	# postgresql
	user = user
	password = password
	hosts = localhost
	dbname = postfix
	query = SELECT goto FROM alias,alias_domain WHERE alias_domain.alias_domain = '%d' and alias.address = '%u' || '@' || alias_domain.target_domain AND alias.active = '1' AND alias_domain.active='1'

	# virtual_alias_maps.cf
	# postgresql
	user = user
	password = password
	hosts = localhost
	dbname = postfix
	query = SELECT goto FROM alias WHERE address='%s' AND active = true

	# virutal_domains_maps.cf
	# postgresql
	user = user
	password = password
	hosts = localhost
	dbname = postfix
	###query = SELECT domain FROM domain WHERE domain='%s'
	###optional query to use when relaying for backup MX
	query = SELECT domain FROM domain WHERE domain='%s' and backupmx = false and active = true	
	
	# virtual_mailbox_limits.cf
	# postgresql
	user = user
	password = password
	hosts = localhost
	dbname = postfix
	query = SELECT quota FROM mailbox WHERE username='%s'

	# virtual_mailbox_maps.cf
	# postgresql
	user = user
	password = password
	hosts = localhost
	dbname = postfix

	table = mailbox
	select_field = maildir
	where_field = username
	additional_conditions = and active = '1'


	###query = SELECT maildir FROM mailbox WHERE username='%s' AND active = true
	###query = SELECT password FROM mailbox WHERE email='%s'

	
	# virtual_sender_maps.cf
	# postgresql
	user = user
	password = password
	hosts = localhost
	dbname = postfix
	query = SELECT username FROM mailbox WHERE username='%s' AND active = true
