Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEBB1F4707
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779410; cv=none; b=hdxexsJGTQL468k9nfkqzBeKf2TKhokH71GZ75SNQr//eWsYJIyReksoQsg5L9sSVU0RNT7YB5EStXqNPiwdKHs6bidpZY8euChW+UMEQ/SAL+a+PC//MbK5AtPasG4TFYPf+Ieb9Vqt4Gk4cQ2YcMBOdC3oWFxZOAKnZZ6iPew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779410; c=relaxed/simple;
	bh=pTvFO5HpWNTKVpKhj1R/gU1AF5GPgWN0yJVmGNUAPfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DabY/JpOjMSqF1WsvvlhFytqfqF0w4HCo0pdl2zo/OEtyVLFiEzGhhMOyxl7Ota6q2ilLadtG6VM6PUbLfT6tLAPEzspPzAgK26kimslty2LI7zrz7fghakho0MPSAE+8riSzCyVAEK5Zpvniz9y4wRujQFpJp6GD/nMbir/zqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCefM9eh; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCefM9eh"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e5fef69f2eso641982b6e.3
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729779407; x=1730384207; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1+3UGQ5LWrVGkDPO9HZBHjaJVKgluASjxMfyCTKNZw=;
        b=GCefM9ehyzIiKxXxDgyUX9/+KqWjMlJ/p2Zu8vMrh1R80fbjK26rXXl0e0WeKgdWg+
         MhIiby0dRt3rbo5Vivalj65B0k7ia7JHAEQNM/EoWcv7LaAfKZhBbrZEEK78iejOq/3M
         mE7vWSWHz4k/0F3/3Cfp6GtYNR67LdEzjuYHSA1XjMLsFi/8GkpaUV13qE/Bbdd4wNCb
         nQZ6+VqnkSR18wI4cKHaXjliu9gp30zhN4h9N7MtVp5GWXnDcknB+rMLbYrHbvSQYTxi
         yCdiad2mp4+eucA78foU2BQfPuQ9bvFiptxYsj+682R2V+Ng649YeIKqpiLVlLaPTPcQ
         SflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729779407; x=1730384207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1+3UGQ5LWrVGkDPO9HZBHjaJVKgluASjxMfyCTKNZw=;
        b=uhfT7X4RdXA0Y3CWuAQ/ElZfv8xxxpj+kzPHvbtP7fOdBCRySigxgWDuUNiQaGceeb
         yNS374dTwJruU06k1MUAhO6hT8ERlybo+cJ+qRobc1eOTmEPUPBvyxUZbtNwevarxVKz
         uGXhz+TzTUbAjLSrfxSmuh9jRBG034T+zAMUYiY/MN8RRGocNNEf8HBVGy1B+pwjBKtz
         83xAFT+SixGzYQifSp+OfRPMqJqKyXzaSKLPNOairY6McBIOZXBKaBdJBYKOqSQtiJ6G
         AwfPb9w26vGfCMKhvWjzfNd0X+KpOMlN4Lmqu1Dka4SUGrLV4JlyTAGfeYfqztO3a4p7
         B6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN+ClQm38QxGT91jmZ/HtX6Jhd74ycju2gunxSlg2lLE8BHzRCjjOqXTz0a7PZmXweR6Q=@lists.linux.dev
X-Gm-Message-State: AOJu0YxxL52b4VwYDCbIIPN5JU8QAomlpMEzRBlgk2v0etLpC4862l6E
	8YssnzEvVxVTwmDyeozgbWyglm8P/IEO9LccVbps7yRndEQYsVk5swY2kQ==
X-Google-Smtp-Source: AGHT+IE62c8qobRa5ODKL9+lzYKm8mFhb0hE/63X+aH2XPabMGnFF/KvKdSztIaUJQB104G6EDYwwg==
X-Received: by 2002:a05:6808:189c:b0:3e3:9b23:98fd with SMTP id 5614622812f47-3e624533ad8mr5754138b6e.23.1729779407110;
        Thu, 24 Oct 2024 07:16:47 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3e61034f113sm2249292b6e.38.2024.10.24.07.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:16:46 -0700 (PDT)
Message-ID: <9e2438bc-8d95-400d-9890-bf7f2e8de2c1@gmail.com>
Date: Thu, 24 Oct 2024 09:16:45 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: check support for all sysfs settings
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241024131628.152607-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241024131628.152607-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/24/24 8:16 AM, James Prestwood wrote:
> If IPv6 is disabled or not supported at the kernel level writing the
> sysfs settings will fail. A few of them had a support check but this
> patch adds a supported bool to the remainder so we done get errors
> like:
> 
> Unable to write drop_unsolicited_na to /proc/sys/net/ipv6/conf/wlan0/drop_unsolicited_na
> ---
>   src/station.c | 36 ++++++++++++++++++++++++++++--------
>   1 file changed, 28 insertions(+), 8 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

