Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99B217F3F
	for <iwd@lists.linux.dev>; Sat, 26 Oct 2024 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729937340; cv=none; b=KSJwdYccq0kE8gcdZYBQq/DqJ8OFp3Z+UQLc32RvPFlLlrzx4mm+MxPHo/Iom5PAYF8TJ9wPR/YYck1Z793O+o+PylokyRubDTAG2SKxrhXSLqQpXqKmVxP1cz0DR5zjL6j41Parkmvh6bV9QuNN6ZJB62xHXf3M5g6HZULpaSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729937340; c=relaxed/simple;
	bh=8BI6xiLhwxPNMfBq8wZ5v0HYjid5MHsRZXqNMnDOSFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2aJSW0oC6SbmuI8upXlYjRCXaOh19Rh39iBfFqMIk8rUpN9y7vNVLbQLWdDAIajvXT1vP6oSVxzhHc2JfJE4LFKUfU2mVCtY2+oozVQ7zgTR3z2iWVplNxhBpcUOHV2ekEGilT/rQrGXOCMNfw+w2rjrUhjYjC+X8Kmq1jG074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=yaYOzuMl; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="yaYOzuMl"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4XbFjc22CVzDvHg;
	Sat, 26 Oct 2024 12:08:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729937332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IWGKPIdxJH4BRvfsssddWCGFpEu4BDRqfVV0S7cJehs=;
	b=yaYOzuMldmJjezGyOUGourwzk3xNeLCZnbHgV/gG6qOjN8t5rxVqR2G6rJZeHkkmjBD1J/
	NGJQtDEo9JyYNQCNr2pNt8kc4J2XEqdUs5qOENAGRvBUOOnr8aBErsrGxftHk/D+JuzLbE
	5k28NQMM1xVymgzGDJyHlJn/mGPJ9IDjpv9/aYCipGyIItEu98AzNY8t0t6iJ7GGGZ5fLU
	sy4gEhM7lX188dCYDJnYawZ78NXeZPQ+WuaTtbl11y+lRmlkWxiJAAA6fpHFN9zx5JInEB
	cUOrOKrxZbYTwJY7CBqrykRU2JsoWT1cmkWDhtTqwB4EzFdRFuZ+3Ve1okcB8Q==
Message-ID: <ae091c7e-d5df-4b2c-a811-f94a0d595932@tavla.de>
Date: Sat, 26 Oct 2024 12:08:51 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection
 patches) - brcmfmac driver
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>
References: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
 <7dbbd152-f251-414a-8d00-29c08bbb272e@tavla.de>
 <02bb45e1-cfef-433d-9a83-2b312c1ae064@gmail.com>
 <6d384377-ee6c-4a5d-8b67-75f367403acd@tavla.de>
 <d33154fa-9309-4285-a592-9e377e199f43@gmail.com>
 <f6a4bd96-32d1-403f-b5cf-4425527252d2@tavla.de>
 <192c8144a90.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <192c8144a90.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XbFjc22CVzDvHg

Hi Arend,

Am 26.10.24 um 11:07 schrieb Arend Van Spriel:
> On October 25, 2024 5:18:04 PM Martin Petzold 
> <martin.petzold@tavla.de> wrote:
>
>> Dear Arend,
>>
>>>
>>> 3. You had another disconnect from the AP, but IWD reconnected:
>>>
>>> Okt 24 06:06:12 tavla iwd[384]: Received Deauthentication event,
>>> reason: 6, from_ap: true
>>>
>>> 4. You then got a disconnect from the AP yet again, reason code 3:
>>>
>>> Okt 25 06:13:21 tavla iwd[384]: Received Deauthentication event,
>>> reason: 3, from_ap: true
>>
>> What about these two reasons 6 and 3, and further below? What a problem
>> does the AP have? (full log attached)
>
> You can find them in the 802.11 spec. You should really get your hands 
> on this doc for reference if you are working with wifi equipment.
>
> 3 = LEAVING_NETWORK_DEAUTH
>   Deauthenticated because sending STA is leaving (or has left) IBSS or 
> ESS
> 6= INVALID_CLASS2_FRAME
>   Class 2 frame received from nonauthenticated STA
>
>>
>> Why don't I see any related brcm messages in the journal even though
>> debugging is enabled (CONFIG_BRCMDBG=y and CONFIG_DEBUG_FS=y)?
>>
>>>
>>> # You got disconnected by the AP here
>>>
>>> Okt 25 06:13:21 tavla iwd[384]:
>>> src/station.c:station_disconnect_event() 3
>>> Okt 25 06:13:21 tavla iwd[384]: event: disconnect-info, reason: 3
>>> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_disassociated() 3
>>> Okt 25 06:13:21 tavla iwd[384]:
>>> src/station.c:station_reset_connection_state() 3
>>> Okt 25 06:13:21 tavla iwd[384]:
>>> src/station.c:station_roam_state_clear() 3
>>> Okt 25 06:13:21 tavla iwd[384]:
>>> src/netconfig.c:netconfig_event_handler() l_netconfig event 2
>>> Okt 25 06:13:21 tavla iwd[384]:
>>> src/netconfig-commit.c:netconfig_commit_print_addrs() removing
>>> address: 192.168.178.113
>>> Okt 25 06:13:21 tavla iwd[384]: src/resolve.c:resolve_systemd_revert()
>>> ifindex: 3
>>> Okt 25 06:13:21 tavla iwd[384]: event: state, old: connected, new:
>>> disconnected
>>> Okt 25 06:13:21 tavla iwd[384]: event: state, old: disconnected, new:
>>> autoconnect_quick
>>> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_insert()
>>> Inserting work item 17
>>> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_next()
>>> Starting work item 17
>>> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_reg_notify()
>>> Notification of command Reg Change(36)
>>> Okt 25 06:13:21 tavla iwd[384]: src/netdev.c:netdev_link_notify()
>>> event 16 on ifindex 3
>>> Okt 25 06:13:21 tavla iwd[384]: src/scan.c:scan_notify() Scan
>>> notification Trigger Scan(33)
>>> Okt 25 06:13:21 tavla iwd[384]: src/netdev.c:netdev_link_notify()
>>> event 16 on ifindex 3
>>> Okt 25 06:13:21 tavla iwd[384]: src/scan.c:scan_request_triggered()
>>> Passive scan triggered for wdev 1
>>> Okt 25 06:13:21 tavla iwd[384]:
>>> src/station.c:station_quick_scan_triggered() Quick scan triggered for
>>> wlan0
>>> Okt 25 06:13:21 tavla iwd[384]: src/scan.c:scan_notify() Scan
>>> notification New Scan Results(34)
>>> Okt 25 06:13:21 tavla iwd[384]: src/netdev.c:netdev_link_notify()
>>> event 16 on ifindex 3
>>> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_print_scan_bss()
>>> Processing BSS '38:10:d5:37:2c:7b' with SSID: XYZ, freq: 2462, rank:
>>> 442, strength: -3300, data_rate: 54.0, load: 21/255
>>> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_print_scan_bss()
>>> Processing BSS '38:10:d5:7a:45:ca' with SSID: FRITZ!Box 7490, freq:
>>> 5580, rank: 16, strength: -8700, data_rate: 2.0, load: 12/255
>>> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_print_scan_bss()
>>> Processing BSS '84:47:65:1a:c8:14' with SSID: WLAN-T4MQUD, freq: 5260,
>>> rank: 442, strength: -6100, data_rate: 54.0, load: 46/255
>>> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_print_scan_bss()
>>> Processing BSS '84:47:65:1a:c8:11' with SSID: WLAN-T4MQUD, freq: 2437,
>>> rank: 294, strength: -6700, data_rate: 36.0, load: 63/255
>>> Okt 25 06:13:21 tavla iwd[384]: 
>>> src/station.c:station_autoconnect_start()
>>> Okt 25 06:13:21 tavla iwd[384]:
>>> src/station.c:station_autoconnect_next() autoconnect: Trying SSID: XYZ
>>> Okt 25 06:13:21 tavla iwd[384]:
>>> src/station.c:station_autoconnect_next() autoconnect:
>>> '38:10:d5:37:2c:7b' freq: 2462, rank: 442, strength: -3300
>>> Okt 25 06:13:21 tavla iwd[384]: src/netdev.c:netdev_cqm_rssi_update()
>>> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_insert()
>>> Inserting work item 18
>>> Okt 25 06:13:21 tavla iwd[384]: event: connect-info, ssid: XYZ, bss:
>>> 38:10:d5:37:2c:7b, signal: -33, load: 21/255
>>> Okt 25 06:13:21 tavla iwd[384]: event: state, old: autoconnect_quick,
>>> new: connecting (auto)
>>> Okt 25 06:13:21 tavla iwd[384]: src/scan.c:scan_cancel() Trying to
>>> cancel scan id 17 for wdev 1
>>> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_done()
>>> Work item 17 done
>>> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_next()
>>> Starting work item 18
>>> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_mlme_notify() MLME
>>> notification Connect(46)
>>> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_connect_event()
>>> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_connect_event()
>>> aborting and ignore_connect_event not set, proceed
>>> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_connect_event()
>>> expect_connect_failure not set, proceed
>>> Okt 25 06:13:22 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_done()
>>> Work item 18 done
>>> Okt 25 06:13:22 tavla iwd[384]: src/station.c:station_connect_cb() 3,
>>> result: 2
>>> Okt 25 06:13:22 tavla iwd[384]: event: connect-failed, status: 16
>>>
>>> # AP rejects your next attempt to connect with status 16 (group
>>> handshake timeout). Looks like the 4-way handshake never even started
>>> so this is kinda odd.
>>>
>>> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_cqm_rssi_update()
>>> Okt 25 06:13:22 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_insert()
>>> Inserting work item 19
>>> Okt 25 06:13:22 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_next()
>>> Starting work item 19
>>> Okt 25 06:13:22 tavla iwd[384]: event: connect-info, ssid: XYZ, bss:
>>> 38:10:d5:37:2c:7b, signal: -33, load: 21/255
>>> Okt 25 06:13:22 tavla iwd[384]: src/station.c:station_try_next_bss()
>>> Attempting to connect to next BSS 38:10:d5:37:2c:7b
>>>
>>> # Then IWD tries to connect again and we get no connect even 
>>> whatsoever.
>>>
>>> I think brcmfmac got very confused and stuck. There are many cases in
>>> IWD where we trust the kernel (and associated driver) will send the
>>> events we expect. And in this case that did not happen and IWD waits
>>> indefinitely.
>>>
>>> Unless I'm missing something this seems like a bug in the driver. When
>>> IWD issues a CMD_CONNECT call the driver needs to tell us if it
>>> succeeded or failed. Not replying at all is going to cause IWD to hang
>>> like this.
>>
>> Can you confirm this is a bug in the driver?
>
> If the behavior is as described above I would say yes. The driver 
> logging as explained in separate email would be helpful to investigate 
> the problem.

I will enable driver debugging in the module. Forgot that, thanks. 
However, current problems are only in the roaming environment (live) 
there I usually don't have debugging at this level available. Need to 
think about how to get there.

However, currently I am using the Laird firmware [1] which is loaded 
using a script before brcmfmac is loaded. What about the firmware 
available from mainline kernel and/or Debian firmware packages? Would it 
make sense to switch to these and will they load the firmware then to 
the chip? Or are they more or less identical to Laird package? Would you 
expect a potential benefit or rather more problems on other side? (maybe 
it depends on Laird or Variscite wiring or other configuration to load 
the firmware)

[1] 
https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/

Martin

