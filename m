Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AA446AB
	for <iwd@lists.linux.dev>; Mon, 28 Aug 2023 15:02:20 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5733d431209so2107134eaf.0
        for <iwd@lists.linux.dev>; Mon, 28 Aug 2023 08:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693234939; x=1693839739;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVSoubtxrfiq8bQgyM+uwMV+nwzRgBGXD9aTHCrWyNM=;
        b=MpDCfTLvGHnRxkO8rx54npVjonPy7PIQ1EIv5quyEqDqUJOyNW7rTVIdTirV+iCBcR
         5oL4IsoslIXUaqk05qpLLsBdhujlu6l4l44dxh5Kts24OaF7Uxzo6045iwOFwts3NURn
         GbDxrTb/qYOZj7rHpfv49VKW6uNeN48Nk7cuUp4pPbjB+DF7oU9HPGmmRv1zYbRrcqxO
         hC24ruqhyQ2Z3GNSWQZdLHBGA239ZvZHF2ZNRIAMkjeM0DuLG2ylmU/TtmJnSb9sROxM
         33prA20K4or67wVfbcpapm9Y+P+4ly+pWEr8lzf4zdYyGfCf9a411X0bCdgBO6HdOsII
         KksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693234939; x=1693839739;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVSoubtxrfiq8bQgyM+uwMV+nwzRgBGXD9aTHCrWyNM=;
        b=hursoxY3Qnz7k4JxoWxx+vS+8ybrojKmW4L5MGk9cSLeHcwsVKULM4J+Tk9sOeH5Uk
         rFGgVZaIKpptq32xQG2uTtZvOtYulVB4u689Ojbv20WQeZ5ptiq+tLjepS+qyjup+mtG
         nobCSqno/T4I2FEStcxN1v3eEUWzkwMmgcyYn50w34g5E6OawNSdeZz4Lf79UG2oxjkK
         7ohr/vppU3R0NAaNcR7xJnsHBC7Gt45yDjfPBPAMYOPIPhOWMeW85b1nFo4naRYZVV7m
         BiZ1gGP4cNwMbJNWBvUwN84HzagEBwM4gt+2C/6ADd45G7wWCxOrcpl9mvkq1ffTvPYf
         aOVA==
X-Gm-Message-State: AOJu0YyFbOSMnEpGoIvRgbYAemnspxbIv/XXLS0s966pO7AK+ixCaOao
	pL2rSyuiEiEPioQK9yX0Kj8=
X-Google-Smtp-Source: AGHT+IEddXbdrdnR6r2Gyl8UFT1pj0HghANMDQ/3m3fFfDRvz98CxtejwJJ3bOI914OHIVRAp3npRw==
X-Received: by 2002:a4a:6c0d:0:b0:56c:d297:164c with SMTP id q13-20020a4a6c0d000000b0056cd297164cmr10565311ooc.4.1693234938521;
        Mon, 28 Aug 2023 08:02:18 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f67-20020a4a5846000000b005734f40f89fsm3475646oob.12.2023.08.28.08.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 08:02:18 -0700 (PDT)
Message-ID: <f01aeb4a-b909-5fe8-3bde-5b77639bcba6@gmail.com>
Date: Mon, 28 Aug 2023 10:02:16 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] station: fall back to reassociation under certain FT
 failures
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230822152931.276136-1-prestwoj@gmail.com>
 <20230822152931.276136-3-prestwoj@gmail.com>
 <4ed15cee-23cc-ded0-ef37-5e1f4424ddc6@gmail.com>
 <a6522b7e-0cec-4f15-9bf3-8e53d832f0d4@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <a6522b7e-0cec-4f15-9bf3-8e53d832f0d4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

> In this patch the strategy is to always try the first candidate: try FT, and if 
> failed with status=53, try reassociate.
> 
> There are drawbacks and benefits to this:
>   - The drawback is if reassociate also fails we have to disconnect, and can't 
> FT to any other candidates. This would mainly hurt if there are other good 
> candidates to connect to.

So that is a pretty significant drawback in my opinion.  There's really no 
guarantee that the behavior you're seeing is the same for every vendor.  As you 
point out, trying FT first has very little drawback.  Falling back to the slow 
re-associate path does, especially on 802.1X networks.

>   - The benefit is if there is only one available BSS to roam to and we failed 
> FT but reassociation succeeded. This prevents us from trying and failing FT over 
> and over. In addition if there are additional FT candidates but poor ranking we 
> would still connect to the best candidate even if we do so via reassociation.

If there's only a single candidate, there's no difference between the two 
approaches.  I'm not following the argument in the second sentence?

> 
> The decision to retry with reassociation mainly boils down to if there are other 
> "good" candidates. If yes we should try FT on those since its faster and failure 
> tolerant. But if all the other candidates or lack thereof are poor, we should 
> reassociate to the one that failed FT, since its the best. Doing this logically 
> is hard because we need to define whats "good" and whats "bad".

That sounds like an argument for trying all FT candidates first.

Doesn't iwd only consider candidates that have a higher rank than the current BSS?

Another possibility would be to insert the BSS twice (or reinsert once FT 
fails), once with FT and once without FT and try them in rank order.  Still, 
there's almost no penalty to trying all FT candidates, so unless the ranking 
calculation is really off, I think that is a better approach.

> 
> One option to make this better would be to recompute the BSS rank after FT 
> fails, without RANK_FT_FACTOR, and re-insert into the queue. Although a 1.3x 
> factor likely won't make a huge difference. The idea here being that if other 
> candidates are closely ranked we try those via FT before falling back to 
> reassociation.

Right.

> 
> Another option is to introduce some cutoff RSSI or rank value that determines if 
> we retry with reassociation or move on to the next BSS with FT.

I doubt any absolute RSSI or rank cutoff will work.  These are very hardware 
dependent.  Better to refine the ranking calculation, but in the end the 
information we base the rank off of is imperfect, so sub-optimal decisions are 
going to be a fact of life.

> 
> At the very least (mostly applicable to 1 roam candidate) we should keep track 
> that all FT attempts failed and try reassociation on the next round.

Or better yet, have the vendor fix the network.

Regards,
-Denis
