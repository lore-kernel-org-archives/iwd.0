Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92B178CEC
	for <iwd@lists.linux.dev>; Sat, 26 Oct 2024 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729933632; cv=none; b=m24z5DTGVgzvH/Rx3jTLiBtXY7HIsZc62vcgGmo4ZTvSrbwZLcADGxjQBZ0154UwuKO/2gqsgsmFnEJyD0oaYFK4znz5uAmkRRAg9JtAAQGK17jZbQWAlGhmrwEVvQGe/kmSi98wMV9XoNs323c+7cBj/aMZsA+fZSrHaCN7SXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729933632; c=relaxed/simple;
	bh=LqlrmzB7eqX4wwYZ0xlPjmO0ZutqGF/CDJ564rizdTw=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rMlI3T85xTj4EqK4G9/PogWMnN5PH2jQHZIpk790qr2n64yEDZAhkqCYX3TlIqT6gM15BYl1KpZwvYU1sYIG2cTFesPyrmSC4bQ6owZUz+u8WljZSdt8oUL69/i+4w4VD1XIGXcwTFo6nQ/HjlqamKDK3tfj8Yn3OBg2RH9jTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fYcpf1/W; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fYcpf1/W"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cb72918bddso3611015a12.3
        for <iwd@lists.linux.dev>; Sat, 26 Oct 2024 02:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729933628; x=1730538428; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=264AyoDMJCgXyZ/K64E+KIhDHdlZF17sRQx3stEGafE=;
        b=fYcpf1/WiOlmINeexOLcMd5r1MXgKzLoRqFrwxwVPz63bkfeGdcyOttLz6BRmFwB0I
         sn3RBkPr/wgIS7FFyAHsAfq3Qz20yVbof7nfKALDjhHlAXLyOIUCzXVLRaT6xzrUZIGg
         OIBcelbWAg5BPQkLD9bBjBzMDo1gANiNRT1lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729933628; x=1730538428;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=264AyoDMJCgXyZ/K64E+KIhDHdlZF17sRQx3stEGafE=;
        b=FFFtWOYNaTT20mMVFeABe8eGRUfn9KLSLbvgqZ+dxwPu0Py4VJtt9fOoBwQlB6q7NL
         hK9Y9DtLmM64fDutXBoAW8dslAb1QBfJ5VxFZLGyWuWNqkFKzqrUlJ7qRDFAz1pqU1+4
         B5yBUCE1b0neyeXLZyEwvwU/M/JAAd7GPftFapsKwhJQasyDcDqUuwgL7fdlg/2L23lf
         ZvwtfXNUxgaaKoE5zMYI5NXxCyIkWPUl9ewm7ZZ+uZfRuXD85JuzNAbddz2UdAp1sUpD
         rRCjlCqWiZ2oQv6ao++8yOGtk4uILRh2rjchFRu3jIhIv0s0uGggH9uf9Nm5xTSX+m7y
         yfRA==
X-Gm-Message-State: AOJu0Yz7OTSrM3fD7novE54iZmwrVTdtOtp1ATIFH0zhpOr7jqbBr2NM
	+mlBUEzgo/fMDzEI+tKB6FkWkCD2eCe6HH/35uPbLSWVuOUOMJerN8TE04hAAg==
X-Google-Smtp-Source: AGHT+IFDV3d0vvOiRMVnr5ZCqrHFPJcpXc17A0oKGEVMYRkI5YX94k/BYhHsGBs0FyY4OzPqZIuy2w==
X-Received: by 2002:a05:6402:845:b0:5cb:8161:40c4 with SMTP id 4fb4d7f45d1cf-5cbbf8e016bmr1115407a12.21.1729933627674;
        Sat, 26 Oct 2024 02:07:07 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6257a68sm1379012a12.9.2024.10.26.02.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 02:07:07 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Martin Petzold <martin.petzold@tavla.de>
CC: <iwd@lists.linux.dev>, James Prestwood <prestwoj@gmail.com>
Date: Sat, 26 Oct 2024 11:07:06 +0200
Message-ID: <192c8144a90.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <f6a4bd96-32d1-403f-b5cf-4425527252d2@tavla.de>
References: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
 <7dbbd152-f251-414a-8d00-29c08bbb272e@tavla.de>
 <02bb45e1-cfef-433d-9a83-2b312c1ae064@gmail.com>
 <6d384377-ee6c-4a5d-8b67-75f367403acd@tavla.de>
 <d33154fa-9309-4285-a592-9e377e199f43@gmail.com>
 <f6a4bd96-32d1-403f-b5cf-4425527252d2@tavla.de>
User-Agent: AquaMail/1.53.0 (build: 105300523)
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection patches) - brcmfmac driver
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On October 25, 2024 5:18:04 PM Martin Petzold <martin.petzold@tavla.de> wrote:

> Dear Arend,
>
> Am 25.10.24 um 14:54 schrieb James Prestwood:
>> Hi Martin,
>>
>> 2. I see this really odd local disconnect with reason code 0. This is
>> likely something from brcmfmac because I doubt the wireless subsystem
>> would use a "success" reason code in a local deauth:
>>
>> Okt 24 06:05:00 tavla iwd[384]: Received Deauthentication event,
>> reason: 0, from_ap: false
>
> What could be the reasons for such a local deauthentication event
> (reason: 0)?
>
> It seems this means "normal operation". But why then a disconnect? Is
> this issued from brcmfmac or from IWD?

Probably the firmware send an event that resulted in the deauth. We do not 
always get a valid reason code from firmware. 0 is actually not success 
reason code. It is reserved. Using 1 (UNSPECIFIED_REASON) would have been 
better I guess.

> Why don't I see any related brcm messages in the journal even though
> debugging is enabled (CONFIG_BRCMDBG=y and CONFIG_DEBUG_FS=y)?

Explained in separate email.

>
>
>>
>> 3. You had another disconnect from the AP, but IWD reconnected:
>>
>> Okt 24 06:06:12 tavla iwd[384]: Received Deauthentication event,
>> reason: 6, from_ap: true
>>
>> 4. You then got a disconnect from the AP yet again, reason code 3:
>>
>> Okt 25 06:13:21 tavla iwd[384]: Received Deauthentication event,
>> reason: 3, from_ap: true
>
> What about these two reasons 6 and 3, and further below? What a problem
> does the AP have? (full log attached)

You can find them in the 802.11 spec. You should really get your hands on 
this doc for reference if you are working with wifi equipment.

3 = LEAVING_NETWORK_DEAUTH
   Deauthenticated because sending STA is leaving (or has left) IBSS or ESS
6= INVALID_CLASS2_FRAME
   Class 2 frame received from nonauthenticated STA

>
> Why don't I see any related brcm messages in the journal even though
> debugging is enabled (CONFIG_BRCMDBG=y and CONFIG_DEBUG_FS=y)?
>
>>
>> # You got disconnected by the AP here
>>
>> Okt 25 06:13:21 tavla iwd[384]:
>> src/station.c:station_disconnect_event() 3
>> Okt 25 06:13:21 tavla iwd[384]: event: disconnect-info, reason: 3
>> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_disassociated() 3
>> Okt 25 06:13:21 tavla iwd[384]:
>> src/station.c:station_reset_connection_state() 3
>> Okt 25 06:13:21 tavla iwd[384]:
>> src/station.c:station_roam_state_clear() 3
>> Okt 25 06:13:21 tavla iwd[384]:
>> src/netconfig.c:netconfig_event_handler() l_netconfig event 2
>> Okt 25 06:13:21 tavla iwd[384]:
>> src/netconfig-commit.c:netconfig_commit_print_addrs() removing
>> address: 192.168.178.113
>> Okt 25 06:13:21 tavla iwd[384]: src/resolve.c:resolve_systemd_revert()
>> ifindex: 3
>> Okt 25 06:13:21 tavla iwd[384]: event: state, old: connected, new:
>> disconnected
>> Okt 25 06:13:21 tavla iwd[384]: event: state, old: disconnected, new:
>> autoconnect_quick
>> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_insert()
>> Inserting work item 17
>> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_next()
>> Starting work item 17
>> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_reg_notify()
>> Notification of command Reg Change(36)
>> Okt 25 06:13:21 tavla iwd[384]: src/netdev.c:netdev_link_notify()
>> event 16 on ifindex 3
>> Okt 25 06:13:21 tavla iwd[384]: src/scan.c:scan_notify() Scan
>> notification Trigger Scan(33)
>> Okt 25 06:13:21 tavla iwd[384]: src/netdev.c:netdev_link_notify()
>> event 16 on ifindex 3
>> Okt 25 06:13:21 tavla iwd[384]: src/scan.c:scan_request_triggered()
>> Passive scan triggered for wdev 1
>> Okt 25 06:13:21 tavla iwd[384]:
>> src/station.c:station_quick_scan_triggered() Quick scan triggered for
>> wlan0
>> Okt 25 06:13:21 tavla iwd[384]: src/scan.c:scan_notify() Scan
>> notification New Scan Results(34)
>> Okt 25 06:13:21 tavla iwd[384]: src/netdev.c:netdev_link_notify()
>> event 16 on ifindex 3
>> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_print_scan_bss()
>> Processing BSS '38:10:d5:37:2c:7b' with SSID: XYZ, freq: 2462, rank:
>> 442, strength: -3300, data_rate: 54.0, load: 21/255
>> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_print_scan_bss()
>> Processing BSS '38:10:d5:7a:45:ca' with SSID: FRITZ!Box 7490, freq:
>> 5580, rank: 16, strength: -8700, data_rate: 2.0, load: 12/255
>> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_print_scan_bss()
>> Processing BSS '84:47:65:1a:c8:14' with SSID: WLAN-T4MQUD, freq: 5260,
>> rank: 442, strength: -6100, data_rate: 54.0, load: 46/255
>> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_print_scan_bss()
>> Processing BSS '84:47:65:1a:c8:11' with SSID: WLAN-T4MQUD, freq: 2437,
>> rank: 294, strength: -6700, data_rate: 36.0, load: 63/255
>> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_autoconnect_start()
>> Okt 25 06:13:21 tavla iwd[384]:
>> src/station.c:station_autoconnect_next() autoconnect: Trying SSID: XYZ
>> Okt 25 06:13:21 tavla iwd[384]:
>> src/station.c:station_autoconnect_next() autoconnect:
>> '38:10:d5:37:2c:7b' freq: 2462, rank: 442, strength: -3300
>> Okt 25 06:13:21 tavla iwd[384]: src/netdev.c:netdev_cqm_rssi_update()
>> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_insert()
>> Inserting work item 18
>> Okt 25 06:13:21 tavla iwd[384]: event: connect-info, ssid: XYZ, bss:
>> 38:10:d5:37:2c:7b, signal: -33, load: 21/255
>> Okt 25 06:13:21 tavla iwd[384]: event: state, old: autoconnect_quick,
>> new: connecting (auto)
>> Okt 25 06:13:21 tavla iwd[384]: src/scan.c:scan_cancel() Trying to
>> cancel scan id 17 for wdev 1
>> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_done()
>> Work item 17 done
>> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_next()
>> Starting work item 18
>> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_mlme_notify() MLME
>> notification Connect(46)
>> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_connect_event()
>> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_connect_event()
>> aborting and ignore_connect_event not set, proceed
>> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_connect_event()
>> expect_connect_failure not set, proceed
>> Okt 25 06:13:22 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_done()
>> Work item 18 done
>> Okt 25 06:13:22 tavla iwd[384]: src/station.c:station_connect_cb() 3,
>> result: 2
>> Okt 25 06:13:22 tavla iwd[384]: event: connect-failed, status: 16
>>
>> # AP rejects your next attempt to connect with status 16 (group
>> handshake timeout). Looks like the 4-way handshake never even started
>> so this is kinda odd.
>>
>> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_cqm_rssi_update()
>> Okt 25 06:13:22 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_insert()
>> Inserting work item 19
>> Okt 25 06:13:22 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_next()
>> Starting work item 19
>> Okt 25 06:13:22 tavla iwd[384]: event: connect-info, ssid: XYZ, bss:
>> 38:10:d5:37:2c:7b, signal: -33, load: 21/255
>> Okt 25 06:13:22 tavla iwd[384]: src/station.c:station_try_next_bss()
>> Attempting to connect to next BSS 38:10:d5:37:2c:7b
>>
>> # Then IWD tries to connect again and we get no connect even whatsoever.
>>
>> I think brcmfmac got very confused and stuck. There are many cases in
>> IWD where we trust the kernel (and associated driver) will send the
>> events we expect. And in this case that did not happen and IWD waits
>> indefinitely.
>>
>> Unless I'm missing something this seems like a bug in the driver. When
>> IWD issues a CMD_CONNECT call the driver needs to tell us if it
>> succeeded or failed. Not replying at all is going to cause IWD to hang
>> like this.
>
> Can you confirm this is a bug in the driver?

If the behavior is as described above I would say yes. The driver logging 
as explained in separate email would be helpful to investigate the problem.

Regards,
Arend



