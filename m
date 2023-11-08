Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4391DDF4E
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzdAV17V"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ce2b6b3cb6so4405883a34.3
        for <iwd@lists.linux.dev>; Wed, 08 Nov 2023 07:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699456047; x=1700060847; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqfLHo1JvXxVOZwI33GMqX4/sE4nwVjr0JJOMv+QPVk=;
        b=GzdAV17Ve8SZkRiRbalsXS1VJLmg1wH4TGJqKTfmta0CYzoKpXvm9+DfH1aflPWmaQ
         7Sv5ecJIgw2oFNEt4cleHg7eGQEcD3zmQHWJ3d4Zkcf5kIwkSsMSlqqbY1nLBsoEga6Y
         SXMfx5S/AZ1h1O0f+pcRaSCJ6jtI/m8JKMJhLTylr88Zd1HGTmignbdGD7WOrwoUyVOU
         ESvw+FHmip7AlSKt8NE1nA6Er8m0SWEyROFCWQfJrSUQjU8OO51wr/rSKAEbPUfvXTlp
         luPI/vKdh0wj8jKqAbEcFO4E9wCWNaBJCfVfeO+fn9eRXxKLEHw8zGM+oI5hPVPstNlj
         whqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699456047; x=1700060847;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqfLHo1JvXxVOZwI33GMqX4/sE4nwVjr0JJOMv+QPVk=;
        b=lzSnUdLp64OLtkwvjjDc+JABJjkqViDMcHbvMlC+i8JHuZr6Aor6DyTmRh5bCAt57g
         IR7SFcgqs87ofde1SJiNiorVL/5/fXkFX3ppTTe/UWh3DJv7ybS6CTsw/0wzzBiG0N5e
         bqLxt+FPThMPIIPtHCxkYzUCarVF0n7E8FHGBuPalkUjHIigOC65FIXdtQ3ztKIg1RIC
         mKJOY6D7E8xdQJwF/XMsl7EpoQRjqS2/BCikpFn02zlXB+JV51+EMpxKKwNfpS0oy7HS
         bPOaNJjbO6+bssKIHQM6hvvvINFnMGbB0llJKY19bMYkouK0Aw6U82RoAFOStCz6Lq/B
         qZlA==
X-Gm-Message-State: AOJu0Yxd/OXWx/j+9efvRWFewX02XT+xaSQf7mHgv7OJZ9nDotvWWJ7N
	l6JRiLJSdN+Evs9F7gemn8g=
X-Google-Smtp-Source: AGHT+IEUAffvgiY3VFozcaJou2fxqg2fnwnK4rSGi65SsP56nAlP56L+4TlGJ7447eWai/M+JpxHZQ==
X-Received: by 2002:a05:6830:3a11:b0:6d3:14dc:823e with SMTP id di17-20020a0568303a1100b006d314dc823emr2334268otb.11.1699456047119;
        Wed, 08 Nov 2023 07:07:27 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id eu14-20020a0568303d0e00b006ce2f4861c5sm1907323otb.62.2023.11.08.07.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 07:07:26 -0800 (PST)
Message-ID: <6e709910-ad9a-4681-83bd-759a4e26e53b@gmail.com>
Date: Wed, 8 Nov 2023 09:07:25 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dpp: initial version of PKEX enrollee support
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231107170629.1831655-1-prestwoj@gmail.com>
 <20231107170629.1831655-3-prestwoj@gmail.com>
 <a9c1e09e-97be-47cf-9ea5-b595ac979b2d@gmail.com>
 <c93871c0-f090-4e7c-9e59-6298113d77bb@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <c93871c0-f090-4e7c-9e59-6298113d77bb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> Since you're sharing the DPP state machine object between the two interfaces, 
>> it seems like starting PKEX on the SharedCode interface side-effects the state 
>> of the regular DeviceProvisioning interface?  I hope that's not intended?
> 
> Your right, it does. Once PKEX finishes it starts DPP on the DeviceProvisioning 
> interface. This was intended, but if we want to keep the two isolated I'll have 
> to change gears and think about how we can do it.

Ugh :)  This is something no-one but the person who wrote the code would expect 
to happen.  The interfaces should be kept separate.

Internal implementation wise, I think you probably can get away with a shared 
dpp state machine object, but you do have to track which 'interface' the state 
machine is actually bound to at the time.

> 
> May have to create a dpp_sm for each DBus interface not per-wdev/netdev, and 
> find some way of communicating which interface the property changed calls 
> correspond to.
> 

Well, there's always dpp_find or dpp_pkex_find.

> Apart from the string/cast comments the rest seem to revolve around the shared 
> state between PKEX/DPP. If separating them is the way we want to go I can do that.
> 

I didn't look super closely at the spec details, but what I saw seemed reasonable.

Regards,
-Denis

