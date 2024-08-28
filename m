Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04A1A28C
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811951; cv=none; b=DFCcgImgF17kB56yinjtwO25euLtNyMECw+AN5Fj2li8AW0NZkV4GHgoO+Jz7Tzed9BDOoObJvg0Vhpi8iSCxg/UMbKXH84+ecnHHwbHwtuJfNTi9V+xSsNfxmDALbLyZ5DJiIFISPiVgHT1eRCgw6cuI3xuTBSnftAFTA9sI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811951; c=relaxed/simple;
	bh=c3NDieTmDRE4+dyc6qUkYEjU1Riy93bwi07B6WhshgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IxogWqGAucSjk6APd+dMr064sCTSSPZ9LWW8t+kZhKKLM99S3vxXhaMyg9G7WNjXBWDtpi2OlUP2VNnrWkgRzPotMbC3wPTi80BbZN4Z31F0KvAszon7R8NNbMorVhRrauaHcNMKofxKz5TMfax76GCSjb3WhsZ7Q1EvWPoFt2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hdnf+mJo; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hdnf+mJo"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70b3b62025dso5209510a34.0
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 19:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724811949; x=1725416749; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C4gax0anYuC+98GoPOL5PnMWUNoE/QccphX5YLJOYmk=;
        b=Hdnf+mJoefOUl38qOV2A1AEv+1SDp0Wi2oQhNI/CquPodz4lXGEMYb1VXUR+YY3E0B
         4J9ys5M9BmYIgFz94ZXIs2jLPgMhuZKShS2T0zDGS8pT6Nm5K+JpY9chr88MUnfQdJr0
         wYUTFKHVYs3lm84qD+Xa785gJyJ81e3vrMZJZdal2x4jHsr3EkhTd8n4hqd4b8SgH0Pe
         cGdDIXuKHbsogO4Movu5yzPEgKEKOwehOTs5xa1qvs8be1Xtdinxrxv9p/1qO67cXGRg
         r61q+KTUc5rFAc583+t2Z7+WzLZxwAZQsVs9X7kHwlolDVhafegVBOweDQqvuejR17wS
         HTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724811949; x=1725416749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4gax0anYuC+98GoPOL5PnMWUNoE/QccphX5YLJOYmk=;
        b=AsQudA3c69BxcyRLgp/Qh3RCUBN9sQV9oae2F5dRaQqrJQ2xgIAAmuxr0+SfmZWuuy
         mogLj0lyv3TezUv6z1QwZn4VX33G7LYcLEl7sYwRNjA63AEiytsWQhPre2fMi4PvEof/
         elZqhxVZJiQ/eIxDNvFTnnnvojGGL3Hny0VbnFHWik5xv5FopmxNWLfUOhMc4wZw9G9c
         Zg16jT6x4s5DCJif7Apd9pBy3MKJ/NgV9ZnLxCzl4EQtCsZ7t/03TCrUyGbXQOjr6Y8n
         gLyKiE2+h+p4fMgk0sAlOR0M11r6bRbt+rN/NQXnQxtVU6hI8fveF1cHYcHcHPBTbmgV
         JaKA==
X-Forwarded-Encrypted: i=1; AJvYcCUaJO+2YDnSErsGxyG5XXBljKq0zmh33tl3K6tMxUWQWe2jpagktrL58Qe67kTTy7A76IM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxrKGGytyh4pBwK/7oTOmhFx/WsGPK3cGkviKO2jvzE14Uw7RaY
	oJtwfY5euy/+6BOeQ6nfAaiSimm3zAq1dl6d+ndzhjqDVHidz3DK
X-Google-Smtp-Source: AGHT+IFesc8F+HXw0qjGzPLccVPIg5IgmSH/ogLRIm65q92wSXzmjMjGgzWqiotEAtMAZjDeGdkEFQ==
X-Received: by 2002:a05:6830:4197:b0:70d:edad:8635 with SMTP id 46e09a7af769-70f53aedfbamr592044a34.31.1724811949090;
        Tue, 27 Aug 2024 19:25:49 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70e03b61166sm2703815a34.59.2024.08.27.19.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 19:25:48 -0700 (PDT)
Message-ID: <80cea4a6-0c2b-4b10-81ad-abece3d661eb@gmail.com>
Date: Tue, 27 Aug 2024 21:25:47 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dpp: factor out key derivation and starting PKEX into
 functions
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240827142125.751023-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240827142125.751023-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/27/24 9:21 AM, James Prestwood wrote:
> This will make things a bit easier in future patches, and reduces
> some of the length/complexity of these functions.
> ---
>   src/dpp.c | 92 ++++++++++++++++++++++++++++++-------------------------
>   1 file changed, 51 insertions(+), 41 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

