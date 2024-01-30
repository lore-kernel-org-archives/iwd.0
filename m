Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010E67E88
	for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618295; cv=none; b=M+/sfaTCQ+4Oyu0ueUkwRLXMtQy6V0kDKpedEFxuHHQJXfsWRigoR58pZGnXo+G5a1/Uf8Xl7XJ3uYlkzsqCnyLeerR+HGqe7ubyxhS7BAxsE8A3z9u3Qz2pgl/GZzzPKafBfFKijTuU4FyRKMJv87K77iCoRB+EoRhM1bvvytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618295; c=relaxed/simple;
	bh=5Qbz9dtYY04wwHJN1EP+Ux7y52HmdY0vId82EQ1iR+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cnqhoDzhw+VYHfdcz/4djJxK8mblwR+Tj41c0ZGNIeKsQmkDDM6APZfU9CahAGTQblWa7EnPvBWx8UH0GsRPw72zMYgslEr5v++oCCsVqjbjvrpFMXbGkcy+zDGoE6MRP5ycH1wrK0PSfNSFV9aI1OsAkbqLCX1dmto8LRLwZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grMxzWoG; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grMxzWoG"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so2875328b6e.2
        for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 04:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706618293; x=1707223093; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IidketqBNy90vu68OdcTkbqswmIruKYu7nNB2FztLWo=;
        b=grMxzWoGSVoPDh1s91AtDFK5g63E4GEsi0neX6/2/CFCwrUZFr8rUhuwv49AC80rTG
         tYd/EoUvL3d3HGSzq/uaNFgj8ZUBmKo6WP0E4vQLmTMKnn2etJ+lDN4jGHCCFglGAUVH
         jhAY00c9l4dip3HLrckosJ1xvPGAOpEUjmWoe16rp/FKs56WG7RdiWBB6vgxGT/c2TGF
         h1z7YjVJ8NCqWTi5WTClCPrGF3arEd5Cg14f0fvEAgaEYQRfHMnPSrwDYIIp+cLBbGe9
         NrzGke1CNtZRgBd6BI4gmeYfKFkGRUN4P+DQB3kgnBlW+hhc0ntlde/BeY7CtZGyKshp
         y9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618293; x=1707223093;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IidketqBNy90vu68OdcTkbqswmIruKYu7nNB2FztLWo=;
        b=SII6vecNr60OJYYmKhhDT+4UbSf8Fm4arTafjXMCqP8ZO6BAYuIvIejT1r6u6ZB/UB
         vw5d9coF5+AVW/pkMhzCQKS3QqiSLAsHzPKkydFPZ/lmFtZcIKAgQiGVrxA1M8wbV0ze
         fD0DvKFXOoKr2BpkpQgHd/NLXeHrxMufQD9vc+NCQAJGdRf96gsLSm8Ln2s5j1UmJbOG
         ChmJLooq+0QBYAZc7EvdcuMDzrOO17WKWuiIOyv6FdKjY2kaEHo7XzbyJgCh2aUSjFKg
         fu08ah3L5tnXe86jwhR21Dc7/BxhlsJb/PCZdIXunMApI6QrnsK34/EAGTSSGU/9wWiL
         IilA==
X-Gm-Message-State: AOJu0Yyhk/j3T4waVfd0uoR/Jy1uj2jSizcduP3cpnaDbZZmz64BJGpp
	Pxg90fBkPxx0FRQV1Hh7jmdg2cnjbgJIWvBJXtjUa6+EGWxFUy0UKtGPaMVq5gE=
X-Google-Smtp-Source: AGHT+IE6uIi7e6r5QfJq2JirrO16Af0kE4P8wNfLLp0F/wJwiCjNa3SdSKuVkQNik56+4FzwH2Gbew==
X-Received: by 2002:a05:6808:1314:b0:3be:a36:8146 with SMTP id y20-20020a056808131400b003be0a368146mr9512118oiv.11.1706618292862;
        Tue, 30 Jan 2024 04:38:12 -0800 (PST)
Received: from [192.168.254.83] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id z23-20020a62d117000000b006dddad7674asm7963288pfg.136.2024.01.30.04.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 04:38:12 -0800 (PST)
Message-ID: <a6385e0a-6bd4-4152-930f-a995c0435179@gmail.com>
Date: Tue, 30 Jan 2024 04:38:11 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] udev: Add module for checking interface renaming actions
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>, iwd@lists.linux.dev
References: <20240126231339.10388-1-marcel@holtmann.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240126231339.10388-1-marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 1/26/24 3:13 PM, Marcel Holtmann wrote:
> ---
>   Makefile.am |   1 +
>   src/udev.c  | 285 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 286 insertions(+)
>   create mode 100644 src/udev.c
>
Just curious what this is for. Are we trying to avoid needing to install 
the link file to disable udev renaming? And instead allow renaming but 
pick up the changes internally?

Thanks,

James

