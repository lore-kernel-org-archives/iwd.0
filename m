Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F1E33D7
	for <iwd@lists.linux.dev>; Mon, 19 Sep 2022 10:37:41 +0000 (UTC)
Received: from [192.168.0.120] (52.85.185.80.rev.sfr.net [80.185.85.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 27D353F12A
	for <iwd@lists.linux.dev>; Mon, 19 Sep 2022 10:37:34 +0000 (UTC)
Message-ID: <8da6bf82-b708-c497-ea31-dbd1c7545f99@ubuntu.com>
Date: Mon, 19 Sep 2022 12:37:32 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: iwd@lists.linux.dev
Content-Language: en-US
From: Sebastien Bacher <seb128@ubuntu.com>
Subject: Build issue in tests when LTO enabled
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey there,

The issue is impacting Debian and Ubuntu, it has been reported on 
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1015432 which includes 
the build log; https://wiki.debian.org/ToolChain/LTO has details on how 
LTO is being enabled in Debian, but basically 'Enabling LTO adds the 
flags -flto=auto -ffat-lto-objects to CFLAGS, CXXFLAGS, OBJCFLAGS ... 
and the flag -flto=auto to LDFLAGS'

the build is errors out on

/bin/bash ./libtool  --tag=CC   --mode=link gcc -fvisibility=hidden 
-DUNITDIR=\""./unit/"\" -DCERTDIR=\""./unit/"\" -DJSMN_PARENT_LINKS 
-DJSMN_STRICT  -g -O2 -ffile-prefix-map=/<<PKGBUILDDIR>>=. -flto=auto 
-ffat-lto-objects -fstack-protector-strong -Wformat 
-Werror=format-security  -flto=auto -ffat-lto-objects -Wl,-z,relro 
-Wl,-z,now -o unit/test-util src/util.o src/band.o unit/test-util.o -lell
/usr/bin/ld: /tmp/cckxZfEz.ltrans0.ltrans.o: in function 
`sae_choose_next_group':
./src/sae.c:144: undefined reference to `__wrap_l_ecc_supported_ike_groups'
/usr/bin/ld: /tmp/cckxZfEz.ltrans0.ltrans.o: in function 
`sae_rx_authenticate':
./src/sae.c:186: undefined reference to `__wrap_l_ecc_supported_ike_groups'
/usr/bin/ld: /tmp/cckxZfEz.ltrans0.ltrans.o: in function 
`handshake_state_free':
./src/handshake.c:49: undefined reference to 
`__wrap_l_ecc_supported_ike_groups'
/usr/bin/ld: /tmp/cckxZfEz.ltrans0.ltrans.o:./src/handshake.c:49: 
undefined reference to `__wrap_l_ecc_supported_ike_groups'
collect2: error: ld returned 1 exit status

That's still a problem with 1.30

Cheers,
Sebastien Bacher

