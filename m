Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AF6116
	for <iwd@lists.linux.dev>; Mon, 28 Aug 2023 15:36:55 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso5153925ad.3
        for <iwd@lists.linux.dev>; Mon, 28 Aug 2023 08:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693237014; x=1693841814;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVHrK38OTGcj9I9hMjYQNhUWoyPYnkUjCaCqsfipxjY=;
        b=S5syOmdXpEAc9iW54hw+SIr2YBimpY4KwuOJZofyGUmPhb8DmnzKAAHh8jqWs47/1U
         gRbu2tADDohDsE9ykjKhbTXqSWjI+tOa6VpTMEKrKMm1BYdWQBWigll77z5xduVMSceB
         byyZV5MZx14xBB9BRHCAKD1+PEdtRPw1cK8E1cvDDd6gVYLLSnR7oPEGAVDrZjYI7EI2
         vU0bcQRWnoq0nHmEP18JdQEUZY3lM03aEoSPEBaAXVLX2zh+n3hAp0hO/s/ZYBCCW/1t
         ZzWa/ocA8aiFW6kC++Sc8c7TUTvvlh7W5MwfCULFlQSQKCU0IGHX9p+Y4Qd3rYIgiWR+
         VtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693237015; x=1693841815;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVHrK38OTGcj9I9hMjYQNhUWoyPYnkUjCaCqsfipxjY=;
        b=JGutOkXNVC/FO7/3AyKZNzJAhbiIHPGjOOI3rysjjnUE+z5UTGLs5yifTb1/95yJBB
         oCIO1vMxu71W+BcOSrPg7hjeFNAB5/HZX+N7e8IoZ4CBIh9PMxX//+dJ+57RxBWBTEc1
         eiDT6WOnnW6tx6AZXLLipPRNyc07hWTvLl1Zap3CepKims01YjsNJNfffe3keED2Nsvf
         GRBJCEXlnozNw/Ij6cAgW7diz35llot4BBDfB5Qs55GnJRzYSSau43oqMsVmiHZEWoHj
         7BDsliaDRQyR/uEFPulRucXSczqBpAP5EJgBFm5e93WbAhCDQmN4BnrbH6BXIWI8/zGe
         iHRA==
X-Gm-Message-State: AOJu0YzirwT/Tw6aQNtyjLOFnNqAzW5/ilNfoL1VxbN61XdddyZIGP1+
	pywxGJZLhQXqvwGu6nbl0ho=
X-Google-Smtp-Source: AGHT+IGAD1XmnkkTU0gPGR45Mu2WrkbUQWM84U8zHlQ7xU1/nNId5zQcun4eUJACba/RT7wH1r6sVw==
X-Received: by 2002:a17:90b:2304:b0:26d:1a49:d1e9 with SMTP id mt4-20020a17090b230400b0026d1a49d1e9mr20814051pjb.17.1693237014545;
        Mon, 28 Aug 2023 08:36:54 -0700 (PDT)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id h12-20020a17090adb8c00b00267b38f5e13sm7223610pjv.2.2023.08.28.08.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 08:36:54 -0700 (PDT)
Message-ID: <4b2351d6-9508-4c55-9929-05591aeec777@gmail.com>
Date: Mon, 28 Aug 2023 08:36:53 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] station: fall back to reassociation under certain FT
 failures
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230822152931.276136-1-prestwoj@gmail.com>
 <20230822152931.276136-3-prestwoj@gmail.com>
 <4ed15cee-23cc-ded0-ef37-5e1f4424ddc6@gmail.com>
 <a6522b7e-0cec-4f15-9bf3-8e53d832f0d4@gmail.com>
 <f01aeb4a-b909-5fe8-3bde-5b77639bcba6@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <f01aeb4a-b909-5fe8-3bde-5b77639bcba6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 8/28/23 8:02 AM, Denis Kenzior wrote:
> Hi James,
> 
>> In this patch the strategy is to always try the first candidate: try 
>> FT, and if failed with status=53, try reassociate.
>>
>> There are drawbacks and benefits to this:
>>   - The drawback is if reassociate also fails we have to disconnect, 
>> and can't FT to any other candidates. This would mainly hurt if there 
>> are other good candidates to connect to.
> 
> So that is a pretty significant drawback in my opinion.  There's really 
> no guarantee that the behavior you're seeing is the same for every 
> vendor.  As you point out, trying FT first has very little drawback.  
> Falling back to the slow re-associate path does, especially on 802.1X 
> networks.

There isn't a guarantee about this behavior, but it is how hostapd 
behaves if the FT key pull mechanism is slow or not working yet. Either 
if the AP backend DHCP server is slow, or some other network issue. I 
really have no visibility into why it happens, its hidden behind their 
proprietary backend. Anyways handling this specific error code, if we 
can minimize the drawbacks, shouldn't hurt clients in other network 
deployments who's vendors don't have this behavior.

> 
>>   - The benefit is if there is only one available BSS to roam to and 
>> we failed FT but reassociation succeeded. This prevents us from trying 
>> and failing FT over and over. In addition if there are additional FT 
>> candidates but poor ranking we would still connect to the best 
>> candidate even if we do so via reassociation.
> 
> If there's only a single candidate, there's no difference between the 
> two approaches.  I'm not following the argument in the second sentence?

Yes a single candidate won't make a difference. What I was talking about 
is if you have the following:

Current BSS: -85dbm
Candidate A: -55dbm
Candidate B: -84dbm

If candidate A failed FT as described we would then FT to candidate B 
which would then immediately trigger another roam. I know its a very 
specific scenario but definitely can happen.

> 
>>
>> The decision to retry with reassociation mainly boils down to if there 
>> are other "good" candidates. If yes we should try FT on those since 
>> its faster and failure tolerant. But if all the other candidates or 
>> lack thereof are poor, we should reassociate to the one that failed 
>> FT, since its the best. Doing this logically is hard because we need 
>> to define whats "good" and whats "bad".
> 
> That sounds like an argument for trying all FT candidates first.
> 
> Doesn't iwd only consider candidates that have a higher rank than the 
> current BSS?
> 
> Another possibility would be to insert the BSS twice (or reinsert once 
> FT fails), once with FT and once without FT and try them in rank order.  
> Still, there's almost no penalty to trying all FT candidates, so unless 
> the ranking calculation is really off, I think that is a better approach.

Ok, I'd rather go this route then, re-insert the BSS without FT after 
this specific failure.

Would you want me to put this behind a config option? Or you think 
reassociation based on ranking is ok? Again, it would only be with 
status=53 so I think the impact is minimal.

> 
>>
>> One option to make this better would be to recompute the BSS rank 
>> after FT fails, without RANK_FT_FACTOR, and re-insert into the queue. 
>> Although a 1.3x factor likely won't make a huge difference. The idea 
>> here being that if other candidates are closely ranked we try those 
>> via FT before falling back to reassociation.
> 
> Right.
> 
>>
>> Another option is to introduce some cutoff RSSI or rank value that 
>> determines if we retry with reassociation or move on to the next BSS 
>> with FT.
> 
> I doubt any absolute RSSI or rank cutoff will work.  These are very 
> hardware dependent.  Better to refine the ranking calculation, but in 
> the end the information we base the rank off of is imperfect, so 
> sub-optimal decisions are going to be a fact of life.
> 
>>
>> At the very least (mostly applicable to 1 roam candidate) we should 
>> keep track that all FT attempts failed and try reassociation on the 
>> next round.
> 
> Or better yet, have the vendor fix the network.

Agreed... but easier said than done. This is just one of several issues 
we're trying to work around on the client side that we shouldn't have to :(

> 
> Regards,
> -Denis
