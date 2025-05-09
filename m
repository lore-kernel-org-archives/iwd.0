Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4C17A310
	for <iwd@lists.linux.dev>; Fri,  9 May 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809997; cv=none; b=OE1WAv8xEXXgGwPhdpHKH1zsuUbYCLJuRG/Pye/cvVfBRLNiokB9o3opFpA9DZmosWun/sIPGjLzMXxryke1GI1NWKtqsPeDP+kQ2zrIsJtp2ebA/6MyQA7HRxrVZMTuEgU9Np4QxN6d9qdaZrL6guZ5X7otd/I+8X9Th3Hc+Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809997; c=relaxed/simple;
	bh=3trsz/ePT88mg84FbCydDrCbLSCv1wiqHI50Xo3VByM=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=upD+GmHjQqFlK4V6/TXK91t3eqiOnCYzvw6hsHAksZ3dW8t5nfScdCT4xfT+yjQwQtI5/f35llDNFlP+VSrSjBZ+JZF4PpJKwpm3a5WvLcSQFLZDU9Y046np+IbFxVBcASAcA6FjKKojH2Y4hxNtUAVYToI9txTqFHxDKi+U3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Unchtafq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Unchtafq"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso386017866b.3
        for <iwd@lists.linux.dev>; Fri, 09 May 2025 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746809994; x=1747414794; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt+ljeA/MymS/vcxDoAh29dX42X22K2HgLbuuLX1+cQ=;
        b=UnchtafqDAO8m+SUh8M32SyHeSOxG50KmwARNC+GH54TyGEQzb1w9JZxM18jnqZBeT
         Q6jDCuWtttKRaCHXEUTZbqVpOnzupN8w/jl/FTPTRBDwFP1HZJJ6tJaaZRAVeB+59Zc9
         WtZj7ne1Ge+k4BDrXyElOFSCsVT+CWkuYKqoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746809994; x=1747414794;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gt+ljeA/MymS/vcxDoAh29dX42X22K2HgLbuuLX1+cQ=;
        b=CdLQhLl225wCKaI8FGSoyGJOO2/Q81yplxe8R6hqiAZpbYtLnuQ17GsOQs8oGZZgVg
         FYrzflu0Kf7dIfhx4nyzY+PoV7rKX667HdYlxcDoFugJHUJXNEOgWCuqf/koY47PB70v
         6xnS2eXRIULOkYbWer+0AI3a4MBNHbC3toCiatxKHTl4vVvLY/PSgklovlXbPfETQSez
         UwlS1pcEKVQU65lFjZ8T0jh9evZwFPxAtGJlYs42dddTiXcogDxYK0ZQWgH1S6N36ncx
         G19kpGJxjBPccpbSTUcUkqINTC9WzgAEkItXVHfMSeQN/AN0rqYnsykT9QTNeVeJm7hG
         pgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJih931zHF7SaE8/BoXtTJ6SP8cQBoS73wSGCbR8ltdco+4DJ35QcmQjCfm5L/GYn7Cnk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzlo7ITuaKHpdW1yLJdnX8wz6RaFcKbMnsYX4A5wLD7F2wPWQnZ
	AgKz+jtqgimS96QQ5eV/aTtpYg6LhNbiYdrKa35Uzz+0VeF3DpeDQmCDVL9e6Q==
X-Gm-Gg: ASbGncuQps2YWOOpY6Q7KguOnvpQA5xyy9QCuHuV5XFqsEtc6dV2y2wQKjZWzEXXdS8
	aCQqjDIdnPZ/55jn6puX8WVyY3pvBCKF6JeDK7l8D47y6WWsG9WE7PkRDoFABMeDELAq9SXsrLU
	jXUMXE/Bm/ufWLeJGm/KHgKi4hO3CNSt3kh0jQFGoaMV9bHrqnI8oE28GqXMYyCmITzy3RLtxEW
	GnYGIBjInpEMQzI6QL/7KNpgLGLq3u7x/PP8A3h1LsYwZC9k+KPLLj1rW6/h5o6/GDQeISSwx2l
	sBLQ/UplaKzxzobnoGEh1Ufvq9kHA2xnh8wcwsF7GWwkicnsyoPbocKJJ3vlRLXiU0lDTkHbK7t
	jt4k=
X-Google-Smtp-Source: AGHT+IE4U+xhLgrY2nPbC3SS25uPMbcp2S0+Nk+CVmKz3yElwUaIwY7+Mmw5zbwFNcp8fTrdclTRNQ==
X-Received: by 2002:a17:907:9704:b0:ad2:35db:a730 with SMTP id a640c23a62f3a-ad235dbb890mr9855466b.21.1746809993564;
        Fri, 09 May 2025 09:59:53 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bd432sm173531466b.129.2025.05.09.09.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 09:59:53 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: KeithG <ys3al35l@gmail.com>
CC: Denis Kenzior <denkenz@gmail.com>, <iwd@lists.linux.dev>, James Prestwood <prestwoj@gmail.com>
Date: Fri, 09 May 2025 18:59:50 +0200
Message-ID: <196b5fd2b70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAG17S_PxYNxLpAMzXOuS6riv46G22zpOM0rT0D7Xp-usbWyo+A@mail.gmail.com>
References: <CAG17S_M4_+CR1uSsajyvHBjig6cfCuxegipnHREhk1sXjSyOsA@mail.gmail.com>
 <a0dcf03d-3bd3-43e5-9532-5a565d20930f@gmail.com>
 <CAG17S_MKZXf3vC0zgaK_MUrA1nqRzhGcPGUho873KU3jYVShXw@mail.gmail.com>
 <45bc2f1b-b037-4784-a2a9-7732a82b7391@gmail.com>
 <CAG17S_MqLBQV6ktjbWsoAv0e+2A0dnNN5+X7Pf+b-qDP3mrL1Q@mail.gmail.com>
 <19691dcb210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_MX3S9=EmiHBae8WsRnmsUGBJ5h4d8kCmgdxYZ2Zaeh8Q@mail.gmail.com>
 <1fb12821-1707-4478-941b-9fbc007c4e9a@broadcom.com>
 <CAG17S_M9_-TG4YnHAwx2+O2bJ6sbEE75X=V0y4Pbxy222O3ZJg@mail.gmail.com>
 <CAG17S_Njkt7rFTk4Tn-KnLVS8kzA61KJGyWgNQ9kqx5M=s7DnA@mail.gmail.com>
 <38be0ddf-50ff-4ef9-bd98-748ffcfed2e1@broadcom.com>
 <CAG17S_NCAmDPa+jK=OPdF18H8Yuuio3czytaa2q5hMSJiKO9bw@mail.gmail.com>
 <CAG17S_MbUsp6Nu=idnk0p9sQLRJWg=G8oaE1X2kdjwZ_uH4KAA@mail.gmail.com>
 <CAG17S_PxYNxLpAMzXOuS6riv46G22zpOM0rT0D7Xp-usbWyo+A@mail.gmail.com>
User-Agent: AquaMail/1.55.0 (build: 105500550)
Subject: Re: brcmfmac disconnects when iwd scans
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On May 9, 2025 4:46:14 PM KeithG <ys3al35l@gmail.com> wrote:

> On Wed, May 7, 2025 at 6:02 PM KeithG <ys3al35l@gmail.com> wrote:
>>
>> On Wed, May 7, 2025 at 2:44 PM KeithG <ys3al35l@gmail.com> wrote:
>>>
>>> On Wed, May 7, 2025 at 9:27 AM Arend van Spriel
>>> <arend.vanspriel@broadcom.com> wrote:
>>>>
>>>> On 5/7/2025 3:54 PM, KeithG wrote:
>>>>> further information...
>>>>>
>>>>> I tried this with 2 different pi4s and have been able to confirm
>>>>> wpa_supplicant/hostapd is stable on the Pi4 (will try others when I
>>>>> get a chance). I also tried both the 'shipping' brcmfmac43455 firmware
>>>>> and the 'latest'. It is only with the 'latest' that I get reliable
>>>>> connections. With the 'shipping' version, I can get connections for
>>>>> both wlan0 with wpa_suppolicant and ap0 with hostapd, but the ap0
>>>>> connection is flaky without any connection on wlan0. And I cannot
>>>>> sustain both connections at all. This 'latest' firmware is required
>>>>> for a sustainable, reliable ap0 with connection with hostapd.
>>>>>
>>>>> this is the firmware required:
>>>>> [    3.658201] brcmfmac: brcmf_fw_alloc_request: using
>>>>> brcm/brcmfmac43455-sdio for chip BCM4345/6
>>>>> [    3.660643] usbcore: registered new interface driver brcmfmac
>>>>> [    4.041524] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
>>>>> available (err=-2)
>>>>> [    4.042269] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
>>>>> wl0: Oct 28 2024 23:27:00 version 7.45.286 (be70ab3 CY) FWID
>>>>> 01-95efe7fa
>>>>>
>>>>> The only annoyance I get is that the log fills up with failed scan messages:
>>>>> May 07 08:43:11 deskrune wpa_supplicant[604]: wlan0: Failed to
>>>>> initiate sched scan
>>>>
>>>> The scheduled scan is basically a scan offload in which user-space tells
>>>> the driver what to look for and how often (hence scheduled). The
>>>> advantage of the scheduled scan is that the host (RPi) goes to sleep
>>>> while the wifi chip is on the lookout for the ssid. No idea why it is
>>>> failing though.
>>>>
>>>>> the Pi still works and is scanning because when a known ssid appears,
>>>>> it immediately connects, so it is scanning, I just get this message.
>>>>
>>>> What I recall from wpa_supplicant behavior is that it does a regular
>>>> scan for a configured ssid and after a number of attempts it does try to
>>>> setup a scheduled scan if the driver supports it. When it fails it
>>>> simply continues with the regular scans. The brcmfmac driver supports
>>>> scheduled scan so it seems like regression although apart from the log
>>>> message the end-user is not really affected. I expect it will not make
>>>> much noticable difference on the energy bill. ;-)
>>>>
>>>>> Now that I have this working well with wpa_supplicant and know how to
>>>>> get it all 'up' and stable, I will start investigating what
>>>>> differences there are with iwd and why it is flaky. Please guide me as
>>>>> to the best way to do this.
>>>>
>>>> Were you successful using nlmon. I suspect differences should show up
>>>> between wpa_supplicant and iwd.
>>>>
>>>> Regards,
>>>> Arend
>>>
>>> I will use nlmon and see what the difference is. Will post them when I get 
>>> them.
>>>
>>> Keith
>>
>> This is an iwmon log showing the hostapd up then a connection from my
>> laptop then a wpa_supplicant connection to my phone acting as a hot
>> spot.
>>
>> https://drive.google.com/file/d/12NhxYT-gF0K2NrBfYEpSvcuGQ6UyejQD/view?usp=sharing
>>
>> This is an iwmon log showing the same activities, but with iwd
>> managing the ap. The laptop connecting, then connecting to the phone
>> as a hot spot. Both disconnected. and passed no data.
>>
>> https://drive.google.com/file/d/1diSp32FXpHjLzQeC5gF-tlNNHji8a1l5/view?usp=sharing
>>
>> I do not know how to read these, but hopefully they will provide some guidance.
>>
>> Keith
>
> Playing with this setup a bit more. It seems that my setup of creating
> ap0 and running hostapd on it and setting up wpa_supplicant@wlan0 to
> run the wlan0 and using wpa_cli is more solid than it has even been. I
> can have both interfaces active for a while. I am connected to the RPi
> via ap0 from a laptop and wlan0 is connected to my phone as a hotspot
> and both interfaces stay up and are functional and pass data, at least
> initially. This stability is only apparent with the latest firmware,
> though. As long as there is no connection on wlan0 (regardless of
> wpa_supplicant scanning), the ap0 connection stays connected.
> Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
> (be70ab3 CY) FWID 01-95efe7fa
> With the shipping firmware (265), the interface is flaky and ap0 will
> go down almost immedaitely after connecting and I am unable to
> maintain both at the same time.
>
> With this setup, things work really well and the only strange thing I
> am getting is a 'failed scheduled scan' message in the log every ~6
> sec.
>
> May 09 08:53:50 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
> sched scan
> May 09 08:53:57 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
> sched scan
> May 09 08:54:03 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
> sched scan
> May 09 08:54:09 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
> sched scan
> May 09 08:54:16 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
> sched scan
> May 09 08:54:22 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
> sched scan

I thought wpa_supplicant had a config option to disable scheduled scan, but 
can not find it. You can disable it in brcmfmac using feature_disable=2 
modparam.

Regards,
Arend


