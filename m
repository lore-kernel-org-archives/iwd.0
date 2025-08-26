Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487C23E340
	for <iwd@lists.linux.dev>; Tue, 26 Aug 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219656; cv=none; b=P1/8NHWZqwEzCzJYH3dZnaro6nX9eDpCD52dVCH0qJk29k0jIt5OTO6nBXU0qYJsn54CgZh68bRpI0uh9cXv/Z2f5F67W0d2MEIXpG6NfEFMVdBVHyAlJ9ocOen7C3zHwrmoLNMl4fawJcGXV2tW6saPip81rNzSGa1dPxMps4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219656; c=relaxed/simple;
	bh=R2JOsKDj+Lx6lRwIHEVFg1EhHKEVrvzv04T4u3hZdN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lr+lbbtQbYv0+vNcPgyjrYZAxhbjmSkdznCd/E+nta3xZigFDoB924eNoPVTKku1HbpJv7vFLc92D8P1+myTmWTP2bH0JKbBXmNpxk9ZPL38QYJnYYizOa7Xhgl6LO05PCnpnokUcw5ETJtM+npcI1YO0Uk2sHAH6ty82pB50GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cH9irEy4; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH9irEy4"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74382027898so2661920a34.3
        for <iwd@lists.linux.dev>; Tue, 26 Aug 2025 07:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756219653; x=1756824453; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3oU88cxs4v09MIzBHiNfAN/HxoPbm+3PXIW08H1yuu8=;
        b=cH9irEy45gzKdaX3S6z7RJDP80g+xRioItpnnKvzZQUCxusRonINXO22jhDHmerX9g
         IhGjVXTbp+VwbD4oreKs5A1Qv/LnoeUduwSSn1r9vbUlnKe8jferfBJ/aWXuHa/YscYD
         bbDEx05wduqSigkZYRAEooeBNQtoz5ULLee5/w1ZR7H8JFvzxOrnhI9kAyKJY1nnyusB
         AaubfyIYsoDs1qG3bnASgfJv6sNiJoIyR6uCU+txayhs6SxPTPqo3MOxwMOX1Gc5iE1b
         vKItpvEWUzCZsyNVYs+riksUImdiy5gEd6bVZEwlw+2D0ehPjlMIKSNJa6QUevTRGu11
         rHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756219653; x=1756824453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oU88cxs4v09MIzBHiNfAN/HxoPbm+3PXIW08H1yuu8=;
        b=Y2Xyb/PJNpuNHFCeArCYKmx4m4OtEhgOLAYeGTtaj2CmB+pQffoTc1LgDg/Htbktd9
         4eMck9XjE3JcWKeSCCpxzqR/KXesUZXZNZFWAp+k6Cq7eopLcIPk0NpssFeIVf4axOra
         uqqmCy4sEbivwJcKVmsxPbc79tRKnX4vkh/oaDC4lZXRJGF9p9AkbdKWjJ1Yx/eb2nfT
         xdBjZm5UlJdPdJhMrCCm84Q21MdhLDovupZd+gGcFRnfm9axMLzkCMu8YzUMPkj5iwWF
         oftQj2SSll6MHzb8ebLhD6Id2raEQKQs2i3nM0lKnpG0Yi0phO0JOtq82wUC7P1I2Z4T
         XhfA==
X-Forwarded-Encrypted: i=1; AJvYcCXwpf4N3fUtZV36acRoeKSORFB7neTzqZM3KchWYAXv/CjnrU3WY+5V5y5BkuoImSLLJkE=@lists.linux.dev
X-Gm-Message-State: AOJu0YzS4tG1DaLc5GTEZADwIKqgm0MJrlPMkl074qppwXn42Pfy/uR9
	Cm83LBPfvii4ZsFT/6GHWKfuFnv8+ntF45EZHsWK5M2V6r3R0Byn+9SZxhm5Ug==
X-Gm-Gg: ASbGncuV/523Wx+MweuGQ+bw1jywXEPZxLCmiGzRRmTDXY/EohO9Pxf4D2QD3TIomPd
	3nzxQsdEkipjxm+aUP9ocIb+zo6S78mzv9EBCnJRAEeHkcDkacUCg1k6iyDY0OP36a4Co7RfxVh
	WnPKUCNumuxoxwjRC1O9HWb/lsfpZLowtETGgF+x+s6+c7Ctm+IsCyMmMTqH0T7HMqBcho8T6Gr
	7IXMkh9ikN7K+16OhtiBhphvCjpOzMss/b76TNug47GRxIWs84PKmdSvuqRMf2VUVGmvTn1GJGI
	eqwoc38jFf5FTHhPJfNt+KHr7k6QnbQxyhnDtHZwVBrrbRPNvN/hwBZiVg4isx/zCnpVN95cR7B
	eddVk1zb7TfZgrxT0sI3SWdwoSF6xiy0a2Yk79AMf6r5GAiCCFaPRZfMGSi0zs7nGtru8dLZA7f
	c=
X-Google-Smtp-Source: AGHT+IGR3P41Cm6tSh3tjaBZ4HDuew/dtaeZjqA6Q0wnee7CwfihDRVxRmx5xM8eDnFFTu3ZgWYAeA==
X-Received: by 2002:a05:6830:488e:b0:727:3439:5bdf with SMTP id 46e09a7af769-745009c2112mr8063337a34.13.1756219653505;
        Tue, 26 Aug 2025 07:47:33 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7450e2841ccsm2399967a34.13.2025.08.26.07.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 07:47:33 -0700 (PDT)
Message-ID: <d30b921a-6de5-4843-b3fa-83ec7973d8ac@gmail.com>
Date: Tue, 26 Aug 2025 09:47:32 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] wiphy: add driver quirk for the colocated scan flag
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250822195118.271122-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250822195118.271122-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/22/25 2:51 PM, James Prestwood wrote:
> Some drivers do not handle the colocated scan flag very well and this
> results in BSS's not being seen in scans. This of course results in
> very poor behavior.
> 
> This has been seen on ath11k specifically but after some
> conversations [1] on the linux-wireless mailing list others have
> reported issues with iwlwifi acting similarly. Since there are many
> hardware variants that use both ath11k and iwlwifi this new quirk
> isn't being forced to those drivers, but let users configure IWD to
> disable the flag if needed.
> 
> [1] https://lore.kernel.org/linux-wireless/d1e75a08-047d-7947-d51a-2e486efead77@candelatech.com/

So why does dropping the colocated flag help?  You have a 2/5 G network that 
isn't related to the 6G network at all, meaning that there is no RNR element. 
Hence 6G must be scanned passively on social channels.  If you don't add the 
colocated flag, the end result should be the same, no?  Or is colocated flag 
forcing the use of RNR element only?

> ---
>   src/wiphy.c | 23 +++++++++++++++++------
>   src/wiphy.h |  1 +
>   2 files changed, 18 insertions(+), 6 deletions(-)
> 

Anyway, I went ahead and applied patches 1-4.

Regards,
-Denis
