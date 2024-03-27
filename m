Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE10F14D430
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565651; cv=none; b=LXITV5mk7xwOvKr5A3pi6OqqyJkIMzqrRs4690qFUrdZ+rgpXcZxIx48ZHLQKPigJuacvOULqgjnWljH53DHrE6Mpt1ks2hEe2ygSzCTIalBKJLzJX1p+CB0HBwp4SLgSfMsIFwzo4gcwXHpffxkxtDPk55chKpoBBVNimRX4kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565651; c=relaxed/simple;
	bh=DvCY6ddFGBs5H82JRTsAWLB8R4rxd3Dr89oTnJNPKOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tnBA77Ka3+jOtktWLhQF6NeJ1flOGPNEIYuybHA4kL33K9uPrVBWZRPTQss4p8BLNTjjTWlpj4R/8qw3r4LRqUYrcGhyYzmYGifhniZEq1hEEu1TQd244f0lGVGfkMLrO7XvnEhcAhlCTOu9xZ7XqfEHLZV885Rc1Fvbq57h0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ7Vm6An; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ7Vm6An"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69629b4ae2bso1225656d6.3
        for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711565649; x=1712170449; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JnMk5/zk7HQAOUgp2fyJUAKO/JjMvz4vBImvBzWmPls=;
        b=HJ7Vm6AnQDnlwyyDjIuyjAxSBM3Sh9KvT/ieoqXLUQPR1+Z/pAXPZydUoB9NXjoVwE
         4PItQXE2pRXHt2Wab7rRlVkGWx12Jyt0HYK4s5oxSDACjZ6sTpXdhn0H/vLq8dgh5LpC
         d+H5BQbCH2posIl2awso/YAOSZLqoCwhICsu7VSH7Ha/5Febyy674Is7r3lSBaVhcjP2
         yKsvgZjtFw9q52hUaDWhiStGB0heBfzm4I9m8E+pjg1+8d8ttBk1mGsVqm2TEVjK290C
         ODL0yZEpZcz0XOPksNGiLFPDeydMVg28V+7pa+ApAI+DrRsXHnWCscszCcvLrNjxsNRr
         t1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711565649; x=1712170449;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnMk5/zk7HQAOUgp2fyJUAKO/JjMvz4vBImvBzWmPls=;
        b=dVoii2j92U05qUY9gAeuHVU1DIGOTEOkN4ZcClCvwyZXUA3oMt9pcLNbylfuSGNsGP
         QBEYa6hB2/IZHonnMqUO0ePz1p0fk9YgT+1j5WUCqq9w3uqB9oByVDDU+AAty1tjQhno
         ltVYDceIfRykGk1/BZO1F8/fuTK7QB3BQqBop9fF5MjxG5ZeQaLJhHBG9yy5K0KNKT1z
         yDrjtBelBgEt66ckganzel1QpVd5lGyi6xs7kPgyW5eohr/SO7GhjhxO4OM2fBJFqvwm
         1x4qIm1n3Au69iXKtz0FpUnoCrJnHVnmdFqKiqoyzWuLx09ZIH44o3J9m7s6VYG9e4nI
         acsg==
X-Forwarded-Encrypted: i=1; AJvYcCVLz8RwQrxKQ4hj9O92l69n+GI5yynbeNKvNyAQ6WZzab7hJt2sBGrUQqbOBEZ5sgp7oXaUif3YPvjs+KPIGXdiDayr
X-Gm-Message-State: AOJu0YxdFTETKMSyQo0Jwr8jW0QebyiIuZygOzhlKtvI5+JuZuaW7Xld
	b0BEiGvz1eKOZQd18LPL4Qf4dcWkMfU+qabydnb07yTeNv8QMLnsDAv/oOF9
X-Google-Smtp-Source: AGHT+IESWl4/U7HMISh8dNS/CeochEXuDWJCBKGqDiNnibnhpQ2nfL+fQ8kX+O1gIvt+Dpl+a/Q8IQ==
X-Received: by 2002:a0c:f710:0:b0:696:b036:62e2 with SMTP id w16-20020a0cf710000000b00696b03662e2mr444104qvn.44.1711565648891;
        Wed, 27 Mar 2024 11:54:08 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id kj5-20020a056214528500b0069150ebcc30sm6579480qvb.76.2024.03.27.11.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 11:54:08 -0700 (PDT)
Message-ID: <16f79ea4-32a2-47f5-b6a9-cfd911454a6a@gmail.com>
Date: Wed, 27 Mar 2024 11:54:06 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwd picking worse network despite better one available
Content-Language: en-US
To: Sven-Hendrik Haase <mailinglists@svenstaro.org>, iwd@lists.linux.dev
References: <699c79ff-0082-4602-9bb8-475722563c46@app.fastmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <699c79ff-0082-4602-9bb8-475722563c46@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/27/24 11:36 AM, Sven-Hendrik Haase wrote:
> Hello,
>
> I've spent a good chunk of my evening looking into why iwd doesn't select the network I want it to select. I have a network "Home" with two APs. iwd seems to strongly prefer the AP that is further away and that has worse strength as measured by iwd.
>
>  From some testing, I believe it has to do with the AP rather than the wifi adapter. I tested a wifi adapter using mt7921e and one using iwlwifi and the result is the same in both cases. The APs are both pretty modern: The one iwd doesn't like is a FRITZ!Box 7590 AX while the one it likes is a FRITZ!Repeater 6000. From the log it seems that iwd is unable to perform a proper data rate estimation and then falls back to some default. At any rate, the rank would indicate that the estimated data rate plays an important role. If I use the developer mode to force roaming to the AP I want (named "better" in the log) then I'm able to use it perfectly well with a good data rate.
>
> As such I think this is a bug _somewhere_ but I'm not exactly sure where. I searched the configuration options but it seems it's not possible to turn off the data rate estimations for the ranking. I'd be perfectly happy to just go by signal strength. However, I suppose it would be better to actually fix the core problem in iwd.

IWD bases the ranking of BSS's heavily off the estimated data rate. If 
that fails then as you see the rank is very low as it defaults back to 
802.11b rates. There are several IEs the AP sends which IWD parses, any 
one of them could be either not included at all, or not be formatted 
correctly, or an actual bug in the parsing code. Could you get an iwmon 
capture of IWD scanning your APs so I could take a look and see exactly 
why its failing? Then we can go from there.

Thanks,

James

