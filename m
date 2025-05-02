Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C522E3FD
	for <iwd@lists.linux.dev>; Fri,  2 May 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746203889; cv=none; b=P0P2/w4Mlwh0wwdsCrw7z1DKUO53ICBYiSY7iZE8y2lMk+qIaKHuAbShNUEuIQkFgVJtmfLVa6BH6m3ZO0mtbDRkDUjhaANS0KRApmd6bxsRT8X5PVM3F2/WMviEeXxAC4fzW6s1pnQiUlXo6TfMazKUmZp8bKhsZHZiIO6hcH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746203889; c=relaxed/simple;
	bh=svlxKBhkYi4K7lOTChTD8pwx11ZK+XPbKV3UoKiquDg=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ORPjvFxM84LpLZqvEv2Pw1Zwcw4fBY16RxKtPELuInE7oHzYF3+7nD7SRp6KPDnVnWAWv+d3KDH3AODRbw7qEJm52Z+5NULUnHVqe05BxlOtCZvuO68f8/OSR+GKiGIw1JBsn2cW/Wi1jE+WOKqvWXiJHwt5Xgot4Nwog0htFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OQGcKJs4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OQGcKJs4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736a7e126c7so2231911b3a.3
        for <iwd@lists.linux.dev>; Fri, 02 May 2025 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746203887; x=1746808687; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=di2eyHKuvMHOWqsympFKOhc3Fi6ZrgugLM1y2jTTpsQ=;
        b=OQGcKJs47KxGNtxMChgVDYxGfd9pCm6O4R72B10OiIjH4Ukps8g1ix3hL/FfNnSQMr
         2+jHC9zG0p5y8FBI9SCwDsshCNp9gvbuY1xvJOZe5QkUyl26+Ct7JRuENhYDDo6ZV35p
         K3n2TNxoMlwgNX4hB41ET+OzuaU70DEGEp8YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746203887; x=1746808687;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=di2eyHKuvMHOWqsympFKOhc3Fi6ZrgugLM1y2jTTpsQ=;
        b=IN2PU3FKFXV1vhha4EYaES6IK2SAag3kRIlyC5qTiW0LQRig4J4U+XRlFdeIkU2oRI
         s6pgxggRdh1OHh7KO9k6/+iMczq9dzUniec89WzQHh6QMWGF/fIqUG9JEz0ZA06yJdZJ
         bLwguxYj0P6VGROUmGjDRz12WM2eOxtkkmojvsttR2zdeW/Lik+3w3g54xn2tqkwdc/p
         CL9W5BNbwj3FAkk7WqUdNYGtJEzkcvf0ZfC4jwVEfpE6/SbE5mxvA+rm0oEQ7bI3B3CV
         RH2O7KOpiktpmgE4fYn2x839Lq0TCBNjd6iNpRAz9yfvtFkHV+PuxaKcxJQ9+YkwAVHJ
         bGXg==
X-Gm-Message-State: AOJu0Yzy2H8P1Sq+FycGBK1FdX+Rzsb/mC1pqeXL+ID/T/BbJd+s8FDT
	oLRvCSSUAlpT8h5Vp3xbVH/CrTTz4RL9caS778JjRQY4ncNt98XeIbYBDwFj6g==
X-Gm-Gg: ASbGncuX9sPTrGjVmjf5RKD5fk01RGFT29Kto4e8zcx2oJce92PDuGVcHVWQ/ALf+n6
	7cOi2H6+p4tT3ayA9hdres5NIjkl7s28I8w6vloMKAxlBB20/U0/H/+XCkvnNiXRRVfzNzQxSCp
	ruUG4PMcxBhaKRkiRizLJLW/RGgtNyW4RuLMUK8Y6yVUOvWUbxbl9jmACsDNnxjH1uQ1wtmQ17i
	jD0EAd9qBRYYygFzz9jFHRxPKtFcjGLJa402Swta+SL0qTSbVm1KfK5vSzBJRnplBcLbNGT2KeQ
	Gbw4u0YxQBRjO1HTfw5jQ8jnd2lpneSdgju6ln53QOLSVCati7s/xwhtYwIFo+XU7P1IWcpwOcK
	7aBk=
X-Google-Smtp-Source: AGHT+IF4a8y8WJDEzC4QxcHLIy9jRZmVnGwF3iA/dxPx/Joj+8jxNmn2PIRdKeNwyBgG52eylIYUjA==
X-Received: by 2002:a05:6a20:2d20:b0:1f5:7710:fd18 with SMTP id adf61e73a8af0-20cde95193amr4702118637.17.1746203886672;
        Fri, 02 May 2025 09:38:06 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590a489asm1850026b3a.170.2025.05.02.09.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 09:38:06 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: KeithG <ys3al35l@gmail.com>, Denis Kenzior <denkenz@gmail.com>
CC: <iwd@lists.linux.dev>, James Prestwood <prestwoj@gmail.com>
Date: Fri, 02 May 2025 18:38:03 +0200
Message-ID: <19691dcb210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAG17S_MqLBQV6ktjbWsoAv0e+2A0dnNN5+X7Pf+b-qDP3mrL1Q@mail.gmail.com>
References: <CAG17S_M4_+CR1uSsajyvHBjig6cfCuxegipnHREhk1sXjSyOsA@mail.gmail.com>
 <a0dcf03d-3bd3-43e5-9532-5a565d20930f@gmail.com>
 <CAG17S_MKZXf3vC0zgaK_MUrA1nqRzhGcPGUho873KU3jYVShXw@mail.gmail.com>
 <45bc2f1b-b037-4784-a2a9-7732a82b7391@gmail.com>
 <CAG17S_MqLBQV6ktjbWsoAv0e+2A0dnNN5+X7Pf+b-qDP3mrL1Q@mail.gmail.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: brcmfmac disconnects when iwd scans
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On May 2, 2025 6:10:35 PM KeithG <ys3al35l@gmail.com> wrote:

> On Fri, May 2, 2025 at 9:45 AM Denis Kenzior <denkenz@gmail.com> wrote:
>>
>> Hi Keith,
>>
>>> I am building iwd from git with those 3 patches and every time it
>>> scans, it disconnects the AP.
>>> When I use wpa_supplicant, it does not disconnect regardless of using:
>>> iw wlan0 scan passive
>>> or
>>> iw wlan0 scan
>>>
>>> it is only with iwd that it disconnects and only with iwctl. If I run
>>> 'iw wlan0 scan passive' or
>>> 'iw wlan0 scan' when iwd is running and wpa_aupplicant is removed, It
>>> seems to be OK.
>>> My laptop shows a disconnect, sometimes, but when I check the wlan0 on
>>> the laptop
>>> it is still connected to the ap running on the RPi. I think it looses
>>> the connection for a
>>> second but reconnects. If I run the 'iwctl station wlan0 scan' it will
>>> disconnect and not reconnect.
>>> When it does, the ap0 gets to a strange state as it takes a number of
>>> attempts to get it to
>>> reconnect and sometimes it requires a tear down and restart of ap0
>>> before I can reconnect
>>>
>>> This is an iwmon log of my RPi.
>>> https://drive.google.com/file/d/1WNZz0dOip0XZZVIOs7RGcYIeLY2W4bXC/view?usp=sharing
>>> I had connected to it from my laptop. I then ran:
>>>
>>> # iw wlan0 scan
>>> # iw wlan0 scan passive
>>> # iwctl station wlan0 scan
>>>
>>> after I ran the last command, the Pi's ap0 disconnected from my laptop.
>>
>> I do indeed see the local AP interface generating 'Del Station' events, which
>> means the local client was disconnected.  The funny part is that iwd ends up
>> scanning a subset of the frequencies triggered via 'iw', it just does it in two
>> sets.
>>
>> Here's what I see iw doing:
>>
>> < Request: Trigger Scan (0x21) len 16 [ack]                           22.190542
>> Interface Index: 3 (0x00000003)
>> Scan Flags: Mask: 0x00004000 len 4
>>     Colocated6G
>>> Event: Trigger Scan (0x21) len 364                                  22.194336
>> Wiphy: 0 (0x00000000)
>> Interface Index: 3 (0x00000003)
>> Wireless Device: 1 (0x0000000000000001)
>> Scan SSIDs: len 0
>> Scan Frequencies: len 320
>> 0: 2412 (0x0000096c)
>> 1: 2417 (0x00000971)
>> 2: 2422 (0x00000976)
>> 3: 2427 (0x0000097b)
>> 4: 2432 (0x00000980)
>> 5: 2437 (0x00000985)
>> 6: 2442 (0x0000098a)
>> 7: 2447 (0x0000098f)
>> 8: 2452 (0x00000994)
>> 9: 2457 (0x00000999)
>> 10: 2462 (0x0000099e)
>> 11: 5170 (0x00001432)
>> 12: 5180 (0x0000143c)
>> 13: 5190 (0x00001446)
>> 14: 5200 (0x00001450)
>> 15: 5210 (0x0000145a)
>> 16: 5220 (0x00001464)
>> 17: 5230 (0x0000146e)
>> 18: 5240 (0x00001478)
>> 19: 5260 (0x0000148c)
>> 20: 5280 (0x000014a0)
>> 21: 5300 (0x000014b4)
>> 22: 5320 (0x000014c8)
>> 23: 5500 (0x0000157c)
>> 24: 5520 (0x00001590)
>> 25: 5540 (0x000015a4)
>> 26: 5560 (0x000015b8)
>> 27: 5580 (0x000015cc)
>> 28: 5600 (0x000015e0)
>> 29: 5620 (0x000015f4)
>> 30: 5640 (0x00001608)
>> 31: 5660 (0x0000161c)
>> 32: 5680 (0x00001630)
>> 33: 5700 (0x00001644)
>> 34: 5720 (0x00001658)
>> 35: 5745 (0x00001671)
>> 36: 5765 (0x00001685)
>> 37: 5785 (0x00001699)
>> 38: 5805 (0x000016ad)
>> 39: 5825 (0x000016c1)
>> Scan Flags: Mask: 0x00004000 len 4
>>     Colocated6G
>>
>> While iwd does:
>> < Request: Trigger Scan (0x21) len 64 [ack]                           31.619536
>> Wireless Device: 1 (0x0000000000000001)
>> Information Elements: len 12
>> Extended Capabilities: len 10
>>     Capability: bit 19: BSS transition
>>     00 00 08 00 00 00 00 00 00 01                    ..........
>> Scan Frequencies: len 24
>> 0: 2412 (0x0000096c)
>> 1: 2437 (0x00000985)
>> 2: 2462 (0x0000099e)
>> Scan Flags: Mask: 0x00004002 len 4
>>     Flush
>>     Colocated6G
>>
>> then
>> < Request: Trigger Scan (0x21) len 248 [ack]                          32.040780
>> Wireless Device: 1 (0x0000000000000001)
>> Information Elements: len 12
>> Extended Capabilities: len 10
>>     Capability: bit 19: BSS transition
>>     00 00 08 00 00 00 00 00 00 01                    ..........
>> Scan Frequencies: len 208
>> 0: 5180 (0x0000143c)
>> 1: 5200 (0x00001450)
>> 2: 5210 (0x0000145a)
>> 3: 5220 (0x00001464)
>> 4: 5240 (0x00001478)
>> 5: 5260 (0x0000148c)
>> 6: 5280 (0x000014a0)
>> 7: 5300 (0x000014b4)
>> 8: 5320 (0x000014c8)
>> 9: 5500 (0x0000157c)
>> 10: 5520 (0x00001590)
>> 11: 5540 (0x000015a4)
>> 12: 5560 (0x000015b8)
>> 13: 5580 (0x000015cc)
>> 14: 5600 (0x000015e0)
>> 15: 5620 (0x000015f4)
>> 16: 5640 (0x00001608)
>> 17: 5660 (0x0000161c)
>> 18: 5680 (0x00001630)
>> 19: 5700 (0x00001644)
>> 20: 5720 (0x00001658)
>> 21: 5745 (0x00001671)
>> 22: 5765 (0x00001685)
>> 23: 5785 (0x00001699)
>> 24: 5805 (0x000016ad)
>> 25: 5825 (0x000016c1)
>> Scan Flags: Mask: 0x00004002 len 4
>>     Flush
>>     Colocated6G
>>
>> And about 1.5 seconds later the Del Station event comes in.
>>> Event: Del Station (0x14) len 32                                    33.560662
>> Interface Index: 7 (0x00000007)
>> MAC Address 50:84:92:A6:7A:7A
>> Generation: 0 (0x00000000)
>> Station Info: len 0
>>
>> Not really sure what could be causing this.  Maybe this is a question for 
>> Arend?
>>
>> Regards,
>> -Denis
>
> Denis,
>
> Thanks for going through this. I am still trying to get more pertinent
> information as to what may cause these disconnects. If there is
> anything I can test or more info I can provide, let me know. As it is,
> I am trying to set up hostapd/wpa_supplicant to see if it is any more
> stable.

So is this thread in any way related to the thread with subject "Cannot 
maintain an ap with brcmfmac"? I responded to that on April 21, but never 
saw any follow-up on that. It's kinda hard to debug by email especially 
when new threads are started in parallel. More than willing to help but a 
bit lost in the woods here.

Regards,
Arend



