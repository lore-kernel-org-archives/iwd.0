Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EB2209689
	for <iwd@lists.linux.dev>; Tue,  4 Mar 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099460; cv=none; b=c80TkLILZluNSkGBqAsq+5zrUviLUxWH3yQxTgvXiilkyh5BKG09WQh2S+QwXfOgeTjfKiQrJ6DE9g4fHLNrC+zc0WMnVP0WRUUgBhCQOYQoo+8Q17cJVqjJQJUwgBDvD4O/pGEvEx8VAxuQ7NcRgBQ3jfFgNWrXJznAfMjg+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099460; c=relaxed/simple;
	bh=JjAarKf8w2VwUKQdBCoseW1LJyBxby08Cd4D+6aE++k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fyxsBFnlcEP8EoW6Nu51agOV6wAJwme4t94nTsURXf9mafxX6rjf1SPUDyLC9b+HcMgRB2b17KUF3lior9kAWQBctPT5/H0lxfvHd/Ycg8APVSf6K83DRJEwO7p4wV+ejZBSYAurR4Q9vmiBNOXITfAHl9UOPPIYmUwcBsIFORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alx85AG5; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alx85AG5"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-600131846b1so1180449eaf.0
        for <iwd@lists.linux.dev>; Tue, 04 Mar 2025 06:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741099456; x=1741704256; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gwzSAUCn/XJ+9C3rpX5KsKDFle5l+YsO1odjg0hQ7mU=;
        b=alx85AG5qc6sn34+GAxB9Vy9hWakoQjkrm4ZaYBW4r1bnZeauwcviQ6gDB5jtHrYIh
         tGsMPCGjmOBVVe4s4481Nwlx9Rw7SXQvWdzYzgrSZZzVOGvhyLLc8o/7EbI2kjNFmK5k
         a/XPiC8Rzofy4s1TIsHQMBAq9EJKmHQCJLNzXhCTVgr96307G7az6YMlQpfWarlqff0j
         3fbzZdlkKhDjcuX5lpmVxmj8XexuyuJheH1piM+4btEJF6nGM/77x8Gx27KwCc9vdAlm
         C85cNAeLaso7Ec4i3YHj1poMBHsKSNJCpXleICu/oj7JbHeH41fw96KoMmBzqt78861b
         jsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741099456; x=1741704256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwzSAUCn/XJ+9C3rpX5KsKDFle5l+YsO1odjg0hQ7mU=;
        b=vNdmVTqe/2g3qe7PrCz/Rf4bcqZdLjxh7kxSE4F9u5WTQZj619VMcF4vrc4ibkqPDa
         imzByuyslbQWBV6OfmDN96xhJO63IMnKpwLOYKCgg5hkauMCialQOLjSrH+URH3pw+Jv
         1dH53KHfQ7FHJ429rKLkedlS4VMdDbRCh0+xvTtkaQmRknc1Bz35D33sLKfAYA71HEW1
         r2FsFizZuEE7a+16CGn5NgDFTqEG8MXYsiE+ZOiaVEllEERysV3kwh3hkoxZKM7zYY3A
         i7PXaMyU6+0x/trR7vHkHGolv3g1LYwgaMUtIO5T3f62NycYWclvyW1rBKU3H+aWV8lA
         QhdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy9DoTSz3TivtTB3dA50VrfjTHXk6+fmctojTq8CuAWBOw+espMt38+lzqqMfNF3ZfG8M=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1fi7z4J9mJCzbxDYTPTpOyckhc1KaYoo/o+W8IVWgtSUozume
	GGG/4CLFk1z2oBCggZTHHxI5apar4d+beEez6O8r3vrUYrv2QBm8
X-Gm-Gg: ASbGncuGMNs9Y47SLLOU6Uwb2Tflb4uTqq7LkEi24993ttTsL6HOvqIvUavQoDkYzqZ
	9QpJszCm/HwcsmwNOkQmjoldQMl62KIFgEIND5beOaRYaj6g8lZ2IKnz9oiMw+j9HLSnd6sd8M8
	5H1h92a5U6ihqGvTYNPiwH3qS1/C+dfgjuJjwh6sbiLiZrEPphGXRHo1u/W5tAeDtMg3wPpYueX
	pZvl6LnY3AY6uSgUiIzY/bAeW0i+tTn5deHqsMvbdMgDzCD4L35DgsqNANcK+7tbp7igl3OsBVv
	iB/uxY2ZzpK4pj7efgRh8QNXyIHzmSvOFE4yo1hPibXwrmHJhPNHfjnDZZTF3kepOpwTEMC+17o
	gs4Rom7oPQQ==
X-Google-Smtp-Source: AGHT+IFHBqWcq/Pit5hmlgMGbw+UOAnLBIJwrfZFnhnvX8NLRhGDMlY3TuYqal2h+GSm/SIHJoZHOg==
X-Received: by 2002:a4a:ee89:0:b0:5fe:9b5a:531 with SMTP id 006d021491bc7-60024bc4090mr2360027eaf.0.1741099455944;
        Tue, 04 Mar 2025 06:44:15 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5feaab76516sm2071866eaf.14.2025.03.04.06.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 06:44:15 -0800 (PST)
Message-ID: <b652f70a-d3ae-42c0-82fb-1cb1d4e45411@gmail.com>
Date: Tue, 4 Mar 2025 08:44:13 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blacklist: allow configuration to disable the blacklist
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250226185548.49127-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250226185548.49127-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 12:55 PM, James Prestwood wrote:
> Certain use cases may not need or want this feature so allowing it to
> be disabled is a much cleaner way than doing something like setting
> the timeouts very low.
> 
> Now [Blacklist].InitialTimeout can be set to zero which will prevent
> any blacklisting.
> 
> In addition some other small changes were added:
>   - Warn if the multiplier is 0, and set to 1 if so.
>   - Warn if the initial timeout exceeds the maximum timeout.
>   - Log if the blacklist is disabled
>   - Use L_USEC_PER_SEC instead of magic numbers.
> ---
>   src/blacklist.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis
