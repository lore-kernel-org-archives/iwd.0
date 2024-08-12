Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F7F1898EE
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486489; cv=none; b=bHzYiGiSDfU2wjPmEMwUXyz9K3OBBSazvLbWyshfCMbs/EB3FdsDCQ+CfVgONf5nAShs++h09du8rIZSuunqc32CKcTYGRs/oaoDmI60lmOy0hTG4fm4wmZC6HIhBoiQUqZ7sgXgW4h+cfw5Yn9RXhQpJ975y/mO5iQ/gRTn3J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486489; c=relaxed/simple;
	bh=UZPOQKPbp27cNmCYjtAEVij9TfuwJHphxzaubBmwTYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aSda35d6WEheXpitD+/mASWOXCB45DbyAJ8mUPKe8kSKssT3c1xwHv9jQbyhE7ZXVnznAYWDhary4mP8MTBchbx2BKDPRX5pTuSmrahTRXWOw5BOfJmI9qckCI8QmLPAyaqzSlYDd+7gD2V3t8jqADqr6FGH5KfBo6oetA8D3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1ZeVNCb; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1ZeVNCb"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-264545214efso2489935fac.3
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723486487; x=1724091287; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLD9RMwzSeu7OBAiAvSbLjKuvjfqpU+RMCC2OkxwO/k=;
        b=I1ZeVNCbh5vwQkYyi+PQpjiBIUJ3LM2YUapwugmPA4wUjBEnchi+GJ6zi3jH24VZpB
         eIBiRvXAZsPiRtlqKXXZCuFRiqb/GEmZUkrvp7C7pDK1RY519aX6LvoIFZr7tirURtJM
         jtHJOFgnlReLmuHUGbwVnWz7guY9GSe3SGs6HZICKO4S9KdlW/SI0gNT5RM0Ek10XKqs
         PEL2mJrCuj4XPcs25CnPSM7RCUP2bHUsGZSvJmWpmY1jNEiq41i3VJOKWCbvAQ6MT+fp
         XM4L5uFye2kZwXVs7E3uTG3F2WodH9i5M253jivJCtw05fWeMSYmcEidhUy1h+NTdUMX
         kkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486487; x=1724091287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLD9RMwzSeu7OBAiAvSbLjKuvjfqpU+RMCC2OkxwO/k=;
        b=ud4MHUPb0c8S0B68DjsKnK5rxfo6eM99ljckRF/T9/DM2RVdcAmd0584KMg456MnBE
         ep0VYcXgj8h+Y+odssMtmcyRsC1LBblRy2D8IfU0IYN6aJwXFB7Iw7hvF8Csk/tXHG2d
         V9Ft8RC6tUmjzC7wg4LxNU8B83+uRyf35aQyfdkSZhGajpLf9GCDxHzyvTQM/c4KSRqU
         SVT1khbujvAcFyPoSBeMOQ/506z9yg7sMBT6luOIpIG/ArJRkdVrE1sYNOf37iKylbbA
         ILIuR/pK6y8fOIIYkrEVsT2IJUhkK6vNbARwzO23WzwHFtvbcFh5Pgwylwx7rBrgECC/
         4WuA==
X-Forwarded-Encrypted: i=1; AJvYcCVxLlMlQynvtMDSm43w6TdCQbhl1fRDLlw8O4nHZkz5EvZJ5HIr0zh5T0zcjVhKFrO3H5m1sXZTvlMV1YRcUto2HMIf
X-Gm-Message-State: AOJu0YxP0nVC7VcgWjMpJD5InAH4jLOYF4yKkIM5sTb/W6DStAUHgIAq
	4Hsi76Fu7z3vSELDHvaVtbDH4lc8zOXCyZo5mNtj/ZbYkmLLdmGg
X-Google-Smtp-Source: AGHT+IHH7zegLzEfY+T0XqS6HZQaadwbzM3k5BeIcac4mnWed6HnbIPJHEVuWfeG6wEHtaVp9zaBNA==
X-Received: by 2002:a05:6870:e242:b0:25e:7a9:b603 with SMTP id 586e51a60fabf-26fcb62e123mr959163fac.5.1723486486763;
        Mon, 12 Aug 2024 11:14:46 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-26c7203f3dasm1922512fac.9.2024.08.12.11.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 11:14:46 -0700 (PDT)
Message-ID: <d70a8db7-acb9-4d1c-8b01-0090c7e40cec@gmail.com>
Date: Mon, 12 Aug 2024 13:14:45 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sae: support default group for H2E
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240812171649.163687-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240812171649.163687-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/12/24 12:16 PM, James Prestwood wrote:
> This was seemingly trivial at face value but doing so ended up
> pointing out a bug with how group_retry is set when forcing
> the default group. Since group_retry is initialized to -1 the
> increment in the force_default_group block results in it being
> set to zero, which is actually group 20, not 19. This did not
> matter for hunt and peck, but H2E actually uses the retry value
> to index its pre-generated points which then breaks SAE if
> forcing the default group with H2E.
> 
> To handle H2E and force_default_group, the group selection
> logic will always begin iterating the group array regardless of
> SAE type.
> ---
>   src/sae.c | 41 ++++++++++++++++++-----------------------
>   1 file changed, 18 insertions(+), 23 deletions(-)

Applied.  Do we have test for H2E & force behavior?

Regards,
-Denis

