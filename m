Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86413FED
	for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iom1e8O1"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7789cc5c8ccso371190585a.0
        for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698160009; x=1698764809; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xuxt0oXjQCnUDRPj9IxBJBlwfgGUCBP6dxHvxRJ8GmU=;
        b=Iom1e8O1hcFcm91qpeC1zI1i4tuYYalcq6+/AYs0ZYy29yIpGBqyNm2JOZ2OR9UaQ5
         S0559vlN7FIqCLAWKTX6f7WEwr/PcURqJKYUuBQOBJ8h8N9DTliuEKV8HBJfnhxTitX1
         yQZmdOZsZbnl7krGMsbPxxdeSfHA6EvsOFxt7iHPoT7LAfALyHoj7R+1Lyv6ggPs76Vc
         UtHUBjYw19/R4orhKWNTJCDW0MW5huLeatGUmvcGS+vEIkWr/9Yd24bbLpDl7d89Inrg
         2gOzp7L52RKuU4pA5jW3eQS2WZY4Xq/uDoezkZNkupuafVM7FB8Ev9L0z2xf5rhjbq1n
         H8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698160009; x=1698764809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuxt0oXjQCnUDRPj9IxBJBlwfgGUCBP6dxHvxRJ8GmU=;
        b=gY+iYWjdrfeGQOMEKsoAke7cHP5RuoiQWpQB0Fy456XYOPWn0SybOD0M7XsHo1/HTq
         TVs40tyIGLfRj9rq/2ggZ3sv6eQAJC3vojF+GSqYimIXenkvgQogrR0BS7gBispe43N9
         iSkaEoy36REobEfGoZkXr65JyZ+jN7ygUwjWl8w7NqHdoh1h11bAUhWZXp3IUlJjdUMI
         TJoaGSah1NMsh5fVz6gwzDRufT/IbvUWjNasgqXfyaq1VJhNwSbkem92hsrYfSY93WVM
         nEzVKOKIx9NrzV38n67cjwOD+/lk/TsvwHm8WdhiBFJs1ugCFAW0a+Tb9Guw4LXmBklv
         phGg==
X-Gm-Message-State: AOJu0YxXMmY55dDvjT0VPC1GHi6L0elUEImqsGYyIP1iM8OTd8KTvYCv
	K/G2TL/yNZLqD/V6FbmYGj/C9TqGx90=
X-Google-Smtp-Source: AGHT+IHtVNfNz1eN9vbtaPxzcUZeYhLxZeMJbNaF3BdWdlvODWgyB0Ff3+v1sNhZGHVdTxd/KbfeWA==
X-Received: by 2002:a05:620a:2455:b0:778:e431:3ef1 with SMTP id h21-20020a05620a245500b00778e4313ef1mr11694443qkn.32.1698160009274;
        Tue, 24 Oct 2023 08:06:49 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id m26-20020ae9e71a000000b00767dba7a4d3sm3472403qka.109.2023.10.24.08.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 08:06:48 -0700 (PDT)
Message-ID: <8a9039e3-1db3-459f-874b-e53d8dcdc16d@gmail.com>
Date: Tue, 24 Oct 2023 08:06:46 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>,
 Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
Cc: iwd@lists.linux.dev
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
 <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
 <bwuu4ra65fpfpenytgu5a6ftjpvyury4omx7ucy65cshorqskl@5ikhebki4wnk>
 <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
 <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
 <f7ced477-6fa4-4efd-bf54-817b100041ef@gmail.com>
 <ccb68e07-e4a0-4e50-b7e2-2a2044d38487@gmail.com>
 <30b6dad4-64b2-41ca-8712-053cb1396eaf@gmail.com>
 <ncmtsi42vkdimzxsuktgfblp66agskivhuntdjlooyp7gglhgo@kwuxknllo527>
 <sebayhpora5e5ispmp5nnjesihoewc74ohygd3orxp7k22ky4c@tt225sdpjrxm>
 <29094eca-dcf8-4234-8afc-13d37db8450c@gmail.com>
 <9e12bf94-aa83-4fe6-b045-8dab45b264ae@gmail.com>
 <3d2c3d76-e08c-4d71-8a72-7193dd51cbfc@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <3d2c3d76-e08c-4d71-8a72-7193dd51cbfc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Simonas,

On 10/24/23 7:26 AM, Denis Kenzior wrote:
> Hi James,
> 
> On 10/24/23 07:32, James Prestwood wrote:
>> Hi Denis/Simonas,
>>
>>>
>>> Now the question is, how do we make sure iwd is estimating the HE 
>>> rate if available?  Also, how do we tweak the estimation logic with 
>>> sensitivity numbers (obtained from a spec sheet, or through 
>>> experimentation) for specific hardware being used.
>>
>> Trying to catalog different hardware performance and act on it for 
>> ranking is an impossible task :)
> 
> We can actually have our own hwdb of sorts for this.  Hardware 
> sensitivity is a differentiator (think marketing), so should be fairly 
> easy to find.  Also, it doesn't have to be absolutely perfect, just 
> reflect the hw capability a bit more closely.

I shouldn't have said impossible, just quite an undertaking. It would 
rely near 100% on community support to add various cards, in addition to 
the "hwdb" framework being committed to the project. But we're open to 
contributions!

> 
>>
>> The only simple solution I can think of would be to add a user-option 
>> for some threshold RSSI in the rate calculation. If set and the RSSI 
>> is below the lowest of ht_vht_he_base_rssi just use the last index 
>> (-82) (and maybe force a 20MHz channel width?). This would at least 
>> let the rate logic return _something_, albeit maybe not accurate. But 
>> again, those RSSI thresholds were sorta made up anyways :)
> 
> They are not made up, they're direct from 802.11.  But again, they're 
> the _minimum_ specified sensitivity.  Hardware typically does better.

The rates/MCS table (ht_vht_rates) is from 802.11, but the mapping from 
RSSI to MCS index's (ht_vht_he_base_rssi) is not. The spec just has a 
formula for calculating the rate using a given MCS/channel width. IWD 
just chooses what it thinks the MCS will be for a given RSSI.

I don't remember exactly where I got those values from but this seems to 
match:

https://wlanprofessionals.com/mcs-table-and-how-to-use-it/

So ultimately its a bit "hand-wavy" but so far has served us pretty 
well. Whats happening in your case is the RSSI is below the lowest 
threshold so its not calculating a rate for HT/VHT/HE (at least I think 
thats whats happening). So my idea is we just force it to use the lowest 
MCS if some threshold is set. That will calculate _something_ at least 
rather than failing.

> 
>>
>> So you could set:
>> [Rank].LowSignalRateThreshold=-90
>>
>> Any RSSI between -82 and -90 would use -82 for the rank calculation. 
>> No idea how this would play out in practice, but its at least simple 
>> and not tied to any given hardware.
> 
> No, I was more thinking about:
> /* Added to the rssi value prior to looking up in the 
> ht_vht_he_base_rssi */
> SensitivityFudgeFactor=4
> /* Width penalty */
> SensitivityWidthPenalty=0 (3 today)
> /* NSS penalty */
> SensitivityNSSPenalty=3
> /* Same as SensitivityFudgeFactor, but for HE */
> SensitivityHEFudgeFactor=10
> 
> Regards,
> -Denis
