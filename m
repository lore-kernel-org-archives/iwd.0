Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E65E224896
	for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594397; cv=none; b=D8oy4TJxT/aXPR5dWeHoiNsk+Q9ALgc60GX6Sdflbja/XabmVMPfhipQhrr9/Tal8NoYOUZTRkR5xO7ot5ywFDcIaIOnaT4JoWFR30MeuDawnCSytituReuSinM4X0U4v4Bje8FKwV2dxWvH+g7mR6sDUqQwBd0lDTTPY2dDX7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594397; c=relaxed/simple;
	bh=R8eCMsxFSSwUhJp+o21+1kWxu2c9gijxCgshWvcc1fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeCLU229fZHiCPlUvSfSAzOFZ/hwQHAunvJqemXJqwr1ej9a0XAZv3fwz4VowkpFArtsEIt8+gY/BQxGLoTwuh0sa91xPBAk13yBmEfxSfPIcARIvEIuQHIhRXJTn3m3BwgUL2flHdUFnaqFSiyV1DyrS5EHLe/tYXgacmPZ7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9u9/TvD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9u9/TvD"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2230c74c8b6so2004765ad.0
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 10:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740594395; x=1741199195; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SpIUZBVMury9XQpmzhuieMSLmyiyRlaa6VfWZem2ZCw=;
        b=Q9u9/TvDv6tLHUxJyjyGu5C/D+32XNuJ55LgcgyUlN2RmWpW3Oz4NwxQ9NKGHeAFrQ
         P/WdL56ciQy547uBt0ellQUC8KZCjvFZJDma+3hSYQC0lY9LkIx/FdFiiefHQ7lITDgT
         wFCfBuW4UV/2MCOkCyW3/09LGQAhuy1j9BjdZxNnxumIw8voKaKq1FzGtBFIl0deEcY6
         OsjM7yV9hr52hC6kvGMdCz9dORmHaaFLGHJ43g3eVHhe5zia/pnz8jhR53ssF5Mbkg4q
         0zCSVODzzhHLAPRurhOtD9wPF1Yy2b4/aU0LX7tc2m+a7tWZUaSovFIaVBE2M+5cZOXl
         M/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594395; x=1741199195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpIUZBVMury9XQpmzhuieMSLmyiyRlaa6VfWZem2ZCw=;
        b=dudAyXPQwxrhsfY5083pygRusWGKCHuAmwDSsE/t0M6YpUOKBktQI9STAIluFBK6Wv
         TaLtCKnzLyFWuDO5WXSDfCBPAj9SSJ3Y+Hmgk7Rj/WHFBu37jo/9Jhm5VO+M50QWFUK7
         vbcbhF2rkmKrqTaSgp07VFI0vk+AjxT1c0TG1rwBA1XTTh8oj/m2KC5/CRx51jP4NvVI
         WbAlAEGAJvuev+tKKUq00hA+MFRSNO7MFVrx79mM20W0kjVmb+hpnIz/0luYaYGwk7GE
         aaGtiTImM1vLbSOd8dW1X/TbU1hEJ8PYolq3AsruZTeMmbUPxEE19gvTs8aftYGk9yZH
         wHNw==
X-Gm-Message-State: AOJu0YxADvSoRovozog7awhX3m98rC9PRXYKgTsmtmoNUft2wFsjoJkg
	NNTY3OyjU7FC2gTP6+lBUz2s6Q/9Kl3R3G6Je0bm+wXoUCp+fr3T2GuZ5g==
X-Gm-Gg: ASbGnctFu1eeCTXgcVRPIJs0a1N6m0aHmxXUlApvKKSLxf7vzDa8585SOlSMp6Tz9ce
	WjucKhyrBtAkexgAs8ja6kiwYeUyIlE/bEDIIuAmDOA41Xg8zhKEi+gP0avROEIFn59TeIn1rpg
	QVpcdTqPq37uOHXRUgZKZVd1dd79SLLjuJMGpBeptVYLsYHhoTh/P6PqGkvWy6Q6rEvUncEjVuA
	BCS1yWLI6PNy+ATcAnaKjtmtQEjJmU+otV44IaDNoZvaosb+XBvzTKJWqRU/mOKc6XkNekEkbmE
	YhmhAlm2SCp8UoxIkwHVxiERUQzLvw==
X-Google-Smtp-Source: AGHT+IGFUlIs+51e5GqamXkD8cLEgGQ1zbNS9KbEGAAazaG80XlFKlQk1TBRuVyz16wIN5Z64Esikw==
X-Received: by 2002:a17:902:f602:b0:21f:14c1:d5a2 with SMTP id d9443c01a7336-22307b32c3amr143870365ad.10.1740594394883;
        Wed, 26 Feb 2025 10:26:34 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0aea18sm36194865ad.220.2025.02.26.10.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 10:26:34 -0800 (PST)
Message-ID: <9ec7008a-06bb-4a59-b987-b51232cc3c70@gmail.com>
Date: Wed, 26 Feb 2025 10:26:31 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Does a AP get blacklisted if it fails auth too many times?
To: Bryce Johnson <bryce@redpinelabs.com>
Cc: iwd@lists.linux.dev
References: <CADXxVSKD-YKOxt+=b919QWFHnU7QcSWnEwfb8xU-JGn=xVrbbg@mail.gmail.com>
 <4ec69c46-bbc1-4a05-9d7a-18c1d4d249d1@gmail.com>
 <CADXxVS+xAeGUiwGTe7L0Rr+OtxqRdvZ2AwwhfgpegB8h-dA9TQ@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVS+xAeGUiwGTe7L0Rr+OtxqRdvZ2AwwhfgpegB8h-dA9TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bryce,

On 2/26/25 10:12 AM, Bryce Johnson wrote:
> On Wed, Feb 26, 2025 at 11:00 AM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi Bryce,
>>
>> On 2/26/25 8:13 AM, Bryce Johnson wrote:
>>> I have an embedded linux device with silabs wf200 chipset with IWD
>>> 3.2.  I got logs remotely after the fact so I didn't get to debug this
>>> one in person.
>>>
>>> Every now and then wifi will drop off and usually reconnected.  On
>>> this particular one it disconnected, tried to reconnect, failed, and
>>> then never tried again.
>>>
>>> <snip>
>>>
>>>
>>> Is there some blacklist that occurs with enough failures?  This device
>>> ended up sitting like this for a couple hours before it got restarted
>>> - after the restart IWD immediately reconnected to the AP.
>> In IWD we have a few special status/reason codes that won't cause an AP
>> to be blacklisted, but an auth timeout will blacklist an AP. You will
>> generally see this log [1] if there were APs seen but they were all
>> blacklisted.
>>
>> The original reason for the blacklisting was a use case where a specific
>> AP is "broken" and repeatedly fails to allow a connection. We wanted to
>> exponentially increase the blacklist time for every failure so a client
>> would avoid connection disruptions. It really depends on your use case,
>> but I also work with headless devices and we control the networks. When
>> there is some failure that would normally trigger a blacklist, I'm
>> fairly confident this is a transient issue and isn't a "broken" AP (this
>> obviously isn't a guarantee though). So in my configuration I've
>> actually lowered the maximum blacklist timeout to something like 2-5
>> seconds to prevent repeated failures from blacklisting the AP for
>> extended periods of time.
>>
>> [1]
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/station.c#n286
> Thanks James!  I'll check that out.  For also headless device use
> case, we are never moving and only provisioned to one AP.  So we'd
> like to try as hard as possible to stay connected to the AP.

Ah yes in that case I'd set the blacklist timeout to something like 1 
second. I just looked and the blacklist code needs some work tbh. You 
can't disable it, and I don't see any checks to ensure the maximum 
blacklist timeout isn't lower than the initial... so I'll fix this up.

>
>>> <snip>
>>>
>>> Thanks
>>> Bryce
>>>
