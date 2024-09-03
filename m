Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C61CA6B5
	for <iwd@lists.linux.dev>; Tue,  3 Sep 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376716; cv=none; b=d7YaPKcbvMmKbJy9n5JQ67E7/Lb4lvFfSWXy376jKXpEGM225y+RH8TWnQcQHqJCrV8AIPE18hECgPLP+G3Tegg09y8cpnexx9o/yppq2pjJ9k7eraHH5E59VvsfQB7WOUiI4Iu8esiYebAh/J/pJMy6PdsqWLxNXQWbgXQ4inw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376716; c=relaxed/simple;
	bh=RXVFO/DXlfV94jwrtQziv1F0VK734H8ZCg4Wqx3Ao0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aoC35bhNsZBciIm0RfqoHo33yGdy1WhPCx1VJ2wsZPGclhCnbycG0orGPAKKCfigRUMx9kPOL/ll0asJ7AbFNLKZYWRHybpegHzwUFqIH3lLhWR0zvNJcTLL77mPG1yn5G/lPdIRuEO9Ev3T8V4znCY+xkGKaugMT0f5sfiR7zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYDgt9eR; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYDgt9eR"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d5c7f23f22so3148745eaf.0
        for <iwd@lists.linux.dev>; Tue, 03 Sep 2024 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725376713; x=1725981513; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gqYNp8ISxkdacQrKlZvktjh6GlMZukAuFPU7lmc35qE=;
        b=GYDgt9eRu7Qq/+xbaDXGLVZV1Um+FptVA3VuZ+GSVpk/Q2xJjB7+iV9pEo0K5irlKJ
         g5zKif8Dy+9eHRvSS/xo8xTuSamMtdvPdYCXf4TM3LT6nPE8GyYKvY+sX3xtCLkGGbIS
         K0VQN11/laVe+SCtod42l4RRVUIk9xDMIGNIXE03BJpBjI+CH+Jo6N0T6C+fhBNADUxP
         zdcHxAOC5rzGBNgAm/wc+eOpfutiB18PkTtCmUfuvqxUq/xLfoakLP8ptuZ1bi3RAN9P
         9rvPaoksArvwEpzSYvrROnbHzXRLfTvIUlzCtSM5zi03/lnkgtDXZQlgmry3z0twzjyZ
         ydsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376713; x=1725981513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqYNp8ISxkdacQrKlZvktjh6GlMZukAuFPU7lmc35qE=;
        b=UKe+bKfU0MUmeaovNlgVmT1Nu9JB4QoVQEkuWkWhTxkH+1cfuJt/ptfIMJFKLdDjuY
         8vNDzUq/J9EG+fmvapygQhRe6fPCXkqr4sf+yaslUOBMhfXPadfk/BLUvNde728tsQLs
         eoKjsWnA9EvcmBUq9us8eG8qylkyBNeZddyHYsNVtcVKqsZbcEvaQuH38oGty0g4frhK
         rSl+lX5HnEneHA4fA7br83HLXappU/9+YvUgvs1+D1abs/94lmplTgRmEoWqGkV6vyaz
         ftRheeJDpjik6UkIG6U+isYncv50e1Y40joY0jxDcHgn1Fz1LJIfpa/3tzU2Hnkgn/G8
         TqQw==
X-Forwarded-Encrypted: i=1; AJvYcCXXWC9UVwR9Gl3d29GyYrmuNeinE5rFJrrEmfPtD7C9FhAEtc9QUBno6fb68nc/Um0Nh5A=@lists.linux.dev
X-Gm-Message-State: AOJu0YxnYmhOiLAR8dKbY5ah5gwEBZftzgJLLBuDWTAQMJu1L7UEXJaq
	7RO3tC3qYNnzUyQpS0dhANies4bo14PcCY+x5ZbHKvJLu/sWNxde/yRvjg==
X-Google-Smtp-Source: AGHT+IGe+nAGpDmpI+sV7LshJHKJ5t98VLEZ9v8kYzqQ5MFbTtwOEFTlaowB0sagoetI1XFfEcN9sg==
X-Received: by 2002:a05:6870:6b07:b0:270:7a7:eaa5 with SMTP id 586e51a60fabf-277ccb06678mr1852221fac.10.1725376713575;
        Tue, 03 Sep 2024 08:18:33 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-277abb61927sm2953870fac.22.2024.09.03.08.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 08:18:33 -0700 (PDT)
Message-ID: <538945e8-2ecd-4d65-94b9-a2839d5052cc@gmail.com>
Date: Tue, 3 Sep 2024 10:18:31 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: check for roam timeout before rearming
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240829112758.35494-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240829112758.35494-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/29/24 6:27 AM, James Prestwood wrote:
> A user reported a crash which was due to the roam trigger timeout
> being overwritten, followed by a disconnect. Post-disconnect the
> timer would fire and result in a crash. Its not clear exactly where
> the overwrite was happening but upon code inspection it could
> happen in the following scenario:
> 
> 1. Beacon loss event, start roam timeout
> 2. Signal low event, no check if timeout is running and the timeout
>     gets overwritten.
> 
> The reported crash actually didn't appear to be from the above
> scenario but something else, so this logic is being hardened and
> improved
> 
> Now if a roam timeout already exists and trying to be rearmed IWD
> will check the time remaining on the current timer and either keep
> the active timer or reschedule it to the lesser of the two values
> (current or new rearm time). This will avoid cases such as a long
> roam timer being active (e.g. 60 seconds) followed by a beacon or
> packet loss event which should trigger a more agressive roam
> schedule.
> ---
>   src/station.c | 48 +++++++++++++++++++++++++++++-------------------
>   1 file changed, 29 insertions(+), 19 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

