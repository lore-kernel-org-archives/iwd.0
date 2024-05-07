Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDBC1509B0
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082910; cv=none; b=bqNrzALxCxL1pQxPvueINeDfQ09w8jgUpwTXU/XgNcIPHqFngIRfkCu29RXJ9/IqqrvKQrz9jahaVgfIX4d+aBMCRAAr5a6sQ5QKXaLWzTWmYKzOtBsHv8O9nNtP3IPk5ZE4A+jW3Qe0ZHhtJuFvOLuhrOaNDvGkF6AjEbtUSpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082910; c=relaxed/simple;
	bh=9uqj0jSiDbWe7334WtZXn2ZEPlJ/kA24WXapOgtmr7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZ4eMDup7fW8zYKnaqZZc7c/CozV78w2hdqtLrGzaQp9SKZr/lUsxoHoA9+kaRTw26Rqu/tIYA19qj7TEcNbb8jTRt0qAzlhmbDB/Giarl6HvMj7lW30bpzwlXcm1v1j8VU5xCRIfu8M+eItCL9lDQcKTJZ3VNvYq1vkHMjBRrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEGA7Clb; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEGA7Clb"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79291262dc2so295356085a.2
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 04:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715082908; x=1715687708; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lutqo1zLDZi00gzOoguPAFYPdtveNfhJw/qEp3OcaHM=;
        b=HEGA7Clb3Y1olgbZboqMKHmoiy1MjQV/F4uakVH026BMAcBReeKKWudBTBwJJzV07a
         71oBukGO4RPacjcxbCUHl736cr+7TWjz0c4vPV8xNyCjyTdSeAsptK46E4I8ermwlIEC
         BbOe9Y0Ad6Z4RIlFoZ/OuOiKxtPxSkiC8VnMiwkIJQ8XlSbHtcpeYy3wnjlo//QzaB4l
         IRIJvW2r9xbeVGCcgb+39O1glQzApM/OZ1m4B0+05t2bN6uxQFs0CorSlluVgzMe1AqX
         cgQAOxKqjBRTAhc6QK6s0zd8k9kR+AMDVCK9KIAkSDIUg/TxtWm+6rkYlFqyqPcSI3KV
         eukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715082908; x=1715687708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lutqo1zLDZi00gzOoguPAFYPdtveNfhJw/qEp3OcaHM=;
        b=NLft42mwA9UeQIqQpaFcAFOfcV9OOl2oPXAXK1bAI/SD7F68riGDJW2c1HLjHDjVQT
         YrJ1HeQCTOQUrKQEvR3FkApTAvn0vE9/iCaHVdsYiE+vLvXLc2xt14chKq58MnMegARa
         cbf0Gyjt6C2KJBeaSaQmel31n41lbDuAk0Y7vfOnSmG5rjzrJTbR/uMAuCyYppKjnHSd
         mDLeRFcG1inZiKgupvvVBQeDEphSJgyT7eap4NzRqAy1Mw6s4js4jsGxjtKCqP0cLshV
         Vamf94A1Mi1UW9i3MWXBK5vNJWWptYbCaRMLmvOWfKNJVtSnpcNdA0Pc8SHvljLanNK4
         kH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMm/Gnd8O+8rCq7HUSmfLFRVceVV4rQlskvvSvLbHe4bE1vwF9spuSN2pke3Hb2YbuCuiU8FsNd/aL7RZksj7BirrJ
X-Gm-Message-State: AOJu0YwQ9PYoV91uWROOB3EOMHqTEk+HNh15fqlnt5+LtrpSbYIDMtnq
	wUFktnxz3NIisijup5Ypwp82X2wYWZFA9m3B0uR5gakn+FuENcc0
X-Google-Smtp-Source: AGHT+IGJSsBJpGK0wsgYdDeWypldCa5QPoyNJ7lX28D8r9tsjC4H5BR5qOIZnzguPZOx0XaeGv4u3A==
X-Received: by 2002:ad4:5c4c:0:b0:6a0:d465:6088 with SMTP id a12-20020ad45c4c000000b006a0d4656088mr17312945qva.34.1715082907959;
        Tue, 07 May 2024 04:55:07 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id x12-20020a0ceb8c000000b006a0f012fab9sm4626983qvo.52.2024.05.07.04.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 04:55:07 -0700 (PDT)
Message-ID: <083f4a69-a164-404b-b4fb-9ce024a38156@gmail.com>
Date: Tue, 7 May 2024 04:55:05 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raspberry Pi 5 and WPA3
Content-Language: en-US
To: KeithG <ys3al35l@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Harry ten Berge <htenberge@gmail.com>, iwd@lists.linux.dev
References: <CAN+yObo7O+c7x51maXYxUiSttAC6ZJkuNb9DJwjCuegbAgyLow@mail.gmail.com>
 <91648487-9c59-40f9-996d-dfad1f1adcbb@gmail.com>
 <38861D9C-F5F5-4149-99CD-0C59480986ED@holtmann.org>
 <25618c14-df5a-4980-9e62-dd5c96084455@gmail.com>
 <CAG17S_MTbFpQB-LDu6s87D1stbojwpto3y+V1X4kSPe3Gkixug@mail.gmail.com>
 <CAG17S_PnK8PebjYZT5s0qyPMn7HhL=D+mC4VaG4i2ZAydeOjSA@mail.gmail.com>
 <997f2369-3805-4141-ba39-72d5f6ac6931@gmail.com>
 <CAG17S_MR1ZKkX7nUmb-0K0WAKDSpV8=xSR8ky-wD4uvmwiGiUw@mail.gmail.com>
 <129db0c4-d402-480a-ba9a-d28ecbbdacfe@gmail.com>
 <CAG17S_MfsMfPaxWa0C7g_O+anw6y1m+7hQTk_Y-RO_bTKHuowA@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_MfsMfPaxWa0C7g_O+anw6y1m+7hQTk_Y-RO_bTKHuowA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/6/24 7:33 PM, KeithG wrote:
> On Thu, May 2, 2024 at 9:07 AM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi Keith,
>>
>> On 5/2/24 6:47 AM, KeithG wrote:
>>> James,
>>>
>>> I tried to connect via my Samsung S23 phone and my desktop with an
>>> intel card. The desktop uses iwd 2.17 and when I tried to connect via
>>> iwctl, it did the same thing as the RPi. I suspect my hostapd config,
>>> but do not know. I can try collecting some logs next week on the
>>> desktop and the Pi. Which log do you need? '-d something' or an iwmon
>>> log?
>> Yeah just a -d IWD log. If you want to capture with iwmon that
>> definitely can't hurt. For reference, this is the config we use for one
>> of our SAE autotests:
>>
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/autotests/testSAE/ssidSAE.conf
>>
>>> Keith
>>>
>>> On Thu, May 2, 2024 at 8:09 AM James Prestwood <prestwoj@gmail.com> wrote:
>>>> Hi Keith,
>>>>
>>>> On 5/2/24 5:56 AM, KeithG wrote:
>>>>> On Tue, Apr 30, 2024 at 7:19 AM KeithG <ys3al35l@gmail.com> wrote:
>>>>>> On Tue, Apr 30, 2024 at 6:24 AM James Prestwood <prestwoj@gmail.com> wrote:
>>>>>>> Hi Marcel,
>>>>>>>
>>>>>>> On 4/30/24 12:42 AM, Marcel Holtmann wrote:
>>>>>>>> Hi James,
>>>>>>>>
>>>>>>>>>> I'm not sure this is the right place to ask for some assistance, but
>>>>>>>>>> here we go...
>>>>>>>>>>
>>>>>>>>>> I'm the author for a small Raspberry Pi audio image that is
>>>>>>>>>> specifically targeting Roon.
>>>>>>>>>> If you're not familiair with Roon: it's an audio streaming platform
>>>>>>>>>> targeting audiophiles ;-)
>>>>>>>>>>
>>>>>>>>>> Anyways, about a year ago I switched from wpa_supplicant to iwd, to
>>>>>>>>>> full satisfaction.
>>>>>>>>>> Better and easier integration, and overall a feel of me being in more control.
>>>>>>>>>>
>>>>>>>>>> Now, recently I'm having issues with WPA3 support. This is partly
>>>>>>>>>> related to firmware (it's just so obfuscated how this all works with
>>>>>>>>>> firmware from broadcom and firmware from cypress :-(
>>>>>>>>>>
>>>>>>>>>> And one of those things is that I can't get it to work on the new Pi
>>>>>>>>>> 5. Specifically IWD reporting this:
>>>>>>>>>>
>>>>>>>>>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
>>>>>>>>>> Network is WPA3-Personal...
>>>>>>>>>> Apr 29 17:41:41 ropieee5 iwd[275]: SAE unsupported: brcmfmac needs
>>>>>>>>>> CMD_EXTERNAL_AUTH for SAE
>>>>>>>>>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
>>>>>>>>>> Can't use SAE, trying WPA2
>>>>>>>>>>
>>>>>>>>>> Now, the Pi guys point me to the missing CMD_EXTERNAL_AUTH message and
>>>>>>>>>> advise me to go back to wpa_supplicant. Which is not something I would
>>>>>>>>>> like to do for various reasons...
>>>>>>>>>>
>>>>>>>>>> Do you have any advice for me on what I can do? is this
>>>>>>>>>> CMD_EXTERNAL_AUTH really related to  this and are you planning on
>>>>>>>>>> implementing this?
>>>>>>>>> Unfortunately the external auth support is not yet implemented in IWD. The brcmfmac driver itself is rather unique being a fullmac driver. Depending on how you look at it, this on its own is "easier" to support. It handles connecting/roaming all on its own. But then, for some reason, someone didn't want to do SAE/WPA3 on the card itself so they came up with some one-off mechanism to offload that onto userspace. This is one of those things that got put upstream that is a pain for projects like IWD to support IMO. Its something we do need to support eventually, especially given the raspi 5 requires it.
>>>>>>>> if the Broadcom firmware finally would be able to support external_auth,
>>>>>>>> then it would be nice, but as seen on recent linux-wireless discussions,
>>>>>>>> it is unclear who does what. Broadcom wanted to support external_auth,
>>>>>>>> but then Infineon (the new owner) might be rather using SAE as part of
>>>>>>>> the firmware. And actually the chip on the RPi5 marks itself as Cypress
>>>>>>>> and so you it is an unclear story. I think that Raspberry Pi foundation
>>>>>>>> should get their story straight. Until really recently they shipped a
>>>>>>>> firmware that couldn’t do SAE and also their drivers couldn’t even do
>>>>>>>> external_auth and you were stuck with WPA2 only.
>>>>>>>>
>>>>>>>> https://holtmann.dev/enabling-wpa3-on-raspberry-pi/
>>>>>>> I was not aware that it didn't even support it correctly. I figured
>>>>>>> broadcom was who added it in the first place.
>>>>>>>> You can use an upstream firmware from linux-firmware and make the RPi5
>>>>>>>> support WPA3. And as of a few weeks ago, even RPi5 latest Debian was
>>>>>>>> switching to the upstream firmware.
>>>>>>>>
>>>>>>>> On side note, there exists no wpa_supplicant release that really supports
>>>>>>>> SAE offload properly. You need to back port a lot of patches or hope
>>>>>>>> that your distro back ported them for you.
>>>>>>>>
>>>>>>>> We should actually check if nl80211 tells us that external_auth is
>>>>>>>> supported by the driver. And if not (which is the case for the Broadcom
>>>>>>>> upstream driver) send a proper message to users and not lead them into
>>>>>>>> a wild goose chase.
>>>>>>>>
>>>>>>>> Regards
>>>>>>>>
>>>>>>>> Marcel
>>>>>>>>
>>>>>> FWIW, the most recent update to the RPI Bookworm image has enabled
>>>>>> this capability:
>>>>>> # uname -a
>>>>>> Linux pi5 6.6.28+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.28-1+rpt1
>>>>>> (2024-04-22) aarch64 GNU/Linux
>>>>>>
>>>>>> # dmesg | grep brcmfmac
>>>>>> [    2.195263] brcmfmac: F1 signature read @0x18000000=0x15264345
>>>>>> [    2.209946] brcmfmac: brcmf_fw_alloc_request: using
>>>>>> brcm/brcmfmac43455-sdio for chip BCM4345/6
>>>>>> [    2.216566] usbcore: registered new interface driver brcmfmac
>>>>>> [    2.384898] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
>>>>>> available (err=-2)
>>>>>> [    2.385212] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
>>>>>> wl0: Apr 15 2021 03:03:20 version 7.45.234 (4ca95bb CY) FWID
>>>>>> 01-996384e2
>>>>>>
>>>>>> # iw list
>>>>>> Wiphy phy0
>>>>>> ...
>>>>>>        Supported extended features:
>>>>>>            * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>>>>>>            * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station mode
>>>>>>            * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in station mode
>>>>>>            * [ DFS_OFFLOAD ]: DFS offload
>>>>>>            * [ SAE_OFFLOAD ]: SAE offload support
>>>>>>            * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
>>>>>>            * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
>>>>>>
>>>>>> This was achieved here with a normal 'apt update ; apt upgrade' routine.
>>>>>>
>>>>>> This appears to work for all Pis, now. Even a 32 bit image on a 3b+
>>>>>> with similar hardware:
>>>>>> # uname -a
>>>>>> Linux rpi32 6.6.28+rpt-rpi-v7 #1 SMP Raspbian 1:6.6.28-1+rpt1
>>>>>> (2024-04-22) armv7l GNU/Linux
>>>>>> # iw list
>>>>>> ...
>>>>>>        Supported extended features:
>>>>>>            * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>>>>>>            * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station mode
>>>>>>            * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in station mode
>>>>>>            * [ DFS_OFFLOAD ]: DFS offload
>>>>>>            * [ SAE_OFFLOAD ]: SAE offload support
>>>>>>            * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
>>>>>>            * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
>>>>>>
>>>>>> The PiZero2W does not show this capability with the same 64 bit image
>>>>>> running as it has different hardware with different firmware:
>>>>>> # dmesg | grep brcmfmac
>>>>>> [    6.051393] brcmfmac: F1 signature read @0x18000000=0x1542a9a6
>>>>>> [    6.077172] brcmfmac: brcmf_fw_alloc_request: using
>>>>>> brcm/brcmfmac43430b0-sdio for chip BCM43430/2
>>>>>> [    6.080782] usbcore: registered new interface driver brcmfmac
>>>>>> [    6.476401] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
>>>>>> available (err=-2)
>>>>>> [    6.481953] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/2
>>>>>> wl0: Mar 31 2022 17:24:51 version 9.88.4.77 (g58bc5cc) FWID
>>>>>> 01-3b307371
>>>>>>
>>>>>> Keith
>>>>> I got around to testing this a bit tonight. I set up my Pi5 with
>>>>> hostapd and used this /etc/hostapd/hostapd.conf
>>>>>
>>>>> # cat /etc/hostapd/hostapd.conf
>>>>> # interface and driver
>>>>> interface=ap0
>>>>> driver=nl80211
>>>>>
>>>>> # WIFI-Config
>>>>> ssid=SSIDWPA3
>>>>> channel=7
>>>>> hw_mode=g
>>>>> ieee80211n=1
>>>>> wmm_enabled=1
>>>>> macaddr_acl=0
>>>>> auth_algs=1
>>>>> max_num_sta=10
>>>>>
>>>>> wpa=2
>>>>> wpa_key_mgmt=SAE
>>>>> rsn_pairwise=CCMP
>>>>> ieee80211w=2
>>>>> wpa_passphrase=password
>>>>> sae_pwe=2
>>>>>
>>>>> Form the log, it looks like SAE is enabled and ruinning, but I do not
>>>>> know what I am looking at.
>>>>> Using interface ap0 with hwaddr d8:3a:dd:27:6f:a7 and ssid "SSIDWPA3"
>>>>> ...
>>>>> SAE: Derive PT - group 19
>>>>> SAE: SSID - hexdump_ascii(len=8):
>>>>>         53 53 49 44 57 50 41 33                           SSIDWPA3
>>>>> SAE: password - hexdump_ascii(len=9): [REMOVED]
>>>>> SAE: pwd-seed - hexdump(len=32): [REMOVED]
>>>>> SAE: pwd-value (u1 P1) - hexdump(len=48): [REMOVED]
>>>>> SAE: u1 - hexdump(len=32): [REMOVED]
>>>>> ...
>>>>>
>>>>> I can 'see' it from my other pi running iwd and on my laptop, but I
>>>>> cannot connect on either. I get nothing in the log. When I type in the
>>>>> password, I get:
>>>>>
>>>>> [iwd]# station wlan0 connect SSIDWPA3
>>>>> Type the network passphrase for SSIDWPA3 psk.
>>>>> Passphrase: *********
>>>>> Operation failed
>>>> We'll need to see some IWD logs to see whats going on. Also, can you
>>>> connect from your phone or some other device?
>>>>
>>>>> Both Pis show that they have what Marcel noted:
>>>>>
>>>>>        Supported extended features:
>>>>>            * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>>>>>            * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station mode
>>>>>            * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in station mode
>>>>>            * [ DFS_OFFLOAD ]: DFS offload
>>>>>            * [ SAE_OFFLOAD ]: SAE offload support
>>>>>            * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
>>>>>            * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
>>>>>
>>>>> Is my config wrong?
>>>>>
>>>>> The version of iwd I am running is 2.17 built from git with the latest
>>>>> commit as of e3f6a2c. The version if hostapd is:
>>>>> # hostapd -v
>>>>> hostapd v2.10
>>>>> User space daemon for IEEE 802.11 AP management,
>>>>> IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator
> James,
>
> I tried this again. a Pi5 running your SAE hostapd.conf and a Pi3b+
> running iwd -d. I get teh same thing on the cli when I try to connect
> and put in the password: "Operation Failed'
> The hostapd config on the Pi5 is:
> # cat /etc/hostapd/hostapd.conf
> # interface and driver
> interface=ap0
> driver=nl80211
>
> # WIFI-Config
> ssid=ssidSAE
> channel=1
> hw_mode=g
>
> wpa=2
> wpa_key_mgmt=SAE
> wpa_pairwise=CCMP
> sae_password=secret123
> sae_groups=19
> ieee80211w=2
> sae_pwe=0
>
> The iwd log from the Pi3b+ is attached.
Could you post the hostapd logs as well if you have them. I haven't 
tried WPA3 on a pi3 in a while but I guess it might be time to give it 
another round of testing. Could you also try connecting to the WPA3 AP 
using a non-IWD device just for sanity?
>
> Keith
