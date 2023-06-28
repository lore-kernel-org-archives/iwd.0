Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827CA322E
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 17:03:04 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1b056276889so2274066fac.2
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687971783; x=1690563783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=49BczUFNOW+nKz2jKO/peRZsDjYnvH8ZiTng6k4Iu/w=;
        b=My3t9jghedRPmZRmqLW6RJuM2FKES/v2ExEIzg10tl9X9+bh2JX0mSustj47XWSP5q
         SLaPpBmziD7Fs08XlT/KVPDDzdWzKOW6YNHQ38fwz31g/89fVGU2TEXPEN46XLk9RJ3D
         /NxR8d8M/SEROq3y9Fb1Niaiyb7V5LYsWNGJ/9/7oQoJZboe3t7dletcYYkQdLOcIvEP
         cuEvdBhrHK+Yw76NgYM2hhj98iKi6RJCqVr04L+YnjglP2Xctm8E69P/lmuLnggGlNtD
         wHyHc+SNV821Y2eS+/HDthq1mmZlObGyjfsRSVxPIGHrCCLv3MnIxZ2V0eMtarLZTWzo
         NUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687971783; x=1690563783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49BczUFNOW+nKz2jKO/peRZsDjYnvH8ZiTng6k4Iu/w=;
        b=lFIwIs85p19P3VWRUcC2D6SYGagOL546MFO1l1xbAd2ZfaY5cwEi57Iq8JddK0X+Nf
         UAxnvlgdYfUymo5MXaCqsGn7shZjeQXHnuOKQk6bJq2GfO1vT+GTaTHmWDI9n+PKp6r0
         sjejlVyUoUlWXffWPE8UZgMGxbITENzz97dznzap1RZqGDW9t+909/B4u5AWl9S9zpyO
         oc7j4U3ukN+JEA5eu2vZMXJZchRwU/r9RTaCdy469nCZwxLFfCotEx11CGtdz+TQHqiR
         JpOvmTOiWoJuHgPaQICrhb3YNV+GxjgtZdDK+LG/R7fVjB0p7qaL6JA2C9CeZgRzYGKz
         9veA==
X-Gm-Message-State: AC+VfDwOT0Cilcfq5z/SBiVKt0jjPvUV3cA2LUDVPkHMpxlNGvITzREL
	uGn7cy1NttNUdSypUMfssOd93yUUzGU=
X-Google-Smtp-Source: ACHHUZ69koYbKar67LMsH9jGqfvFaLhgxYIZLJbDElVj/cRF3+0jaFPISOzI8LjS6H5FV6jBTsGjmQ==
X-Received: by 2002:a05:6870:3044:b0:1a6:987b:f09d with SMTP id u4-20020a056870304400b001a6987bf09dmr46186989oau.51.1687971783184;
        Wed, 28 Jun 2023 10:03:03 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v41-20020a056870b52900b001b053e47bb3sm3228634oap.43.2023.06.28.10.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 10:03:02 -0700 (PDT)
Message-ID: <44b16fe4-064f-dcc1-88e8-3e238c74c4a5@gmail.com>
Date: Wed, 28 Jun 2023 11:57:20 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230504215247.581443-1-prestwoj@gmail.com>
 <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
 <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
 <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
 <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com>
 <d2d0841b-62a0-c8df-924f-851df5f88203@gmail.com>
 <865cf0a3-1be4-34cb-0535-e76cf43d6753@gmail.com>
 <63162827-5b8b-3c70-7f6f-fc7b513f2b6d@gmail.com>
 <1742c6eb-bbd5-7883-5a72-53021a771ca6@gmail.com>
 <3790483a-442f-9602-03c9-b205376d9262@gmail.com>
 <280831cf-933a-95b0-3889-ddca6ca544cc@gmail.com>
 <24a0ae5c-529b-a061-0fb4-0ba8a66fe76b@gmail.com>
 <2c35a14a-3ed7-fefb-5a78-fb29199f0fd4@gmail.com>
 <82ba7228-441f-ebf1-22d2-890b00c676e2@gmail.com>
 <7c2ca71d-5cba-c067-04bf-75a9341f3db6@gmail.com>
 <6795644d-1ce8-6937-d8b8-4318f2720289@gmail.com>
 <5b044364-7a3d-7be0-ff18-bcba656e6172@gmail.com>
 <1069cde5-2ef9-657b-77a2-931615fb2104@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1069cde5-2ef9-657b-77a2-931615fb2104@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> Then this may be a conversation you have to start on linux-wireless.  I would 
>> have thought that there should only be a single wmediumd instance on a system 
>> regardless of namespaces, but maybe I'm wrong here.
> 
> Yeah, I'll do that as well. This would simplify things if the namespaces didn't 
> come into play.

Check
100cb9ff40e0 ("mac80211_hwsim: Allow managing radios from non-initial namespaces")
f21e4d8ed16b ("mac80211_hwsim: Allow wmediumd to attach to radios created in its 
netns")

 From those two commits I get the impression that the intent is to allow a 
single wmediumd across namespaces.  If for some reason the ADD_MAC_ADDR messages 
are not being sent, then I would look into fixing that first.

> 
> Nevertheless, was the distributed hwsim concept something you'd be interested in 
> accepting upstream? Like I said, I'm already doing it and I'm happy to re-use 
> hwsim and extend to support this external socket concept.

I'm not against it, but as you point out, it sounds super complicated.  So I'd 
have to look into it more once you are ready to share something.

Regards,
-Denis

