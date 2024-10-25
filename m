Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3174206500
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861524; cv=none; b=O3B3J0ILZTWinoZRbb833BJV++Twk9ByBHjO1OhkNfNF2/3U9D5dlOY8ytRBMznbUrP3LvwASRI2cujjAhzfHIvsk5nV0Lnant+sJ/k1DJqMqEZQOi7qgSCviDGVzDcUyr0JAndNZNZIIdNaylL89Ah2a7gn67g6RRY7r5ursuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861524; c=relaxed/simple;
	bh=8fLGDmbzVkOAzJbY9QK4SD2KCYjnAD9StKuudubdves=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvL+jTwb/anbvc5KG6VIWH6Eu6Xag0EP+we0U23i1c0rp0Nb7HHbY02b5bPRokJGgyHl8G2Jg9liF/ATrRAiA749yqk5/R5HDUTEQ32AwGQcLAAvkjdussrKQKnWU6OUFeBi3CAzos/MkaU+YO0lTJUOdwGzxa+puU0hLJ6gXQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=wZr315+t; arc=none smtp.client-ip=195.10.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="wZr315+t"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4XZjgV1B2Fz9vrl;
	Fri, 25 Oct 2024 15:05:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729861510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYIen3sLd2RE7Miu49wqWAQJvUBcgIVYvAt+SbboyzM=;
	b=wZr315+tLURruC51QyzFF8psd9SgNhOWw8zlIfeYIzluynkTB9gCd1W25UspT5C0buWytC
	gVc72i/gipJ29wMoFeDcVWGjit2C2BtIJa4KDXgz0EQNEPBGg7tZ7rT3DQcJKCEYRyCC1C
	sRlTJwFa6xS4BxirW3uD9qaGpJEzHLTEEouYwBICOxovbdDa0J4YD0ObuJYD3gWalv7CSc
	/4cxGBkydWX5bnQXUP+CFXs6lRwexnDqR0C25zAl0mqnu+fRzh/US2hQ6jaUqLIpiJDCOp
	4iHqPg/YYT2BjpNeZI9jEDtee1a5ZQPlHNMA2s3kA7prZd+DQyceLGhiW23wpw==
Message-ID: <228c149f-24f7-4d46-bf0e-d2dcafeb326a@tavla.de>
Date: Fri, 25 Oct 2024 15:05:08 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection
 patches) - brcmfmac driver
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
References: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
 <7dbbd152-f251-414a-8d00-29c08bbb272e@tavla.de>
 <02bb45e1-cfef-433d-9a83-2b312c1ae064@gmail.com>
 <6d384377-ee6c-4a5d-8b67-75f367403acd@tavla.de>
 <d33154fa-9309-4285-a592-9e377e199f43@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <d33154fa-9309-4285-a592-9e377e199f43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XZjgV1B2Fz9vrl

Hi James,

Am 25.10.24 um 14:54 schrieb James Prestwood:
> Hi Martin,
>
> On 10/25/24 5:28 AM, Martin Petzold wrote:
>> Hi James,
>>
>> Am 25.10.24 um 13:48 schrieb James Prestwood:
>>> Hi Martin,
>>>
>>> On 10/25/24 4:10 AM, Martin Petzold wrote:
>>>> Hi all,
>>>>
>>>> Am 25.10.24 um 12:12 schrieb Martin Petzold:
>>>>> Hi all,
>>>>>
>>>>> I open a new thread for this one: During the last weeks I have 
>>>>> seen connection losses for 30+ minutes, sometimes even hours or 
>>>>> just now even forever (IWD HEAD with v2 OWE / BSS selection 
>>>>> patches). Driver is brcmfmac (NXP 6.1.36 kernel) and chip is 
>>>>> BCM4339 (Laird LWB5).
>>>>>
>>>>> It happens in a) single router environment (WPA2-PSK; Touchstone 
>>>>> TG3442DE), and b) router + repeater environment (WPA2 CCMP; 
>>>>> Fritz!Box + Fritz!Repeater), and maybe also in the WPA3 OWE 
>>>>> Transition network (yesterday lost a connection again).
>>>>
>>>> I lost now again 2 of 10 devices in the WPA3 OWE network (with 
>>>> roaming). However, now they don't disappear all after a shorter 
>>>> while. It seems to be later.
>>>>
>>>> I also lost one device in a Router+Repeater WPA2 (CCMP) network. It 
>>>> is confirmed here on router side, that the device is disconnected. 
>>>> Since more than a day.
>>>
>>> We can't do anything without logs. If you suspect its the blacklist 
>>> you can lower the blacklist time down in main.conf:
>>>
>>> [Blacklist]
>>> MaximumTimeout=5
>>>
>>> But logs would be best, we would be able to see if that is whats 
>>> happening or if its something else.
>>>
>>>
>> I can also now see this on one of our local devices (which was 
>> connected to Ethernet and WiFi).
>>
>> Please find attached the log. The logs start at late 23rd with the 
>> image upgrade.
>>
>> I can see on our server side, that devices continuously connect and 
>> disconnect again (missed heartbeat = hard loss of websocket 
>> connection). I see some type of connection loop on client side too 
>> ("org.eclipse.jetty.websocket.api.UpgradeException: 0 null" caused by 
>> "java.util.concurrent.TimeoutException: DNS timeout 15000 ms"). Maybe 
>> it alternates between Ethernet and WiFi. You will understand better. 
>> Or the network is re-configured all the time.
>>
>> Here is my local status:
>>
>> tavla@tavla:~$ iwctl station wlan0 show
>>                                  Station: wlan0
>> -------------------------------------------------------------------------------- 
>>
>>   Settable  Property Value
>> -------------------------------------------------------------------------------- 
>>
>>             Scanning no
>>             State connecting
>>             Connected network     XYZ
>>             No IP addresses       Is DHCP client configured?
>>
>> tavla@tavla:~$ networkctl status
>> ●        State: routable
>>   Online state: unknown
>>        Address: 192.168.178.178 on eth0
>>                 2a0a:a549:da80:0:fadc:7aff:fe67:2e4 on eth0
>>                 fe80::fadc:7aff:fe67:2e4 on eth0
>>                 fe80::c2ee:40ff:fe8a:dd62 on wlan0
>>        Gateway: 192.168.178.1 on eth0
>>                 fe80::3a10:d5ff:fe37:2c79 on eth0
>>            DNS: 192.168.178.1
>>            NTP: 192.168.178.1
>> IDX LINK  TYPE     OPERATIONAL SETUP
>>   1 lo    loopback carrier     unmanaged
>>   2 eth0  ether    routable    configured
>>   3 wlan0 wlan     no-carrier  unmanaged
>>
>> 3 links listed.
>
> Yep, IWD is ultimately hung up waiting for a connect event from the 
> kernel/driver. A few things I noticed prior to that:

Why should there be a connect event from the kernel/driver? Why don't we 
get any related logs from brcm?


>
> 1. Not really critical but you have an agent connecting and 
> disconnecting multiple times a second. Are you polling info with iwctl 
> or something?
>
> 2. I see this really odd local disconnect with reason code 0. This is 
> likely something from brcmfmac because I doubt the wireless subsystem 
> would use a "success" reason code in a local deauth:
>
> Okt 24 06:05:00 tavla iwd[384]: Received Deauthentication event, 
> reason: 0, from_ap: false
>
> 3. You had another disconnect from the AP, but IWD reconnected:
>
> Okt 24 06:06:12 tavla iwd[384]: Received Deauthentication event, 
> reason: 6, from_ap: true
>
> 4. You then got a disconnect from the AP yet again, reason code 3:
>
> Okt 25 06:13:21 tavla iwd[384]: Received Deauthentication event, 
> reason: 3, from_ap: true
>
> # You got disconnected by the AP here

Okay, thanks. I don't do any polling of IWD or other network daemons. 
However, I do have a mechanism for web socket re-connects in case of 
disconnect.

What I also see: networkctl shows some IPv6 for wlan0. However, I have 
IPv6 disabled in the iwd.conf. Could this be a problem?

I sent additional log output for networkd and resolved in an earlier 
message.


>
> Okt 25 06:13:21 tavla iwd[384]: 
> src/station.c:station_disconnect_event() 3
> Okt 25 06:13:21 tavla iwd[384]: event: disconnect-info, reason: 3
> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_disassociated() 3
> Okt 25 06:13:21 tavla iwd[384]: 
> src/station.c:station_reset_connection_state() 3
> Okt 25 06:13:21 tavla iwd[384]: 
> src/station.c:station_roam_state_clear() 3
> Okt 25 06:13:21 tavla iwd[384]: 
> src/netconfig.c:netconfig_event_handler() l_netconfig event 2
> Okt 25 06:13:21 tavla iwd[384]: 
> src/netconfig-commit.c:netconfig_commit_print_addrs() removing 
> address: 192.168.178.113
> Okt 25 06:13:21 tavla iwd[384]: src/resolve.c:resolve_systemd_revert() 
> ifindex: 3
> Okt 25 06:13:21 tavla iwd[384]: event: state, old: connected, new: 
> disconnected
> Okt 25 06:13:21 tavla iwd[384]: event: state, old: disconnected, new: 
> autoconnect_quick
> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_insert() 
> Inserting work item 17
> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_next() 
> Starting work item 17
> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_reg_notify() 
> Notification of command Reg Change(36)
> Okt 25 06:13:21 tavla iwd[384]: src/netdev.c:netdev_link_notify() 
> event 16 on ifindex 3
> Okt 25 06:13:21 tavla iwd[384]: src/scan.c:scan_notify() Scan 
> notification Trigger Scan(33)
> Okt 25 06:13:21 tavla iwd[384]: src/netdev.c:netdev_link_notify() 
> event 16 on ifindex 3
> Okt 25 06:13:21 tavla iwd[384]: src/scan.c:scan_request_triggered() 
> Passive scan triggered for wdev 1
> Okt 25 06:13:21 tavla iwd[384]: 
> src/station.c:station_quick_scan_triggered() Quick scan triggered for 
> wlan0
> Okt 25 06:13:21 tavla iwd[384]: src/scan.c:scan_notify() Scan 
> notification New Scan Results(34)
> Okt 25 06:13:21 tavla iwd[384]: src/netdev.c:netdev_link_notify() 
> event 16 on ifindex 3
> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_print_scan_bss() 
> Processing BSS '38:10:d5:37:2c:7b' with SSID: XYZ, freq: 2462, rank: 
> 442, strength: -3300, data_rate: 54.0, load: 21/255
> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_print_scan_bss() 
> Processing BSS '38:10:d5:7a:45:ca' with SSID: FRITZ!Box 7490, freq: 
> 5580, rank: 16, strength: -8700, data_rate: 2.0, load: 12/255
> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_print_scan_bss() 
> Processing BSS '84:47:65:1a:c8:14' with SSID: WLAN-T4MQUD, freq: 5260, 
> rank: 442, strength: -6100, data_rate: 54.0, load: 46/255
> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_print_scan_bss() 
> Processing BSS '84:47:65:1a:c8:11' with SSID: WLAN-T4MQUD, freq: 2437, 
> rank: 294, strength: -6700, data_rate: 36.0, load: 63/255
> Okt 25 06:13:21 tavla iwd[384]: src/station.c:station_autoconnect_start()
> Okt 25 06:13:21 tavla iwd[384]: 
> src/station.c:station_autoconnect_next() autoconnect: Trying SSID: XYZ
> Okt 25 06:13:21 tavla iwd[384]: 
> src/station.c:station_autoconnect_next() autoconnect: 
> '38:10:d5:37:2c:7b' freq: 2462, rank: 442, strength: -3300
> Okt 25 06:13:21 tavla iwd[384]: src/netdev.c:netdev_cqm_rssi_update()
> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_insert() 
> Inserting work item 18
> Okt 25 06:13:21 tavla iwd[384]: event: connect-info, ssid: XYZ, bss: 
> 38:10:d5:37:2c:7b, signal: -33, load: 21/255
> Okt 25 06:13:21 tavla iwd[384]: event: state, old: autoconnect_quick, 
> new: connecting (auto)
> Okt 25 06:13:21 tavla iwd[384]: src/scan.c:scan_cancel() Trying to 
> cancel scan id 17 for wdev 1
> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_done() 
> Work item 17 done
> Okt 25 06:13:21 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_next() 
> Starting work item 18
> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_mlme_notify() MLME 
> notification Connect(46)
> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_connect_event()
> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_connect_event() 
> aborting and ignore_connect_event not set, proceed
> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_connect_event() 
> expect_connect_failure not set, proceed
> Okt 25 06:13:22 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_done() 
> Work item 18 done
> Okt 25 06:13:22 tavla iwd[384]: src/station.c:station_connect_cb() 3, 
> result: 2
> Okt 25 06:13:22 tavla iwd[384]: event: connect-failed, status: 16
>
> # AP rejects your next attempt to connect with status 16 (group 
> handshake timeout). Looks like the 4-way handshake never even started 
> so this is kinda odd.
>
> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_cqm_rssi_update()
> Okt 25 06:13:22 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_insert() 
> Inserting work item 19
> Okt 25 06:13:22 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_next() 
> Starting work item 19
> Okt 25 06:13:22 tavla iwd[384]: event: connect-info, ssid: XYZ, bss: 
> 38:10:d5:37:2c:7b, signal: -33, load: 21/255
> Okt 25 06:13:22 tavla iwd[384]: src/station.c:station_try_next_bss() 
> Attempting to connect to next BSS 38:10:d5:37:2c:7b
>
> # Then IWD tries to connect again and we get no connect even whatsoever.
>
> I think brcmfmac got very confused and stuck. There are many cases in 
> IWD where we trust the kernel (and associated driver) will send the 
> events we expect. And in this case that did not happen and IWD waits 
> indefinitely.
>
> Unless I'm missing something this seems like a bug in the driver. When 
> IWD issues a CMD_CONNECT call the driver needs to tell us if it 
> succeeded or failed. Not replying at all is going to cause IWD to hang 
> like this.
>
> Thanks,
>
> James
>
>>
>>>>
>>>>>
>>>>> We have 100% reproducable builds, test environments (testing 
>>>>> sites), and web socket-based telemetry. Thus my feeling is, there 
>>>>> is still something wrong with the BSS selection (maybe 
>>>>> blacklisting)! Of course this can also be something about the 
>>>>> driver (brcmfmac) or firmware (roaming?). Or can this be about 
>>>>> IPv6 disabled (my configuration below)?
>>>>>
>>>>> This is really really serious, I (still) lose connections to devices!
>>>>>
>>>>> I will investigate further and provide logs later today, if possible.
>>>>>
>>>>> SETUP:
>>>>>
>>>>> SoM: Variscite DART-IMX8M-PLUS
>>>>> SoC: NXP i.MX8M Plus
>>>>> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
>>>>> Antenna: Laird FlexPIFA
>>>>> RootFS: Debian bookworm
>>>>> Kernel: NXP Kernel 6.1.36 (with Variscite patches)
>>>>> Driver: brcmfmac (from Kernel, only minor patches - device tree)
>>>>> Firmware: Laird 12.29.0.22 (loaded via scripts)
>>>>> Network Daemon: systemd-networkd 252.30
>>>>> Wi-Fi Daemon: IWD 2.22+ (c459dc75c080dcbff6f9b9389344e11328dec411 
>>>>> + OWE and BSS selection patches) + ELL 0.69 
>>>>> (7bed251f8020ef896043f008276f41cd13fdd43f)
>>>>>
>>>>> KERNEL:
>>>>>
>>>>> REPOSITORY=https://github.com/tavla/linux-imx.git (fork from 
>>>>> https://github.com/varigit/linux-imx)
>>>>> BRANCH=lf-6.1.y_var03
>>>>> COMMIT=a4b3cc1dbbb396284e501b938aa79d2dfd4f1a98
>>>>>
>>>>> FIRMWARE:
>>>>>
>>>>> summit-lwb5-etsi-firmware-12.29.0.22.tar.bz2
>>>>>
>>>>> From: 
>>>>> https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/
>>>>>
>>>>> IWD
>>>>>
>>>>> -----
>>>>>
>>>>> [General]
>>>>> EnableNetworkConfiguration=true
>>>>>
>>>>> [Network]
>>>>> NameResolvingService=systemd
>>>>> EnableIPv6=false
>>>>>
>>>>> [DriverQuirks]
>>>>> OweDisable=brcmfmac
>>>>>
>>>>> -----
>>>>>
>>>>> Best regards,
>>>>>
>>>>> Martin
>>>>>
>>>>>
