Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61C32C60
	for <iwd@lists.linux.dev>; Thu,  2 May 2024 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655395; cv=none; b=N+g6g0Qt62gtgdStZuIAlUIf4pt9lJvQ1+8WDsWuFq5uz8TcuIhJNcqCorFrsEEUESZEdc+7EYQZRuefTjTwV0oDydmmdExT4RGKyevf91S+TxBkBdqHiYtz+Un5Q/RQFrBUd9Kbbo0T7CGrQ12PXyjK2FU+n4QGV4RJHQyYhO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655395; c=relaxed/simple;
	bh=wxdAycos0SsZmAtbBNonmRMsPKxZtDPqqgoiUBoKeTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6ccLkbfoGXhwlwxjLNFW/gUYGFdZLGjUOtBOOJ+oYgE3p2Y9BJ8VFVCuGxrVBWkUyO3az+K0hriyB70E9VJutxbNXf66CIWMA2w1FaiUk0AWvMVkb/YtEW6ooU3GEfzHsxZyeHv81/M+kLVg4HLDCnCkdygd8bimfSuyfp5yuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iq6GJ/oi; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq6GJ/oi"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78f05e56cb3so495142085a.1
        for <iwd@lists.linux.dev>; Thu, 02 May 2024 06:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714655392; x=1715260192; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bny0pMftvB+W8QFD2+M05EAOvDktk+Aa5xvfz/R5l4s=;
        b=Iq6GJ/oiEPljoZbyFqejv2tDYXGYJe44sp/yqkNxrRWo9U0H0MYxPrIGRneL2+yHoF
         WV9Jpi4LiX8kclNSLE9UzHeeJjOAWgbCfXmAah/Zfe3mu8t5Wto1GdxRLtoNs6icZ4L3
         ZD4DvMkWkbe5BLP9AQCw05DeFBV7tSipBnUCa5INEz3CVBoXWm6vaCSPuMs2gtabz5q/
         +jooB8DAE+1Of88bvi06K34ZTKxqBwsqHfk+y+u6zuJz06TsJZ1iYtIXN+44/GMwGcoB
         eEz0Qm1ufM5N8bc1hG+ZtbLn4tfrTMqGbmBPBQWw3ap9cphok8RdQXd7wOb63e4WItDe
         5FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714655392; x=1715260192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bny0pMftvB+W8QFD2+M05EAOvDktk+Aa5xvfz/R5l4s=;
        b=UCBGmK7MUOAroenrUpdIKur0oerxILwUrYn/gOXcdiKj6D/3+Yboz8Ecltbd1CkcnM
         x8DucfDUMd/jMls6+RRCCp6Afo1Qb932jDPKT9j4lzjclQkZixjo+QT2275rPFPdOjv6
         ySWUJuacwsnsBxUODzFF1vArTkaO1DC1oFM26T01EvALLRODsklbkoBfs17wfKCXGjY1
         WEDvZ4sYhY9EzMEaX+lEHQT+LYkFwo60cLO9F+MPr+NGDQPIdwst4q3BSDfjNKVS9L+C
         mYJgQbsLOuYlyMohXrEQYy4FE4buty9Jnl0o+RvhJfpRLafruedUd+Dbe6Kk0IU0/uSD
         WlpA==
X-Forwarded-Encrypted: i=1; AJvYcCVyIZYON/3WSZhL2SmVwespq4GWAVrjAzoCjPLWAtsaa5X9E42RbzLfZHZMz9bfzafVO3VbcGQv4uQUv3pePmS6Ni0G
X-Gm-Message-State: AOJu0YwSnmYIJ8ix7RonCLyGZsVI5IX1spqH30pB09gD9fI2AMDG3c/2
	1byIDicjCcg5SzvpmEZJHmxL0glqcO90ovlk1hcAQceoYwzbAcMY
X-Google-Smtp-Source: AGHT+IHxldiyK1gnxSlUksAo9+1nVCQi6btUuCQgr4ut8J2IYtNw1kdixWZz9DNa2W0suhKageL5QA==
X-Received: by 2002:a05:6214:ca4:b0:6a0:c143:5535 with SMTP id s4-20020a0562140ca400b006a0c1435535mr2648340qvs.10.1714655387874;
        Thu, 02 May 2024 06:09:47 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id fc5-20020a05622a488500b00437c6fb5d62sm460831qtb.7.2024.05.02.06.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 06:09:47 -0700 (PDT)
Message-ID: <997f2369-3805-4141-ba39-72d5f6ac6931@gmail.com>
Date: Thu, 2 May 2024 06:09:44 -0700
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_PnK8PebjYZT5s0qyPMn7HhL=D+mC4VaG4i2ZAydeOjSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 5/2/24 5:56 AM, KeithG wrote:
> On Tue, Apr 30, 2024 at 7:19 AM KeithG <ys3al35l@gmail.com> wrote:
>> On Tue, Apr 30, 2024 at 6:24 AM James Prestwood <prestwoj@gmail.com> wrote:
>>> Hi Marcel,
>>>
>>> On 4/30/24 12:42 AM, Marcel Holtmann wrote:
>>>> Hi James,
>>>>
>>>>>> I'm not sure this is the right place to ask for some assistance, but
>>>>>> here we go...
>>>>>>
>>>>>> I'm the author for a small Raspberry Pi audio image that is
>>>>>> specifically targeting Roon.
>>>>>> If you're not familiair with Roon: it's an audio streaming platform
>>>>>> targeting audiophiles ;-)
>>>>>>
>>>>>> Anyways, about a year ago I switched from wpa_supplicant to iwd, to
>>>>>> full satisfaction.
>>>>>> Better and easier integration, and overall a feel of me being in more control.
>>>>>>
>>>>>> Now, recently I'm having issues with WPA3 support. This is partly
>>>>>> related to firmware (it's just so obfuscated how this all works with
>>>>>> firmware from broadcom and firmware from cypress :-(
>>>>>>
>>>>>> And one of those things is that I can't get it to work on the new Pi
>>>>>> 5. Specifically IWD reporting this:
>>>>>>
>>>>>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
>>>>>> Network is WPA3-Personal...
>>>>>> Apr 29 17:41:41 ropieee5 iwd[275]: SAE unsupported: brcmfmac needs
>>>>>> CMD_EXTERNAL_AUTH for SAE
>>>>>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
>>>>>> Can't use SAE, trying WPA2
>>>>>>
>>>>>> Now, the Pi guys point me to the missing CMD_EXTERNAL_AUTH message and
>>>>>> advise me to go back to wpa_supplicant. Which is not something I would
>>>>>> like to do for various reasons...
>>>>>>
>>>>>> Do you have any advice for me on what I can do? is this
>>>>>> CMD_EXTERNAL_AUTH really related to  this and are you planning on
>>>>>> implementing this?
>>>>> Unfortunately the external auth support is not yet implemented in IWD. The brcmfmac driver itself is rather unique being a fullmac driver. Depending on how you look at it, this on its own is "easier" to support. It handles connecting/roaming all on its own. But then, for some reason, someone didn't want to do SAE/WPA3 on the card itself so they came up with some one-off mechanism to offload that onto userspace. This is one of those things that got put upstream that is a pain for projects like IWD to support IMO. Its something we do need to support eventually, especially given the raspi 5 requires it.
>>>> if the Broadcom firmware finally would be able to support external_auth,
>>>> then it would be nice, but as seen on recent linux-wireless discussions,
>>>> it is unclear who does what. Broadcom wanted to support external_auth,
>>>> but then Infineon (the new owner) might be rather using SAE as part of
>>>> the firmware. And actually the chip on the RPi5 marks itself as Cypress
>>>> and so you it is an unclear story. I think that Raspberry Pi foundation
>>>> should get their story straight. Until really recently they shipped a
>>>> firmware that couldn’t do SAE and also their drivers couldn’t even do
>>>> external_auth and you were stuck with WPA2 only.
>>>>
>>>> https://holtmann.dev/enabling-wpa3-on-raspberry-pi/
>>> I was not aware that it didn't even support it correctly. I figured
>>> broadcom was who added it in the first place.
>>>> You can use an upstream firmware from linux-firmware and make the RPi5
>>>> support WPA3. And as of a few weeks ago, even RPi5 latest Debian was
>>>> switching to the upstream firmware.
>>>>
>>>> On side note, there exists no wpa_supplicant release that really supports
>>>> SAE offload properly. You need to back port a lot of patches or hope
>>>> that your distro back ported them for you.
>>>>
>>>> We should actually check if nl80211 tells us that external_auth is
>>>> supported by the driver. And if not (which is the case for the Broadcom
>>>> upstream driver) send a proper message to users and not lead them into
>>>> a wild goose chase.
>>>>
>>>> Regards
>>>>
>>>> Marcel
>>>>
>> FWIW, the most recent update to the RPI Bookworm image has enabled
>> this capability:
>> # uname -a
>> Linux pi5 6.6.28+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.28-1+rpt1
>> (2024-04-22) aarch64 GNU/Linux
>>
>> # dmesg | grep brcmfmac
>> [    2.195263] brcmfmac: F1 signature read @0x18000000=0x15264345
>> [    2.209946] brcmfmac: brcmf_fw_alloc_request: using
>> brcm/brcmfmac43455-sdio for chip BCM4345/6
>> [    2.216566] usbcore: registered new interface driver brcmfmac
>> [    2.384898] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
>> available (err=-2)
>> [    2.385212] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
>> wl0: Apr 15 2021 03:03:20 version 7.45.234 (4ca95bb CY) FWID
>> 01-996384e2
>>
>> # iw list
>> Wiphy phy0
>> ...
>>      Supported extended features:
>>          * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>>          * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station mode
>>          * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in station mode
>>          * [ DFS_OFFLOAD ]: DFS offload
>>          * [ SAE_OFFLOAD ]: SAE offload support
>>          * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
>>          * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
>>
>> This was achieved here with a normal 'apt update ; apt upgrade' routine.
>>
>> This appears to work for all Pis, now. Even a 32 bit image on a 3b+
>> with similar hardware:
>> # uname -a
>> Linux rpi32 6.6.28+rpt-rpi-v7 #1 SMP Raspbian 1:6.6.28-1+rpt1
>> (2024-04-22) armv7l GNU/Linux
>> # iw list
>> ...
>>      Supported extended features:
>>          * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>>          * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station mode
>>          * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in station mode
>>          * [ DFS_OFFLOAD ]: DFS offload
>>          * [ SAE_OFFLOAD ]: SAE offload support
>>          * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
>>          * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
>>
>> The PiZero2W does not show this capability with the same 64 bit image
>> running as it has different hardware with different firmware:
>> # dmesg | grep brcmfmac
>> [    6.051393] brcmfmac: F1 signature read @0x18000000=0x1542a9a6
>> [    6.077172] brcmfmac: brcmf_fw_alloc_request: using
>> brcm/brcmfmac43430b0-sdio for chip BCM43430/2
>> [    6.080782] usbcore: registered new interface driver brcmfmac
>> [    6.476401] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
>> available (err=-2)
>> [    6.481953] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/2
>> wl0: Mar 31 2022 17:24:51 version 9.88.4.77 (g58bc5cc) FWID
>> 01-3b307371
>>
>> Keith
> I got around to testing this a bit tonight. I set up my Pi5 with
> hostapd and used this /etc/hostapd/hostapd.conf
>
> # cat /etc/hostapd/hostapd.conf
> # interface and driver
> interface=ap0
> driver=nl80211
>
> # WIFI-Config
> ssid=SSIDWPA3
> channel=7
> hw_mode=g
> ieee80211n=1
> wmm_enabled=1
> macaddr_acl=0
> auth_algs=1
> max_num_sta=10
>
> wpa=2
> wpa_key_mgmt=SAE
> rsn_pairwise=CCMP
> ieee80211w=2
> wpa_passphrase=password
> sae_pwe=2
>
> Form the log, it looks like SAE is enabled and ruinning, but I do not
> know what I am looking at.
> Using interface ap0 with hwaddr d8:3a:dd:27:6f:a7 and ssid "SSIDWPA3"
> ...
> SAE: Derive PT - group 19
> SAE: SSID - hexdump_ascii(len=8):
>       53 53 49 44 57 50 41 33                           SSIDWPA3
> SAE: password - hexdump_ascii(len=9): [REMOVED]
> SAE: pwd-seed - hexdump(len=32): [REMOVED]
> SAE: pwd-value (u1 P1) - hexdump(len=48): [REMOVED]
> SAE: u1 - hexdump(len=32): [REMOVED]
> ...
>
> I can 'see' it from my other pi running iwd and on my laptop, but I
> cannot connect on either. I get nothing in the log. When I type in the
> password, I get:
>
> [iwd]# station wlan0 connect SSIDWPA3
> Type the network passphrase for SSIDWPA3 psk.
> Passphrase: *********
> Operation failed

We'll need to see some IWD logs to see whats going on. Also, can you 
connect from your phone or some other device?

>
> Both Pis show that they have what Marcel noted:
>
>      Supported extended features:
>          * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>          * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station mode
>          * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in station mode
>          * [ DFS_OFFLOAD ]: DFS offload
>          * [ SAE_OFFLOAD ]: SAE offload support
>          * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
>          * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
>
> Is my config wrong?
>
> The version of iwd I am running is 2.17 built from git with the latest
> commit as of e3f6a2c. The version if hostapd is:
> # hostapd -v
> hostapd v2.10
> User space daemon for IEEE 802.11 AP management,
> IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator
