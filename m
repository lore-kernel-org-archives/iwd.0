Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851A55E52
	for <iwd@lists.linux.dev>; Fri, 19 Jan 2024 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686295; cv=none; b=ohFU2R8OwIyCwMwRKLkhb/wzgteO0hIOMzvHpNskbPQJf6IS77seSZcdsla/2mNUCCq3y8VWTbmGJjmQ66n3ATZpyrcZ640nK1Q/7cB7yHSR//OugjG1fhK8jJqkM0HX0sJRWUjtNpGfisE7nOK/o0NqCy28R12rNYAhc8a1zzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686295; c=relaxed/simple;
	bh=ax2NAqhHBqLnk8hwo2WVnQ7aV8h1b3OLhK+7Ietxy1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIG6F0qlBQWsXfifhGdyI7KyKeKjyv20VqNYY/zeb8hr2QvBkLzwpKtMwfhcmv4zOit0HCH1hNyfVJuzFO51u1meqavd00Py1/ZzWhjcJ6CBKl9RPLMCz0hSSB8SFtcnsjkmoGZoZYSBc2WtQfRJVp2RC7avbgHDtd+L5JpCweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoGQ6nOl; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoGQ6nOl"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3608bd50cbeso4990595ab.3
        for <iwd@lists.linux.dev>; Fri, 19 Jan 2024 09:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705686293; x=1706291093; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+vYUEBMKbuFaYaK2VxfoDm3iALT87iBrWd6g00U310=;
        b=CoGQ6nOlIEWbihEDyKP4+8h7xyWoV5cSYKorWa713MXxC6DNtmRUYkTd+ElvHSTMPH
         GJ9vAtuiL3eor4s4kcU0gtvouK/iVGwzRCDu9WZWA4Ys394eRAc683TeS83cknD1u0L/
         0GBW0JRvnUd3yyoItK1eUwktEKM5hZ2/9xkWpxX7KeWz3EuWAQhhxP1KxOBmjwILi+Ij
         g61hPuAcH6Wd3nbmdRK9FdJA6LsIXlax/F4eZRV2cLVXePvquKR3n6MUq/XI/GRliQ44
         o4tozln21Tka8xsjPfuw6/+XbVazQYsWU9ocRsvk8qFcQeTIkx4XOv+llsmNxZZcYiQZ
         F3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705686293; x=1706291093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+vYUEBMKbuFaYaK2VxfoDm3iALT87iBrWd6g00U310=;
        b=rkpG1YMwg+7UD70H/C0ss0m+Z7PQL35GbiNe9iYPSOQNOAQrnyrp9/VTzghjMZUFgU
         7M4dPlFRE785/KM+kEcCID+yryoEr2uFFc/IXfjFc3a/x7hfaMkt92OuMBvySE+CLVmW
         nNhbbCd0JPX6YV7I6ylPrf7rb/+8m4x8uOQbupZDGYuQII5uHxdK4ZGcyqUlOMdyz/A1
         CI5vZp0p4oYliH5tpUdqyBnnA4rqmjGLILiqKweIRN5bEtOO2wsOHGaCpVdSUdjaBLV6
         oSg6IXGRHiyVDklCmb/4NFYgPjcJWQph9S08g/i3gk4w55OxIXR6T1TViOu5VKi1CiI7
         D27w==
X-Gm-Message-State: AOJu0Yy2sQuz2LHRMQHGIc3tCmFuavZ/8cz4xnASLaQqMB+J+h7vf4zb
	5w/qA28n80hYF+q2ratiW3yPPJpzyOo9LP+F8iaQiurEOARUtf2p
X-Google-Smtp-Source: AGHT+IHpHv175ImBZ1SO83fbF+jbXa2WntF9bDW5secCEyyJ/5wK2kRkFVhNiZS0zb0P19djyG/4tw==
X-Received: by 2002:a92:ce86:0:b0:360:8c80:bef0 with SMTP id r6-20020a92ce86000000b003608c80bef0mr203397ilo.56.1705686293036;
        Fri, 19 Jan 2024 09:44:53 -0800 (PST)
Received: from [10.100.20.9] ([50.225.159.98])
        by smtp.gmail.com with ESMTPSA id bs18-20020a056e02241200b00361ac393e61sm423526ilb.75.2024.01.19.09.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 09:44:52 -0800 (PST)
Message-ID: <2f3e11c6-bcf8-43fc-82a1-afe836d37a2d@gmail.com>
Date: Fri, 19 Jan 2024 09:44:50 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Iwd: unable to start AP with NXP 88W9098 chipset
To: Joao Marcos Costa <joaomarcos.costa@bootlin.com>, iwd@lists.linux.dev
Cc: gregory.clement@bootlin.com, Salahaldeen.Altous@leica-camera.com
References: <6c9b05a2-7474-4eed-bb74-6f5de1d433ba@bootlin.com>
 <c11d1310-a0ca-46a2-b08e-d1e35351826a@gmail.com>
 <8c484950-c99d-47c0-b048-5a447cffd719@bootlin.com>
 <edd63888-bf1f-440f-98d1-3fc33fc2b609@bootlin.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <edd63888-bf1f-440f-98d1-3fc33fc2b609@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Joao,

On 1/19/24 6:28 AM, Joao Marcos Costa wrote:
> Hello James,
>
> On 12/22/23 16:36, Joao Marcos Costa wrote:
>> Hello James,
>>
>> Thanks for such a quick reply!
>>
>
> [...]
>
>
>> I updated it to v2.9 and indeed it works. For documentation's sake:
>>
>> This is my /etc/iwd/main.conf:
>>
>>    [General]
>>    EnableNetworkConfiguration=true
>>    Country=FR
>>    UseDefaultInterface=true
>>
>>    [Network]
>>
>>    [Scan]
>>    DisablePeriodicScan=true
>>
>> and this is my /var/lib/iwd/ap/test.ap:
>>
>>    [General]
>>    DisableHT=true
>>    Channel=10
>>
>>    [Security]
>>    Passphrase=password123
>>
>>    [IPv4]
>>    Address=192.168.250.1
>>    Gateway=192.168.250.1
>>    Netmask=255.255.255.0
>>    DNSList=8.8.8.8
>>
>
> [...]
>
>
>>> When helping  Salahaldeen in the original thread I remember that 
>>> hardware being extremely flaky. It would start sometimes and not 
>>> others, and if it failed once it would need a full reboot to get it 
>>> working again. Even with hostapd if I used an option it didn't like 
>>> it required a full reboot to get it going again.
>>>
>>> IIRC there was also some success on one of the interfaces but not 
>>> the others. If you could provide some IWD debug logs too that would 
>>> be great, and might as well show the hostapd configuration that 
>>> works as well.
>>
>> I kept trying with muap0 interface, which worked fine.
>>
>> Just in case, here's my hostapd.conf:
>>
>>    # the interface used by the AP
>>    interface=muap0
>>    # "g" simply means 2.4GHz band
>>    hw_mode=g
>>    # the channel to use
>>    channel=10
>>    # limit the frequencies used to those allowed in the country
>>    ieee80211d=1
>>    # the country code
>>    country_code=FR
>>    # 802.11n support
>>    ieee80211n=1
>>    # QoS support, also required for full speed on 802.11n/ac/ax
>>    wmm_enabled=1
>>
>>    # the name of the AP
>>    ssid=test
>>
>>    # 1=wpa, 2=wep, 3=both
>>    auth_algs=1
>>    # WPA2 only
>>    wpa=2
>>    wpa_key_mgmt=WPA-PSK
>>    rsn_pairwise=CCMP
>>    wpa_passphrase=password123
>
>
> Would you remember if you faced performance issues with this 
> hardware/driver?
>
> I'm using iwd v2.9 with the same main.conf and *.ap (except for the IP 
> addresses) as before, and this is what I get with iperf3:
>
> iperf3 -c 10.0.24.1
> Connecting to host 10.0.24.1, port 5201
> [  5] local 10.0.24.102 port 46170 connected to 10.0.24.1 port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec   768 KBytes  6.29 Mbits/sec    0   45.2 KBytes
> [  5]   1.00-2.00   sec   512 KBytes  4.19 Mbits/sec    0   46.7 KBytes
> [  5]   2.00-3.00   sec   640 KBytes  5.24 Mbits/sec    0   49.5 KBytes
> [  5]   3.00-4.00   sec   384 KBytes  3.14 Mbits/sec    0   53.7 KBytes
> [  5]   4.00-5.00   sec   384 KBytes  3.15 Mbits/sec    0   53.7 KBytes
> [  5]   5.00-6.00   sec   512 KBytes  4.19 Mbits/sec    0   53.7 KBytes
> [  5]   6.00-7.00   sec   256 KBytes  2.10 Mbits/sec    0   53.7 KBytes
> [  5]   7.00-8.00   sec   512 KBytes  4.19 Mbits/sec    0   53.7 KBytes
> [  5]   8.00-9.00   sec   512 KBytes  4.19 Mbits/sec    0   53.7 KBytes
> [  5]   9.00-10.00  sec   768 KBytes  6.29 Mbits/sec    0   74.9 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  5.12 MBytes  4.30 Mbits/sec 0 sender
> [  5]   0.00-10.05  sec  4.77 MBytes  3.98 Mbits/sec                  
> receiver
>
> iperf Done.
>
> On the other hand, with hostapd (using the same hostapd.conf as 
> before), I'm getting considerably better results:
>
> Connecting to host 192.168.0.1, port 5201
> [  5] local 192.168.0.2 port 44490 connected to 192.168.0.1 port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  12.1 MBytes   102 Mbits/sec    0    447 KBytes
> [  5]   1.00-2.00   sec  9.12 MBytes  76.5 Mbits/sec    0    472 KBytes
> [  5]   2.00-3.00   sec  9.50 MBytes  79.8 Mbits/sec    0    551 KBytes
> [  5]   3.00-4.00   sec  9.75 MBytes  81.7 Mbits/sec    0    611 KBytes
> [  5]   4.00-5.00   sec  10.4 MBytes  87.0 Mbits/sec    0    626 KBytes
> [  5]   5.00-6.00   sec  10.1 MBytes  85.0 Mbits/sec    0    626 KBytes
> [  5]   6.00-7.00   sec  11.5 MBytes  96.5 Mbits/sec    0    626 KBytes
> [  5]   7.00-8.00   sec  10.1 MBytes  84.9 Mbits/sec    0    626 KBytes
> [  5]   8.00-9.00   sec  12.8 MBytes   107 Mbits/sec    0    701 KBytes
> [  5]   9.00-10.00  sec  11.6 MBytes  97.4 Mbits/sec    0    747 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec   107 MBytes  89.7 Mbits/sec 0 sender
> [  5]   0.00-10.02  sec   104 MBytes  86.9 Mbits/sec                  
> receiver
>
> iperf Done.
>
>
> I tried removing 'DisableHT', but that raises some issues on the driver:
>
> | CMD_RESP: cmd 0xb0 error, result=0x1
> | IOCTL failed: 000000006106683e id=0x20000, sub_id=0x2000c action=1, 
> status_code=0x1
>
> or:
>
> No matching method found
> Failed to retrieve I[  610.756333] Block woal_cfg80211_set_power_mgmt 
> in abnormal driver state
> WD dbus objects, quitting...
>
>
> Could you please give me some insights on why we need DisableHT for it 
> to work?
>
> Would you have any suggestions on how to approach this performance gap?

Prior to me adding HT (high throughput) IWD's AP mode was just using 
basic rates, so very slow. I added HT support, but apparently not all 
drivers were happy about it. So DisableHT removes the extra stuff that 
allows it to work with this specific driver, but at the cost of performance.

I'm not really in a position to devote a lot of time to AP mode at the 
moment. I know we've gotten a lot of inquiries about it recently but to 
be completely honest if your intent is to run a full fledged access 
point hostapd is really the tool to use. I'd love to get IWD up to the 
same level of quality and support as hostapd but its a massive 
undertaking. Not only that but out of tree driver support is something 
very hard to get right. Hostapd has been around long enough and is the 
de-factor software for APs that hardware vendors have added their quirks 
here and there, IWD doesn't have that luxury.

Thanks,

James

>
>
> Thanks once more!
>
