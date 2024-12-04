	# This is the right place to customize your installation of SpamAssassin.
	#
	# See 'perldoc Mail::SpamAssassin::Conf' for details of what can be
	# tweaked.
	#
	# Only a small subset of options are listed below
	#
	###########################################################################
	
	#   Add *****SPAM***** to the Subject header of spam e-mails
	#
	
	rewrite_header Subject *****SPAM*****
	
	
	#   Save spam messages as a message/rfc822 MIME attachment instead of
	#   modifying the original message (0: off, 2: use text/plain instead)
	#
	# report_safe 1
	
	
	#   Set which networks or hosts are considered 'trusted' by your mail
	#   server (i.e. not spammers)
	#
	# trusted_networks 212.17.35.
	
	
	#   Set file-locking method (flock is not safe over NFS, but is faster)
	#
	# lock_method flock
	
	
	#   Set the threshold at which a message is considered spam (default: 5.0)
	#
	required_score 3.0
	
	#######
	debug_level 3
	
	
	#   Use Bayesian classifier (default: 1)
	#
	# use_bayes 1
	
	
	#   Bayesian classifier auto-learning (default: 1)
	#
	# bayes_auto_learn 1
	
	
	#   Set headers which may provide inappropriate cues to the Bayesian
	#   classifier
	#
	
	add_header all Status _YESNO_, score=_SCORE_ required=_REQD_ version=_VERSION_
	bayes_ignore_header X-Bogosity
	bayes_ignore_header X-Spam-Flag
	bayes_ignore_header X-Spam-Status
	
	
	#   Whether to decode non- UTF-8 and non-ASCII textual parts and recode
	#   them to UTF-8 before the text is given over to rules processing.
	#
	# normalize_charset 1
	
	#   Textual body scan limit    (default: 50000)
	#
	#   Amount of data per email text/* mimepart, that will be run through body
	#   rules.  This enables safer and faster scanning of large messages,
	#   perhaps having very large textual attachments.  There should be no need
	#   to change this well tested default.
	#
	# body_part_scan_size 50000
	
	#   Textual rawbody data scan limit    (default: 500000)
	#
	#   Amount of data per email text/* mimepart, that will be run through
	#   rawbody rules.
	#
	# rawbody_part_scan_size 500000
	
	#   Some shortcircuiting, if the plugin is enabled
	# 
	ifplugin Mail::SpamAssassin::Plugin::Shortcircuit
	#
	#   default: strongly-whitelisted mails are *really* whitelisted now, if the
	#   shortcircuiting plugin is active, causing early exit to save CPU load.
	#   Uncomment to turn this on
	#
	#   SpamAssassin tries hard not to launch DNS queries before priority -100. 
	#   If you want to shortcircuit without launching unneeded queries, make
	#   sure such rule priority is below -100. These examples are already:
	#
	# shortcircuit USER_IN_WHITELIST       on
	# shortcircuit USER_IN_DEF_WHITELIST   on
	# shortcircuit USER_IN_ALL_SPAM_TO     on
	# shortcircuit SUBJECT_IN_WHITELIST    on
	
	#   the opposite; blacklisted mails can also save CPU
	#
	# shortcircuit USER_IN_BLACKLIST       on
	# shortcircuit USER_IN_BLACKLIST_TO    on
	# shortcircuit SUBJECT_IN_BLACKLIST    on
	
	#   if you have taken the time to correctly specify your "trusted_networks",
	#   this is another good way to save CPU
	#
	# shortcircuit ALL_TRUSTED             on
	
	#   and a well-trained bayes DB can save running rules, too
	#
	# shortcircuit BAYES_99                spam
	# shortcircuit BAYES_00                ham
	
	endif # Mail::SpamAssassin::Plugin::Shortcircuit
	
	
	header SPAM_SUBJECT_FREE Subject =~ /free money/i
	describe SPAM_SUBJECT_FREE Subject contains "free money"
	score SPAM_SUBJECT_FREE 4.0
	
	
	# kara listeler
	header RCVD_IN_ZEN eval:check_rbl('zen.spamhaus.org')
	describe RCVD_IN_ZEN Sender listed in Spamhaus Zen
	score RCVD_IN_ZEN 3.0
	
	header RCVD_IN_SPAMCOP eval:check_rbl('bl.spamcop.net')
	describe RCVD_IN_SPAMCOP Sender listed in SpamCop
	score RCVD_IN_SPAMCOP 2.5
	
	header RCVD_IN_BARRACUDA eval:check_rbl('b.barracudacentral.org')
	describe RCVD_IN_BARRACUDA Sender listed in Barracuda blacklist
	score RCVD_IN_BARRACUDA 4.0