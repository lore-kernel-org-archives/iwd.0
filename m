Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ACA23760
	for <iwd@lists.linux.dev>; Fri, 22 Dec 2023 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="omm9FhLk"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95340E0005;
	Fri, 22 Dec 2023 15:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703259389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6GspVnJlUqGX8n3aKCmoXl0dluJJ0MaQeCO4w7a85KE=;
	b=omm9FhLkPfHksSunmtFUIyk8NtzOLRscwRhvEAgzXxhEKlzeizs1ulR1/Cp+ijfXWBgSXR
	S28D1Y2lFGZyhAwVhMo5R9FNUuRGK5dPUiG0tfkuoKp4sAspkiykKWrJ4PCHErxLwtuhR8
	S+4LVg9Mz5ffucoE1iFiqZHRZJqvsb1LF0qPluNdRiXm0PrQ3Pn/jobriieyaOUqCdBebL
	+/2eY+LI98G/ZVKslIW322uUTJxMM2ckFCl8v0Wk7Nl2iy0S5SDoYqzvBVlldjTx5sTzFZ
	fw7ZoigsmWKHQxd1ESDBWl/UCbCfZqRgkLx6RIz9RculkilW/uMFZv0nsuA7uQ==
Message-ID: <8c484950-c99d-47c0-b048-5a447cffd719@bootlin.com>
Date: Fri, 22 Dec 2023 16:36:28 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Iwd: unable to start AP with NXP 88W9098 chipset
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Cc: gregory.clement@bootlin.com, Salahaldeen.Altous@leica-camera.com
References: <6c9b05a2-7474-4eed-bb74-6f5de1d433ba@bootlin.com>
 <c11d1310-a0ca-46a2-b08e-d1e35351826a@gmail.com>
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Organization: Bootlin
In-Reply-To: <c11d1310-a0ca-46a2-b08e-d1e35351826a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: joaomarcos.costa@bootlin.com

Hello James,

Thanks for such a quick reply!


On 12/21/23 17:08, James Prestwood wrote:
> Hi Joao,
>
> On 12/21/23 7:46 AM, Joao Marcos Costa wrote:
>> Hello,
>>
>> I hope this email finds you well.
>>
>> I'm currently facing what seems to be the very same bug reported at 
>> https://lore.kernel.org/iwd/AM7PR01MB67244F63EBEAB9A65D965BEAADC69@AM7PR01MB6724.eurprd01.prod.exchangelabs.com/
>>
>> As for my own context, I'm using:
>>
>> - Ublox wifi module Jody-W377-00A
>>
>> - IWD v1.26 (from meta-openembedded)
> This is quite an old version, there have been many changes to AP mode 
> since then.
>>
>> - Linux v6.1.68 (x86_64)
>>
>> - NXP Wi-Fi driver for NXP 88W9098 chipset, from 
>> github.com/nxp-imx/mwifiex (branch=lf-6.1.55_2.2.0)
>>
>> I followed the steps in https://iwd.wiki.kernel.org/ap_mode, and this 
>> is the error I get in my iwctl console:
>>
>> # iwctl
>> NetworkConfigurationEnabled: enabled
>> StateDirectory: /var/lib/iwd
>> Version: 1.26
>> [iwd]# device muap0 set-property Mode ap
>> [iwd]# device list
>> Devices                                   *
>> -------------------------------------------------------------------------------- 
>>
>>   Name                Address             Powered   Adapter Mode
>> -------------------------------------------------------------------------------- 
>>
>>   uap0                62:09:c3:80:9b:1d   on        mwiphy0 ap
>>   mlan0              60:09:c3:80:9a:1d   on        mwiphy0 station
>>   muap0             62:09:c3:80:9b:1e   on        mwiphy1 ap
>>   mmlan0           60:09:c3:80:9a:1e   on        mwiphy1 station
>> [iwd]# ap list
>>                           Devices in Access Point 
>> Mode                        *
>> -------------------------------------------------------------------------------- 
>>
>>   Name                Started
>> -------------------------------------------------------------------------------- 
>>
>>   uap0                no
>>   muap0             no
>>
>> [iwd]# ap muap0 start-profile testap
>> [iwd]# [22444.663032] wlan: Starting AP
>> [22444.668197] fw doesn't support 11ax
>> [22444.674130] CMD_RESP: cmd 0xb1 error, result=0x1
>> [22444.679286] IOCTL failed: 00000000ae152881 id=0x20000, 
>> sub_id=0x20001 action=1, status_code=0x1
>> [22444.689145] woal_cfg80211_add_beacon: start uap failed
>> Operation failed
>>
>> My /var/lib/iwd/ap/testap.ap file is identical to the one provided in 
>> the Wiki, and as for my main.conf:
>>
>> ---
>>
>> [General]
>> EnableNetworkConfiguration=true
>> UseDefaultInterface=true
>>
>> [Network]
>>
>> [Scan]
>> DisablePeriodicScan=true
>>
>> ---
>>
>> I tried adding Country=FR and ControlPortOverNL80211=false, but 
>> without any success.
>>
>> I also added DisableHT=true in the testap.ap file later on, but the 
>> result was the same.
> This is a more recent option. I have a feeling if you updated IWD and 
> set DisableHT it would work.

I updated it to v2.9 and indeed it works. For documentation's sake:

This is my /etc/iwd/main.conf:

    [General]
    EnableNetworkConfiguration=true
    Country=FR
    UseDefaultInterface=true

    [Network]

    [Scan]
    DisablePeriodicScan=true

and this is my /var/lib/iwd/ap/test.ap:

    [General]
    DisableHT=true
    Channel=10

    [Security]
    Passphrase=password123

    [IPv4]
    Address=192.168.250.1
    Gateway=192.168.250.1
    Netmask=255.255.255.0
    DNSList=8.8.8.8

>> However, I was able to start the Access Point using hostapd, and it 
>> worked fine.
>>
>> I can provide you with my hostapd.conf, if you find it pertinent.
>>
>>
>> Since referencing the original thread, are there any updates?
>>
>> Has anyone else encountered a similar issue? Even if the chipset is 
>> not precisely the same.
>>
>> Please feel free to ask for logs or other unmentioned details, and 
>> thank you for your assistance.
>
> When helping  Salahaldeen in the original thread I remember that 
> hardware being extremely flaky. It would start sometimes and not 
> others, and if it failed once it would need a full reboot to get it 
> working again. Even with hostapd if I used an option it didn't like it 
> required a full reboot to get it going again.
>
> IIRC there was also some success on one of the interfaces but not the 
> others. If you could provide some IWD debug logs too that would be 
> great, and might as well show the hostapd configuration that works as 
> well.

I kept trying with muap0 interface, which worked fine.

Just in case, here's my hostapd.conf:

    # the interface used by the AP
    interface=muap0
    # "g" simply means 2.4GHz band
    hw_mode=g
    # the channel to use
    channel=10
    # limit the frequencies used to those allowed in the country
    ieee80211d=1
    # the country code
    country_code=FR
    # 802.11n support
    ieee80211n=1
    # QoS support, also required for full speed on 802.11n/ac/ax
    wmm_enabled=1

    # the name of the AP
    ssid=test

    # 1=wpa, 2=wep, 3=both
    auth_algs=1
    # WPA2 only
    wpa=2
    wpa_key_mgmt=WPA-PSK
    rsn_pairwise=CCMP
    wpa_passphrase=password123

>
> Thanks,
>
> James


Thanks once more. I hope this will be of help to other users.

-- 
Best regards,
João Marcos Costa

