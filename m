Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E991E4109
	for <iwd@lists.linux.dev>; Wed,  4 Sep 2024 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476357; cv=none; b=iwMTqtysJYq2juoQLa8iaZTFFhSqMCrjdxmbpUIqx7M6tdknb1kY78S/ENC32Rce2XhHeq/yg5ugmfk8F3ZrfrjoJL2s847G3++MSZC7aHm0GskDjwlPeAu+tuYyO1Qr2kDZ2cZRfWMW8mjB8gVlwxC10LrPyo2LP1c7ouOWc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476357; c=relaxed/simple;
	bh=nXmwvUxMWcArrIojwPKC/iH9tjIj6IIDbHtDhRtK8RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TiSW1FZ9aCykp6lAPXGyNF1qDH9O+8QulaXpI4jul5I9AAcVPZcZNJ2HnMJOrNU014P4GCiuyjIQeMhj64WYgHC/OYUIL9q7WryWemqutjTMObCyTqc7Pf3GD0vKz+25hpKpqxK2J1eZdcwd3l3wrNy7hFpEQQcx9kRzoSiKcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr8xvQfx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr8xvQfx"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a809736a2cso387451585a.1
        for <iwd@lists.linux.dev>; Wed, 04 Sep 2024 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725476355; x=1726081155; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bneCNJxmmFPAW2heN/toZD/c8vtHTRQRzdLEpWJCP28=;
        b=Wr8xvQfxDsdj2rXBQLWcbyGLCZsufbiUE5OMolo5XSjs/QPnRac6wJgHzQ0vOq8Pm2
         H/8yQGMD6Ms60jtjy8iIuzG7PafGOwpgHwbegwlcPc0MmNShcJNmHAvVHhXVErrOD495
         sLQtT1TycRhdkihgUqva5ElWbGZsYg3eqfGQ7K2QUotmtNXS2vYE1ch9lH32lZzeABZo
         ukrBOQ7MOJ5rcMbTq9i794IgA1AF8yBFTg06xTYaKeadm9+ggKq3R6tDNON+k45tkEFB
         dhd+fZo8gvJ+YLp9nrrhAf2/TX8kObK9Tlj1X+XOtgcokSgBDNPZphgAqac56MMFpwhH
         mFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725476355; x=1726081155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bneCNJxmmFPAW2heN/toZD/c8vtHTRQRzdLEpWJCP28=;
        b=BqMfrptvmYMO8jl41Irc4OvDMA11YAGgK4KrNhMj02JgV6ElNljUNMigeQdCIqWB2g
         S1yWb3VkwjAXGHsjnoTW/Mst0eKhTqG9xPAoWHgSUfFllGkhvGX72hJTJeFMeMfwyAsj
         /Hj0R1bq+esIvMmNGztex6UiRcx17PZbsWQ0ipLgkcdxnCULGji4T2M0eP1nwoXcaisc
         vmUpsWiKqNU4wcXzcSWwz2XN+uyny601enPsuKT6bR5bTvlCzIApAKYgNMOZJoHaH06k
         tk5Uz6+5Rgl9zNR3FqmBiuWkTebp8kt0miCiVF15n/pQ/cHd9uf47EqURuu3B3qRgZH3
         3AUw==
X-Forwarded-Encrypted: i=1; AJvYcCVaJ6gGvjyYQ7rPN5e+jY/lfhV14NftHo6SQSDpDxhEsP5TDcFk3Qrogpy1wLoRJ0QzseA=@lists.linux.dev
X-Gm-Message-State: AOJu0YyJHpmUSusiT59zdGbavr5clgp4n6Ndn9RH4l7OJaIlmR8wnIvS
	qYac2sx7aFecjYpQnHoOGWrZtrKqxZ1e9DvSJ+9p39hG0+WNktft4R3ByQ==
X-Google-Smtp-Source: AGHT+IFf4ws0wSxh4aUk6aLK+FYgaD6vcewp+aRUZtfCURqsi84stU54gMDOW6hKx0rsE+xPU1mDhQ==
X-Received: by 2002:a05:620a:45a1:b0:7a1:d025:434e with SMTP id af79cd13be357-7a978839d6fmr858315285a.31.1725476354921;
        Wed, 04 Sep 2024 11:59:14 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98f00f9b6sm8110885a.124.2024.09.04.11.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:59:14 -0700 (PDT)
Message-ID: <5b8e4908-a41b-407c-a767-a3bb9f7ea017@gmail.com>
Date: Wed, 4 Sep 2024 11:59:12 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Any recent wifi certifications with IWD?
To: Bryce Johnson <bryce@redpinelabs.com>, iwd@lists.linux.dev
References: <CAG17S_N+Hjt2c8t8hN4VMx79QsQ3hiiE_cwOErg6fKoyHkr67A@mail.gmail.com>
 <ef38aa12-634e-4870-888c-219c961f301c@gmail.com>
 <b0ef10a2-c30b-4b6c-8370-66f9e0ace7b1@gmail.com>
 <CAG17S_P_MO4_BZYTCp4WDkJ_q4j=0s_s3azCOWrsvqmLD0ravw@mail.gmail.com>
 <de951e97-547f-4c14-841c-267f64b0020b@gmail.com>
 <CAG17S_Oh_1NS9SUSadAJkMXtJ3s_AjMhnUDSqrKMzEiO69jBPA@mail.gmail.com>
 <cf5ba208-58d9-44e8-bd91-0639ea062d5d@gmail.com>
 <CADXxVSLa+DF9CRWy0Yin7cShrwauQw0=EC-i+MuGnxVcB+2n3w@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVSLa+DF9CRWy0Yin7cShrwauQw0=EC-i+MuGnxVcB+2n3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

On 8/30/24 9:37 AM, Bryce Johnson wrote:
> Hi All,
> I was wondering if anyone had recent wifi certification experience.
> We are working on a new product that will get certificated in the next
> 6-12 months.  Last time (about a year ago), we had to switch back to
> wpa_supplicant last minute because of one failed test around PMKSA
> caching. IMO it was a pretty ambiguous test, but couldn't get the wifi
> alliance to let us skip that test.
>
> There was some discussion at the end of this thread:
> https://lore.kernel.org/all/504042cf-1704-a590-391c-009b500cf505@gmail.com/T/
>
> We got our testing in last time just before some additional wifi
> certification requirements.  So there are probably some stricter tests
> now.
>
> If anyone successfully got certification with IWD I'd love to know!
>
> Bryce
>
Just to remind me, was the only issue you know of PMKSA support? I'm 
having a really hard time finding any actual requirements on the 
wifi-alliance web page. In that thread you had sent some of the 
requirements, how did you get those?

Thanks,

James

