Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E3A1C9DF9
	for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567410; cv=none; b=WAggbN2mJfcr4tsPx6aC9eGi2Ywj9M+yHdKvBBLKh1e6B+inpWO46AOL6Z7ORhVFlrNCec/6OHHZorV3vmaKyn2r/2DhdPObXxz7oAWEal8nbyWuTzwAZpI7dbmCmIfDINpE56tAQ49/swvgD4mpWHVg9RAhcL5KEhP4tWKkR4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567410; c=relaxed/simple;
	bh=tkdXLhx59L8VU9bj46ZZ5MgchbfbVHP5vmFIRo5vSww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sc5YsTl2WTpW7A3avB4/eqCHdBTBGXPCxIHZKJVJeFiXoQcr9VRnbldoyK2CAfFRpTuqBwlFJlKb3YlaTu45RIekplVs5ZvL2fGVB6esx3LBqzrFj2n4EDlXV4jNl50C1+eEldxON27CbyhFl3/VLvkDuzPqsL5nZij9e6f35Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp5ZJn2o; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp5ZJn2o"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45efe44eb77so9368991cf.0
        for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 06:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728567408; x=1729172208; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUWYms31NLTdi6w9X+J/Hr1pkYMWRsGcJN33ZQDIn0g=;
        b=cp5ZJn2oVnxWLKCm/FwtbdwIrh6EfaCDZu6/scvvnLrh3paLKflj6FmGG+jyAP87ud
         cW4VAn+ttZlzsHVUVVp29ErmYsMTPtxclJAKLiuY1VuquEJBeEif4tnR0dSqYnIAVOJj
         ZXb5KjhUo94Y4hSWEtTvCJnYnOHsZUX58Eqfi+qGB+jmESpKUj31KRCQesLXLvzZmECF
         pMArWwEw5X96n9SOeMnHm2HAxjPv/g2+WkUS7PzUN0KOQSMwHB+keXUd69OX6IERkWp5
         XHMYyjaSPwAKdVsAUp+uKSKobtU78i4Rsn6BeATNI87uSO7N+0qWe+cftLtaEvZLn7y4
         r9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728567408; x=1729172208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUWYms31NLTdi6w9X+J/Hr1pkYMWRsGcJN33ZQDIn0g=;
        b=OC69oySRXV2SRqAARLNn4WAu7L78Cmh/w0FNRsUnk3DA4m1PSVB32iZFbcRghbsHjA
         cUzY6cB4K+Wxhm0kXMhA5299xkbnc/rfpuUY4tlkLY9jdviIaT5mbxBP9vz+ZjxFhH9L
         SDVjSV1iikCS3unVOk+XwGN3JzfjJU+zqOSWi0WvnubrAu+a6jcVuomeG2NCTrIYtkDe
         d1PAbk/fmiS5sT7uhxelnsCFH5i3OEjctczBHDipbkERjatDYxOwH02E6h9ydhNyJ32H
         /WVrmu84riTbvJYos0vIQL2nvxhUlLxW61UejiUONuUkF+ABfI+PGygLtqg5xX8U7OrI
         UdUw==
X-Gm-Message-State: AOJu0YxjB7vNDwPiqShhry6z9/OvbtNeVqiaVf9VRXayutAe1ZXDZdiP
	9Z+u7zlG+LBnnQq6/xoS53NaaRR5+bcf7aMEJWbm0CcmkMiXJcwckReX/Q==
X-Google-Smtp-Source: AGHT+IHsBOo69VM4DvI4VCKmB4wDDTSByiGpQdBWyDdyA7V2TVsqrguVSJcVEJ6M9N8F9EbCLrDQbw==
X-Received: by 2002:a05:622a:1b05:b0:456:802c:a67f with SMTP id d75a77b69052e-45fa5ecaeb2mr81783041cf.3.1728567407817;
        Thu, 10 Oct 2024 06:36:47 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4604287e00dsm5394251cf.74.2024.10.10.06.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 06:36:47 -0700 (PDT)
Message-ID: <154ebbba-2a3b-4f65-8b21-41dcc93d2107@gmail.com>
Date: Thu, 10 Oct 2024 06:36:45 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Martin Petzold <martin.petzold@tavla.de>,
 Denis Kenzior <denkenz@gmail.com>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <74af8f9e-b5dc-41be-998c-45bdd5958bbd@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <74af8f9e-b5dc-41be-998c-45bdd5958bbd@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/10/24 6:20 AM, Martin Petzold wrote:
> Hi Denis,
>
> Am 09.10.24 um 18:07 schrieb Denis Kenzior:
>> [...]
>>
>>> 3. Build IWD 2.22 from source (maybe using Debian sid source 
>>> package?) -> how to do best and will this work with libc6 version 
>>> 2.36? Missing libreadline8t64?
>>
>> I mean this is your only real solution.  There is no 'long term 
>> support' model for iwd.  You either run the latest or you're on your 
>> own.  It is highly unlikely that any of the developers will look at 
>> logs (or attempt to fix) anything but the latest version.
>>
>>
> Why does the following build fail. I did not install 'python-docutils' 
> package because is is not available for Debian bookworm (only a source 
> package). How should I proceed? Maybe the documentation should be 
> fixed then for Debian bookworm.
You need to use an updated version of ELL. IWD and ELL get released in 
tandem in case of any API/behavior changes.
>
> ----------
>
> $ make
>   GEN      ell/shared
>   GEN      ell/internal
>   GEN      ell/ell.h
>   GEN      src/builtin.h
> make --no-print-directory all-am
>   CC       client/main.o
>   CC       client/adapter.o
>   CC       client/agent.o
>   CC       client/agent-manager.o
>   CC       client/ad-hoc.o
>   CC       client/ap.o
>   CC       client/command.o
>   CC       client/dbus-proxy.o
>   CC       client/device.o
>   CC       client/display.o
>   CC       client/known-networks.o
>   CC       client/network.o
>   CC       client/properties.o
>   CC       client/wsc.o
>   CC       client/station.o
>   CC       client/diagnostic.o
>   CC       client/daemon.o
>   CC       client/dpp.o
>   CC       client/dpp-pkex.o
>   CC       client/station-debug.o
>   CC       client/bss.o
>   CC       src/util.o
>   CC       src/band.o
>   CC       ell/util.lo
>   CC       ell/test.lo
>   CC       ell/strv.lo
>   CC       ell/utf8.lo
>   CC       ell/queue.lo
>   CC       ell/hashmap.lo
>   CC       ell/string.lo
>   CC       ell/settings.lo
>   CC       ell/main.lo
>   CC       ell/idle.lo
>   CC       ell/signal.lo
>   CC       ell/timeout.lo
>   CC       ell/io.lo
>   CC       ell/ringbuf.lo
>   CC       ell/log.lo
>   CC       ell/checksum.lo
>   CC       ell/netlink.lo
>   CC       ell/genl.lo
>   CC       ell/rtnl.lo
>   CC       ell/dbus.lo
>   CC       ell/dbus-message.lo
>   CC       ell/dbus-util.lo
>   CC       ell/dbus-service.lo
>   CC       ell/dbus-client.lo
>   CC       ell/dbus-name-cache.lo
>   CC       ell/dbus-filter.lo
>   CC       ell/gvariant-util.lo
>   CC       ell/siphash.lo
>   CC       ell/hwdb.lo
>   CC       ell/cipher.lo
>   CC       ell/random.lo
>   CC       ell/uintset.lo
>   CC       ell/base64.lo
>   CC       ell/pem.lo
>   CC       ell/tls.lo
>   CC       ell/tls-record.lo
>   CC       ell/tls-suites.lo
>   CC       ell/tls-extensions.lo
>   CC       ell/uuid.lo
>   CC       ell/key.lo
>   CC       ell/file.lo
>   CC       ell/dir.lo
>   CC       ell/net.lo
>   CC       ell/dhcp.lo
>   CC       ell/dhcp-transport.lo
>   CC       ell/dhcp-lease.lo
>   CC       ell/dhcp-util.lo
>   CC       ell/dhcp-server.lo
>   CC       ell/cert.lo
>   CC       ell/cert-crypto.lo
>   CC       ell/ecc-external.lo
>   CC       ell/ecc.lo
>   CC       ell/ecdh.lo
>   CC       ell/time.lo
>   CC       ell/path.lo
>   CC       ell/dhcp6.lo
>   CC       ell/icmp6.lo
>   CC       ell/dhcp6-lease.lo
>   CC       ell/dhcp6-transport.lo
>   CC       ell/acd.lo
>   CC       ell/netconfig.lo
>   CC       ell/sysctl.lo
>   CC       ell/notifylist.lo
>   CCLD     ell/libell-internal.la
>   CCLD     client/iwctl
>   CC       monitor/main.o
>   CC       monitor/nlmon.o
>   CC       monitor/pcap.o
>   CC       monitor/display.o
>   CC       src/ie.o
>   CC       src/wscutil.o
>   CC       src/mpdu.o
>   CC       src/crypto.o
>   CC       src/watchlist.o
>   CC       src/eapolutil.o
>   CC       src/nl80211cmd.o
>   CC       src/p2putil.o
>   CC       src/anqputil.o
>   CCLD     monitor/iwmon
>   CC       src/main.o
>   CC       src/netdev.o
>   CC       src/wiphy.o
>   CC       src/device.o
>   CC       src/station.o
>   CC       src/dbus.o
>   CC       src/eapol.o
>   CC       src/handshake.o
>   CC       src/scan.o
>   CC       src/common.o
>   CC       src/agent.o
>   CC       src/storage.o
>   CC       src/network.o
>   CC       src/wsc.o
>   CC       src/backtrace.o
>   CC       src/knownnetworks.o
>   CC       src/rfkill.o
>   CC       src/ft.o
>   CC       src/ap.o
>   CC       src/adhoc.o
>   CC       src/sae.o
>   CC       src/nl80211util.o
>   CC       src/owe.o
>   CC       src/blacklist.o
>   CC       src/manager.o
>   CC       src/erp.o
>   CC       src/fils.o
>   CC       src/anqp.o
>   CC       src/netconfig.o
>   CC       src/netconfig-commit.o
>   CC       src/resolve.o
>   CC       src/hotspot.o
>   CC       src/p2p.o
>   CC       src/module.o
>   CC       src/rrm.o
>   CC       src/frame-xchg.o
>   CC       src/eap-wsc.o
>   CC       src/diagnostic.o
>   CC       src/ip-pool.o
>   CC       src/sysfs.o
>   CC       src/offchannel.o
>   CC       src/dpp-util.o
>   CC       src/json.o
>   CC       src/dpp.o
>   CC       src/udev.o
>   CC       src/eap.o
> src/eap.c: In function ‘eap_rx_packet’:
> src/eap.c:419:57: warning: ‘vendor_type’ may be used uninitialized 
> [-Wmaybe-uninitialized]
>   419 |         (type == EAP_TYPE_EXPANDED && vendor_id == (id) && 
> vendor_type == (t))
>       |                                                         ^~
> src/eap.c:429:18: note: ‘vendor_type’ was declared here
>   429 |         uint32_t vendor_type;
>       |                  ^~~~~~~~~~~
> src/eap.c:419:49: warning: ‘vendor_id’ may be used uninitialized 
> [-Wmaybe-uninitialized]
>   419 |         (type == EAP_TYPE_EXPANDED && vendor_id == (id) && 
> vendor_type == (t))
>       |                                                 ^~
> src/eap.c:428:18: note: ‘vendor_id’ was declared here
>   428 |         uint32_t vendor_id;
>       |                  ^~~~~~~~~
>   CC       src/eap-md5.o
>   CC       src/eap-tls.o
>   CC       src/eap-ttls.o
>   CC       src/eap-mschapv2.o
>   CC       src/eap-sim.o
>   CC       src/eap-aka.o
>   CC       src/eap-peap.o
>   CC       src/eap-gtc.o
>   CC       src/eap-pwd.o
>   CC       src/simutil.o
>   CC       src/simauth.o
>   CC       src/eap-tls-common.o
>   CC       src/mschaputil.o
>   CCLD     src/iwd
>   CC       tools/probe-req.o
>   CCLD     tools/probe-req
>   CC       tools/iwd-decrypt-profile.o
>   CCLD     tools/iwd-decrypt-profile
>   GEN      src/iwd.8
> Generated manual page src/iwd.8 does not exist
> make[1]: *** [Makefile:4106: src/iwd.8] Fehler 1
> make: *** [Makefile:1746: all] Fehler 2
>
> ----------
>
> Thanks,
>
> Martin
>
>
