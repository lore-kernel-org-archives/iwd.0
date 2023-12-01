Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9A38829
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7mTH1H4"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-77d67000b69so121473585a.2
        for <iwd@lists.linux.dev>; Fri, 01 Dec 2023 08:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701449264; x=1702054064; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/sxp3YoiKIkx3FdbkeNvSu6otyMrI/dpnwZbmW8jjI=;
        b=Q7mTH1H4ndJVKkIBlnGFEriqYwJl6ky06T0tusRlpAmqiyMR0EWjAZd/hbovsBObpS
         MwV562awyW2wNt6gTaOjG8RlmMCB/Lli4dRRhV5F++2v8CuFmYwT7R1XsyL3EOQ9m+v4
         rG0V6jeOKV6D0kKQhlbxBIHL0nwcKhoM38Vv9T2nga2D9DS5oaw8TccDwrd3NpYpDtHW
         s1BbfBbRq80aY+MHJb1cMJcceKYSdrOPN8L8glXy3ZBsFYZDug6mEkOm3jQIbfqTdmWY
         +xR4zkl8gMj4JAASOXnyS+QRU/z+jDruYLvUbz7Z0fju3uiGXp/dGMEg2YB8NXaMwaC5
         llEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701449264; x=1702054064;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/sxp3YoiKIkx3FdbkeNvSu6otyMrI/dpnwZbmW8jjI=;
        b=DrZbdRWx29YUR8kH3NMrvHugzXwjcYMzuJTqFfOc+O3AhoUUwPylXIB81HNPqhN0s/
         EQ8p3y7gzwt+ACshuvbR/wFeLVOkTkOnX76/dbNEygmdxX8Y9xzFaV8wJ4sd93ita+8a
         8FDfczRIQljEqihfKM+iY+zi6xEHM+TzQ6q4mMRnB2vDGmHqhiw+H0NWwI7aFGJADo9L
         /ENSz42mxBIi4DbNOILwCpnDRR9egOlRcsUdalDu9s51/bxX7GB+QbMM75jTUD2MCfIg
         S0TFYZOIXUzxqvrtzPPv2i2esL2p27MwfQxKZNC4mNZoF05oNiUajaRqRYLzlMUwdjSD
         bvCw==
X-Gm-Message-State: AOJu0Yy0dL8qeqOKkmtT5wNrI1Mb4eixcj5F0VBBQG4k5DKdYKH6haMu
	Zm0zVz/JUu4j7jYcU0gWVt2AB94sTsk=
X-Google-Smtp-Source: AGHT+IEFDVX08XYlKRPOj3Aw8sWjpw4t2ObuAVmee9Pvp+3iOt/euUMCTofEI5TIcA9wuYMD2e1QHA==
X-Received: by 2002:a05:620a:801b:b0:77d:73ba:915d with SMTP id ee27-20020a05620a801b00b0077d73ba915dmr30145213qkb.40.1701449264336;
        Fri, 01 Dec 2023 08:47:44 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id rg3-20020a05620a8ec300b0077703f31496sm1635204qkn.92.2023.12.01.08.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 08:47:43 -0800 (PST)
Message-ID: <a8ddba3d-0e13-449f-840a-10f0cb980403@gmail.com>
Date: Fri, 1 Dec 2023 08:47:41 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] handshake: Add cleanup function for handshake_state
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231201040020.161143-1-denkenz@gmail.com>
 <c0e09d22-519b-4161-b8ab-32e3830569fd@gmail.com>
 <b656ec75-6f85-49c6-b78b-75d15f0aff08@gmail.com>
 <43b52716-991d-436b-b1b6-a6d9d459ff8c@gmail.com>
 <6a803951-646d-4fbc-87e8-44b8c3a6436b@gmail.com>
 <7a80e9d4-ecd8-4592-a5ec-d81cbe666991@gmail.com>
 <b6ea29ea-5fa8-4ac2-afea-3ff2507322eb@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <b6ea29ea-5fa8-4ac2-afea-3ff2507322eb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 12/1/23 08:32, Denis Kenzior wrote:
> Hi James,
>
>>> Nvm, I'm getting the 4 failures on a 6.6 kernel now. Something must 
>>> have changed so I'll look into it.
>>
>> 6.2 - works
>>
>> 6.5 - works
>>
>> 6.6 - broken
>
> Sigh, figures.  I doubt the patch from Johannes would fix anything for 
> us since we don't query carrier state directly if I recall correctly.  
> We only react to events, at least on the connect path.

Two separate things here:

  - Confirmed that CQM events are broken at least in 6.6, this was the 
patch I linked in this thread.

  - Earlier email I sent about the carrier state was more of a suspected 
problem for flaky tests, before I even saw the roaming tests were 
failing. I haven't tried applying those kernel patches, but it would 
also require userspace changes checking that extra attribute. I just 
need to look more into this.

Anyways, yes, unfortunate. At it's also broken in wpa_supplicant so its 
going to get a lot of visibility.

Thanks,

James

>
> Regards,
> -Denis
