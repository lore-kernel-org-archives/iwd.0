Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824BC2D7DCE
	for <iwd@lists.linux.dev>; Mon,  4 May 2026 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777878865; cv=none; b=EmU0SK4XpoLpwyNJJ/KcqMZ1nUQKf2mxtMBF04I5kagDrW5mBRWavkbZ/BTt6HX4x3SCZGE2zzzgQ0elwZX1quylif9qZ9Mmzc6LN87IHIVOxCc/auO6iYO2OeGZZIKch8yxC7ha+Oh7exTf30dr3CUMr3/xFDRgmSOByOFE6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777878865; c=relaxed/simple;
	bh=dE6kJExLfJO9Vn+l5iOvEaO5fvqT7iM7ajZlYc9k2FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQ2eQF1/+H+StTdy01u8whiRiUeqOvh1Z+y2c2FqhgzEooE5W407NSwlhdLQsQ5CE3EdcKgYD/or5xufFjDB4vT91caOgZNx39v0Jv9CSSpnH2Z1gJjADjXFqW9qIPWitgfYoY+X/1N07sqz+EGpq4DDvLruo2y1ywNUBuGm3QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5VfaNgm; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5VfaNgm"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9358bc9c50so562580366b.1
        for <iwd@lists.linux.dev>; Mon, 04 May 2026 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777878862; x=1778483662; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WolpqoCneMnItnSSSFSP2/B/Fsn6HEOtBfvx8to2RII=;
        b=m5VfaNgm1vIkIt0CeH0FxbFz9aeUN9wyDr2JhqxzFnbU6l9fPIjzz3cFQ6kElffJ0C
         SjPdrRHA0KH+3xawbRfjxjYaNOf7C268PbRoMXHDW+Nan0PAraNG3qj/3OSoOQxNZ8Lf
         Bo5lPUsTAVHzOuzNlV45FNsdbfHagjYudB57hgi8hurcJyuuNl2D6OZqL6BV/fz6lhg+
         eyt3f9JdbMPeDcMSd1sLYA4/fNfJNYh5szh27begBRJkSDul4WVy/OrVzIf4Bi190B2A
         PeM4S6xC5TYCjQOFmwyffNYPLxKHMcdfmxw7aZl0ur0NsgDqryy24XiexzjkBW0U4jQK
         MBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777878862; x=1778483662;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WolpqoCneMnItnSSSFSP2/B/Fsn6HEOtBfvx8to2RII=;
        b=B+mVy8kszQmPRYoj4bKL/boIvxTptTIiBWxPpYjJNBbdbt9HkHPmCUZEgsRNTj7efe
         LK4WSceXTWamQ6fySAIgy7PV1D0Ry4e1r9MDKEvO18Samci8bL+zIZyQFCZSgj1OIp+D
         nCNOW2pt5sJ9uAge40QC/CununtuDnAwyrtqLPBBg9or94oq9zo2kazHNI983yK0TeT4
         YitJUSexoWq7YxqcGvPLBuB5JPsd96sc8ARKq9IfPkwf4T4BMAq/wTVZ3QVgW7vC/yLS
         mJGduDm3nSpF4w55HIfS/n2oi07Jnu1XQ8GaSoQsZaBHWrlUZuQ+cKmAe6dibiR1f9xp
         X2JA==
X-Forwarded-Encrypted: i=1; AFNElJ+GTY8nexrr+BwDHh2U712c5X7+IW/O3mgJqrkSH/MQwrz42tKGeCT3HIAfNJvHw58hUC0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxpg2OCWWORDqF7OzPhRd/MynJXlXEODQ12A9F2aGp0Mm8lu/48
	PEh3kFcpKzDwfyXrOOP5ZDhvqTgAH1JtHHFGB04BVvFBY+E8Oe4Kbo1x
X-Gm-Gg: AeBDievH1wN/IvfVwtvceVkhL4bHTe6yHrPMwu4WuQPbIEWShbZglurCYhBb31Ttz//
	/ouusPPXXxHRycYg0i/sDuxGPKKjc5uFactwIPZTlcK4gNMISufHeNzhWTtlIfoVEtWPgS4WG4Q
	UjJpfXKcFs2UGPTUnas1OY6g2vbSSscPSmV4FUyXKRSs/M1Ef6Toa1LGuU+lhP20qSh0EK/uain
	cplGe2moVTyMxKi4iraWnrTGbLzrrKjqiSQtvTa0IUJatWl022E6E7xzgp+y8AACXKR7LGL9CnR
	zUpqrPaX5DJzgOGcSgZqFAAXkdyr/mB+91ZjfiXYytYhcVcv769Bhp9ZQeY5VJsspnxX9eGHgn4
	hDQhY28BLrdd2pkNosB/i29JV4NWzEfnOJZOmXBhq/Nc8FJTN3lCuLK0r5pN6wt4i8vb9AVn7C5
	WOIhMlkCq6lFwXy51zuE2h6rPTjW/4PUyopw2+SsQ=
X-Received: by 2002:a17:906:f595:b0:bb7:be6a:7671 with SMTP id a640c23a62f3a-bbff8dc5c7cmr485192266b.6.1777878861389;
        Mon, 04 May 2026 00:14:21 -0700 (PDT)
Received: from [192.168.1.116] ([176.74.141.242])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88472df8sm3025510a12.28.2026.05.04.00.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:14:20 -0700 (PDT)
Message-ID: <7f31ae12-f1af-40cb-9131-04a548930ddd@gmail.com>
Date: Mon, 4 May 2026 09:14:19 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [oss-security] CVE-2026-31431: CopyFail: linux local privilege
 scalation
To: Eric Biggers <ebiggers@kernel.org>,
 Demi Marie Obenour <demiobenour@gmail.com>
Cc: oss-security@lists.openwall.com, Jan Schaumann <jschauma@netmeister.org>,
 iwd@lists.linux.dev
References: <afJorKIje4O6dXbH@netmeister.org>
 <d6111caa-db61-498a-92cb-ea7a0aa0a5e2@ehuk.net> <87se8dgicq.fsf@gentoo.org>
 <afL-QhLfEKqHZqka@eldamar.lan> <20260430071917.GB54208@sol>
 <177abb5d-8ba9-4bb9-8b23-9fbc868ed3cd@gmail.com> <20260501180028.GA2260@sol>
 <19837ef5-e5b6-45f4-8336-3ce07423dfb1@gmail.com>
 <021503ca-8a9b-4f9d-8b8e-81661572a018@gmail.com>
 <16a713ee-4cf3-4f40-a532-8a937eaffd21@gmail.com>
 <20260504064346.GA112568@sol>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20260504064346.GA112568@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/4/26 8:43 AM, Eric Biggers wrote:
> On Mon, May 04, 2026 at 02:13:01AM -0400, Demi Marie Obenour wrote:
>>> - It is used for benchmarking, where we actually need kernel crypto.
>>>
>>> As it will be used in real dm-crypt mapping later, benchmarking
>>> userspace lib just does not make sense.
>>> (Requiring CAP_SYS_ADMIN here is not such a big issue, and it is
>>> a very rough test - but useful for relative comparison, not for the
>>> real numbers.)
>>
>> Would an API to ask the kernel to benchmark its own algorithms work
>> for this?  That would be a more accurate benchmark as it removes
>> syscall overhead.
> 
> For what it's worth, I've always been frustrated by
> 'cryptsetup benchmark' and the numbers that people report with it
> because they underestimate the fast algorithms so significantly.

Yes, but note that dm-crypt will cause a lot of more slowdown
by processing of requests later, so in the end it is not so different.
It was kind of intentional, it is a cryptsetup benchmark, not a kernel
crypto benchmark  :-)

But seriously, benchmark is a hack, but we need at least something.
You can see AES-NI speedup in comparison to otherwise fast symmetric ciphers,
you can see parallelization in CBC decryption This is still useful for users.

I refused to touch it so at least we can compare relative differences
among kernel versions.

If there is any usable interface that can do better job, we will use it.

In the future, I would need to measure both - userspace crypto and kernel.

Milan


