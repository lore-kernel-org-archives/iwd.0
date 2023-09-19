Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE521747C
	for <iwd@lists.linux.dev>; Tue, 19 Sep 2023 17:29:58 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-577a98f78b2so4293758a12.3
        for <iwd@lists.linux.dev>; Tue, 19 Sep 2023 10:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695144598; x=1695749398; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9pWK28ktYyM77owEuLeJKwGfxCmfhb1pjXKoU3wQy8=;
        b=Y23KL7H4xQvv1z/9KmjsxzUP9JsvWilASJ95/N3qvIFZ9bycecmtntX11kp/s68BeZ
         0mvOftChCrvRTQqltYlJs0wTqZa2cq7JBwqXrgTmmJtxEdlyNPAkrMb1sEwXcEzvpC2x
         WkNLG0cBr1pd67acXQyDtd4JKI70eBV8NggeZsahTAsEOUX8tCYk3pBZEbehx8302kFS
         U7VUHVoF1WU+vE6moPq4uWWnLU2R6pj0Ne1eX2dBgLMjnHJRgWHhyYWcflK208Beb4nE
         ch22OqXQz5NBRgwE3Ylc2ljAgKcxG/uZv0wk5+HA6aD4J4LL+P0RALvk1as9X7eQxAiI
         Kd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695144598; x=1695749398;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9pWK28ktYyM77owEuLeJKwGfxCmfhb1pjXKoU3wQy8=;
        b=rNFTMC5BuWKoYjy4XB8aNuBzUrZO0yr7Q+vl85wK7cTspXx9dpRQg6Kvodz4IcMsWP
         sx3TNGrIsuHrtfyvdJTcGSOL+dAcHEZVlxkWqZvJ44byWsaqyBBxbxz5ACKCIawk/713
         I9XhPo3jehUwbNL5hwy/sG2PlEboapCti5N5qSjgbnVPFwO2cS18q8SbHanHEpOKOfG8
         jcTm56kHGHg7zaxEEAUiyA+KjysL3Ir32FYqYWTX40kb6+jwIiE5BOD6+VvfiHkvKPqA
         vFkaMbhkY73V14kCAPS8L/fZux4BCSXBR7Q3DlMnP/5mt4Q9emnWp28kotCvo5PSfz8g
         Itjg==
X-Gm-Message-State: AOJu0YyxUEEmVNGsepqh5rp0Qk8J8Ykn23lbM74hYMj6CR0ZEvA9L57P
	S3aRDzkShRXpkrJvvqVsJYA=
X-Google-Smtp-Source: AGHT+IHmPcf8C8dLmmDrhehKrcnoBeDIqsTs5bM8BIQWhfnojIDkRRUP6SERu2otizB52prlbBtbSg==
X-Received: by 2002:a17:90a:f292:b0:263:ebab:a152 with SMTP id fs18-20020a17090af29200b00263ebaba152mr387256pjb.19.1695144598176;
        Tue, 19 Sep 2023 10:29:58 -0700 (PDT)
Received: from [192.168.254.38] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a19de00b002694fee879csm11585852pjj.36.2023.09.19.10.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 10:29:57 -0700 (PDT)
Message-ID: <21fba510-baf5-4719-8938-b1564c9d6654@gmail.com>
Date: Tue, 19 Sep 2023 10:29:56 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Force use of 5GHz band
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
 <d0b59d7ddf82006b6280e3b6652614d9ece09f7a.camel@grosse-sundrup.com>
 <6aac9366-36fd-474d-882e-1bcc940fb444@gmail.com>
 <ea23c922129d3c18c4affb0f0e4a737b7e2a03e5.camel@grosse-sundrup.com>
 <e74c1a50-b5bf-48eb-a53e-100d9706e7f5@gmail.com>
 <43d47533-a4a3-e3d5-8f17-30467475660a@gmail.com>
 <8629e294-0550-436d-91b3-e0cf1c84f8e7@gmail.com>
 <42efcf9a-6aca-c728-ba9d-fe95a6066900@gmail.com>
 <e144f8a4-82b2-4882-bf25-5fac6165b9af@gmail.com>
 <a61e3a1d-9e97-89c1-d543-6b6ba9860146@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <a61e3a1d-9e97-89c1-d543-6b6ba9860146@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/16/23 8:18 AM, Denis Kenzior wrote:
> Hi James,
> 
>>
>> How would you prefer I do this? We've got quite a few modules using 
>> scan APIs so I question if we want to filter the frequencies before 
>> calling scan_*
> 
> We should be doing that already, no?  Any code that specifies scan 
> frequencies in some way should be aware of wiphy band capability and 
> regdom.
> 
>>
>> If we filter in scan.c and call back as if the scan returned no 
>> results we shouldn't need to touch anything except scan.c. The 
>> downside is its a bit of 
> 
> I really rather not generate dummy/bogus callbacks.  That just pollutes 
> debug logs and makes the code hard to follow.  Station would be most 
> affected here since it breaks up the 2.4Ghz band scan quite a bit.
> 
> If 2.4 is turned off, it should just skip those requests entirely.
> 
>> wasted work doing this since we have to create requests and work items 
>> for nothing, but the alternative of adding this specific logic to each 
>> module using scan calls seems worse IMO, what do you think?
>>
> 
> One thing to keep in mind is that some devices operate only on 2.4G.  
> For example WSC/WPS might only perform push button operations on 2.4 GHz 
> band and not 5G.  Might be similar with DPP?  So for compatibility 
> reasons maybe this should be a station-only feature?

Yeah, keeping it station only is good with me. Only part that gets nasty 
are periodic scans. Since we scan the entire spectrum and specifying a 
frequency list will break the 6GHz logic we have... So for this I'll 
need to add support to split the scan request if explicit frequencies 
are provided, since periodic scans will need to include a (potentially) 
paired down list if the user disables them.

This could end up being useful though if e.g. a quick scan includes a 
6GHz channel and is able to scan it rather than falling back to a full scan.

> 
> Regards,
> -Denis
> 
