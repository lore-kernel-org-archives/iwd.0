Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5DF189BB2
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429515; cv=none; b=Lgbi8tbrtP1w0kwo+RgqyqDP5YuFGBvaJYbIRYKbcAMt8qnFrQPM1YOfFdVU+C6t1r2rJJGxoqnm3jTItqt3g3Sp4WzWO0lCO5aGWD+qkYHEuTyRKJQYR9ohaEFuHlO9d7f7VB0ejG8YpvwHzLoI3AZ1UtNDBxvTod4gYYL1ObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429515; c=relaxed/simple;
	bh=p2xWm+W9qtsrAdP8saiFjQ13kUv2RiJV3MRsXIpWomk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MXa+JKWti3sRq4DakeRcJ3vnQgUREUG6vu+Fio/O0wOjUaPIf7UDQ1M+1R28HBua0u63+Lfrl5R/6ocn/9eWWLU+yzi5oRqurRcQd6dVJ6USJBy8jdF/loHJ4MnwbqSNI5ZBFvIS5LtGEgkgljAeuHelxMXrskIWLqIpsGi4dow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnQtX5p0; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnQtX5p0"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7093ba310b0so1337532a34.2
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724429513; x=1725034313; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xH60lr0iMamCVFqLRGdbhwAAxSz/AE5Dn3i7U3elnGA=;
        b=mnQtX5p0DhYAFhj98KTkVzCUXh8+c7mXQ1F9YfI3bQOUuN0bcQECMDt00W8QntSrbN
         ar55KtyZUVys+qJW7FuwMTOZdMBefcbPLyOeMlAmEzeN8JgJxehKvmAKd+x7LFx4X+xO
         tg9ziO49xCitPk1rOuliHvzeEBC5PHbe0nI7iFmb6dkGcpb1ND12a5H5r36iwLVQhnV1
         ExjnR3HmSvt1tIta8YE0QPtQsPz+ANvvR8m64VXUPjaSh/IYfwA62od1yWEZ/cuMFY0s
         16CEwsZKts9p0mKgCnw/bg9A2rxeOY2a01olG1ImPhQ8GNkRwGZBpXWf26QjKFqHxDxj
         XlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429513; x=1725034313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xH60lr0iMamCVFqLRGdbhwAAxSz/AE5Dn3i7U3elnGA=;
        b=k2WR5/9cZQxH66B7hdI9Fh1nxDYyor4lxmAXgsi4NyjpB0i5GAAx+EMRPRMmxs2UWV
         GZ1JOBtolC5PYeMLKUP204Lou+ptXLmWsuxz5YYavoyBFn99oeBoI8zhNSUB+NDh6vL9
         80Egwt79bZpaNl589+X2C9n+GcU9O5cNPbWmm0M0W3zOQy7L3PR0T84cUoMTQ4Yt5Xrn
         bRxS4IEn0tibusqrpD4HDS02kN0SD750CoUdR4R4TCBtTIEtZ7d3Xq4swi9ujNrmD6gJ
         +8K4B7ufKjymKf23ThHl6JBs7pIfF/iX48/o9IdEFSRwSrwFv9CrZyNUzc33zeS2zuNZ
         oRGA==
X-Forwarded-Encrypted: i=1; AJvYcCW/dELeZi640oWZqKtTK/QZNYVbbiDGgvBQe6Z5qXzDtfMjnR7syiWujYytN5aVL/oEF3A=@lists.linux.dev
X-Gm-Message-State: AOJu0YwSuI2GCJRTdvcipHOAS1BHmBJy57GVYYKjjbIISL+IxY2e/ZZI
	cRZNvUKBZuMftHdmnG7jMudT/DBr7jUsIY/0zj7fpAKN5hr+US5M
X-Google-Smtp-Source: AGHT+IFsZ9LXy+70ckI2rAteuCK4HYpTvt3SEQSy1oqLlNbpY73KTlosG4x3ZmWzYxayCTCp0ouZSg==
X-Received: by 2002:a05:6830:6306:b0:703:5ccb:85f3 with SMTP id 46e09a7af769-70e0ec00d1fmr3805730a34.22.1724429513347;
        Fri, 23 Aug 2024 09:11:53 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70e03ac5ea1sm714346a34.43.2024.08.23.09.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 09:11:53 -0700 (PDT)
Message-ID: <721cb93e-c42c-4fc5-b3e4-c989120c297b@gmail.com>
Date: Fri, 23 Aug 2024 11:11:52 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] doc: Document station Affinities property
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240819175151.1310546-1-prestwoj@gmail.com>
 <1ae5fbdc-631b-4bac-a913-2011a7e9996e@gmail.com>
 <a5aeda36-1618-468d-b796-b8b06dd68f96@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <a5aeda36-1618-468d-b796-b8b06dd68f96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,
>>> +            [General].CriticalRoamThreshold{_5GHz} at which point
>>
>> Should '{_5GHz}' be without the '_'?
> 
> Yep, that was a typo

Okay, and I guess also drop the Hz since the setting is just 5G.

> 
>>
>> <snip>
>>
>>> +
>>> +   * - CriticalRoamThreshold5G
>>
>> What about 6G?
> We could add one for 6G as well, I was just maintaining what we had today with 
> respect to the existing thresholds. I can add 6GHz thresholds across the board 
> in a later patch set.

Okay, that's fine.

Regards,
-Denis
