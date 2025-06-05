Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37271CAA62
	for <iwd@lists.linux.dev>; Thu,  5 Jun 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135782; cv=none; b=ulEvWLRnhVyScXrwSFVfwxqxwBD+qK/gjuM3ktXfHCEwHkIuErMfIG5pBTpcwApJM+Qlfi8Dm4JE51+pGVXlfowj/yx8/+Uu8Ed0YTZnjuw36vNAMZ6PqIX1akEJdCbIBaDROCno3d/hzaOK4K2YIvfPkpWM3NH+qM45RtmYhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135782; c=relaxed/simple;
	bh=y01gJj5GW0QG72gGOTVQvLgM0SAUVGIqNJ0gvc/lCs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n2ySro/0EOkD6je1rbhJcatS6MCPQplme7ngD5rnxDcu1thCyPgFJfk2ng6EhA0jZvTk/hwQpIUtSppdrOgZOeq7nONrMgJq3DE3oeCgob/5EPSQFIfS53Veo9dooT8DimG/rIVfhH+TznmENkSzDrcwWMGitxYNqcdXCHzc4eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia52BwtE; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia52BwtE"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4067ac8f6cdso925441b6e.2
        for <iwd@lists.linux.dev>; Thu, 05 Jun 2025 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749135780; x=1749740580; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UzJTlIll5N/g8hbiX9JUDigU4b/9VU9op719ylatrKc=;
        b=ia52BwtEqitGgKeHn1UWHjA5INgctYtro90VHFQF8zo9jUJtEJcg2VoekC529c2CJh
         uusPkVniR5mM8+LcK1NhfZI9Md4nikrWt6ddLvRagKwAGymebPVwft76QJwa7svWEo9S
         1BI7OsIs0qbPTIa5RRj/z+2wOdayrVQ2UgV/TaoBUWs8BKqy1O7zHhrz7/dPG4eoOEKg
         Ov3zLsK4LSXlfyNA6LCIim4/e2oXf7FKxGcFs2TLO55HabVm4cW9WONQIM5DcHn5AYm9
         l1FhqZBIRVGNkJ5jwjqPWNyzQk+LC/1H/e39XScPZ23vA9Bih97zA0gLtE/XW5yWqUCK
         2ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749135780; x=1749740580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzJTlIll5N/g8hbiX9JUDigU4b/9VU9op719ylatrKc=;
        b=TDCXOre2vpC7OyoA7AopFEu73IaDFA7vpXyT3AxV1sp1CHC3l6ADjMEu70+R6PS1bo
         zn4px0hQ+46uuzUrQySsBSBg1U1X6c3v1TZZ+SkYP1viUl4XyKa2FCdGh9ANl+zko2bK
         cMKDeGqRdMsDl90G8EC9yd+Woob5E1f6PjDfaj+MDJOl3NCRfD1SnbPY+Y3YI6pQJBYU
         qixrtagM28wSIpN1pWm2gwk1PEJbACYB1VAgb/nZe0do8i9J58l/NU3DED1txREkPIgp
         CktUtrtyJ3lbPkfquMB/UPVhwJ1CidePg/43cMrCq1SKIeGK81JqFGME99VPR3MUHMUj
         rHgA==
X-Forwarded-Encrypted: i=1; AJvYcCVVaaKPtkMuwJeNIYtDfySQm5faTjdXQJl/G1RC5bXSz3kuEDppnD6l5B5ZypUBpQd6ILE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4vDFF1319hU7c7lZb3M0kRNL3tyZ3EnJ8VuKmf86lBGhhwSUl
	GSagEDWLRRFFtAmE9wvb2m57fQKV+uWIGptG+4EhVoe0q+dx16piawvO
X-Gm-Gg: ASbGncu0vbuSPLz5TKC0m52a5nrh9OjE9Fa9bj2+qh1/+L/subpNx3ca25U4TCU+7ed
	2x2twrgeJN4voL+5yaiUIlBPvuPmULnUceImcYqBdPpV8c8HFYmGrcJ2L/D20CIIdQTrTumo8nh
	5pyxAr5rtgg8xB4yu65/n6tU8RCdvon5MBOX030RHLxlvJtxgAs0n6/YUSb5pQ8gVNKLsLb/Jah
	RYceDozZ3f7o8zkUGI+VlGf7HP3FLvQ+MZtKTQg9cXBEa8wZaPP7RiYo8YqSiT6UTixnVCzvfKn
	O/lW8tF9Q4ibuVClWVt1MWOtgb9UNmEqpUvEYK25KqEEc8EDvt9b/IVVOPai13LG5DQMGRs2e+R
	T1edCKiSiWGG25CNXb0omvnUq0Qs=
X-Google-Smtp-Source: AGHT+IFTb4sesOkcqoVW4IaNyhcvfRWjr7K0YIEQKKy++jj3uTTuZH/CxDnSd4SwVOqkdpzpKZ7mpA==
X-Received: by 2002:a05:6808:1df2:b0:403:2a0d:428b with SMTP id 5614622812f47-408f105e774mr4990927b6e.39.1749135779908;
        Thu, 05 Jun 2025 08:02:59 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60f283b2244sm360117eaf.18.2025.06.05.08.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 08:02:59 -0700 (PDT)
Message-ID: <30652854-cb83-4695-8a85-82734219873d@gmail.com>
Date: Thu, 5 Jun 2025 10:02:58 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] network: make clearing network blacklist a
 separate operation
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250528201026.598221-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250528201026.598221-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/28/25 3:10 PM, James Prestwood wrote:
> This adds a new API network_clear_blacklist() and removes this
> functionality from network_connected(). This is done to support BSS
> iteration when netconfig is enabled. Since a call to
> network_connected() will happen prior to netconfig completing we
> cannot clear the blacklist until netconfig has either passed or
> failed.
> ---
>   src/network.c | 9 ++++++---
>   src/network.h | 1 +
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 

All applied, thanks.

Regards,
-Denis
