Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93A1549F
	for <iwd@lists.linux.dev>; Tue,  2 Jan 2024 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgTgaqx8"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbc5636b8eso2556800b6e.2
        for <iwd@lists.linux.dev>; Tue, 02 Jan 2024 09:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704216653; x=1704821453; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ewPKx/y70Xp/81OeEev89jeV/HQpv1rZm2bqFV0G3Ps=;
        b=RgTgaqx8+mmrXrr//Akn2x0jFwoeQyQlaqtnN8BrzMy57hPc21huY12ROz1ofZtFb6
         mFKTH/+76F7mlivFhZSqqQgo/BH6fta/oMKc08mernZX1cC7RIKNhNKADxDtSJPRxl5G
         PIYbmNt+0AM4AU/7x/605MViWps99Revk+3cLBPJjM6UxO2Zal+r0hOLfNk5//S8K3Q1
         nOTjZSCKQkVWCnQroyFNjBwjTiKi95ZedWCTKHuD26/KyrnAzBHNBeSEHZbw7oCGN1x2
         eoqYarVC8s4H0YEpj1hfGjG05gx0do6SCS+JWxOwyrGvn5dkrYGmKjwst8/SBRcjJ24B
         fZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704216653; x=1704821453;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewPKx/y70Xp/81OeEev89jeV/HQpv1rZm2bqFV0G3Ps=;
        b=TLAkC/N6PxsXnMTmatijuS9KeY5eWNSLM+bkqkFdj6HKIVES4i9EHK+Ia9clXFbHCg
         55xSyIbYrA0Ymcoxuw9tFUmhZSsl9MEjAw/1xSdqYn/VXTSvZggGRb2cx7xzulFgYu3i
         fRxauEy1+W9oQUs2/zJCgxyhTgwF/OsEJfaZZysbGD/bgxpJsA7ixnT7pf2ERGysLexr
         wVUEj7hUo41Gf6G36NKacY3acHyWE4XXzQxfha/gm4G+X8wRzmqnDCWer1Qu4M8j4G6m
         rkxJl1QRYZjMDn+Vz5NwzttPjROPcwClVnbWlvA4HndM6Mic7b/NYADDnutiUSv/HqBf
         0zng==
X-Gm-Message-State: AOJu0Yy2e5uGd5OiM2nvLw9BV68qZ/qrU7db5E/eBBQXp/ppDgJZ6tyB
	h0f9rNyyzK59OYjOS6DJIWLiyTEjmyc=
X-Google-Smtp-Source: AGHT+IGpYZzEiLCWmziLzRFHMO8Zq99yOb5mpPQZE+2rIBDlDQzrLNCHpyL9uVLbd3lblsIqGjK9nw==
X-Received: by 2002:aca:1910:0:b0:3bb:bc78:10de with SMTP id l16-20020aca1910000000b003bbbc7810demr5670864oii.90.1704216652857;
        Tue, 02 Jan 2024 09:30:52 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id dn15-20020a056214094f00b0067f52e39899sm10095875qvb.65.2024.01.02.09.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 09:30:52 -0800 (PST)
Message-ID: <278c2319-ddcb-4be5-84fd-dbc7a3b835f1@gmail.com>
Date: Tue, 2 Jan 2024 09:30:50 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Setup help request
Content-Language: en-US
To: Mauro Condarelli <mc5686@mclink.it>, iwd@lists.linux.dev
References: <5b97b06f-5047-4a1e-958d-27a6185ba504@mclink.it>
 <a345fe93-149b-46d6-bc00-ac35bb302858@gmail.com>
 <f477c1f4-4585-4b76-95a6-d0d31532e401@mclink.it>
 <b3c259af-ee4f-488c-ad81-a734302fc6d6@gmail.com>
 <2aaed79f-9fae-4750-8e85-994a48a45da1@mclink.it>
 <5f3370ee-14a4-4921-b337-944cf1d5aaf4@mclink.it>
 <b99e05cb-6661-4f57-8519-e88082975f1a@gmail.com>
 <c98b7094-a11d-4368-b979-9e8be3cd37b4@mclink.it>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <c98b7094-a11d-4368-b979-9e8be3cd37b4@mclink.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/2/24 9:09 AM, Mauro Condarelli wrote:
> Thanks James,
> comments inline below.
>
>
> On 1/2/24 16:36, James Prestwood wrote:
>> Hi Mauro,
>>
>> On 1/2/24 7:11 AM, Mauro Condarelli wrote:
>>> SNIP!
>>>
>>
>> Ok, so I'm not seeing any request to even connect from the AP side of 
>> things. Since your clients aren't even asking for a password I 
>> suspect it thinks there is some issue with compatibility. You could 
>> try using hostapd with a very basic configuration and see if that 
>> works, then we can go from there:
>>
>> hw_mode=g
>> channel=1
>> ssid=testssid
>>
>> wpa=1
>> wpa_pairwise=TKIP
>> wpa_passphrase=secret123
>>
> I had to add `interface=wlan0`, but that works... almost.
>
> It actually asks for password, connects and then fails because there's 
> (currently) no DHCP active (so no IP).
> I think that's expected.
> Behavior is the same with both clients.
>
> Do you have any further suggestions?

Ok perfect, at least it connected. Could you run iwmon before hostapd 
and connect (same as you did with IWD), and send me those pcaps/logs. 
I'll be able to compare and see what its doing differently.

>
> TiA!
> Mauro
