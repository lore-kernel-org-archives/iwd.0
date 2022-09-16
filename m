Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79FA53A7
	for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 13:45:03 +0000 (UTC)
Received: from [10.172.195.180] (1.general.seb128.uk.vpn [10.172.195.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 659F63F12E
	for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 13:37:45 +0000 (UTC)
Message-ID: <afcd1b75-6cac-9efa-5ed0-d1ebb5a46f0d@ubuntu.com>
Date: Fri, 16 Sep 2022 15:37:43 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From: Sebastien Bacher <seb128@ubuntu.com>
Subject: No rule to make target 'src/iwd.debug.7'
To: iwd@lists.linux.dev
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The error was initial found while trying to build an Ubuntu package 
update for iwd but can be triggered by those steps (basically building, 
cleaning the tree and trying to build again)

$ wget 
https://mirrors.edge.kernel.org/pub/linux/network/wireless/iwd-1.30.tar.xz
$ tar xf iwd-1.30.tar.xz
$ cd iwd-1.30
$ ./configure
$ make
$ make distclean
$ autoreconf
$ ./configure
$ make
...

  GEN      src/iwd.8
make[1]: *** No rule to make target 'src/iwd.debug.7', needed by 
'all-am'.  Stop.
make: *** [Makefile:1579: all] Error 2

Cheers,
Sebastien
