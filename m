Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6AF14D28C
	for <iwd@lists.linux.dev>; Mon,  6 Jan 2025 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177949; cv=none; b=X6PH7NP1V+UpJYTQJzYAA9iajd1SGBaryEnGhoXUW6h6GtV94bDr3JbQyoA7BKM03C2UMSsar4nWQU13HdP4YdY4WpP+ILacIOzHUaVJuAupxWtcKu7VFdzs1c4exqV3jnyNEaCwOb9whWEBiTjN+gz+7Rcs+itICLVvan8jiVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177949; c=relaxed/simple;
	bh=LNC1odcu9C4kKtbNYUKpXEU8I6WwRjLI9V9gXe5kHc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L8w3rmu900nYHJBDWEGAq9HXOFRjm45vve4hqxFeM3SY01K8hyN0Qp8iHzEpQilYZVZkZdm9rtTcqL3SoTsB5Fp8WyScg05AI5joxO7nLvt5D3OrFbFuBH8V7D8FNjEB7FhQREskP5WB2AvW1k5N8HPF2f5lAeb40lbXHGu5uMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JleRzvSc; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JleRzvSc"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5f340d6db09so6217176eaf.1
        for <iwd@lists.linux.dev>; Mon, 06 Jan 2025 07:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736177947; x=1736782747; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jPR09fm9Sey199C0s5l0YXVfsKAFNBofAWsgojc+wSk=;
        b=JleRzvScZ7h7m4VMziLVH+GZZy4foxTOMUJaWvPlkOcmGx5TWJUaa3tRb8LoJbUxqt
         kM2cNhrlyVJByUK10TzJ2M6U99XmOkv+tRV5OOGE3eEo90I2RIJ+BKMFlR7t4wxVKmVi
         j4gy0yFLg26haBqzMCvt9Y24Cqr0AZ9k0vIhrQr6DmruPrVwgoTyHa72KawLhV2CFaLI
         th09M8AkZ/yIjGFB7dxhS8ndCEmk9ioxqyVfn4KHTSZGslXrQVgH3o7B0o2pNV6auj6K
         CA1GwV4uQKdyi15QTTWDXX9oxnlfbQgMQtad0GxTHnOkUd/ahRdcHfz40Byuo+KOtceb
         7ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736177947; x=1736782747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPR09fm9Sey199C0s5l0YXVfsKAFNBofAWsgojc+wSk=;
        b=mYaxBPUekhUtyPUI2P8+V/FYKIAIlsVEkNm4y8NxY+NXxazWrlneFqNjOuoUTz7oNY
         wugE6i0kmQfa+AUqB3QTPVvrhkT1aB12I2GCK6wCs9o3omD8JIQuvuEpi/a8bMV/y+Ho
         w5u3O6MROemab4Yuw849tvWuchbsumDgi4ZPtnMClW5XKVi2bT9cnYHtKpFN0NKnRsja
         FgJ/eyKLXVxaNnX6KPX3rFRlPzCHRMELijB09uJaE84FAdQco9DHdwUVhR36E/U3wptn
         dfsw72+uNRUC9FdxJh9HPkAMmboqo1mqRPfDzXrXz+UcPnyFyp+PPr3fY8X/BU9xX4n3
         1T2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXt2hfCI+RTs2dJ9wjyISQnXuhjldbSb7GzC7guNF44B/u7Rg16DVA13EKjfpG0D2K5pGI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwGYhsEvf3l5ahDeoY3lCBXvdN2PSv34U9R6633oJo5JV/HHg17
	9m6ssHlLaE8OYNhTp6DSKkxAiMWFl2c0k5ZEjIvcoxI99y4ESg2A6OLxGQ==
X-Gm-Gg: ASbGncs/b2wggbIgcUwUawofI1puujGbNMeGFJXuMyQqVzVLoqex94q2HKlf85dbOqK
	4dfgKlXevoxxhmVNwliNlgkK05mzoAO5tK9DmYTnGjhLheRK/ueSGnlOcoeuvKn2hF5wmrlI5+p
	NPBqrR9tEpviwK1hEF/FzA5Zy/wD5JaJ6mQAU7nubJFVEeR6spJ1zGdu/KWrElRypKgsgaFREMh
	8yuwzBfbxE5HX7tOE7cLzNA4Wk0+6axmH/0vNLsxDbxwI2j5hzEwYeUlaNlzrG/WBydT2i1Ikth
	F4IbAmuwHqW4TUH/LaTyXA==
X-Google-Smtp-Source: AGHT+IF8sDQKlTaaXyG9uetex3TexLM/DldOsvW5qz5kuvdMLyfRNw+1Rosv3iMG0h/nllceXHR/Hw==
X-Received: by 2002:a05:6870:9d98:b0:29e:76d1:a8f2 with SMTP id 586e51a60fabf-2a7fb245f7bmr35015863fac.18.1736177946929;
        Mon, 06 Jan 2025 07:39:06 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2a7d77b5371sm11744818fac.38.2025.01.06.07.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 07:39:06 -0800 (PST)
Message-ID: <3ac83f28-76fa-4d5f-81a4-2508e2b846d8@gmail.com>
Date: Mon, 6 Jan 2025 09:39:05 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] handshake: add more debugging around PMKSA caching
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250106153430.132452-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250106153430.132452-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/6/25 9:34 AM, James Prestwood wrote:
> Instead of just printing the PMKSA pointer separate this into two
> separate debug messages, one for if the PMKSA exists and the other
> if it does not. In addition print out the MAC of the AP so we have
> a reference of which PMKSA this is.
> ---
>   src/handshake.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Applied, thanks.

Regards,
-Denis
