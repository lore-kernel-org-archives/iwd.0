Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2CF14A90
	for <iwd@lists.linux.dev>; Fri, 29 Dec 2023 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faCa5MWb"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35ffb15244dso36528325ab.1
        for <iwd@lists.linux.dev>; Fri, 29 Dec 2023 14:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703888640; x=1704493440; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfEDd0bkAFIOfCZ4rMz600JESQVLybWrP9Wbx7tWt14=;
        b=faCa5MWbro3DbWCVl1wA/fsHqPa81Bv6/sPh84EDLQM8pAbXCER7eIdtf+bKeApATz
         3XOzQTHHiXAJlk/9UvirIABkTjy2dd/Mz3+RGcmqXvnwOScdB4VwIgH2ExFAdpgeTqnW
         CjiO9m+YhtKxSg1gYarlPxPHmD3jeryZUn9TXJ0Kk9UpP+3cpZQgx8u6YSJ9KyggC2ew
         A53th0poUgJYsNRs6NZwoeNxgyHkGDKDV2O4SwGOGiIqeGi+9R5yStEL3A5InuXi2mOX
         MT2TXi60HtMafikGZcOzSFrFNpRvsXRDu0IQaRGzDPnxQQPE6I+jNc9Fuw5RX1Yv73we
         eEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703888640; x=1704493440;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfEDd0bkAFIOfCZ4rMz600JESQVLybWrP9Wbx7tWt14=;
        b=v8YIUeAXnBBuZQ/Jb9Ihk0Ayw8Ro1BhPRxwfkz74V+SGR1QBIz6A0bgXJIsOUg5zJZ
         v2XOgMHb++JqBTRPmJtsUgkwQ04CozvvllEQ27Or3WbSXAvisDN+4E3LmX8yxstmmBnX
         dB2GvDrhvCwhLzrPFHVWSYl1STBO2d2Q9rYRk3umqtXMyz2wrondTAUDplr8iDYztRsI
         kowyHbZZ9i7LvzEQQYNbx+acaEcdpdkTvSkszjvBseA1ZgAdJCb0iBSXKdxDa89yqQ99
         W8jL92/x2u6urL7tEgyxlcGLJciwwj06HKmeZ5KdTt0/tnhj0jYfdTa8c5PMwkvsX7qq
         1Nkw==
X-Gm-Message-State: AOJu0YytoY2/20OHv3c6sb79t9WZIhbwcZrG0y+cPV2Rk1sI39ZKT9RY
	APoAYJSx63rSZEUG+np8uss=
X-Google-Smtp-Source: AGHT+IE+Vsuj/c8GCsbepUWIBenmAjx7h9RIkulK1FOqSS8fb0aET21R4qUt5SL0W1RzgzTBx15lcA==
X-Received: by 2002:a05:6e02:1888:b0:35d:5995:7990 with SMTP id o8-20020a056e02188800b0035d59957990mr19180094ilu.42.1703888639599;
        Fri, 29 Dec 2023 14:23:59 -0800 (PST)
Received: from [192.168.254.38] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id jd1-20020a170903260100b001d3d9edf983sm16233395plb.217.2023.12.29.14.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 14:23:59 -0800 (PST)
Message-ID: <a82add89-7b37-4c88-96a5-e98597d9b342@gmail.com>
Date: Fri, 29 Dec 2023 14:23:58 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: disconnects when in AP mode
Content-Language: en-US
To: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev
References: <CAG17S_MXzqBrOrCuRYuwx0tfQT2V9Qe0MyD9c+hckZ+a7TMBHA@mail.gmail.com>
 <CAG17S_M4xvot2HahnxMT2pmB6BYr1aJu+exFmSO00j+jxYDDEw@mail.gmail.com>
 <CAG17S_MpE_p=TS4uBSY+_8XvedKct_FqXzr66tUbhtQL0x6_rg@mail.gmail.com>
 <CAG17S_MJdOj195CvvcEAXvA_WOQQH1XYsKuFU1NhdWL2_JJ7pw@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_MJdOj195CvvcEAXvA_WOQQH1XYsKuFU1NhdWL2_JJ7pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 12/29/23 2:17 PM, KeithG wrote:
> On Fri, Dec 29, 2023 at 12:53 PM KeithG <ys3al35l@gmail.com> wrote:
>> On Thu, Dec 28, 2023 at 12:42 PM KeithG <ys3al35l@gmail.com> wrote:
>>> I put iwd in debug mode and this is what happens at disconnect. Maybe
>>> better for diagnostics.
>>> If there is something else I can do to help diagnose it, please let me know
>>>
>>> Dec 28 12:32:37 runeaudio iwd[5127]: src/netdev.c:netdev_mlme_notify()
>>> MLME notification Del Station(20)
>>> Dec 28 12:32:37 runeaudio iwd[5127]: src/netdev.c:netdev_mlme_notify()
>>> MLME notification Del Station(20)
>>> Dec 28 12:35:13 runeaudio iwd[5127]: src/netdev.c:netdev_mlme_notify()
>>> MLME notification New Station(19)
>>> Dec 28 12:35:13 runeaudio iwd[5127]: KEY_SEQ not returned in GET_KEY reply
>>> Dec 28 12:35:13 runeaudio iwd[5127]: src/eapol.c:eapol_start()
>>> Dec 28 12:35:13 runeaudio iwd[5127]:
>>> src/eapol.c:eapol_send_ptk_1_of_4() STA: f0:42:1c:d7:da:e8 retries=0
>>> Dec 28 12:35:13 runeaudio iwd[5127]:
>>> src/eapol.c:eapol_handle_ptk_2_of_4() ifindex=4
>>> Dec 28 12:35:13 runeaudio iwd[5127]:
>>> src/eapol.c:eapol_send_ptk_3_of_4() STA: f0:42:1c:d7:da:e8 retries=0
>>> Dec 28 12:35:13 runeaudio iwd[5127]:
>>> src/eapol.c:eapol_ptk_3_of_4_retry() attempt 1
>>> Dec 28 12:35:13 runeaudio iwd[5127]:
>>> src/eapol.c:eapol_handle_ptk_4_of_4() ifindex=4
>>> Dec 28 12:35:13 runeaudio iwd[5127]: src/netdev.c:netdev_set_tk()
>>> ifindex=4 key_idx=0
>>> Dec 28 12:35:13 runeaudio iwd[5127]: src/netdev.c:netdev_set_station_cb()
>>> Dec 28 12:35:13 runeaudio iwd[5127]:
>>> src/netdev.c:try_handshake_complete() ptk_installed: 1, gtk_installed:
>>> 1, igtk_installed: 1
>>> Dec 28 12:35:13 runeaudio iwd[5127]:
>>> src/netdev.c:try_handshake_complete() nhs->complete: 0
>>> Dec 28 12:35:13 runeaudio iwd[5127]:
>>> src/netdev.c:try_handshake_complete() Invoking handshake_event()
>>> Dec 28 12:35:13 runeaudio iwd[5127]: src/ap.c:ap_new_rsna() STA
>>> f0:42:1c:d7:da:e8 authenticated
>>> Dec 28 12:35:55 runeaudio iwd[5127]: src/agent.c:agent_register()
>>> agent register called
>>> Dec 28 12:35:55 runeaudio iwd[5127]: src/agent.c:agent_register()
>>> agent :1.566 path /agent/12001
>>> Dec 28 12:35:55 runeaudio iwd[5127]: src/station.c:station_dbus_scan()
>>> Scan called from DBus
>>> Dec 28 12:35:55 runeaudio iwd[5127]:
>>> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 13
>>> Dec 28 12:35:55 runeaudio iwd[5127]:
>>> src/wiphy.c:wiphy_radio_work_next() Starting work item 13
>>>
>>> On Thu, Dec 28, 2023 at 12:19 PM KeithG <ys3al35l@gmail.com> wrote:
>>>> Group,
>>>>
>>>> I finally gave up on getting connman to manage scanning when iwd is in
>>>> AP mode. What I have done is listen to James who posted this a long
>>>> time ago and I just finally figured out what he was saying.
>>>>
>>>> I am doing what is outlined here:
>>>> https://lore.kernel.org/linux-wireless/87k0dhdg0d.fsf@bang-olufsen.dk/
>>>>
>>>> I am running this on RPis all with the brcmfmac adapters. I can get it
>>>> all working, but when connected to the RPi on its advertised AP, I can
>>>> get a connection for a bit then it disconnects, requiring a reconnect.
>>>> I am running a freshly built iwd version 2.11 with ell 0.61 on RPiOS
>>>> fully up to date on Bookworm
>>>>
>>>> I get tons of this in the log: "wiphy_estimate_data_rate() failed" and
>>>> a few others but it does not seem like this is what triggers it to
>>>> disconnect. I have not been able to pinpoint anything in the log where
>>>> it disconnects.
>>>>
>>>> Any help appreciated.
>>>>
>>>> # uname -a
>>>> Linux runeaudio 6.1.0-rpi7-rpi-v8 #1 SMP PREEMPT Debian
>>>> 1:6.1.63-1+rpt1 (2023-11-24) aarch64 GNU/Linux
>>>>
>>>> this is what shows at bootup
>>>> Dec 28 11:50:45 runeaudio kernel: brcmfmac: F1 signature read
>>>> @0x18000000=0x15264345
>>>> Dec 28 11:50:45 runeaudio kernel: brcmfmac: brcmf_fw_alloc_request:
>>>> using brcm/brcmfmac43455-sdio for chip BCM4345/6
>>>> Dec 28 11:50:45 runeaudio kernel: usbcore: registered new interface
>>>> driver brcmfmac
>>>> Dec 28 11:50:45 runeaudio kernel: Bluetooth: hci0: BCM4345C0
>>>> 'brcm/BCM4345C0.raspberrypi,3-model-b-plus.hcd' Patch
>>>> Dec 28 11:50:45 runeaudio kernel: brcmfmac: brcmf_c_preinit_dcmds:
>>>> Firmware: BCM4345/6 wl0: Nov  1 2021 00:37:25 version 7.45.241
>>>> (1a2f2fa CY) FWID 01-703fd60
>>>> Dec 28 11:50:48 runeaudio kernel: brcmfmac:
>>>> brcmf_cfg80211_set_power_mgmt: power save enabled
>>>> Dec 28 11:50:55 runeaudio kernel: brcmfmac:
>>>> brcmf_cfg80211_set_power_mgmt: power save disabled
>>>> Dec 28 11:51:30 runeaudio kernel: brcmfmac:
>>>> brcmf_cfg80211_set_power_mgmt: power save disabled
>>>> Dec 28 11:51:31 runeaudio kernel: brcmfmac:
>>>> brcmf_cfg80211_set_power_mgmt: power save disabled
>>>> Dec 28 11:51:40 runeaudio kernel: ieee80211 phy0: brcmf_escan_timeout:
>>>> timer expired
>>>>
>>>> I get this in the log:
>>>> Dec 28 11:51:30 runeaudio iwd[1306]: No Diffie-Hellman support found,
>>>> WPS will not be available
>>>> Dec 28 11:51:30 runeaudio iwd[1306]: The following options are missing
>>>> in the kernel:
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:         CONFIG_KEY_DH_OPERATIONS
>>>> Dec 28 11:51:30 runeaudio iwd[1306]: Wireless daemon version 2.11
>>>> Dec 28 11:51:30 runeaudio iwd[1306]: Loaded configuration from
>>>> /etc/iwd/main.conf
>>>> Dec 28 11:51:30 runeaudio systemd[1]: Started iwd.service - Wireless service.
>>>> Dec 28 11:51:30 runeaudio iwd[1306]: Wiphy: 0, Name: phy0
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:         Permanent Address:
>>>> b8:27:eb:52:cc:d0
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:         2.4GHz Band:
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                 Bitrates (non-HT):
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                          1.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                          2.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                          5.5 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         11.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                          6.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                          9.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         12.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         18.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         24.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         36.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         48.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         54.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                 HT Capabilities:
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         HT40
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI for 20Mhz
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                 HT RX MCS indexes:
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         0-7
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:         5GHz Band:
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                 Bitrates (non-HT):
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                          6.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                          9.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         12.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         18.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         24.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         36.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         48.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         54.0 Mbps
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                 HT Capabilities:
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         HT40
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI for 20Mhz
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI for 40Mhz
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                 HT RX MCS indexes:
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         0-7
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                 VHT Capabilities:
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI for 80Mhz
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         Max RX
>>>> MCS: 0-9 for NSS: 1
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:                         Max TX
>>>> MCS: 0-9 for NSS: 1
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:         Ciphers: BIP-CMAC-128 CCMP-128 TKIP
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:         Supported iftypes: ad-hoc
>>>> station ap p2p-client p2p-go p2p-device
>>>> Dec 28 11:51:30 runeaudio iwd[1306]:         Driver Flags: DefaultInterface
>>>> Dec 28 11:51:30 runeaudio iwd[1306]: Wiphy phy0 will only use the
>>>> default interface
>>>> Dec 28 11:51:30 runeaudio iwd[1306]: Could not register frame watch
>>>> type 00b0: -22
>>>> Dec 28 11:51:46 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
>>>> Dec 28 11:51:56 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
>>>> Dec 28 11:52:22 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
>>>> Dec 28 11:52:22 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
>>>> Dec 28 11:52:29 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY reply
>>>> Dec 28 11:52:29 runeaudio iwd[1306]: 4-Way handshake failed for
>>>> ifindex: 4, reason: 15
>>>> Dec 28 11:52:39 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY reply
>>>> Dec 28 11:52:40 runeaudio iwd[1306]: 4-Way handshake failed for
>>>> ifindex: 4, reason: 15
>>>> Dec 28 11:52:49 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY reply
>>>> Dec 28 11:52:49 runeaudio iwd[1306]: 4-Way handshake failed for
>>>> ifindex: 4, reason: 15
>>>> Dec 28 11:53:07 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
>>>> Dec 28 11:53:35 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY reply
>>>> Dec 28 11:54:33 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
>>>> Dec 28 11:54:33 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
>> I tried this similarly with hostapd and get similar results with
>> disconnects. I have connman/iwd managing eth0 and wlano and created an
>> ap0 virtual interface on wlan0 then start hostapd. It will come up but
>> repeatedly disconnects in a similar fashion. I see these disconnects
>> with my phone as well as with my laptop running an intel wireless
>> card. My next investigation is to use wpa_supplicant on wlan0 and see
>> if it is any more stable. After that, maybe looking for any more up to
>> date firmware for the brcmfmac. Could iwd scanning in the wlan0 cause
>> a disconnect on the virtual ap0? Any other ideas welcome.
>>
>> This is a snippet of the log showing iwd and hostapd:
>>
>> Dec 29 07:45:26 runeaudio iwd[19160]:
>> src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
>> DemBoyz_5G
>> Dec 29 07:45:26 runeaudio iwd[19160]:
>> src/station.c:station_autoconnect_next() autoconnect:
>> 'd8:07:b6:8e:97:7a' freq: 5785, rank: 13, strength: -8100
>> Dec 29 07:45:26 runeaudio iwd[19160]:
>> src/station.c:station_autoconnect_next() autoconnect:
>> network_autoconnect: No such file or directory (-2)
>> Dec 29 07:45:26 runeaudio iwd[19160]:
>> src/wiphy.c:wiphy_radio_work_done() Work item 12 done
>> Dec 29 07:45:30 runeaudio iwd[19160]:
>> src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
>> Dec 29 07:45:30 runeaudio hostapd[1583]: ap0: STA f0:42:1c:d7:da:e8
>> IEEE 802.11: disassociated
>> Dec 29 07:45:30 runeaudio iwd[19160]:
>> src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
>> Dec 29 07:45:30 runeaudio hostapd[1583]: ap0: STA f0:42:1c:d7:da:e8
>> IEEE 802.11: disassociated
>> Dec 29 07:45:49 runeaudio iwd[19160]:
>> src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
>> Dec 29 07:45:49 runeaudio hostapd[1583]: ap0: STA f0:42:1c:d7:da:e8
>> IEEE 802.11: associated
>> Dec 29 07:45:49 runeaudio hostapd[1583]: ap0: STA f0:42:1c:d7:da:e8
>> RADIUS: starting accounting session 28F5839359A8BF79
>> Dec 29 07:45:49 runeaudio hostapd[1583]: ap0: STA f0:42:1c:d7:da:e8
>> WPA: pairwise key handshake completed (RSN)
> I did the test of the latest firmware from cypress while still using
> iwd and connman but using hostapd and get similar results. It still
> disconnects right after iwd makes a scan.
> Orig firmware on my Pi 7.45.241:
> Dec 29 13:18:45 runeaudio kernel: brcmfmac: F1 signature read
> @0x18000000=0x15264345
> Dec 29 13:18:45 runeaudio kernel: brcmfmac: brcmf_fw_alloc_request:
> using brcm/brcmfmac43455-sdio for chip BCM4345/6
> Dec 29 13:18:45 runeaudio kernel: usbcore: registered new interface
> driver brcmfmac
> Dec 29 13:18:46 runeaudio kernel: brcmfmac: brcmf_c_preinit_dcmds:
> Firmware: BCM4345/6 wl0: Nov  1 2021 00:37:25 version 7.45.241
> (1a2f2fa CY) FWID 01-703fd60
>
> This is the latest from cypress 7.45.265:
> ec 29 14:17:26 runeaudio kernel: brcmfmac: F1 signature read
> @0x18000000=0x15264345
> Dec 29 14:17:26 runeaudio kernel: brcmfmac: brcmf_fw_alloc_request:
> using brcm/brcmfmac43455-sdio for chip BCM4345/6
> Dec 29 14:17:26 runeaudio kernel: usbcore: registered new interface
> driver brcmfmac
> Dec 29 14:17:27 runeaudio kernel: brcmfmac: brcmf_c_preinit_dcmds:
> Firmware: BCM4345/6 wl0: Aug 29 2023 01:47:08 version 7.45.265
> (28bca26 CY) FWID 01-b677b91b
>
> This is is what happens with hostapd/dnsmasq on virtual ap0 and
> connmanctl/iwd on wlan0. I get a disconnect as soon as iwd performs a
> scan.
> https://pastebin.com/FsepZ6PM
>
> Could iwd -station be causing this to disconnect? When I use
> connman/wpa_supplicant and hostapd, it is rock steady. No disconnects.
> I waited over an hour and it stayed connected. There is not really a
> way for me to use connman/wpa_supplicant and use iwctl to start the AP
> on the virtual interface to test this hypothesis thst it is only iwd
> station, but as it is, iwd ap mode does not really work for brcmfmac.

Looks like we replied at the same time :)

If hostapd + wpa_supplicant doesn't cause disconnects then its likely 
the type of scan IWD does that causes problems. You could get an iwmon 
capture when wpa_supplicant is running, that would tell me what type of 
scan its doing versus IWD. There are active/passive scans and tons of 
knobs to toggle. You could also try and play around with iw and see what 
works and what doesn't:

iw wlan0 scan active

iw wlan0 scan passive

etc.

Thanks,

James


