Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568781C9DD3
	for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568077; cv=none; b=YO2bmhpAPnsKYwKjti6ufUUwL5HOGQ9sU0C9RnAanDz+T7GHTF3WiMHBDCDrgSibQOTZZkgk7cq9AqBZuq1flPTMxaEg/UF6aqdpNhtJpKCNT+aIp05zUX/I0dZISrl7i33miSwsTh+trwuwMoRfWCnGPuVgw/6hh6KHHzv8+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568077; c=relaxed/simple;
	bh=6dfp5d1NCZGhO8FhbPtAL/lX2rFLMey3ehKFEz0wbwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eovTl7cbkveRUAZYtoJpN8KsArLslS9LpOISe1Jmdwmtcd6oogo9ImIq/FWZmSxyFeirfPGU75z3mYfZJfPQ51pOhA8ey36I8PI0xVZfe0FqT+kNbfdw9QXQXgRl9MxYK0END4ytB/SutbNL9u1y0x6apObbXtGbV9K/lxOu8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=EtDLdWM9; arc=none smtp.client-ip=195.10.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="EtDLdWM9"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4XPWKd3Mg4z9v3W;
	Thu, 10 Oct 2024 15:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1728568069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtQ2/NnCRgSyXWBQOavoDBimsH9xwz9XuCukAzzNg0M=;
	b=EtDLdWM9cAiCWcCQDFDndLQEN6sz4ysEuxp3nke0BVoE2c/091NFjlmwG8rZCaThwMPJrk
	u+alNvBELjts2XapY07QPo8EmsX00D7pLUzH/qvyq+bQfk8RE2kH2WYzMyBxu5KBopcQTP
	61F4KwZsjEdEWVisrla4pRt4QOXyPR8c4GVHw5A41IaujLhHMdzMwBTc0il6OHk09zhB4O
	bMG9RwpgLzMrw6jGtqXqKs3xKvt4WOOKetWbuH7a8E0IZYmzfWMozmMTWuJ/8AuLmeylnD
	GbZXVKWPrFi9GYUY0r1jAi5NWdfGfbHALX6ElIOxOlfyWmfZ5Gpiz+Ku+Ov7Ng==
Message-ID: <1fcf76fd-85ab-4a31-8aaf-9d6922ab3a97@tavla.de>
Date: Thu, 10 Oct 2024 15:47:48 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: James Prestwood <prestwoj@gmail.com>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 Denis Kenzior <denkenz@gmail.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <74af8f9e-b5dc-41be-998c-45bdd5958bbd@tavla.de>
 <154ebbba-2a3b-4f65-8b21-41dcc93d2107@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <154ebbba-2a3b-4f65-8b21-41dcc93d2107@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

Am 10.10.24 um 15:36 schrieb James Prestwood:
>
> On 10/10/24 6:20 AM, Martin Petzold wrote:
>> Hi Denis,
>>
>> Am 09.10.24 um 18:07 schrieb Denis Kenzior:
>>> [...]
>>>
>>>> 3. Build IWD 2.22 from source (maybe using Debian sid source 
>>>> package?) -> how to do best and will this work with libc6 version 
>>>> 2.36? Missing libreadline8t64?
>>>
>>> I mean this is your only real solution.  There is no 'long term 
>>> support' model for iwd.  You either run the latest or you're on your 
>>> own.  It is highly unlikely that any of the developers will look at 
>>> logs (or attempt to fix) anything but the latest version.
>>>
>>>
>> Why does the following build fail. I did not install 
>> 'python-docutils' package because is is not available for Debian 
>> bookworm (only a source package). How should I proceed? Maybe the 
>> documentation should be fixed then for Debian bookworm.
> You need to use an updated version of ELL. IWD and ELL get released in 
> tandem in case of any API/behavior changes. 

I used for both git HEAD repository (how can I get both in line?):

tavla@tavla:~/iwd$ make clean
  rm -f client/iwctl monitor/iwmon
test -z "src/iwd.service wired/ead.service" || rm -f src/iwd.service 
wired/ead.service
  rm -f src/iwd
rm -rf .libs _libs
rm -rf client/.libs client/_libs
rm -rf ell/.libs ell/_libs
rm -rf monitor/.libs monitor/_libs
rm -rf src/.libs src/_libs
rm -rf tools/.libs tools/_libs
rm -rf unit/.libs unit/_libs
rm -rf wired/.libs wired/_libs
quiet --directory . -z
/bin/bash: Zeile 1: quiet: Kommando nicht gefunden.
make: [Makefile:4113: gcov-clean] Fehler 127 (ignoriert)
rm -rf "./iwd-coverage.info" "./gcov"
find . -name "*.gcda" -o -name "*.gcov" -o -name "*.gcno" -delete
rm -f unit/cert-*.pem unit/cert-*.csr unit/cert-*.srl unit/*-settings.8021x
test -z "ell/libell-internal.la" || rm -f ell/libell-internal.la
rm -f ell/so_locations
  rm -f tools/probe-req tools/iwd-decrypt-profile
rm -f *.o
rm -f client/*.o
rm -f ell/*.o
rm -f ell/*.lo
rm -f monitor/*.o
rm -f src/*.o
rm -f tools/*.o
rm -f unit/*.o
rm -f wired/*.o
test -z "unit/test-cmac-aes.log unit/test-hmac-md5.log 
unit/test-hmac-sha1.log unit/test-hmac-sha256.log unit/test-prf-sha1.log 
unit/test-kdf-sha256.log unit/test-crypto.log unit/test-eapol.log 
unit/test-mpdu.log unit/test-ie.log unit/test-util.log 
unit/test-ssid-security.log unit/test-arc4.log unit/test-wsc.log 
unit/test-eap-mschapv2.log unit/test-eap-sim.log unit/test-sae.log 
unit/test-p2p.log unit/test-band.log unit/test-dpp.log 
unit/test-json.log unit/test-nl80211util.log unit/test-client.log" || rm 
-f unit/test-cmac-aes.log unit/test-hmac-md5.log unit/test-hmac-sha1.log 
unit/test-hmac-sha256.log unit/test-prf-sha1.log 
unit/test-kdf-sha256.log unit/test-crypto.log unit/test-eapol.log 
unit/test-mpdu.log unit/test-ie.log unit/test-util.log 
unit/test-ssid-security.log unit/test-arc4.log unit/test-wsc.log 
unit/test-eap-mschapv2.log unit/test-eap-sim.log unit/test-sae.log 
unit/test-p2p.log unit/test-band.log unit/test-dpp.log 
unit/test-json.log unit/test-nl80211util.log unit/test-client.log
test -z "unit/test-cmac-aes.trs unit/test-hmac-md5.trs 
unit/test-hmac-sha1.trs unit/test-hmac-sha256.trs unit/test-prf-sha1.trs 
unit/test-kdf-sha256.trs unit/test-crypto.trs unit/test-eapol.trs 
unit/test-mpdu.trs unit/test-ie.trs unit/test-util.trs 
unit/test-ssid-security.trs unit/test-arc4.trs unit/test-wsc.trs 
unit/test-eap-mschapv2.trs unit/test-eap-sim.trs unit/test-sae.trs 
unit/test-p2p.trs unit/test-band.trs unit/test-dpp.trs 
unit/test-json.trs unit/test-nl80211util.trs unit/test-client.trs" || rm 
-f unit/test-cmac-aes.trs unit/test-hmac-md5.trs unit/test-hmac-sha1.trs 
unit/test-hmac-sha256.trs unit/test-prf-sha1.trs 
unit/test-kdf-sha256.trs unit/test-crypto.trs unit/test-eapol.trs 
unit/test-mpdu.trs unit/test-ie.trs unit/test-util.trs 
unit/test-ssid-security.trs unit/test-arc4.trs unit/test-wsc.trs 
unit/test-eap-mschapv2.trs unit/test-eap-sim.trs unit/test-sae.trs 
unit/test-p2p.trs unit/test-band.trs unit/test-dpp.trs 
unit/test-json.trs unit/test-nl80211util.trs unit/test-client.trs
test -z "test-suite.log" || rm -f test-suite.log
rm -f *.lo
tavla@tavla:~/iwd$
tavla@tavla:~/iwd$
tavla@tavla:~/iwd$ ./bootstrap
libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, 'build-aux'.
libtoolize: linking file 'build-aux/ltmain.sh'
libtoolize: putting macros in AC_CONFIG_MACRO_DIRS, 'build-aux'.
libtoolize: linking file 'build-aux/libtool.m4'
libtoolize: linking file 'build-aux/ltoptions.m4'
libtoolize: linking file 'build-aux/ltsugar.m4'
libtoolize: linking file 'build-aux/ltversion.m4'
libtoolize: linking file 'build-aux/lt~obsolete.m4'
configure.ac:23: installing 'build-aux/compile'
configure.ac:8: installing 'build-aux/missing'
Makefile.am: installing 'build-aux/depcomp'
tavla@tavla:~/iwd$ ./configure --prefix=/usr --localstatedir=/var 
--sysconfdir=/etc --disable-systemd-service
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a race-free mkdir -p... /usr/bin/mkdir -p
checking for gawk... no
checking for mawk... mawk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking how to create a pax tar archive... gnutar
checking whether make supports nested variables... (cached) yes
checking whether to enable maintainer-specific portions of Makefiles... no
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether the compiler supports GNU C... yes
checking whether gcc accepts -g... yes
checking for gcc option to enable C11 features... none needed
checking whether gcc understands -c and -o together... yes
checking whether make supports the include directive... yes (GNU style)
checking dependency style of gcc... gcc3
checking whether gcc accepts -fPIE... yes
checking whether gcc accepts -fsanitize=address... yes
checking whether gcc accepts -fsanitize=leak... yes
checking whether gcc accepts -fsanitize=undefined... yes
checking whether gcc accepts -fprofile-arcs... yes
checking whether gcc accepts -ftest_coverage... yes
checking whether ln -s works... yes
checking for special C compiler options needed for large files... no
checking for _FILE_OFFSET_BITS value needed for large files... no
checking build system type... aarch64-unknown-linux-gnu
checking host system type... aarch64-unknown-linux-gnu
checking how to print strings... printf
checking for a sed that does not truncate output... /usr/bin/sed
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for fgrep... /usr/bin/grep -F
checking for ld used by gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
checking the name lister (/usr/bin/nm -B) interface... BSD nm
checking the maximum length of command line arguments... 1572864
checking how to convert aarch64-unknown-linux-gnu file names to 
aarch64-unknown-linux-gnu format... func_convert_file_noop
checking how to convert aarch64-unknown-linux-gnu file names to 
toolchain format... func_convert_file_noop
checking for /usr/bin/ld option to reload object files... -r
checking for file... file
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for ar... ar
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for sysroot... no
checking for a working dd... /usr/bin/dd
checking how to truncate binary pipes... /usr/bin/dd bs=4096 count=1
checking for mt... no
checking if : is a manifest tool... no
checking for stdio.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for strings.h... yes
checking for sys/stat.h... yes
checking for sys/types.h... yes
checking for unistd.h... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC -DPIC
checking if gcc PIC flag -fPIC -DPIC works... yes
checking if gcc static flag -static works... yes
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker (/usr/bin/ld) supports shared 
libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
checking for _init in -lasan... yes
checking for _init in -llsan... yes
checking for _init in -lubsan... yes
checking for explicit_bzero... yes
checking for rawmemchr... yes
checking for reallocarray... yes
checking for linux/types.h... yes
checking for linux/if_alg.h... yes
checking for readline... yes
checking D-Bus data directory... /usr/share
checking for rst2man... no
checking for rst2man.py... no
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating config.h
config.status: config.h is unchanged
config.status: executing depfiles commands
config.status: executing libtool commands

     iwd 2.22

tavla@tavla:~/iwd$ make
   GEN      ell/shared
   GEN      ell/internal
   GEN      ell/ell.h
   GEN      src/builtin.h
make --no-print-directory all-am
   CC       client/main.o
   CC       client/adapter.o
   CC       client/agent.o
   CC       client/agent-manager.o
   CC       client/ad-hoc.o
   CC       client/ap.o
   CC       client/command.o
   CC       client/dbus-proxy.o
   CC       client/device.o
   CC       client/display.o
   CC       client/known-networks.o
   CC       client/network.o
   CC       client/properties.o
   CC       client/wsc.o
   CC       client/station.o
   CC       client/diagnostic.o
   CC       client/daemon.o
   CC       client/dpp.o
   CC       client/dpp-pkex.o
   CC       client/station-debug.o
   CC       client/bss.o
   CC       src/util.o
   CC       src/band.o
   CC       ell/util.lo
   CC       ell/test.lo
   CC       ell/strv.lo
   CC       ell/utf8.lo
   CC       ell/queue.lo
   CC       ell/hashmap.lo
   CC       ell/string.lo
   CC       ell/settings.lo
   CC       ell/main.lo
   CC       ell/idle.lo
   CC       ell/signal.lo
   CC       ell/timeout.lo
   CC       ell/io.lo
   CC       ell/ringbuf.lo
   CC       ell/log.lo
   CC       ell/checksum.lo
   CC       ell/netlink.lo
   CC       ell/genl.lo
   CC       ell/rtnl.lo
   CC       ell/dbus.lo
   CC       ell/dbus-message.lo
   CC       ell/dbus-util.lo
   CC       ell/dbus-service.lo
   CC       ell/dbus-client.lo
   CC       ell/dbus-name-cache.lo
   CC       ell/dbus-filter.lo
   CC       ell/gvariant-util.lo
   CC       ell/siphash.lo
   CC       ell/hwdb.lo
   CC       ell/cipher.lo
   CC       ell/random.lo
   CC       ell/uintset.lo
   CC       ell/base64.lo
   CC       ell/pem.lo
   CC       ell/tls.lo
   CC       ell/tls-record.lo
   CC       ell/tls-suites.lo
   CC       ell/tls-extensions.lo
   CC       ell/uuid.lo
   CC       ell/key.lo
   CC       ell/file.lo
   CC       ell/dir.lo
   CC       ell/net.lo
   CC       ell/dhcp.lo
   CC       ell/dhcp-transport.lo
   CC       ell/dhcp-lease.lo
   CC       ell/dhcp-util.lo
   CC       ell/dhcp-server.lo
   CC       ell/cert.lo
   CC       ell/cert-crypto.lo
   CC       ell/ecc-external.lo
   CC       ell/ecc.lo
   CC       ell/ecdh.lo
   CC       ell/time.lo
   CC       ell/path.lo
   CC       ell/dhcp6.lo
   CC       ell/icmp6.lo
   CC       ell/dhcp6-lease.lo
   CC       ell/dhcp6-transport.lo
   CC       ell/acd.lo
   CC       ell/netconfig.lo
   CC       ell/sysctl.lo
   CC       ell/notifylist.lo
   CCLD     ell/libell-internal.la
   CCLD     client/iwctl
   CC       monitor/main.o
   CC       monitor/nlmon.o
   CC       monitor/pcap.o
   CC       monitor/display.o
   CC       src/ie.o
   CC       src/wscutil.o
   CC       src/mpdu.o
   CC       src/crypto.o
   CC       src/watchlist.o
   CC       src/eapolutil.o
   CC       src/nl80211cmd.o
   CC       src/p2putil.o
   CC       src/anqputil.o
   CCLD     monitor/iwmon
   CC       src/main.o
   CC       src/netdev.o
   CC       src/wiphy.o
   CC       src/device.o
   CC       src/station.o
   CC       src/dbus.o
   CC       src/eapol.o
   CC       src/handshake.o
   CC       src/scan.o
   CC       src/common.o
   CC       src/agent.o
   CC       src/storage.o
   CC       src/network.o
   CC       src/wsc.o
   CC       src/backtrace.o
   CC       src/knownnetworks.o
   CC       src/rfkill.o
   CC       src/ft.o
   CC       src/ap.o
   CC       src/adhoc.o
   CC       src/sae.o
   CC       src/nl80211util.o
   CC       src/owe.o
   CC       src/blacklist.o
   CC       src/manager.o
   CC       src/erp.o
   CC       src/fils.o
   CC       src/anqp.o
   CC       src/netconfig.o
   CC       src/netconfig-commit.o
   CC       src/resolve.o
   CC       src/hotspot.o
   CC       src/p2p.o
   CC       src/module.o
   CC       src/rrm.o
   CC       src/frame-xchg.o
   CC       src/eap-wsc.o
   CC       src/diagnostic.o
   CC       src/ip-pool.o
   CC       src/sysfs.o
   CC       src/offchannel.o
   CC       src/dpp-util.o
   CC       src/json.o
   CC       src/dpp.o
   CC       src/udev.o
   CC       src/eap.o
src/eap.c: In function ‘eap_rx_packet’:
src/eap.c:419:57: warning: ‘vendor_type’ may be used uninitialized 
[-Wmaybe-uninitialized]
   419 |         (type == EAP_TYPE_EXPANDED && vendor_id == (id) && 
vendor_type == (t))
       |                                                         ^~
src/eap.c:429:18: note: ‘vendor_type’ was declared here
   429 |         uint32_t vendor_type;
       |                  ^~~~~~~~~~~
src/eap.c:419:49: warning: ‘vendor_id’ may be used uninitialized 
[-Wmaybe-uninitialized]
   419 |         (type == EAP_TYPE_EXPANDED && vendor_id == (id) && 
vendor_type == (t))
       |                                                 ^~
src/eap.c:428:18: note: ‘vendor_id’ was declared here
   428 |         uint32_t vendor_id;
       |                  ^~~~~~~~~
   CC       src/eap-md5.o
   CC       src/eap-tls.o
   CC       src/eap-ttls.o
   CC       src/eap-mschapv2.o
   CC       src/eap-sim.o
   CC       src/eap-aka.o
   CC       src/eap-peap.o
   CC       src/eap-gtc.o
   CC       src/eap-pwd.o
   CC       src/simutil.o
   CC       src/simauth.o
   CC       src/eap-tls-common.o
   CC       src/mschaputil.o
   CCLD     src/iwd
   CC       tools/probe-req.o
   CCLD     tools/probe-req
   CC       tools/iwd-decrypt-profile.o
   CCLD     tools/iwd-decrypt-profile
   GEN      src/iwd.8
Generated manual page src/iwd.8 does not exist
make[1]: *** [Makefile:4106: src/iwd.8] Fehler 1
make: *** [Makefile:1746: all] Fehler 2

