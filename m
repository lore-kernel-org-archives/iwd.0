Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85501B14EC
	for <iwd@lists.linux.dev>; Thu, 20 Jun 2024 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899384; cv=none; b=r/yrC2pmhpNg7jff/Vrk+RNQ1ntQZ5txtNeslS2QezJeSzO4hcDl0ZJyCBpcoknuDq4TTPwq23Z1EWkhODTxkx8CFQeo4ResLJHv0KTrv6EtiH1u2SC9a3z0PHWxdB5aRyYjrrG/DryLgq73lWNp96Kq2c00FW0dVzJVBDLlkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899384; c=relaxed/simple;
	bh=+VK5neaBtCJjkyWLyVn0HWa5c8rSk7Nfl6e32+02YRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ifl9jFi5lKCcO6fG7/eur9QYQ0AFy/l1KlYr/OXWv0aod7TnMlSEeCkUOeBIwvUI/J3df9FNtMmfQC2KAc/OBHXvvZAAd01ZNdIQZhBTQyt3gjBdmmtO6rHehdCImbUYuQnp0PnD+akO0HcZvlBt7m2eOKnvR+ncVl30BQHanO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbCyXqg9; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbCyXqg9"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-24c9f630e51so552138fac.1
        for <iwd@lists.linux.dev>; Thu, 20 Jun 2024 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718899382; x=1719504182; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xsND7eW5V1QNdzeq1GWWnP1d/WBXdL9x5JU0uzScvg=;
        b=CbCyXqg9R7HPeAAaonDoUzwVEklwLBg/ns+aN03/Cj58rNKAr02WRPt591gK+DHfvi
         /lXmWjV+n43NlBgvKSoFkQn8+G5WW/VfB7Ko+zlUlgFgS/6MWz33qJo4e4H/f5hUUt+I
         h0kbaoO3IXA8EEDR0qQGwUsYjJAnaz/3SDSPd5CTxBMiCilnF5/Ul/PoXPliKNSr2KBU
         xP8lOOlilGqsFh8DsPm9dTshEN9FV16Jzc9ToCRK/13/U+aHpVy+LjhUOswZUNuvBYyK
         0fTAUpuSC8vE4SFF7r+buKf+uPTO8sRC3w/XD6E/o67hZolSpYCWJ64UiubxIsMPYOTq
         I6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899382; x=1719504182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xsND7eW5V1QNdzeq1GWWnP1d/WBXdL9x5JU0uzScvg=;
        b=tqCiOWcC+CZTCSW09dzttG9VZfli+og9udM9rSzaWJWtcN1cP+aczW4i3Q+uerHFAU
         +5K6XrqvHRr4DyDnKSV7rIYxvA9gcgNinfglkOE5KjWrs0qv2N89iCzBlJ/M2f9I+zny
         jniMJ0qwPIbN5MLGgYYtdaCLvunHlIAiDwmNwK+On87mJicoRhaaxUywQfVh14BsvmjC
         35Apxm/d5G+R4vuCpgPW7N0RLgNGwwc7VfY/zwx8mnvjFxegTBCnqRs7rK7/l6UDbHKS
         N5RF78Y0llu9hDAJZIYcUQ6mypcUI1UpS2YZJ9xXawQpD9UWHi8LRRyd/wJ9MeAYR7eQ
         VMCA==
X-Forwarded-Encrypted: i=1; AJvYcCU3sD8FhAIvIzJj0wQAqJ/USpSJ2uu+gbaXYUZhPH5bXhbGlNsnLF0AiTQjwocBUnBLCyF52MBC5Ae+FExRhaP7OeNy
X-Gm-Message-State: AOJu0YxKRebwCcIc8bjmmZIoIw3nlKY+FHhpmz+wAmp9laKJ1Jo62YV2
	JyIEayrxwMkAmPlRuMgAmkkGBdy6CIapWiVwTl8g0D+Pg3WBM8CK
X-Google-Smtp-Source: AGHT+IHs7PUbp4B4tuMytCpKoxpsuQ1gp0v9z+n8AJG5PeNYb1tvpJbkUEUCKAnxE3ac3cJPwof+fQ==
X-Received: by 2002:a05:6870:c088:b0:251:8d0:1c76 with SMTP id 586e51a60fabf-25c949f5d5dmr6596133fac.29.1718899381602;
        Thu, 20 Jun 2024 09:03:01 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2567aa52f97sm4303038fac.29.2024.06.20.09.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 09:03:01 -0700 (PDT)
Message-ID: <075cf3f2-f7e2-455a-bc79-ad436bca2f67@gmail.com>
Date: Thu, 20 Jun 2024 11:03:00 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SAE/WPA3 in AP mode config question
To: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev
References: <CAG17S_P52iGw9j12MrP0OwL7ZxENH6gj17er1vXR58R3qRS3Kw@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_P52iGw9j12MrP0OwL7ZxENH6gj17er1vXR58R3qRS3Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 6/20/24 10:58 AM, KeithG wrote:
> Group,
> 
> This page shows how to set up a simple ap config:
> https://iwd.wiki.kernel.org/ap_mode
> 
> The AP using this is set up with wpa2, I believe.
> 
> How do we tell iwd to use SAE/WPA3 authentication in such a config
> file? I also did not see a flag in the help on setting it while using
> iwctl interactively.

iwd does not yet support WPA3 in AP mode.  There was a patchset [1] a few months 
back that added this, but it was only partially merged with additional changes 
requested.

Regards,
-Denis

[1] https://patchwork.kernel.org/project/iwd/list/?series=850639

