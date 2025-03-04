Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05A276056
	for <iwd@lists.linux.dev>; Tue,  4 Mar 2025 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100080; cv=none; b=nPZKJPvx34djGQI+ej66HZSvQjGJ/9Qyq3EeyqmDJytHfvAv8skY4iQ+0cIxyOH2idsf+Uvu8nqqmdktQHfCPHtPusrc6pluCVhgbYNx2wCkia5M9NycBqMrEpPC+xZvuVUChzF9uBMApLwcikhu4aopUNsRmYsiA7KkqzltC44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100080; c=relaxed/simple;
	bh=4vVOfKResrbUjfKqP8smBScCl20StXx1Io/llWuKv5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VlqNB29YmPzHHXOvZv+HT2PhJ3Ui1XzksUFxARLttbbq+R9JUY+3m+F0FmWyypTTwUG3vzEyAHXEWWhnYbvirDL+6DyykZ35Lk33y7sUC4Zvp49trU3bewDr3/ZvnWbFVRCA1Y1a+xtYNQqA8tjuq09OurgmFJRkvAGaI9FFzR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsOLU7qy; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsOLU7qy"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7272f9d216dso3091630a34.3
        for <iwd@lists.linux.dev>; Tue, 04 Mar 2025 06:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741100078; x=1741704878; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qfv1vYNSni8bFrbaDYvlhC5yNgxC1p6nxIVdxiYWf3k=;
        b=hsOLU7qyBsf+wZfnT5FAOJTimsup7iDqOYKSi+bzxAkXyKb7L6sII4d9QXhGgbn4N7
         5LEwGpKVe7dtCiJfrcfQd5RoHUfLvQOXOGZ+9QzpveHTzFAdnyT4koHZdUHnGxKreHkT
         TpMF4D0g6cBavYHHdOKwPaIaFwFe8aBaW+OyvnnZ88RXOe4zy2cOFis8ErI6HpBTKbGM
         odPpbMFY42r/Dv2xGHAnk/hHvaHbMbfEFuaUaB+g+HlRdLwc42Xp9PBz2vRKdk8l1Y/8
         srRfmhv5hcHxMCeXcG1aI+4ncCfJ1mPjADoSWOT8qygiuYb0VJ+ba1+VYXdAQvKVWWAv
         jIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100078; x=1741704878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfv1vYNSni8bFrbaDYvlhC5yNgxC1p6nxIVdxiYWf3k=;
        b=s4bxaeBh+7jC8o4/sFvNGr/RUMx1DmEoGWTBBjPxfIeQXPtPpsrUCbMJw5zkEyLo19
         Ho7QIywlRCq47uM0ZRh645S38OLpokHGT/IjKHzZ3S0xyJq+E5DfGIbPZTo3W/y1gr0g
         YYIVgEErcLlmlPkZxuXwsZ4VHk8DcGnZ5OtA0MQhzRaeCKTwRl0vE0DDibf9IRrxM0MJ
         YAH30HGIsDBK7wlLAthov7DScz0/q9lzH5puVxB3BhYs5s6wVsND9Oo4YGpg86gBafVF
         mh+DtAYSI53IH8M5bI59AYdJiYfI4XDjIMsA9AweDRrsBYgDUlNmcoRErL1LSf37Hd0A
         yT7w==
X-Forwarded-Encrypted: i=1; AJvYcCV0rw2MG749skXnaR2I/VEen90o8/zmtLFVs2hG9i77aZ4ppPJmkmXp1kN3gGL3T0w1zpQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwyBeaF0QJfj1PuVXzeHyz1c6LegL+75mvZUi5sGK989h/NbcGj
	WyThiJmLRZ+8AqFz381kbD2zESCHhrN8Ao6VL8H2KdBEzkn1st6i
X-Gm-Gg: ASbGncsafA6VdXR88Azz9fTlJU9PcI9u4Lk4hlaO1QjNn+9ovmVKReXbIpxh4jtKDqS
	YOtUK3udEbBBaVliAILNHJUsqWs23O4KNPAA/y2+DZS2s4rMYM5rUeinZs1WZmI4DGNCVfHXSbZ
	+76zL+PyIuv+0GdQyRGZQXtr/OQEQ2U8rGoVKJhG4cr7nKF+zaBx7YsZyIzfbc+m3NxSbwbuMyZ
	zCTVbRpyRfWJN7gFpP7iq/jQaFDeXALwZzUrWz0oVcRRTX3OdvCGfTvG2rqL3VdfQuOZUNdzlQu
	9DBGZgN6I4eLdA4v9yMLQjB5dxYKXBj1T+lIZLGOW+U2CHGi7+g8yr+p+Ka/fWIjDsBA4sgaD3E
	fxGR2l1uGTg==
X-Google-Smtp-Source: AGHT+IF4smO3b3SXAvCQjeuZOqrzXgeKv4Xs/q3H7nco6mIK+DkPtZhUo5AiLDhORmnL1IboJBQgAg==
X-Received: by 2002:a05:6830:65cb:b0:72a:1ade:bbe8 with SMTP id 46e09a7af769-72a1adebc42mr1065264a34.18.1741100077600;
        Tue, 04 Mar 2025 06:54:37 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72a0e18af79sm606291a34.69.2025.03.04.06.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 06:54:37 -0800 (PST)
Message-ID: <44b67fe3-d5e1-405a-9198-18b3d6b81d14@gmail.com>
Date: Tue, 4 Mar 2025 08:54:35 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: systemd-networkd managed wireless networks
To: Donald <sirspudd@gmail.com>, iwd@lists.linux.dev
References: <CAOVeLGQuNx5Cr0WVcNQDJpPZk1bWKcmQ-+YeTxdruiAODBGxBw@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAOVeLGQuNx5Cr0WVcNQDJpPZk1bWKcmQ-+YeTxdruiAODBGxBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Donald,

On 2/28/25 4:55 PM, Donald wrote:
> Top of the morning,
> 
> Do the iwd dev team strongly recommend having iwd manage the wireless
> interface with:

This greatly depends on your use case.  If you are integrating iwd with another 
network manager that doesn't support iwd's NetworkConfigurationAgent APIs 
(ConnMan, systemd-networkd), then using EnableNetworkConfiguration=true is not 
what you want.  Recent versions of NetworkManager do support this feature and 
are thus able to let iwd figure out the network configuration details and apply 
the settings to the system.

> 
> [General]
> EnableNetworkConfiguration=true
> 
> I am asking as I am using iwd in conjunction with systemd-networkd,
> and was caught by surprise that disconnecting from my ap in iwd:
> 
> iwctl station wlan0 disconnect
> 
> does not result in the associated networkd instance from being degraded:
> 

That may be a question for systemd-networkd folks.  'station disconnect' should 
result in iwd bringing the interface down.  I don't see why it would continue 
having addresses assigned.

>                     Link File: n/a
>                  Network File: /etc/systemd/network/wireless.network
>                         State: routable (configured)
>                  Online state: online
>                          Type: wlan
>                          MTU: 1500 (min: 68, max: 1500)
>                         QDisc: pfifo_fast
> IPv6 Address Generation Mode: eui64
>            Wi-Fi access point: (null) (00:00:00:00:00:00)
>      Number of Queues (Tx/Rx): 1/1
>                       Address: 192.168.50.153 (DHCPv4 via 192.168.50.1)
>                                fe80::ea4f:25ff:fe44:f60b
>                       Gateway: 192.168.50.1
>                           DNS: 192.168.50.240
>                                1.1.1.1
>                                192.168.50.1
>                                2600:1700:7c10:d0ff::1
>                           NTP: 192.168.50.1
> 
> It is interesting to me that networkd has enough insight to know the
> ap's name, but still does not change the state off of: routable
> (configured) or adjust the online state.
> 

Perhaps it has to do with some roaming hacks that systemd-networkd introduced 
recently?

Regards,
-Denis
