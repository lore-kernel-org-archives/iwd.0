Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D22E22F15F
	for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592818; cv=none; b=GPOrW7qsBCj4gNrRJOL1X+QrMI/pWeZOPtO8aYa5HVGGT1++2bPRsa7mIVbP416DGT1NGw6zgV1fz6+qbIhsAlY0EwGyEupnkfubdzFZk3qzH36nKbeT0Eq20WnjwxFYO+egzC/5a+E0p+3UVB8NDpCiCv/rF03nXg8WTOLq8XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592818; c=relaxed/simple;
	bh=cAgrY+tuZQs6UsbGeC7IBkK9g6/EmmWofXffDqm6YqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gqXIbjnT9Xn8QxgLlulyq6UcehrwRmr4nFOIwdjIUcc6Gzf40RptVqIBaRBZnMds7kZPALcyM+zITOzCnKLHhtZ55n/M2kpx9ovQdrSixX4Gavp8nj8Rb9zRNuRAAWzca6PB0kU+Wah0AMfvyR0/AaQAwIpAZymUgYrCF0Vsnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaLfZA+i; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaLfZA+i"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22349bb8605so922355ad.0
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 10:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740592816; x=1741197616; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PDBxbm0dT73n7Wu/Sv8aJeVcZAANZL/bca45vjfFy2A=;
        b=SaLfZA+i0X8O+PcnCrgd/QweOCWXLDlNtJ/91BfTFGW/iGDvP2rg1TMXW8MGl0n86C
         26ay9wY5rPZ+5Vrfh/4dh5AuckeP7JCU0dbt04HQ5iJpgeuNfU4WzW/6ZBzPBnAuTUkI
         PEs1j7NAUtixSmD0NP0brvtMvSi0XGu5qq4IlE54AYbQuVOXmx02XQXoETdmW+UEafup
         CEnpnarvRl0XxoUsxEFNiDfAUwYtJPZUr9YqiktOD/4WkFcEuY2B6u24fgKdZkMTpIt+
         BSdiF74Dw8kkhajPGq5o9BuNor0QRw4NH7dEGqVELUSalJTEBxMI7btfiUm6xVjDEBSN
         ASew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592816; x=1741197616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDBxbm0dT73n7Wu/Sv8aJeVcZAANZL/bca45vjfFy2A=;
        b=T72m5krhGioKkieJenQpt5EnuMpEF8Y+k+RDA6s9eZHA431JYOcQBE4hb5gUNnueLZ
         gxrYBXI/+i04aZrvPFy1lP3+FrPF8uiqNs9FwAIHBkkVQPG3EMpvztO/qDtujhFnmFZV
         SqTPhOJhjPFmlZYMeE5P5vaaOTT5LSKtdT9biIKnnfB3yUkNOzBuUHKQFKZ9+Rkhn036
         10AcNQAd1rbhiYfGMGwYuHXpmbgJ75x/H3UPHlqhCQGVlvpqGnjgwLnIeA9NnMhz7zOa
         tmRoYNQHq4AHmh+aC7+5Q+mt3jTbAT2Ib9f/2sa5TNptZNqLf42LbBk0HgVajfLwfDBC
         CWAg==
X-Forwarded-Encrypted: i=1; AJvYcCXAFGZNs0CA35Wh7HVS5Mbl+qZuXXyzN05CIbpCSK1ybKVtMceT8w1IblXs58DkpPi09s0=@lists.linux.dev
X-Gm-Message-State: AOJu0YyfS5++mTC5yMXwTp8CrPpdwibDCOg2iTetFIFbGcOHW8KRDtEW
	grq2EJu6SJWV6kc8GThhqNYGtG0SHkxmrTCNxfarpRIAXLQluvQ3/phxow==
X-Gm-Gg: ASbGncupCXjb8R8DMnjIPHRh945mdmezYdfP05hFowhNE0SRbJa8FLAtjfTtvmW+c0x
	3qMGbyrNKGZtJk0N+v5VYl1rusAnt5Bx/b+51MKf3hEab81vNocHJjAtNLrOXYPmsSTeQiY3/h/
	IN/yET50ye/85w/CWGRyv422aqBeqIqgDoI6AvEc2kbr2IGfSwQCNEkuxLg4CWhj/LmbtYvNjTH
	TV6AZOApB2phtC+oIE/vH8K9dRzCYtVA1ggSIsPYNWIoC3FLY/u73OQMqsy4QFBAiNufDNwA2Si
	2UGHW0HeywaRNeD8vNvMKr9e181VPQ==
X-Google-Smtp-Source: AGHT+IG8izyhiuS+7WCJqUZxFgepkO/vCC42MrdEPhQ5hZaWYRKOj+wcZo+9Nli8rDuvNm+X204wuA==
X-Received: by 2002:a17:90b:2590:b0:2ee:d63f:d73 with SMTP id 98e67ed59e1d1-2fe68ada4cemr13759166a91.11.1740592816128;
        Wed, 26 Feb 2025 10:00:16 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825bb363sm1894814a91.20.2025.02.26.10.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 10:00:15 -0800 (PST)
Message-ID: <4ec69c46-bbc1-4a05-9d7a-18c1d4d249d1@gmail.com>
Date: Wed, 26 Feb 2025 10:00:13 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Does a AP get blacklisted if it fails auth too many times?
To: Bryce Johnson <bryce@redpinelabs.com>, iwd@lists.linux.dev
References: <CADXxVSKD-YKOxt+=b919QWFHnU7QcSWnEwfb8xU-JGn=xVrbbg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVSKD-YKOxt+=b919QWFHnU7QcSWnEwfb8xU-JGn=xVrbbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

On 2/26/25 8:13 AM, Bryce Johnson wrote:
> I have an embedded linux device with silabs wf200 chipset with IWD
> 3.2.  I got logs remotely after the fact so I didn't get to debug this
> one in person.
>
> Every now and then wifi will drop off and usually reconnected.  On
> this particular one it disconnected, tried to reconnect, failed, and
> then never tried again.
>
> <snip>
>
>
> Is there some blacklist that occurs with enough failures?  This device
> ended up sitting like this for a couple hours before it got restarted
> - after the restart IWD immediately reconnected to the AP.

In IWD we have a few special status/reason codes that won't cause an AP 
to be blacklisted, but an auth timeout will blacklist an AP. You will 
generally see this log [1] if there were APs seen but they were all 
blacklisted.

The original reason for the blacklisting was a use case where a specific 
AP is "broken" and repeatedly fails to allow a connection. We wanted to 
exponentially increase the blacklist time for every failure so a client 
would avoid connection disruptions. It really depends on your use case, 
but I also work with headless devices and we control the networks. When 
there is some failure that would normally trigger a blacklist, I'm 
fairly confident this is a transient issue and isn't a "broken" AP (this 
obviously isn't a guarantee though). So in my configuration I've 
actually lowered the maximum blacklist timeout to something like 2-5 
seconds to prevent repeated failures from blacklisting the AP for 
extended periods of time.

[1] 
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/station.c#n286

>
> <snip>
>
> Thanks
> Bryce
>
