Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953591BF2B
	for <iwd@lists.linux.dev>; Tue, 15 Oct 2024 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005453; cv=none; b=Uy1/Z3/cs7KlBbIDje/+jT7sOdEBDpnzCkg4Y3pKRmn87+w475NYbUHadsmLJFDE4l+HwxwTy2V2/roniWAVgxPbiQT/R8Z7s5LF8Br8UP8/iwqinZNtFlG9mgV7Q4z4vjMrT7Jys0ks2EpCvW6ePHerje5N6uGqo30Zjs3Hb8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005453; c=relaxed/simple;
	bh=i56rQrgtdsFOC6fMal3GhsvXnkzd6b9UNUQqqCGs/wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhP+cYA+P6OsWUmQ9VGYmWMuVdY9Q0AAdH8DXzbRBK1JaX6HZLytkZXwS3fQUCU6i5kC+HSjU+ltmaqGRWkCyLB12isBfEH8NJXi7fA50siQ0hMJFcKjqxPRiO6z1XqCZm4ln1esO0KwwuM8C+wq7grBCN/iF+TvbBd0K8aboNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOdL0roJ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOdL0roJ"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71578c14972so3212270a34.3
        for <iwd@lists.linux.dev>; Tue, 15 Oct 2024 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729005450; x=1729610250; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXjn5LUCpRX2sst/qE8v+z+Rfc9g9j+PqxrSgNasJMQ=;
        b=VOdL0roJ5pbDIbpz5mFH8UB5BVqT9lz3l2V3dkh8kW/AuTQZmCzN6Tybd7KGwjGgTP
         6V0XYHlnG+OzOYu8WrvC1ybmu6l33oHwk3As8vG4mo3nTvfd+n0x1AqUS7LyHN6dCL5l
         uBJOlHcrSWdmXFpI68kj8Hz9oiHol0t2x+FDDnPSztGC3fb020+SV7UcXZh6fmfVGbD0
         iy9C/1vqA1VrqsXTn/Umhtdg6x4iX33cco5lYTzPFDrcq/3y/NdAR+c4p04zvYRiDUex
         Ov+ChNXr/74/IuzNIsZcr4sJ7tBkMVaPaMO/CeTQZpbh399IYORsv0glfWoC1KtS0C3L
         hHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729005450; x=1729610250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXjn5LUCpRX2sst/qE8v+z+Rfc9g9j+PqxrSgNasJMQ=;
        b=q/3a07m7EDdWtKefRMuKvqK5jKe5HfoMliwoMGlzZhxLtkva7kV3eoTR7wfaqRcsjr
         pHwmzI0Nk9vQDi+BTBaFmptvnoubhN77lZBbk9OMorM3EvDenTsMnVML91LGu8H71BkQ
         ZR7LdaPSNNi3P9C0NQ9ZhkEn2tMYuV7NglywXaoU4FrWnOs8u9ib8qKnyUnQLGftg9VL
         AEMQUx04B19gyGEJFo7r0QpL5TSz4BaRGTVncaNOCYkAiwIUlYChYKE3zwwwoodO6iWe
         QMSa+d8tPvFaRV5YJ/slACMcLpQflabphV2vYnpPOW7u7ZQHstWQcys8WoVexkYtNdEz
         lGIA==
X-Forwarded-Encrypted: i=1; AJvYcCXYgqGDALqIQmvsv3m6MCnoUOi/fGFlG/qY88lKxyftaJy2IpqWeEiTSNUbvOntVfoIjvc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzXy8KQyMpZ8aDwKKecKkZEZb+kzOyvIz9EGB5WyQoteuBxcL/h
	5549UHoA45Yav8LZcOyUWHgJf5gQXPaPB8qjpGYdZXhpLSWsteH5
X-Google-Smtp-Source: AGHT+IGqh9rzTkF9artX2fAO8VyZ6q1J7egEZEgv8M+xhKz+/Pq5ncDpqrKmfBj+qyF164kAopWAbA==
X-Received: by 2002:a05:6830:6488:b0:70f:674c:116c with SMTP id 46e09a7af769-718034da7ddmr676434a34.24.1729005450567;
        Tue, 15 Oct 2024 08:17:30 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-717fba0e178sm324408a34.48.2024.10.15.08.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 08:17:30 -0700 (PDT)
Message-ID: <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
Date: Tue, 15 Oct 2024 10:17:27 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Martin Petzold <martin.petzold@tavla.de>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

> 
> I think the regulatory domain issue is fixed. It seems that 99 is correct 
> (because it is handled in firmware). We see far better signal and data rates at 
> a site where we had problems. It seems the general setup is far better now for 
> simple setups. We removed the configuration from device tree and then it may 
> have used the configuration from brcmfmac4339-sdio.txt (device tree stuff was 
> something the SOM vendor added for some reason).

Sounds like you're getting somewhere.

> 
> However, I have now already seen at one of our testing sites, that it connected 
> to the router instead of the repeater (which is far closer and has far far 
> better signal: -67 vs. -29 dBm). It also did not switch to the repeater after

You may have to revise your expectations here.  Most implementations do not 
trigger roaming unless signal quality reaches a certain threshold.  This 
includes many of the firmware roaming implementations I've seen.

For iwd this threshold is -70 dbm on 2.4G and -76 dbm on 5/6G by default. 
Parking at the AP with good signal (-67 is good) is just fine and I see nothing 
inherently wrong here.  And remember, the firmware is responsible for roaming in 
the case of brcmfmac.

One may question why -67 AP was preferred over -29 one?  We'd need logs to 
answer that question.  It could be the -29 one was simply not seen in the scan 
results at the time of the initial scan / connection.

> several hours (both FritzBox - so consumer grade and we don't know the exact 
> configuration). After a reboot, it connected to the repeater and until now it 

So that's... good?

> remains there. I will switch to more complex roaming environment, however, this 
> is more sensitive because it is at a clients site. This first impression gave me 
> not much confidence...
> 
> What do you think about the idea to disable roaming in the firmware / driver? 
> (if I understand Arend right, this is setting "roam_off" in brcmfmac4339-sdio.txt)

You can certainly give it a try.  It is not something we have tested explicitly, 
but it should (mostly?) work.  However, note that trying to make a FullMAC card 
roam from userspace in such a manner is inherently limited.  iwd cannot utilize 
advanced roaming features such as FT with such a setup (I can get into the 
technical details if you care).  Having said that, roaming behavior is a 
frequent complaint for many fullmac implementations.

> 
> Will IWD smoothly take over the roaming? How can I check who is handling the 
> roaming?

iwd looks at the NL80211_ATTR_ROAM_SUPPORT flag.  If such a flag is reported by 
the wifi driver, iwd will let the firmware handle roaming.  Otherwise it will 
try to handle roaming itself with the (rather limited in the case of fullmac) 
tools that it has access to.  Taking a peek at the brcmfmac driver, looks like 
it is doing the right thing in setting/not setting this flag based on the 
"roam_off" parameter.

Regards,
-Denis
