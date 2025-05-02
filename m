Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FD035950
	for <iwd@lists.linux.dev>; Fri,  2 May 2025 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746197155; cv=none; b=WCpxWeyosmDXXtGTvfh8J81hgqIH7j6XdQ3C+2gqMhdAJrR9yeKc+XXOz3aDKT+svrEtTdh8If+ZLzKXbIW7qn3XO2Gt5vh/gN7ON1dgHLmoF8I2sku2kZ/tp2aJk+c0e14HOMeCX6ehtPwY8UDslQBoeOFrKpIWQPNDGaAaX/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746197155; c=relaxed/simple;
	bh=obSo+HDuapebjKKeghFcYbPBOh9AwP53C0sRhJ1tzvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9C4IBLkZf6peh6LBbplx7UB1a0fU2njNyw56gl1VhPCHENqUpO13Bh9EDJnX56TVWuK481qOby7Z99D2cpmHHvCX/xNokyLq5wmMqoAbCzidw8WCUd7Y+cC2kdu22ZedHR/TE7lhKZAVLOt63TXb9GIwj2tg66bD33iHPiE9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqXiP6WW; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqXiP6WW"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3feaedb39e9so624865b6e.1
        for <iwd@lists.linux.dev>; Fri, 02 May 2025 07:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746197153; x=1746801953; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4N4GUU1MrHBZDSKj3vg88WA92E3QifFZwCcl8lMfOQ=;
        b=gqXiP6WWzMFPjhmBr/XvdkCutRcPahgGUb4SqfNxV5JUIg8sKgh8YD6mFWwgZj9ow4
         6QnwrslSFz8dcgIj9csLIX5ZeXTAwZ65p6OjSuKX8RkIFV006pC1ZmtBbPfN50S04OQd
         9LL5f5+sb/v2UNSRszkgb6HzC1M8nzYqh7k7FdteKkQN/EjSoWc7+TrX/jYw+M3Dh55T
         +Q7XQZw7e5QHg0oFiSeuk3QiIxnVQjEt8Qn7nY/2G29+WRtmp7FfsOpbVK1h0M9Yba6Q
         UgX5RDzLOrUwE4xFMz7GZhbJ1RPH1xt3E0F/ivRClc5nyV2Z0VO+rI1juLwoWnvZm/Rg
         NS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746197153; x=1746801953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4N4GUU1MrHBZDSKj3vg88WA92E3QifFZwCcl8lMfOQ=;
        b=boZhHwkLr5pnQuse7PWLKE0nScgH2RMEFDh+k6dlQrRKCGQ4YMwegE34bEGXv1dQjn
         fu09kEFBP1y8uXmm3fX4eCsyp08h6Xk5Li/SDlBV/UUV+suJIpQ3wfVBnuVndgnS6nkA
         P91n8ph68tRJ09HozeCML2Y228VP0ot3dcz7zRdOokM8GlbaOqe1A41sY7xjHcMxnwNo
         jL5iTRRzU4WxDhG/YRp6xaB3Cggs0BMLlxGRXoFhGZSg2IQPqht70ombiEjPd2eDnqN/
         hA9o5I0nQpA4AVHiC4n4Ed66yXZPDaQwydQL7grDT90AIwjYeakb2VFUfkbuirQsZl+H
         GQxg==
X-Gm-Message-State: AOJu0Yzey8JFP/m6oljpfUKVzTBxFWYAg5hFAvUZoo2pORHy9XJxTbkT
	pwOitGJcdASbiPjz1aHSWiY+BGth5lvloGsI8psup6OUqpFB7f77
X-Gm-Gg: ASbGnctKpg94klW0Ju7DLeOB61uxoj3UiTRk6l3Qbnvt4pxHXuBrc+12J/sHASO6IKG
	0XsmdS8ikZSadCrLXi8OunU36mwMW+GxC/ZoMHzMsoC5pGZE+Q1P1neKsIi0ps3uPqsRiCgWFbU
	Yx5t8I5sukFEWI+/AzpNyidtQYqxL4NrEFIDYw4w8UwJZVzwD7D8Si88WInxlYoAIkiFCx2Hd3E
	yxRothWcrrgiVdPdoY5XoMzZmm/u++qrPV1IGS2jr315X1coQeBs3Hevu/+6GDNM6QGLBFualOs
	aLMvrO79fE6ZDKXRzBzqMTTINAD5KlK2nL5m93uZVmXBf6YvYL4WFMRZvXY0N1vomH58ZUll8Au
	Jv5exhQ==
X-Google-Smtp-Source: AGHT+IEnlZ+n83D3V7wzYeB/zUWh4hc1SfdjdlBd0Rr3JRsVXYjfUo1A6+eLhLJ2k0Cd/Vp6bBBXUw==
X-Received: by 2002:a05:6808:90:b0:3fe:aeaf:2d3 with SMTP id 5614622812f47-403414c3561mr1712365b6e.39.1746197153161;
        Fri, 02 May 2025 07:45:53 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-607e7fb645bsm550480eaf.28.2025.05.02.07.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 07:45:52 -0700 (PDT)
Message-ID: <45bc2f1b-b037-4784-a2a9-7732a82b7391@gmail.com>
Date: Fri, 2 May 2025 09:45:51 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac disconnects when iwd scans
To: KeithG <ys3al35l@gmail.com>
Cc: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>
References: <CAG17S_M4_+CR1uSsajyvHBjig6cfCuxegipnHREhk1sXjSyOsA@mail.gmail.com>
 <a0dcf03d-3bd3-43e5-9532-5a565d20930f@gmail.com>
 <CAG17S_MKZXf3vC0zgaK_MUrA1nqRzhGcPGUho873KU3jYVShXw@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_MKZXf3vC0zgaK_MUrA1nqRzhGcPGUho873KU3jYVShXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

 > I am building iwd from git with those 3 patches and every time it
> scans, it disconnects the AP.
> When I use wpa_supplicant, it does not disconnect regardless of using:
> iw wlan0 scan passive
> or
> iw wlan0 scan
> 
> it is only with iwd that it disconnects and only with iwctl. If I run
> 'iw wlan0 scan passive' or
> 'iw wlan0 scan' when iwd is running and wpa_aupplicant is removed, It
> seems to be OK.
> My laptop shows a disconnect, sometimes, but when I check the wlan0 on
> the laptop
> it is still connected to the ap running on the RPi. I think it looses
> the connection for a
> second but reconnects. If I run the 'iwctl station wlan0 scan' it will
> disconnect and not reconnect.
> When it does, the ap0 gets to a strange state as it takes a number of
> attempts to get it to
> reconnect and sometimes it requires a tear down and restart of ap0
> before I can reconnect
> 
> This is an iwmon log of my RPi.
> https://drive.google.com/file/d/1WNZz0dOip0XZZVIOs7RGcYIeLY2W4bXC/view?usp=sharing
> I had connected to it from my laptop. I then ran:
> 
> # iw wlan0 scan
> # iw wlan0 scan passive
> # iwctl station wlan0 scan
> 
> after I ran the last command, the Pi's ap0 disconnected from my laptop.

I do indeed see the local AP interface generating 'Del Station' events, which 
means the local client was disconnected.  The funny part is that iwd ends up 
scanning a subset of the frequencies triggered via 'iw', it just does it in two 
sets.

Here's what I see iw doing:

< Request: Trigger Scan (0x21) len 16 [ack]                           22.190542
     Interface Index: 3 (0x00000003)
     Scan Flags: Mask: 0x00004000 len 4
             Colocated6G
 > Event: Trigger Scan (0x21) len 364                                  22.194336
     Wiphy: 0 (0x00000000)
     Interface Index: 3 (0x00000003)
     Wireless Device: 1 (0x0000000000000001)
     Scan SSIDs: len 0
     Scan Frequencies: len 320
         0: 2412 (0x0000096c)
         1: 2417 (0x00000971)
         2: 2422 (0x00000976)
         3: 2427 (0x0000097b)
         4: 2432 (0x00000980)
         5: 2437 (0x00000985)
         6: 2442 (0x0000098a)
         7: 2447 (0x0000098f)
         8: 2452 (0x00000994)
         9: 2457 (0x00000999)
         10: 2462 (0x0000099e)
         11: 5170 (0x00001432)
         12: 5180 (0x0000143c)
         13: 5190 (0x00001446)
         14: 5200 (0x00001450)
         15: 5210 (0x0000145a)
         16: 5220 (0x00001464)
         17: 5230 (0x0000146e)
         18: 5240 (0x00001478)
         19: 5260 (0x0000148c)
         20: 5280 (0x000014a0)
         21: 5300 (0x000014b4)
         22: 5320 (0x000014c8)
         23: 5500 (0x0000157c)
         24: 5520 (0x00001590)
         25: 5540 (0x000015a4)
         26: 5560 (0x000015b8)
         27: 5580 (0x000015cc)
         28: 5600 (0x000015e0)
         29: 5620 (0x000015f4)
         30: 5640 (0x00001608)
         31: 5660 (0x0000161c)
         32: 5680 (0x00001630)
         33: 5700 (0x00001644)
         34: 5720 (0x00001658)
         35: 5745 (0x00001671)
         36: 5765 (0x00001685)
         37: 5785 (0x00001699)
         38: 5805 (0x000016ad)
         39: 5825 (0x000016c1)
     Scan Flags: Mask: 0x00004000 len 4
             Colocated6G

While iwd does:
< Request: Trigger Scan (0x21) len 64 [ack]                           31.619536
     Wireless Device: 1 (0x0000000000000001)
     Information Elements: len 12
         Extended Capabilities: len 10
             Capability: bit 19: BSS transition
             00 00 08 00 00 00 00 00 00 01                    ..........
     Scan Frequencies: len 24
         0: 2412 (0x0000096c)
         1: 2437 (0x00000985)
         2: 2462 (0x0000099e)
     Scan Flags: Mask: 0x00004002 len 4
             Flush
             Colocated6G

then
< Request: Trigger Scan (0x21) len 248 [ack]                          32.040780
     Wireless Device: 1 (0x0000000000000001)
     Information Elements: len 12
         Extended Capabilities: len 10
             Capability: bit 19: BSS transition
             00 00 08 00 00 00 00 00 00 01                    ..........
     Scan Frequencies: len 208
         0: 5180 (0x0000143c)
         1: 5200 (0x00001450)
         2: 5210 (0x0000145a)
         3: 5220 (0x00001464)
         4: 5240 (0x00001478)
         5: 5260 (0x0000148c)
         6: 5280 (0x000014a0)
         7: 5300 (0x000014b4)
         8: 5320 (0x000014c8)
         9: 5500 (0x0000157c)
         10: 5520 (0x00001590)
         11: 5540 (0x000015a4)
         12: 5560 (0x000015b8)
         13: 5580 (0x000015cc)
         14: 5600 (0x000015e0)
         15: 5620 (0x000015f4)
         16: 5640 (0x00001608)
         17: 5660 (0x0000161c)
         18: 5680 (0x00001630)
         19: 5700 (0x00001644)
         20: 5720 (0x00001658)
         21: 5745 (0x00001671)
         22: 5765 (0x00001685)
         23: 5785 (0x00001699)
         24: 5805 (0x000016ad)
         25: 5825 (0x000016c1)
     Scan Flags: Mask: 0x00004002 len 4
             Flush
             Colocated6G

And about 1.5 seconds later the Del Station event comes in.
 > Event: Del Station (0x14) len 32                                    33.560662
     Interface Index: 7 (0x00000007)
     MAC Address 50:84:92:A6:7A:7A
     Generation: 0 (0x00000000)
     Station Info: len 0

Not really sure what could be causing this.  Maybe this is a question for Arend?

Regards,
-Denis

