Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AAF3222
	for <iwd@lists.linux.dev>; Fri, 19 Jan 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674551; cv=none; b=EDts9OWCNZuPkDDm+6JUqtqQgHpuAUMmOFOAHO2LxaxBn5f6QpAqGQNodM3N3skpHk7G2qftEC0+20Bptu2uzRsO24iafhA9DvL2YlTcsYXftI4drVGEk32xbIylJWkjmWaVFmfZpVXoxfdlXatbSG2yoygfW1De9QzJDeIRGh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674551; c=relaxed/simple;
	bh=Bp9JjDnutAeOoHmg/dioph0DJg/BtJbdU0QDHLJVIIg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iZTLb/4R4yV50r7z4UuDK+1+q2Q808sa5rFGfpzuwbQzK1YHaXfwcAoBYrN2WBCukLeOkncYwq2y8yZhqUsVg9Oh4ZXl8OhO4m9rXPYpfgfBwxTVZMZXtWeiB4cOgOgrNUjcfZR4eTx/SNUoGSNlt+C10t+7lIgrWlLo1hC67i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ASfD2UzN; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ASfD2UzN"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3ED4A6000F;
	Fri, 19 Jan 2024 14:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705674540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tleXooxhRb6DEbVzVfGjyACPhNI2jOsh0MIm8PLfOEQ=;
	b=ASfD2UzNwBqm0DfX9D2FLKDrt5pOlYLdrw4ThTX/4QWAedIlH4pL0uJYGdrkZIe24kTTs/
	n6Pco0miLaxuy3hNrhpGtILpUwfXHMpEk38qGCz4aBVuONV9t4JJSOJLMyiAOuKO5rGNGZ
	nS7b5BowDwjwPSxa+1WgyWjZ/1P+mlVYdKIW9oOE+YLjpj5Tcevd6nFtrHvTM0A7dhVwxL
	MxwtqIT+h1vAHc6jwIqVXSmVUYrvcPY2tFo3d5LYbPijBSwoSsvqVBYupRfb6RuRpXGphV
	HXJDb0ZmMUGyisVGEpgwa28iTKHM/1uayZ/8s8337wac/MmPmQd0/IgUisDtYQ==
Message-ID: <edd63888-bf1f-440f-98d1-3fc33fc2b609@bootlin.com>
Date: Fri, 19 Jan 2024 15:28:59 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Iwd: unable to start AP with NXP 88W9098 chipset
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Cc: gregory.clement@bootlin.com, Salahaldeen.Altous@leica-camera.com
References: <6c9b05a2-7474-4eed-bb74-6f5de1d433ba@bootlin.com>
 <c11d1310-a0ca-46a2-b08e-d1e35351826a@gmail.com>
 <8c484950-c99d-47c0-b048-5a447cffd719@bootlin.com>
Content-Language: en-US
Organization: Bootlin
In-Reply-To: <8c484950-c99d-47c0-b048-5a447cffd719@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: joaomarcos.costa@bootlin.com

Hello James,

On 12/22/23 16:36, Joao Marcos Costa wrote:
> Hello James,
>
> Thanks for such a quick reply!
>

[...]


> I updated it to v2.9 and indeed it works. For documentation's sake:
>
> This is my /etc/iwd/main.conf:
>
>    [General]
>    EnableNetworkConfiguration=true
>    Country=FR
>    UseDefaultInterface=true
>
>    [Network]
>
>    [Scan]
>    DisablePeriodicScan=true
>
> and this is my /var/lib/iwd/ap/test.ap:
>
>    [General]
>    DisableHT=true
>    Channel=10
>
>    [Security]
>    Passphrase=password123
>
>    [IPv4]
>    Address=192.168.250.1
>    Gateway=192.168.250.1
>    Netmask=255.255.255.0
>    DNSList=8.8.8.8
>

[...]


>> When helping  Salahaldeen in the original thread I remember that 
>> hardware being extremely flaky. It would start sometimes and not 
>> others, and if it failed once it would need a full reboot to get it 
>> working again. Even with hostapd if I used an option it didn't like 
>> it required a full reboot to get it going again.
>>
>> IIRC there was also some success on one of the interfaces but not the 
>> others. If you could provide some IWD debug logs too that would be 
>> great, and might as well show the hostapd configuration that works as 
>> well.
>
> I kept trying with muap0 interface, which worked fine.
>
> Just in case, here's my hostapd.conf:
>
>    # the interface used by the AP
>    interface=muap0
>    # "g" simply means 2.4GHz band
>    hw_mode=g
>    # the channel to use
>    channel=10
>    # limit the frequencies used to those allowed in the country
>    ieee80211d=1
>    # the country code
>    country_code=FR
>    # 802.11n support
>    ieee80211n=1
>    # QoS support, also required for full speed on 802.11n/ac/ax
>    wmm_enabled=1
>
>    # the name of the AP
>    ssid=test
>
>    # 1=wpa, 2=wep, 3=both
>    auth_algs=1
>    # WPA2 only
>    wpa=2
>    wpa_key_mgmt=WPA-PSK
>    rsn_pairwise=CCMP
>    wpa_passphrase=password123


Would you remember if you faced performance issues with this 
hardware/driver?

I'm using iwd v2.9 with the same main.conf and *.ap (except for the IP 
addresses) as before, and this is what I get with iperf3:

iperf3 -c 10.0.24.1
Connecting to host 10.0.24.1, port 5201
[  5] local 10.0.24.102 port 46170 connected to 10.0.24.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   768 KBytes  6.29 Mbits/sec    0   45.2 KBytes
[  5]   1.00-2.00   sec   512 KBytes  4.19 Mbits/sec    0   46.7 KBytes
[  5]   2.00-3.00   sec   640 KBytes  5.24 Mbits/sec    0   49.5 KBytes
[  5]   3.00-4.00   sec   384 KBytes  3.14 Mbits/sec    0   53.7 KBytes
[  5]   4.00-5.00   sec   384 KBytes  3.15 Mbits/sec    0   53.7 KBytes
[  5]   5.00-6.00   sec   512 KBytes  4.19 Mbits/sec    0   53.7 KBytes
[  5]   6.00-7.00   sec   256 KBytes  2.10 Mbits/sec    0   53.7 KBytes
[  5]   7.00-8.00   sec   512 KBytes  4.19 Mbits/sec    0   53.7 KBytes
[  5]   8.00-9.00   sec   512 KBytes  4.19 Mbits/sec    0   53.7 KBytes
[  5]   9.00-10.00  sec   768 KBytes  6.29 Mbits/sec    0   74.9 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  5.12 MBytes  4.30 Mbits/sec 0             sender
[  5]   0.00-10.05  sec  4.77 MBytes  3.98 Mbits/sec                  
receiver

iperf Done.

On the other hand, with hostapd (using the same hostapd.conf as before), 
I'm getting considerably better results:

Connecting to host 192.168.0.1, port 5201
[  5] local 192.168.0.2 port 44490 connected to 192.168.0.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  12.1 MBytes   102 Mbits/sec    0    447 KBytes
[  5]   1.00-2.00   sec  9.12 MBytes  76.5 Mbits/sec    0    472 KBytes
[  5]   2.00-3.00   sec  9.50 MBytes  79.8 Mbits/sec    0    551 KBytes
[  5]   3.00-4.00   sec  9.75 MBytes  81.7 Mbits/sec    0    611 KBytes
[  5]   4.00-5.00   sec  10.4 MBytes  87.0 Mbits/sec    0    626 KBytes
[  5]   5.00-6.00   sec  10.1 MBytes  85.0 Mbits/sec    0    626 KBytes
[  5]   6.00-7.00   sec  11.5 MBytes  96.5 Mbits/sec    0    626 KBytes
[  5]   7.00-8.00   sec  10.1 MBytes  84.9 Mbits/sec    0    626 KBytes
[  5]   8.00-9.00   sec  12.8 MBytes   107 Mbits/sec    0    701 KBytes
[  5]   9.00-10.00  sec  11.6 MBytes  97.4 Mbits/sec    0    747 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   107 MBytes  89.7 Mbits/sec 0             sender
[  5]   0.00-10.02  sec   104 MBytes  86.9 Mbits/sec                  
receiver

iperf Done.


I tried removing 'DisableHT', but that raises some issues on the driver:

| CMD_RESP: cmd 0xb0 error, result=0x1
| IOCTL failed: 000000006106683e id=0x20000, sub_id=0x2000c action=1, 
status_code=0x1

or:

No matching method found
Failed to retrieve I[  610.756333] Block woal_cfg80211_set_power_mgmt in 
abnormal driver state
WD dbus objects, quitting...


Could you please give me some insights on why we need DisableHT for it 
to work?

Would you have any suggestions on how to approach this performance gap?


Thanks once more!

-- 
Best regards,
João Marcos Costa

