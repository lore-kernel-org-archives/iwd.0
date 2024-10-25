Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF8212161
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862336; cv=none; b=dl58XBeE+4abqeWikROLQttXiudSHRUuTH21r3MBGoeMW+3wFFIN2rGeRSL2sSH1oRK0N7oI1rgIKb3KE4Q7gttknOdroCvPehd159Z0Km1MxwBoyoNI6itfkJSNXVqW2exW2IuAbM9xMj+Rzc78uORQZFd2fBnylp3SZ8mQlfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862336; c=relaxed/simple;
	bh=2W12LXJM9qfNN2nt/jwI8wgVj/pSFCAQitjsp6/ZjMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKCIemjLgEIdwTwhvHNgYELk/TsVIFc7/6naV8Mr/pAXkUEejlDpCWYEFIjh3j7pjj3bSuStyL7YbR+7So2TxFlCLsCyZ/D5QHlTeyPV2qn2z19GlMYk9r2HotvkjfCrYbpwqT58PucatVHdRkIUxR+mAKB3unOO16HPLnVvnqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+55iBan; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+55iBan"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbceb48613so12957646d6.2
        for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729862332; x=1730467132; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kttjqMDqVW+ou9U/wMw3MEoGX6Q+zqwFgNJTNXXiyVc=;
        b=J+55iBan7GLK9zXBo39hdPTxoUj/M8z1pZrXWycAP5EYz8ePZ2s5gWLbXOHB+cssfv
         IamJw6p7yK9vKWlceNetx/JfnWfkUuostlk9SkQbuA1x0FiMJRihWdG2aLC3GoUBnQUf
         oXF0vKZaEHfIfbHvX+8txMZoBN0gyvd8K+eL7i255njXLYHdYe6KwfhXIVc/398b7/k/
         GVIvozgB9pgFSH3EoFuIS0VhMPi7/OG6o73zC5oaVw8elnWobIfXnBOICKr3e+7WeDKa
         swfGC50uD1xFSf2XW/ruO+x0d2Dzd3BI9aV4TGXl8vUXY/3m2a+7kdC1PF2VxNN0zan1
         gSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729862332; x=1730467132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kttjqMDqVW+ou9U/wMw3MEoGX6Q+zqwFgNJTNXXiyVc=;
        b=rgDC/Vx5I1lxfVZeBle/5TBpLc6D7ZOl70XGM0p/esVOExpZnMNB42lDjnOKqb/CtP
         K8x4X1eRK8YJ375n7uT9rrdFESwu/DeCPf217UXPRu52IXb5D7VgBEguVowUJ4x+fMeG
         ZIMWnhZJQcEil55peqxcRBWvJ6/J7YM6VAnVcAPAV/ZyQxcw2i25kreDKrPtskxIwa8L
         O0pzriuVnZCh220sqz+O0AQ3BtceHT7IyanlFGyivD4GU2+S7eE17q2Hg9hgcABrX7pd
         GYtNM0x8WbNZKNpqE70CtrYd/BWK1VeHChXn8jyqTER2ax6YYGKGHuoyieDht/WM+44U
         60YQ==
X-Gm-Message-State: AOJu0YxzSwOC89PTEWj2m4D+F68fajIsMmIEfI3IpXi58klxZ3yak6dO
	9ZhFfYLS5tQmfu5gKI4URp6Fh8AaRJGOA4AmPVE+HXWXevqc03Hyy+pL9w==
X-Google-Smtp-Source: AGHT+IFoFfhjtxpmGPvX1WXAMX7HGBStRXm7d0LYLquF+4pv5jsddKEmRp+5YQp96AwnD2tcxqry9A==
X-Received: by 2002:a05:6214:5d06:b0:6ce:30ac:9a51 with SMTP id 6a1803df08f44-6ce33f47f43mr120080506d6.0.1729862332387;
        Fri, 25 Oct 2024 06:18:52 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798aa5bdsm5715596d6.43.2024.10.25.06.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 06:18:51 -0700 (PDT)
Message-ID: <e19e7527-9cc1-4c84-95ac-dcb39f836d58@gmail.com>
Date: Fri, 25 Oct 2024 06:18:49 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection
 patches) - brcmfmac driver
To: Martin Petzold <martin.petzold@tavla.de>
Cc: iwd@lists.linux.dev
References: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
 <7dbbd152-f251-414a-8d00-29c08bbb272e@tavla.de>
 <02bb45e1-cfef-433d-9a83-2b312c1ae064@gmail.com>
 <6d384377-ee6c-4a5d-8b67-75f367403acd@tavla.de>
 <d33154fa-9309-4285-a592-9e377e199f43@gmail.com>
 <57826e6a-8466-4e45-8906-6cb15968bcc8@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <57826e6a-8466-4e45-8906-6cb15968bcc8@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/25/24 6:11 AM, Martin Petzold wrote:
> Hi James,
>
> Am 25.10.24 um 14:54 schrieb James Prestwood:
>> Hi Martin,
>>
>> On 10/25/24 5:28 AM, Martin Petzold wrote:
>>> Hi James,
>>>
>>> Am 25.10.24 um 13:48 schrieb James Prestwood:
>>>> Hi Martin,
>>>>
>>>> On 10/25/24 4:10 AM, Martin Petzold wrote:
>>>>> Hi all,
>>>>>
>>>>> Am 25.10.24 um 12:12 schrieb Martin Petzold:
>>>>>> Hi all,
>>>>>>
>>>>>> I open a new thread for this one: During the last weeks I have 
>>>>>> seen connection losses for 30+ minutes, sometimes even hours or 
>>>>>> just now even forever (IWD HEAD with v2 OWE / BSS selection 
>>>>>> patches). Driver is brcmfmac (NXP 6.1.36 kernel) and chip is 
>>>>>> BCM4339 (Laird LWB5).
>>>>>>
>>>>>> It happens in a) single router environment (WPA2-PSK; Touchstone 
>>>>>> TG3442DE), and b) router + repeater environment (WPA2 CCMP; 
>>>>>> Fritz!Box + Fritz!Repeater), and maybe also in the WPA3 OWE 
>>>>>> Transition network (yesterday lost a connection again).
>>>>>
>>>>> I lost now again 2 of 10 devices in the WPA3 OWE network (with 
>>>>> roaming). However, now they don't disappear all after a shorter 
>>>>> while. It seems to be later.
>>>>>
>>>>> I also lost one device in a Router+Repeater WPA2 (CCMP) network. 
>>>>> It is confirmed here on router side, that the device is 
>>>>> disconnected. Since more than a day.
>>>>
>>>> We can't do anything without logs. If you suspect its the blacklist 
>>>> you can lower the blacklist time down in main.conf:
>>>>
>>>> [Blacklist]
>>>> MaximumTimeout=5
>>>>
>>>> But logs would be best, we would be able to see if that is whats 
>>>> happening or if its something else.
>>>>
>>>>
>>> I can also now see this on one of our local devices (which was 
>>> connected to Ethernet and WiFi).
>>>
>>> Please find attached the log. The logs start at late 23rd with the 
>>> image upgrade.
>>>
>>> I can see on our server side, that devices continuously connect and 
>>> disconnect again (missed heartbeat = hard loss of websocket 
>>> connection). I see some type of connection loop on client side too 
>>> ("org.eclipse.jetty.websocket.api.UpgradeException: 0 null" caused 
>>> by "java.util.concurrent.TimeoutException: DNS timeout 15000 ms"). 
>>> Maybe it alternates between Ethernet and WiFi. You will understand 
>>> better. Or the network is re-configured all the time.
>>>
>>> Here is my local status:
>>>
>>> tavla@tavla:~$ iwctl station wlan0 show
>>>                                  Station: wlan0
>>> -------------------------------------------------------------------------------- 
>>>
>>>   Settable  Property Value
>>> -------------------------------------------------------------------------------- 
>>>
>>>             Scanning no
>>>             State connecting
>>>             Connected network     XYZ
>>>             No IP addresses       Is DHCP client configured?
>>>
>>> tavla@tavla:~$ networkctl status
>>> ●        State: routable
>>>   Online state: unknown
>>>        Address: 192.168.178.178 on eth0
>>>                 2a0a:a549:da80:0:fadc:7aff:fe67:2e4 on eth0
>>>                 fe80::fadc:7aff:fe67:2e4 on eth0
>>>                 fe80::c2ee:40ff:fe8a:dd62 on wlan0
>>>        Gateway: 192.168.178.1 on eth0
>>>                 fe80::3a10:d5ff:fe37:2c79 on eth0
>>>            DNS: 192.168.178.1
>>>            NTP: 192.168.178.1
>>> IDX LINK  TYPE     OPERATIONAL SETUP
>>>   1 lo    loopback carrier     unmanaged
>>>   2 eth0  ether    routable    configured
>>>   3 wlan0 wlan     no-carrier  unmanaged
>>>
>>> 3 links listed.
>>
>> Yep, IWD is ultimately hung up waiting for a connect event from the 
>> kernel/driver. A few things I noticed prior to that:
>>
>> 1. Not really critical but you have an agent connecting and 
>> disconnecting multiple times a second. Are you polling info with 
>> iwctl or something?
>>
>> 2. I see this really odd local disconnect with reason code 0. This is 
>> likely something from brcmfmac because I doubt the wireless subsystem 
>> would use a "success" reason code in a local deauth:
>>
>> Okt 24 06:05:00 tavla iwd[384]: Received Deauthentication event, 
>> reason: 0, from_ap: false
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
>>
>> # You got disconnected by the AP here
>
> I stopped my application (all processes gone!). And then tried a 
> manual re-connect via iwctl:
>
> -----
>
> tavla@tavla:~$ iwctl station wlan0 connect "XYZ"
>
> Okt 25 15:07:06 tavla iwd[384]: src/agent.c:agent_register() agent 
> register called
> Okt 25 15:07:06 tavla iwd[384]: src/agent.c:agent_register() agent 
> :1.13733 path /agent/204414
> Okt 25 15:07:06 tavla iwd[384]: src/network.c:network_connect()
> Okt 25 15:07:06 tavla iwd[384]: src/agent.c:agent_disconnect() agent 
> :1.13733 disconnected
> Okt 25 15:07:06 tavla iwd[384]: src/agent.c:agent_free() agent free 
> 0xaaaae76e8b30
>
> tavla@tavla:~$ iwctl station wlan0 show
>                                  Station: wlan0
> -------------------------------------------------------------------------------- 
>
>   Settable  Property Value
> -------------------------------------------------------------------------------- 
>
>             Scanning no
>             State connecting
>             Connected network     XYZ
>             No IP addresses       Is DHCP client configured?
>
> tavla@tavla:~$ iwctl station wlan0 disconnect
> Operation failed
>
> Okt 25 15:08:56 tavla iwd[384]: src/agent.c:agent_register() agent 
> register called
> Okt 25 15:08:56 tavla iwd[384]: src/agent.c:agent_register() agent 
> :1.13740 path /agent/204425
> Okt 25 15:08:56 tavla iwd[384]: src/station.c:station_dbus_disconnect()
> Okt 25 15:08:56 tavla iwd[384]: 
> src/station.c:station_reset_connection_state() 3
> Okt 25 15:08:56 tavla iwd[384]: 
> src/station.c:station_roam_state_clear() 3
> Okt 25 15:08:56 tavla iwd[384]: event: state, old: connecting (auto), 
> new: disconnecting
> Okt 25 15:08:56 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_done() 
> Work item 19 done
> Okt 25 15:08:56 tavla iwd[384]: src/station.c:station_connect_cb() 3, 
> result: 5
> Okt 25 15:08:56 tavla iwd[384]: src/station.c:station_disconnect_cb() 
> 3, success: 0
> Okt 25 15:08:56 tavla iwd[384]: event: state, old: disconnecting, new: 
> disconnected
> Okt 25 15:08:56 tavla iwd[384]: src/agent.c:agent_disconnect() agent 
> :1.13740 disconnected
> Okt 25 15:08:56 tavla iwd[384]: src/agent.c:agent_free() agent free 
> 0xaaaae76eaa50
Yes, the driver seems completely stuck. I would recommend 
unloading/reloading it with modprobe.
>
> -----
>
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
>> Okt 25 06:13:21 tavla iwd[384]: 
>> src/resolve.c:resolve_systemd_revert() ifindex: 3
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
>> Okt 25 06:13:21 tavla iwd[384]: 
>> src/station.c:station_print_scan_bss() Processing BSS 
>> '38:10:d5:37:2c:7b' with SSID: XYZ, freq: 2462, rank: 442, strength: 
>> -3300, data_rate: 54.0, load: 21/255
>> Okt 25 06:13:21 tavla iwd[384]: 
>> src/station.c:station_print_scan_bss() Processing BSS 
>> '38:10:d5:7a:45:ca' with SSID: FRITZ!Box 7490, freq: 5580, rank: 16, 
>> strength: -8700, data_rate: 2.0, load: 12/255
>> Okt 25 06:13:21 tavla iwd[384]: 
>> src/station.c:station_print_scan_bss() Processing BSS 
>> '84:47:65:1a:c8:14' with SSID: WLAN-T4MQUD, freq: 5260, rank: 442, 
>> strength: -6100, data_rate: 54.0, load: 46/255
>> Okt 25 06:13:21 tavla iwd[384]: 
>> src/station.c:station_print_scan_bss() Processing BSS 
>> '84:47:65:1a:c8:11' with SSID: WLAN-T4MQUD, freq: 2437, rank: 294, 
>> strength: -6700, data_rate: 36.0, load: 63/255
>> Okt 25 06:13:21 tavla iwd[384]: 
>> src/station.c:station_autoconnect_start()
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
>> Okt 25 06:13:22 tavla iwd[384]: src/netdev.c:netdev_mlme_notify() 
>> MLME notification Connect(46)
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
>> Unless I'm missing something this seems like a bug in the driver. 
>> When IWD issues a CMD_CONNECT call the driver needs to tell us if it 
>> succeeded or failed. Not replying at all is going to cause IWD to 
>> hang like this.
>>
>> Thanks,
>>
>> James
>>
>>>
>>>>>
>>>>>>
>>>>>> We have 100% reproducable builds, test environments (testing 
>>>>>> sites), and web socket-based telemetry. Thus my feeling is, there 
>>>>>> is still something wrong with the BSS selection (maybe 
>>>>>> blacklisting)! Of course this can also be something about the 
>>>>>> driver (brcmfmac) or firmware (roaming?). Or can this be about 
>>>>>> IPv6 disabled (my configuration below)?
>>>>>>
>>>>>> This is really really serious, I (still) lose connections to 
>>>>>> devices!
>>>>>>
>>>>>> I will investigate further and provide logs later today, if 
>>>>>> possible.
>>>>>>
>>>>>> SETUP:
>>>>>>
>>>>>> SoM: Variscite DART-IMX8M-PLUS
>>>>>> SoC: NXP i.MX8M Plus
>>>>>> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
>>>>>> Antenna: Laird FlexPIFA
>>>>>> RootFS: Debian bookworm
>>>>>> Kernel: NXP Kernel 6.1.36 (with Variscite patches)
>>>>>> Driver: brcmfmac (from Kernel, only minor patches - device tree)
>>>>>> Firmware: Laird 12.29.0.22 (loaded via scripts)
>>>>>> Network Daemon: systemd-networkd 252.30
>>>>>> Wi-Fi Daemon: IWD 2.22+ (c459dc75c080dcbff6f9b9389344e11328dec411 
>>>>>> + OWE and BSS selection patches) + ELL 0.69 
>>>>>> (7bed251f8020ef896043f008276f41cd13fdd43f)
>>>>>>
>>>>>> KERNEL:
>>>>>>
>>>>>> REPOSITORY=https://github.com/tavla/linux-imx.git (fork from 
>>>>>> https://github.com/varigit/linux-imx)
>>>>>> BRANCH=lf-6.1.y_var03
>>>>>> COMMIT=a4b3cc1dbbb396284e501b938aa79d2dfd4f1a98
>>>>>>
>>>>>> FIRMWARE:
>>>>>>
>>>>>> summit-lwb5-etsi-firmware-12.29.0.22.tar.bz2
>>>>>>
>>>>>> From: 
>>>>>> https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/
>>>>>>
>>>>>> IWD
>>>>>>
>>>>>> -----
>>>>>>
>>>>>> [General]
>>>>>> EnableNetworkConfiguration=true
>>>>>>
>>>>>> [Network]
>>>>>> NameResolvingService=systemd
>>>>>> EnableIPv6=false
>>>>>>
>>>>>> [DriverQuirks]
>>>>>> OweDisable=brcmfmac
>>>>>>
>>>>>> -----
>>>>>>
>>>>>> Best regards,
>>>>>>
>>>>>> Martin
>>>>>>
>>>>>>
