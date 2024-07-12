Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA54176AD7
	for <iwd@lists.linux.dev>; Fri, 12 Jul 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803800; cv=none; b=prpjMq+q3qa5ipwR4XXQ8JYEQEI7JqdK4EnFRQ12cLU9Um08Pworoj2XgG+IeDju66n4hrhCQWgOlJath0Iu1M7ByClPc0htYw1Wt7NvV6wDXbT7rJWC66jWAOCygecwg3H8xlQhnmQbcnf3RdLxL2nJHT3lPeoOBA+H5IftuwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803800; c=relaxed/simple;
	bh=gEaGcLYNaDbi2Rja0I4T5h+vNoZIXl1ysfi2wDoBH3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OiyqUl4HerdYKTVVdUyjcBXHokjOckWRY5b3FY/P+KpgwxYcOjJYwIUysLoZLAnrTsGyBumiyYmtfL6c+auhFnPRcWKdbiEnO9aP3arEqp+g7HiSTzoBBnOojmw5lH26eJ40t32vBV4PlZt54V6/uApgM/C39E5eZk3Kf6mmLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l18axYyn; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l18axYyn"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-260209df55dso1063237fac.2
        for <iwd@lists.linux.dev>; Fri, 12 Jul 2024 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720803798; x=1721408598; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lulmuiCg2krHH1cZX5xOWtck1c23VPWWckV6jVhp6kw=;
        b=l18axYyng7lkJdTqV+QSkAPL0KiRAIF1SW9Ss7nwhZZ6nYAICWWZjnaWXgJF5snyMe
         NlgRPp8u6Ja3nu5poUAJxC825NnEM7seWjZ5ZUPfVIGqfyxCY9OzdEAsnxMFwnzNjngh
         FMwRLvHEoxq2hTvf9VkImftUR0q+lq53XoNmNU/j+y/CO1dJa3GW9bvMCX2Q4yNVmn+3
         ELfnhhv8t0+g8JuNZ/C4EVfvsRttiUFFidzbileDLtKLez5UNSAi0kpcebHV0bHwkgsv
         vFbK+JY7EA1vZO7Er9U9HEBzkO6bkwZJejxgtHW1htCCcLbLCtd0T8+DIJnUks9zsIMF
         IuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720803798; x=1721408598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lulmuiCg2krHH1cZX5xOWtck1c23VPWWckV6jVhp6kw=;
        b=AiBbHF1/ttkJmJVfDmGgkLS8opMjADSr/yenccEOxfT9EntyVddWhiQQS5jWbp/h+i
         ZDeWf0EkCaKx07SA5uyGw+lAQz7u2/eH7R9+Q/R7sCV4fs8Tjg2sF23FL4EihSQkX5LL
         9xT1A+5q9Al26fZV1uMY/8EdSgbHhCRkalYumgUhzSehd9Rt4vTCtV/DbuCOAIZfIgAg
         t8OfJiHfoOvwYU+rTWuCtV6Rts2qBE7VAB+2avql6HQ3r3Fmljtp75G2h729L5s77wuP
         iRapEheXsP3loaoEjU/595v+r4yg/ej0jhjgsnTU5A3iiG+kOBpCYUk/lnco57CdJ8zw
         PZ8A==
X-Forwarded-Encrypted: i=1; AJvYcCWO5cEkOGiw8YDixu0LNaXDJ8yFEI3JpuqHO+7kUfs23O119IC2sMD4/oadBH+75fLcFmy2tXfkTzfCwQ11oZf18bDg
X-Gm-Message-State: AOJu0Yz5w1weEn1lH8/qC+LReAbUw1e4nTv4EHbo2AD7fijd9LNi/maH
	ZJzU/sLcTo3IrG71bT9cwPX1u8WDmv5BscvW9YxhJ9PP7NWmgO59
X-Google-Smtp-Source: AGHT+IH5fVHL13Ebc7+4ld+57qJy/x8W5OtEkql6On2Ejc5fqWrCAmXdCdSLfaG0lFgIc+G1dgEr1g==
X-Received: by 2002:a05:6870:819b:b0:25d:ff4c:bc5f with SMTP id 586e51a60fabf-25eae9dee79mr10333232fac.29.1720803797597;
        Fri, 12 Jul 2024 10:03:17 -0700 (PDT)
Received: from ?IPV6:2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3? ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-25ea9feb870sm2272182fac.16.2024.07.12.10.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 10:03:17 -0700 (PDT)
Message-ID: <4622c9da-f16c-4739-b359-c3885cf13682@gmail.com>
Date: Fri, 12 Jul 2024 12:03:16 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] main: update usage with logger option
To: Steve Schrock <steve.schrock@getcruise.com>, iwd@lists.linux.dev
References: <20240712162954.23746-1-steve.schrock@getcruise.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240712162954.23746-1-steve.schrock@getcruise.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

On 7/12/24 11:29 AM, Steve Schrock wrote:
> ---
>   src/main.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Applied, thanks.

Regards,
-Denis

