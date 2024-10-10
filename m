Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655B1C9B89
	for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566813; cv=none; b=i4HQU3UHLJdoobkN2/3v26nc1STIvGiq1M7pIavtooXtb8EOk6nC3eNVDpC8d2uVG5hedAbC26v3c45xJ17gPN/2Wn3UaBc+nNHq6L4HfuKUQQF5GHPth6lQwsU3uD/WT1pI5tYB/R2HnfHRBP3cDJFX06RSUYV0Ym0ceKTeoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566813; c=relaxed/simple;
	bh=HoYBrePk9JYMJYseepOVpyXwKbviHGRpIMrMqOGkYZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=OBJLivP+IZoAiNKkF3hDNELC+OYt2kAzz5xVbOFBL6lpxQG+UxVd8dn3pa8FdWObu8gEcdZE9v2ZP/+3ovqKRtQaTcJDo81zgegI7Ol85xs4z44CgYixZN7bEv0cu3zVbGBrxMm5ObDRVP6Lcjm1fpPadkpliW7AKd8fkfBdZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=O3PR+Xox; arc=none smtp.client-ip=195.10.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="O3PR+Xox"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4XPVjg5PRyz9tSV;
	Thu, 10 Oct 2024 15:20:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1728566407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1ezu64fKDU8ZKlbcadKLMd17mpelH6cU4AXu+0UDe8=;
	b=O3PR+XoxPWUV1J4W6NS2Ph6L0DTryKeEXgda4GQkpShXv3sguCs5vj0lURgc5eEnXwL1fM
	52tt65wyxjWo5nyuqMaN+2skOxTJoFa/f6Vt5xGWDdaW+wD/fn9jhOWqmWj14apv0QmhR+
	dnPIvKa4fVF/Tsw1dwimlqL2NAr2xKQd6mHm14m01WSJJJp7KqqZxmGV1uq5uAGsps2rKy
	win03UaQToD9M8dWTrrg7LC8iDKKrXALj3KlAdhS9riOGpV0CJYZWqRSQ6yy/8lMp63ixE
	MiqTwTYb68gz4oIkQ/itengoHRDzFh4lUclh46nC6ts6Bdg/3OCAdgDkZ2d6nQ==
Message-ID: <74af8f9e-b5dc-41be-998c-45bdd5958bbd@tavla.de>
Date: Thu, 10 Oct 2024 15:20:05 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Denis Kenzior <denkenz@gmail.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
Content-Language: en-GB, de-DE
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XPVjg5PRyz9tSV

Hi Denis,

Am 09.10.24 um 18:07 schrieb Denis Kenzior:
> [...]
>
>> 3. Build IWD 2.22 from source (maybe using Debian sid source 
>> package?) -> how to do best and will this work with libc6 version 
>> 2.36? Missing libreadline8t64?
>
> I mean this is your only real solution.  There is no 'long term 
> support' model for iwd.  You either run the latest or you're on your 
> own.  It is highly unlikely that any of the developers will look at 
> logs (or attempt to fix) anything but the latest version.
>
>
Why does the following build fail. I did not install 'python-docutils' 
package because is is not available for Debian bookworm (only a source 
package). How should I proceed? Maybe the documentation should be fixed 
then for Debian bookworm.

----------

$ make
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

----------

Thanks,

Martin

