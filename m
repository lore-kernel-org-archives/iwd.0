Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C31304B0
	for <iwd@lists.linux.dev>; Fri, 20 Dec 2024 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734674265; cv=none; b=Jf20wIwkCcM591lcmlh5txM63VdTPxuqxiSTsSia3gDYCAbzF30OYlkt0wh87JT4Fw4A0Cpy4SoImJ3VH3XGgeBOenp/LYVQRi3HWOVB6LWP1hKf+AKmyq3mEoDxzr9MuGyGXwfur6nc8AcTcQ+TZlwfg9cSEAffgKUxVE/i3bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734674265; c=relaxed/simple;
	bh=zBbMRfa0e3EymW56lFwoYTtB+kEegx1OKs3I5YmAN7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q53USrNT/0i5Rc8p8ONv2+rAH2u2Pkp+Rmp6yqHoCOCfHbaId5FATRxZ17+DbzGJU8514IvOXcMmo+DSUx+N6yASsG1wo5bvli3BNUAwZzBlfikBatGac5NPgQSJFoZn48G8bgN7sXzvHHSIh0YKGr3fN/kN/e1B9+scpLUPxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg0BjCw/; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg0BjCw/"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-29fae583cc8so832277fac.1
        for <iwd@lists.linux.dev>; Thu, 19 Dec 2024 21:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734674263; x=1735279063; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0gJ2mwErEqFmWHxelYWwW+g9eLgGYTzl07EE5lFKCo=;
        b=Dg0BjCw/CamF2cvvfzl84ww4yI8XINV6uOFew30uQurO90urV8OPK5kqtluSe7DbEJ
         +dkVgWkocTE0DMRnG59TD1ZfNZoP3IXhY2w++tJ0v4/c8+H6Gu/iZ1+JsxjeQmZc/Fi6
         +LQ3LiJB5IOtecBulU/GMGzot1ILtD08YuaG2cCX8bc7K5tCXiet9Camib0TlsYnPuR9
         x/6v8Sk8YRHXCfsiuf01uZmZsxJlopexZ3QVwXrEJQyEFm4/EZuyhC7bvqhXRxbNeO41
         Vt/xOHIS9qgUk/5YmN1LrhBLRlUQzF7OTxPZjIBwNB1gRWeNmMLPueeqF99rPKgI+kih
         J9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734674263; x=1735279063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0gJ2mwErEqFmWHxelYWwW+g9eLgGYTzl07EE5lFKCo=;
        b=Ja+H0GgRtjZfLxRA8Cr79y05R3Br3phU6RajyZEc9rT8LbdT0t1b8W86q+xpJ1+8LR
         9YCKI/9JrWqA4qTK1yakAlvrU7/7lVGQqlsLEFwCMSH+zyoyzMLOVkpFUcDc5+KBD3L8
         dlE14XzacYuc+FsmQyX5H8SWa0Nai+zDii37l+uCTxOpakam3qg6ByNWCSHyxczfllPX
         bNBLt7QFUy9lvgiwUWJWVCW14km18+1MIswUNJIUwTZjOeuq7RPsLXih/zeWVzSZFtNe
         5tBOprcOwnQ0UWKKonTppgoa/mf1+s+SmPUpLoXN/FoIceeLfBxlU0ZvvXAjDy5hXSMf
         l5mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe7KltFD/q75SlFFgledWqcWb4zZBOb8pT5zRR+B+cyLMsHmUqCgnB9xWmd1I1VpFlw1c=@lists.linux.dev
X-Gm-Message-State: AOJu0Yykg8xSvXHdxNqJLgj/i4hvIGNfvxy5J/TSlDGHU0oY/Tadi3gm
	AUiC36a9F8IxXpZZaGH671hPOmAa6G5m+B3I3mnfrGe6LvkYkAlY
X-Gm-Gg: ASbGncs3VNKvRDGi3qoU9dEtHqRgjq4wwfbO0rDYDTogUEGkhmM/oX0+KEMQgrfHK3r
	QY4GH7QKhtLJDUzZwYhiaNR5fNTBMBcM7+ZtHjkZX3coSNIlnu22ueuWtGxvbcoZMangJEc25kI
	cwVp0+NLo5ee3hx2NiMdKACIVslMw0nCIck8Dm6Qk1qrrYo7cm6c8qI9ZQO0v4eJ+1TLkqodoAV
	q9wiyAvaKtjPCb4xyBopFgEmshfRWfET50gAygC2cLMsNKzY2m54+s0BA==
X-Google-Smtp-Source: AGHT+IGU5Wv1IrHbQx1AIzthmkOZoRDaPcu5ZkXZdKg1xpyXlZN6tyWvm5AJ7hRds5uYIZNuJSKYqA==
X-Received: by 2002:a05:6871:6305:b0:29d:c449:320a with SMTP id 586e51a60fabf-2a7fcdd08c7mr858771fac.21.1734674263235;
        Thu, 19 Dec 2024 21:57:43 -0800 (PST)
Received: from [192.168.1.184] ([136.35.146.47])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2a7d7519f37sm746361fac.23.2024.12.19.21.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 21:57:42 -0800 (PST)
Message-ID: <c3e18fa9-d389-410a-9f81-7e4ab02aa601@gmail.com>
Date: Thu, 19 Dec 2024 23:57:41 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: destroy auth-proto after external auth
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241219181701.164349-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241219181701.164349-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/19/24 12:17 PM, James Prestwood wrote:
> With external auth there is no associate event meaning the auth proto
> never gets freed, which prevents eapol from starting inside the
> OCI callback. Check for this specific case and free the auth proto
> after signaling that external auth has completed.
> ---
>   src/netdev.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 

Applied, thanks.

Regards,
-Denis
