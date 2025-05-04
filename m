Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7713D2B2
	for <iwd@lists.linux.dev>; Sun,  4 May 2025 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746337895; cv=none; b=bW5+Pcczspijha03wfjvuUgXPPxmgrBSROoISBNyJOmn+/mv0a/zBmPNvSb2jiPSmFUfsep4VgxZgGEr2FipQGow1saRlrHdYVjpXm2k835z/S9qIeUNAMT0XwiB+nJZsg2aFE5FR6kaptHU+HcVqJGFfnmclUYkQjCTLexDK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746337895; c=relaxed/simple;
	bh=gzJOlBuqVDW/9zusZ+E3TkZ60fqbyTYdP6HTdW0mTdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bODdrDr7DRngvy1sVkIg9fAI3Cfh9TWzhCpo5VzWbEtDrE2oH+twon4Hd98XlbLvNlbiwfIDSURP/bNGMr97JSdOh++tdc8LOmoh76kBpHoU88Dir3+TjzGB5G7gwRca6cgyJ1IR3kG+9NEoFqVpzRJWsG8+j3hSJMW0mf1iAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M5W8OrDn; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M5W8OrDn"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso544255766b.3
        for <iwd@lists.linux.dev>; Sat, 03 May 2025 22:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746337891; x=1746942691; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wK9czZIzFXOCrEwv/B7Scv//SZadLPQj6rvIICVb58s=;
        b=M5W8OrDnU58tlnspDrQ0ixeZTZTiA7edg6RSalzq1TXO+2Ncrv+o4Ow9/kAsLX7NqP
         t2eN+Bcudcm+ms2TEeiW9GO4E7nJSogMUunnZ3Lh6g3Os3UgrBzwWgx8lbnx9DqrqLxE
         0JhBTEbwovgsSWmedmv7sELxv+Alevt5eYU9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746337891; x=1746942691;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK9czZIzFXOCrEwv/B7Scv//SZadLPQj6rvIICVb58s=;
        b=xR0F/bmdfCcdBwKmamAvwR7aIPl6CUoBBXafnk6V+6z/myHKSMQeluMc+h0HTxW3Yz
         ltXMI4PAZuGMA3ekq9wPVWGQgqwr3U9uliG40lMzsQ9FC/GIN7DExWeUIcdu4gRkkJGN
         0jwBo9uxmRS7UivWPfqaDlWyaXwzLzdjNN736sVZG6F0JB10CRciOtwaW0g3JW1o6L3D
         kRsvqU2ef4OmpMhrqQtMD68HRuiGwl6Zy10dTyzgREN6kDd9bZg26389rXuZgfd7N59T
         lehNXhueMUXP0wYVjbPgSla/TewBcNvS3NDIB9M+UXB8s/fNgGdN4F1PvaOaUW/tHi9i
         S0Ag==
X-Forwarded-Encrypted: i=1; AJvYcCU2K2VpX25SN9EySvp7j1ZERXbkPDAtj/ju3kKbpuKi+Qasw3/ffWXKmw//Y9oplLUx0k8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzRx/qeOHepF/vn2Dy5NIJNyfeVyhqiHAdUvlPemYmoIJgFPPah
	yAeQyT6LvE3wrbHci5R8IDou0ziCGg2JM9pSNQru9cSEcKpXAoXGgG+fYq6phQ==
X-Gm-Gg: ASbGncuNzirU/W7NvlCIuOr7d7xayrzrTOzurZF1YIgrxKMoyQPG54mloplA6s4cPio
	Q91VNKAoYsrZA1npGqD/uMPHq8zt4g5EYXzZLt/PqrzSeI7Bvlt6rBb/iJrRoioKAWZKRinhPgZ
	ji5wMoTb6ujfKYKPs6/w7Yfk4Zs8FomJTUxrOjFKU1Rc1N4QT3jz8fj3uLnFNUqikoptBSjbFKQ
	FJJh9/tMID3N7+UlIcvma1RpUf1r1QUfVTonp5ognqYHrDwHLtsaeM3xMB55pge2paTvXDVNRja
	l6J49rgKEnXIhf8Ie/5D/1vEZgS5Mw4AaUwUgFiDl4qBRz6/t3QpZ8yFZs9fI/ARNukTkaaTAo+
	XQGFfd1wiE+r3TNAI
X-Google-Smtp-Source: AGHT+IHttJNZNHDNHtWQEICFzAk2YheUaZbUjN/pw7kCFsvONt/BiJS/664yxSxvxTYozdetep42Hw==
X-Received: by 2002:a17:907:97c7:b0:aca:d52d:b59b with SMTP id a640c23a62f3a-ad19084ec5fmr430256666b.47.1746337890781;
        Sat, 03 May 2025 22:51:30 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891f3c60sm285598766b.80.2025.05.03.22.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 May 2025 22:51:30 -0700 (PDT)
Message-ID: <1fb12821-1707-4478-941b-9fbc007c4e9a@broadcom.com>
Date: Sun, 4 May 2025 07:51:28 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac disconnects when iwd scans
To: KeithG <ys3al35l@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev,
 James Prestwood <prestwoj@gmail.com>
References: <CAG17S_M4_+CR1uSsajyvHBjig6cfCuxegipnHREhk1sXjSyOsA@mail.gmail.com>
 <a0dcf03d-3bd3-43e5-9532-5a565d20930f@gmail.com>
 <CAG17S_MKZXf3vC0zgaK_MUrA1nqRzhGcPGUho873KU3jYVShXw@mail.gmail.com>
 <45bc2f1b-b037-4784-a2a9-7732a82b7391@gmail.com>
 <CAG17S_MqLBQV6ktjbWsoAv0e+2A0dnNN5+X7Pf+b-qDP3mrL1Q@mail.gmail.com>
 <19691dcb210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_MX3S9=EmiHBae8WsRnmsUGBJ5h4d8kCmgdxYZ2Zaeh8Q@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAG17S_MX3S9=EmiHBae8WsRnmsUGBJ5h4d8kCmgdxYZ2Zaeh8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/3/2025 1:43 AM, KeithG wrote:
> On Fri, May 2, 2025 at 11:38 AM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> On May 2, 2025 6:10:35 PM KeithG <ys3al35l@gmail.com> wrote:
>>
>>> On Fri, May 2, 2025 at 9:45 AM Denis Kenzior <denkenz@gmail.com> wrote:
>>>>
>>>> Hi Keith,
>>>>
>>>>> I am building iwd from git with those 3 patches and every time it
>>>>> scans, it disconnects the AP.
>>>>> When I use wpa_supplicant, it does not disconnect regardless of using:
>>>>> iw wlan0 scan passive
>>>>> or
>>>>> iw wlan0 scan
>>>>>
>>>>> it is only with iwd that it disconnects and only with iwctl. If I run
>>>>> 'iw wlan0 scan passive' or
>>>>> 'iw wlan0 scan' when iwd is running and wpa_aupplicant is removed, It
>>>>> seems to be OK.
>>>>> My laptop shows a disconnect, sometimes, but when I check the wlan0 on
>>>>> the laptop
>>>>> it is still connected to the ap running on the RPi. I think it looses
>>>>> the connection for a
>>>>> second but reconnects. If I run the 'iwctl station wlan0 scan' it will
>>>>> disconnect and not reconnect.
>>>>> When it does, the ap0 gets to a strange state as it takes a number of
>>>>> attempts to get it to
>>>>> reconnect and sometimes it requires a tear down and restart of ap0
>>>>> before I can reconnect
>>>>>
>>>>> This is an iwmon log of my RPi.
>>>>> https://drive.google.com/file/d/1WNZz0dOip0XZZVIOs7RGcYIeLY2W4bXC/view?usp=sharing
>>>>> I had connected to it from my laptop. I then ran:
>>>>>
>>>>> # iw wlan0 scan
>>>>> # iw wlan0 scan passive
>>>>> # iwctl station wlan0 scan
>>>>>
>>>>> after I ran the last command, the Pi's ap0 disconnected from my laptop.
>>>>
>>>> I do indeed see the local AP interface generating 'Del Station' events, which
>>>> means the local client was disconnected.  The funny part is that iwd ends up
>>>> scanning a subset of the frequencies triggered via 'iw', it just does it in two
>>>> sets.
>>>>
>>>> Here's what I see iw doing:
>>>>
>>>> < Request: Trigger Scan (0x21) len 16 [ack]                           22.190542
>>>> Interface Index: 3 (0x00000003)
>>>> Scan Flags: Mask: 0x00004000 len 4
>>>>      Colocated6G
>>>>> Event: Trigger Scan (0x21) len 364                                  22.194336
>>>> Wiphy: 0 (0x00000000)
>>>> Interface Index: 3 (0x00000003)
>>>> Wireless Device: 1 (0x0000000000000001)
>>>> Scan SSIDs: len 0
>>>> Scan Frequencies: len 320
>>>> 0: 2412 (0x0000096c)
>>>> 1: 2417 (0x00000971)
>>>> 2: 2422 (0x00000976)
>>>> 3: 2427 (0x0000097b)
>>>> 4: 2432 (0x00000980)
>>>> 5: 2437 (0x00000985)
>>>> 6: 2442 (0x0000098a)
>>>> 7: 2447 (0x0000098f)
>>>> 8: 2452 (0x00000994)
>>>> 9: 2457 (0x00000999)
>>>> 10: 2462 (0x0000099e)
>>>> 11: 5170 (0x00001432)
>>>> 12: 5180 (0x0000143c)
>>>> 13: 5190 (0x00001446)
>>>> 14: 5200 (0x00001450)
>>>> 15: 5210 (0x0000145a)
>>>> 16: 5220 (0x00001464)
>>>> 17: 5230 (0x0000146e)
>>>> 18: 5240 (0x00001478)
>>>> 19: 5260 (0x0000148c)
>>>> 20: 5280 (0x000014a0)
>>>> 21: 5300 (0x000014b4)
>>>> 22: 5320 (0x000014c8)
>>>> 23: 5500 (0x0000157c)
>>>> 24: 5520 (0x00001590)
>>>> 25: 5540 (0x000015a4)
>>>> 26: 5560 (0x000015b8)
>>>> 27: 5580 (0x000015cc)
>>>> 28: 5600 (0x000015e0)
>>>> 29: 5620 (0x000015f4)
>>>> 30: 5640 (0x00001608)
>>>> 31: 5660 (0x0000161c)
>>>> 32: 5680 (0x00001630)
>>>> 33: 5700 (0x00001644)
>>>> 34: 5720 (0x00001658)
>>>> 35: 5745 (0x00001671)
>>>> 36: 5765 (0x00001685)
>>>> 37: 5785 (0x00001699)
>>>> 38: 5805 (0x000016ad)
>>>> 39: 5825 (0x000016c1)
>>>> Scan Flags: Mask: 0x00004000 len 4
>>>>      Colocated6G
>>>>
>>>> While iwd does:
>>>> < Request: Trigger Scan (0x21) len 64 [ack]                           31.619536
>>>> Wireless Device: 1 (0x0000000000000001)
>>>> Information Elements: len 12
>>>> Extended Capabilities: len 10
>>>>      Capability: bit 19: BSS transition
>>>>      00 00 08 00 00 00 00 00 00 01                    ..........
>>>> Scan Frequencies: len 24
>>>> 0: 2412 (0x0000096c)
>>>> 1: 2437 (0x00000985)
>>>> 2: 2462 (0x0000099e)
>>>> Scan Flags: Mask: 0x00004002 len 4
>>>>      Flush
>>>>      Colocated6G
>>>>
>>>> then
>>>> < Request: Trigger Scan (0x21) len 248 [ack]                          32.040780
>>>> Wireless Device: 1 (0x0000000000000001)
>>>> Information Elements: len 12
>>>> Extended Capabilities: len 10
>>>>      Capability: bit 19: BSS transition
>>>>      00 00 08 00 00 00 00 00 00 01                    ..........
>>>> Scan Frequencies: len 208
>>>> 0: 5180 (0x0000143c)
>>>> 1: 5200 (0x00001450)
>>>> 2: 5210 (0x0000145a)
>>>> 3: 5220 (0x00001464)
>>>> 4: 5240 (0x00001478)
>>>> 5: 5260 (0x0000148c)
>>>> 6: 5280 (0x000014a0)
>>>> 7: 5300 (0x000014b4)
>>>> 8: 5320 (0x000014c8)
>>>> 9: 5500 (0x0000157c)
>>>> 10: 5520 (0x00001590)
>>>> 11: 5540 (0x000015a4)
>>>> 12: 5560 (0x000015b8)
>>>> 13: 5580 (0x000015cc)
>>>> 14: 5600 (0x000015e0)
>>>> 15: 5620 (0x000015f4)
>>>> 16: 5640 (0x00001608)
>>>> 17: 5660 (0x0000161c)
>>>> 18: 5680 (0x00001630)
>>>> 19: 5700 (0x00001644)
>>>> 20: 5720 (0x00001658)
>>>> 21: 5745 (0x00001671)
>>>> 22: 5765 (0x00001685)
>>>> 23: 5785 (0x00001699)
>>>> 24: 5805 (0x000016ad)
>>>> 25: 5825 (0x000016c1)
>>>> Scan Flags: Mask: 0x00004002 len 4
>>>>      Flush
>>>>      Colocated6G
>>>>
>>>> And about 1.5 seconds later the Del Station event comes in.
>>>>> Event: Del Station (0x14) len 32                                    33.560662
>>>> Interface Index: 7 (0x00000007)
>>>> MAC Address 50:84:92:A6:7A:7A
>>>> Generation: 0 (0x00000000)
>>>> Station Info: len 0
>>>>
>>>> Not really sure what could be causing this.  Maybe this is a question for
>>>> Arend?
>>>>
>>>> Regards,
>>>> -Denis
>>>
>>> Denis,
>>>
>>> Thanks for going through this. I am still trying to get more pertinent
>>> information as to what may cause these disconnects. If there is
>>> anything I can test or more info I can provide, let me know. As it is,
>>> I am trying to set up hostapd/wpa_supplicant to see if it is any more
>>> stable.
>>
>> So is this thread in any way related to the thread with subject "Cannot
>> maintain an ap with brcmfmac"? I responded to that on April 21, but never
>> saw any follow-up on that. It's kinda hard to debug by email especially
>> when new threads are started in parallel. More than willing to help but a
>> bit lost in the woods here.
>>
>> Regards,
>> Arend
>>
> Arend,
> 
> Sorry about that, Yes it is the same. I stopped responding to that
> thread as it seemed to me to be be an IWD issue and not a
> wpa_supplicant/hostapd/firmware/driver issue that I was running into.
> It still may be, but I thought I'd investigate iwd first. I composed a
> whole response, but then noticed that it seemed more stable with
> wpa_supplicant than iwd and did not want to exercise everyone (you).

No problem. Glad we have it clarified. With user-space and kernel driver 
interacting it is good to keep both sides in the loop and stick with a 
single email thread.

> my next steps are to reconfigure everything with just
> hostapd/wpa_supplicant and see if it is any more stable. If so, then
> look to see if I can characterize how it behaves differently with iwd
> than wpa_supplicant.

You could try without encryption if that is possible to see if that 
makes a difference. Also would help if you enabled CONFIG_BRCMDBG for 
the brcmfmac driver so you can enble additional debug prints by passing 
the 'debug' module parameter. CONN, EVENT, and FIL debug levels are good 
to have and maybe SCAN => debug=0xd400.

> What we want is to be able to use the single WiFi chip with 2
> interfaces, one as the default alan0 and one as ap0 . Have it scan
> automatically on wlan0 while ap0 is up and advertising if not
> connected. If the scan shows a 'known network', tear down off the ap0,
> stop hostapd and initiate a connection to the SSID on the wlan0. We
> create the ap0 via these commands:

Okay. That sounds a bit peculiar. So what is the idea here. When it is 
not connected and running ap0 clients can connect to it and then what? 
Is the use-case here that those client can setup 'known networks'? 
Anyways, you have your reasons and leave it with that.

> iw dev wlan0 interface add ap0 type __ap
> ip link set dev ap0 address '$some_MAC'
> ip link set dev ap0 up

Would it be sufficient to only create the ap0 interface and leave the 
rest to hostapd/iwd. I am pretty sure hostapd does take care of those steps.

Regards,
Arend
