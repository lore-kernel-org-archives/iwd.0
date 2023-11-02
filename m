Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FF219BDE
	for <iwd@lists.linux.dev>; Thu,  2 Nov 2023 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvSg9PaD"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ce31c4a653so538878a34.3
        for <iwd@lists.linux.dev>; Thu, 02 Nov 2023 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698938269; x=1699543069; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hm2sz8UzZAir2aBhaZ9+9SfG0wBOIYEJY0COjH7gno0=;
        b=TvSg9PaDpyV2ccvGIYln/h2rdNLve5Hm4JZvqfpPQAARWZzxb8xsLR74qbadvY63dM
         oKL3wOpBf6QOMDhuC5A8XZ1MFgU4dSPlZA0nE/MhIKxjzJEbnQPX8fUFppOBs17dbdxy
         CbG531VRMlAnEKUrbWnKUsQhdpf6nJ2N0TQlRQmaegdYqy/uNDVH0C/g3SVycH7rVvHY
         Pg26m8y7e3fLGqvSU6Qi6yht3rbmZPfFOz7TwhGuRTKrZiHbcYGKcvbUAT7kcIVhTnBt
         vQloSSKt6U4NjqrU4nQVQtSb7Dt9TQhDh5cS/Yc88bwYQCUulI/6JBZTHdRwLlqdokK0
         ZOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698938269; x=1699543069;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hm2sz8UzZAir2aBhaZ9+9SfG0wBOIYEJY0COjH7gno0=;
        b=aivXbtTzfHCrp0jEtYlTnrOXwxVGLYXmOZ3VtR6wKaoRawwDIz4Ns157+8xIPRsnGo
         iT9eYnV7TL3HV5at+BtI+d80/huLcdx/dRskRisjhA3FZft3Mpcgcr16J1in+6/AF2i/
         +Nsz6cSHQp1mPZF65i4YP6w9ynEbIpgzJRT5jk6B27wnOhTXnlAd8jQQwxEKBrmtTK3w
         HEDXH4c2yyhebWXoxqQsiRWefoe5fb6C3BYd6nlJuut0SuPNMUQi5DLFFXMofItuo5Wh
         k5fJzbDkncdtrrlOzYheoJSwzG4wMWSNgR4q6CF6gPs1Tz803QgpDYdZWZ5oFL/p/qCo
         uJdg==
X-Gm-Message-State: AOJu0YysERhvvt3PzZDXUxhRL1uCdfYv056lPgZ2PjAPAPln3XT1ZX/M
	nv4l5HYA3xS/V4+2cK4htYA=
X-Google-Smtp-Source: AGHT+IE3YYXZzyDBBUQeZBv3KPR7mxmbXZQ5/aNpn0mXjfykRZKXaE5UTR+feeDdlJWXlVAkcwnxKw==
X-Received: by 2002:a9d:6659:0:b0:6c4:c3ac:a9dc with SMTP id q25-20020a9d6659000000b006c4c3aca9dcmr20396467otm.21.1698938269552;
        Thu, 02 Nov 2023 08:17:49 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id x15-20020a056830408f00b006b9848f8aa7sm525268ott.45.2023.11.02.08.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 08:17:49 -0700 (PDT)
Message-ID: <424127a9-af47-4a15-91f1-ff97e7ceacc8@gmail.com>
Date: Thu, 2 Nov 2023 10:17:47 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Packet/beacon loss roaming improvements
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231030134837.452957-1-prestwoj@gmail.com>
 <b5138012-c4aa-40bd-892e-5b578a29ade4@gmail.com>
 <0cf695c9-7abc-40e9-a6fa-fdd10589839b@gmail.com>
 <fb8dfeeb-3f5d-49d2-8a4e-063b4933d905@gmail.com>
 <70935a8f-1f38-4e9e-8d77-40179c2b31f3@gmail.com>
 <68d50637-4b8d-4690-bfac-e379e1044492@gmail.com>
 <d5be907b-5790-42da-a17d-6ded2f9562a6@gmail.com>
 <27703a4f-a071-4ff7-afbc-8dda1c5b0b27@gmail.com>
 <be09ed30-f92c-4f9d-897d-77d9d5f7a919@gmail.com>
 <16ab09cc-0ba9-4c01-9f92-47e05aac2160@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <16ab09cc-0ba9-4c01-9f92-47e05aac2160@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> In the behavior I witnessed which was actually quite reproducible at the time, 
> and yes roaming on beacon loss definitely helped. It avoided an inevitable 
> disconnect.
> 

Okay, then lets put this in with a 1-2 delay to let the kernel disconnect if it 
is going to.

>>
>>>
>>> I'm not sure how, but being able to detect if the AP responded to 
>>> nullfunc/probes prior to the kernel blowing away the connection would be 
>>> great. (like send our own nullfunc frames or something, not really sure...)
>>
>> Yes, the current implementation of this event in the kernel is pretty useless. 
>> What we really need is an additional threshold that generates an event out to 
>> userspace _before_ the kernel starts taking potentially irreversible actions. 
>> Something like a pre-beacon-loss event that gets generated when 2-3 beacons 
>> are lost in a row.
> 
> Best would be an event like "Disconnection Imminent" (after the 2 nullfuncs 

It is too late by that point.

> failed) so userspace could start a roam. Like you mentioned even if we knew a 
> few beacons were lost, scanning is probably going to ruin any chance of recovery.

<snip>

> 
> In theory only 5:
> known_freq_set = known_networks_get_recent_frequencies(5);
> 

No, that picks the top 5 most recently used networks.  The known frequencies for 
each of the top 5 are added to the quick scan.  This works okay most of the 
time, but we do not rotate out known frequencies, so if you have a network with 
lots of APs spread out over the spectrum, it might end up scanning quite a bit.

Regards,
-Denis
