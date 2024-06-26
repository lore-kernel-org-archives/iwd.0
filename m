Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF010186289
	for <iwd@lists.linux.dev>; Wed, 26 Jun 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413849; cv=none; b=i+0s0U9vCl3O9nY8G4ET5rD1nT6E/Fq7DxkkCry3Ze9TL0wtfR0V4gvaIfTpLHIOoKzzVSxiNyOl459T7DsXFUeDia8QNIDIXxMqeib5okk3Llp6bgMovWCOWwXd7dy7M76vvl+wT+D1E3A0YTT4rdLTYwzFXBbRTWOOEdf9xkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413849; c=relaxed/simple;
	bh=waddhWiZJWXb6sLlhCFQbUQLGIa99l1iGy2RIXgFIvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AcU/v4XBKRxKl2XQSGgiiDO/14Ut+aQaV0tea25B0GUI7E+oFNi6/K/iruSDFtT4c6PnprP+aZJYWBDTlBfIfrkQbpoUX83wzPNgswUApkafSZiaiZXHmAAv2exKLW3sHKP5p46jNt2tfoURoqb4kG1mCHtZM/uS7ZnVW8gqfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaYxX7fo; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaYxX7fo"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b97a9a9b4bso3182884eaf.0
        for <iwd@lists.linux.dev>; Wed, 26 Jun 2024 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719413847; x=1720018647; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UapqzeDigNjwKb8fpc9UketCSWAi6r8KPyt8othlwUM=;
        b=PaYxX7for1CKT7EluqsNm6GuG4OeHFVqGaMtsXz6kfg6VoEOykv/yDt70ZRScx2fqv
         5yjzE64N3Ytzn1QmHsmldE1i0TwyjKK/u684jtde4Hv2WbvTPoCOHAiKk8iEmkhQycRT
         bHuSybT4/p+XKs/RYgtjVQ4Xopq3eQ8BmvRe5QzvdLQuGpdlOuMuRPFG7L/i0BOodUOT
         GU1JPNr4E+cUUMuHWvlVTdkjCbiUrW7qsISk0Dp2wICjXHtgY4hJxw7v8WVmLG0r4q7j
         k4iTPHZaoJssdw/KPBd7qPgH07oqEz4MD/VXX8j07cMAcg+gIqWm/tg5V8C6vSuM4baQ
         To1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719413847; x=1720018647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UapqzeDigNjwKb8fpc9UketCSWAi6r8KPyt8othlwUM=;
        b=FzxypHqr13Yx6EqfMyYyeS4aCCY3sZFf+6vrSlDDhLECS6bixXzq6i1SzZTG0+BEDg
         sImrffhwwTi/jRfsvj/D4Rwk3nPZvRhUvf5vIRrRXteG8MHnQbErlq8UNkCMcyybPRiS
         4+Uyv2c3nKWg1lWj/2gl6oLbHObXIwwamsTS+5PW2WPBH4DgNbqkZLHKBVJshiDAT1Rw
         pBqJ9IbTvhdNHUjWe0mDaOVV5ZYlNitkFr2woz57PLi6bJwoDuE9oop+qRJscqWSq+3W
         Jqxc5p+koAyxZhGIRTsuZ6IVwH0wBG8Oxg4uLv7gBK0voyGyBOXIN3ORE9zxsxQy19wd
         UPzA==
X-Forwarded-Encrypted: i=1; AJvYcCWcbFEHK/JMJg5LAXz6eYkfh0ru5Q8zh1tzGQP7DGFM8iq/B7AD/ePvLhk40BgrXA8G+FNmvPPlcY6u+OaIHKiC7S92
X-Gm-Message-State: AOJu0Yyn4de01rqiG6ZXpv2kkkjhqDRm8Oi8ccgolpT6MEqEVcHmFGqN
	+FuXNqSFzIrBoQ5Ndpqj4h2yh/FQpzL8ieCVNrBJLg8XWjEQicPJMpH3pg==
X-Google-Smtp-Source: AGHT+IHZdtQt3g2iRVmZ2t+azZdKSMZC14yZWOiusm+RmUgfS6GSjljqM17Dv1wtxh68Pf3C09SoVA==
X-Received: by 2002:a4a:2451:0:b0:5bb:2d23:8aeb with SMTP id 006d021491bc7-5c1eb9ddd8bmr11693072eaf.2.1719413846771;
        Wed, 26 Jun 2024 07:57:26 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5c1d592633bsm2144095eaf.47.2024.06.26.07.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:57:26 -0700 (PDT)
Message-ID: <c8cc4e80-1f3e-4393-8e21-54804628f5b0@gmail.com>
Date: Wed, 26 Jun 2024 09:57:25 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: No re-connect using systemd-networkd and IWD
To: Martin Petzold <martin.petzold@tavla.de>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <e088f7e6-c455-4635-9edd-a51c619654d4@tavla.de>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <e088f7e6-c455-4635-9edd-a51c619654d4@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 6/26/24 4:24 AM, Martin Petzold wrote:
> Dear all,
> 
> I have some serious issues with the Wi-Fi connection using systemd-networkd and 
> IWD. Our devices are fixed at a place and have only a single Wi-Fi network 
> configured. There is also an Ethernet device, but no cable connected. Wi-Fi 
> configuration and connection work well using iwctl. However, some of our devices 
> lose the connection to this network and DO NOT re-connect. We have seen this 
> with several devices and different routers. Some devices also do not have this 
> problem. It seems to depend on the stability of the connection. But I am also 
> talking about this issue like 1m away from the router - for such devices only 
> rarely.
> 
> SETUP
> 
> SoM: Variscite DART-IMX8M-PLUS
> SoC: NXP i.MX8M Plus
> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
> Antenna: Laird FlexPIFA
> RootFS: Debian bullseye
> Kernel: NXP Kernel 5.10.52
> Driver: Laird 8.2.0.16
> Network Daemon: systemd-networkd 247.x
> Wi-Fi Daemon: IWD 1.14

Is iwd version really that old?  We're at 2.18 now.

What kind of authentication is being used on the network? PSK or 802.1X?  Do you 
have logs (preferably with debugging enabled) around the time this happens?

> 
> CONFIGURATION
> 
> -> Blacklisted "brcmfmac" kernel module
> -> Enabled Kernel "Networking support > RF switch subsystem support" (but as far 
> as I understand the Laird driver does not support RF Kill)
> -> Added [Scan] and [Blacklist] section later, problem still exists (however, I 
> could reproduce that re-connect works better if I switch on/off Wi-Fi SSID)

These options were added to take care of certain routers misbehaving.  For 
example, one of the APs in an ESS not responding to association requests but 
still sending beacons / probe responses.  Modifying the parameters from defaults 
should not be generally necessary, I think?

> 
> ##### /etc/systemd/network/20-wlan0.network
> 
> [Match]
> Name=wlan0
> 
> [Network]
> DHCP=yes
> 
> [Link]
> RequiredForOnline=no
> 
> ##### /etc/iwd/main.conf
> 
> [General]
> UseDefaultInterface=true
> 
> [Network]
> NameResolvingService=systemd
> 
> [Scan]
> InitialPeriodicScanInterval=10
> MaximumPeriodicScanInterval=10
> 

This will just make iwd scan more aggressively, without fixing the underlying 
issue.  Aggressive scanning isn't really necessary unless you're moving through 
your environment very fast.  You mentioned that your devices are stationary.

> [Blacklist]
> InitialTimeout=10
> MaximumTimeout=10
> 
> #####
> 
> OPTIONS
> 
> A. Try "IgnoreCarrierLoss=5s" in systemd -> but this is not about re-connect
> B. Switch to Debian Bookworm (with systemd  and IWD ) and NXP Kernel 6.1.36 -> 
> is already WIP
> C. Switch to new Laird firmware 11.x
> 
> -> Which option could be promising?
> -> Do you have any other idea, how to address this issue?
> 

Upgrading to latest iwd and logs [1] of the issue occurring would be the steps 
I'd start with.

> Thanks,
> 
> Martin
> 
> 

Regards,
-Denis

[1] https://iwd.wiki.kernel.org/debugging
