Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3570158DD2
	for <iwd@lists.linux.dev>; Tue,  3 Sep 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376287; cv=none; b=rBJPDnKBZFuzl4bzOgQAcxRAqgRfUdjQraVZNMDYdyhKSObGXkYaRSVp22AsYAhtWdvb3tjcJ3JLl7XJxRSeVV0ofiEPRAiAJxWIlr31PeuM67M+EsoL9r3CHJr8NdnziRRG1BwyPpbMc5AiKCPC8XAb56alovdNM1dPSFLY8rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376287; c=relaxed/simple;
	bh=OPFeFmqNIAKRKtE/TdSn8XRZVBjQaKBWD5JRi8iNArI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ma7MgJEvqm15oAcAxQIHIHWpMkNScglmWZWcWilMgbbKIHHoFI68oYhxJSWSVQ88Tnnm/T/QSrx6WMisW8hgqO/PKopKPdw1FMZdc+FsE7M3YHm4hctscoZ1yYR0nvshzpVaZcBh0LBXqN83LjhzvmDOZWLSY8OHeRrNXBPrurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuTwEWh6; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuTwEWh6"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3df02c407c4so3134865b6e.1
        for <iwd@lists.linux.dev>; Tue, 03 Sep 2024 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725376285; x=1725981085; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLWwH0ZyfWWLk2Yr4+aaOOPR8RLiU580cMVFWu4ylWA=;
        b=KuTwEWh6vgu+8Zq7T9/OuCUnPhzWOYhqJGlq+8z1yWAggnQ2i/KGRpkEnUYCZ8b/il
         f2N1qEKi7ANEJTk3NMBJhhqI2vzSYzmXjLSXE66WWQJyN62D936z+aQyYZbTdD+SqeeV
         FbDC1e/0xwiX7O5/90uT1Vh6to4K+VF8bMVh7634XLUUawxjT7rOo1f4DYTmyPmeFXqf
         /hgUTWaKw6zNxpQXnZcQYDUXpyDGBGhNeJESbDWbGbwj3NssVxSdbF8qpY0171Rh/II5
         r5FiQEg4CWxDQzl84fScuvkiumgnAam2kl3rRGh+BOjFIaVo4RfpakOqDH7zvfrgljo/
         JKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376285; x=1725981085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLWwH0ZyfWWLk2Yr4+aaOOPR8RLiU580cMVFWu4ylWA=;
        b=UgC3hhOumSNKvk3398uMf6+0ZT4gZxOq7rkMwfkmarEcJJV0Z3WNCCVF51jK6rP8Ev
         9Qt6TdYc2IFm/T+rid1Qpt2KH3VdqGy6jBqg69qE86/mh0QCZFDIahgocHpaIAlrpeHG
         xM14relY8MEHCWBgCfAsSilVhqu45iicSsKAL93wF6/K2kqBiF4CmD0erZcr7bAr7e29
         CfbpbcHuTp5gPHFqmHz0sz/fAl4VPlkqfxbGb9hEvnPTgxh7K//KQo5oyq7jT7Cdw9xp
         lpMIGI0l2uWOwqTaIegHrmtdPMHbQJAH/fN/TIjWoAXMZyRan6dYVNjkSAOLrTVPK0pl
         2M1w==
X-Forwarded-Encrypted: i=1; AJvYcCWrmp5OYNiei33h+jtJH3lJNNpzFZkdlxJM4mDhE4X+HwCuF2kopz4YOSly+QSLbwBXRZY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzueXBOLgywNt/mR5TJOmb54+djKBFXBUI2+vs1rN2ubesKUyHp
	7Zb3jfugycFjPm6n6PEZToM1bglxytroEIrh/Yc9r7AsVv7QksdG
X-Google-Smtp-Source: AGHT+IGpm9sUTPs/6mXL+h0t3nXQLCmOyz1ATNFqPFI0qR1lOpB390lIkluZgr9aCL4sYWYcbIeg7w==
X-Received: by 2002:a05:6808:229f:b0:3d9:3f5d:7b59 with SMTP id 5614622812f47-3df21db8d1amr12756467b6e.0.1725376284725;
        Tue, 03 Sep 2024 08:11:24 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3df118855c3sm2347179b6e.49.2024.09.03.08.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 08:11:24 -0700 (PDT)
Message-ID: <6dea3768-f5ac-4116-bb84-0bb0f1efe69b@gmail.com>
Date: Tue, 3 Sep 2024 10:11:23 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] wiphy: add flag for supporting remain on channel
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240829114102.56284-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240829114102.56284-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/29/24 6:41 AM, James Prestwood wrote:
> ---
>   src/wiphy.c | 9 +++++++++
>   src/wiphy.h | 1 +
>   2 files changed, 10 insertions(+)
> 

Patch 1 & 2 applied, thanks.

Regards,
-Denis

