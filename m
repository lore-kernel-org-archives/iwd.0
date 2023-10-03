Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC95125102
	for <iwd@lists.linux.dev>; Tue,  3 Oct 2023 16:33:28 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6c64c2c0f97so731917a34.3
        for <iwd@lists.linux.dev>; Tue, 03 Oct 2023 09:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696350807; x=1696955607; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rS2nlFocli+XCbMkEBp4TrAhFZmqM2sfsavF9DSUUvw=;
        b=QaXX/Ip9HfKeQoqv0FzAb8TiZJnZQF95T8AVEGgk6PI4KRZUo4wV/lZWdYZPcLvJbj
         1b7zcrmURCXzLF33MAhzt5JzAKdl7x4MzYicSkUXJlrIrYIijPutvjYGv/TF/QCubtwn
         0P4DwHWJS8tOx85ukrPZXjffn1drv0XRUMY4728md+t5JQDZCJL4HEDQR4/77WvbpZOb
         cSHo5H351iC7ZH5oYVixz5CnapfROHUVl8gf+PYlQAKJKycqxalxR37bPGPGgAj6uSQs
         Rg1X3k3ynrEIUU4pPl3L/I0+8w0uzXr8tfeARcwYGuWhVWnjNGSCtnF/5LxGP6mYdtnU
         UdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350807; x=1696955607;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rS2nlFocli+XCbMkEBp4TrAhFZmqM2sfsavF9DSUUvw=;
        b=PLt6YB9vb0tKaTGC3CXg+1ktoeui3eMEKoFCWN1ZCLLmKGGdpkaY3VpqZVzd+g3xg4
         4sColScqQEzt4rXNJzGg9Xyx3g8FHdsrbzEvlVTEq0pg33kCEIUK6szezFW2qZNKg/DM
         +m97/Khwcm3Suo758vW+LxrMpYCAagK5Nu4t+gGoz3UBnC1thOCAeKN31qi9lL7eJHtB
         6DP7WXyv6YSY8J2VMhBM8S+SxERCO1uGO8Jd2ESLWvgkPp3de9ci9I+SU64jEYhjuWEg
         7YGFvpmf1d2JsCIDWYGgdDAkBJHW3YqIeX54EjEAmNd4/SmA6/am+tXDDokZsbFW3QK2
         d4Pw==
X-Gm-Message-State: AOJu0YzE4MPmG7ynGPGi73fm5CBSjpQSOdDFv8UpEmtErVV/mdQxfkZb
	h3FVDTDtoKYhNa6XfW2K1Sk=
X-Google-Smtp-Source: AGHT+IF3LEdbXmUNBVg5uDgS6Qf3Lo/81KRPdybEKDdgvpReIMKZhHKZZjbhO2QYyhMSVut7jhHIEw==
X-Received: by 2002:a05:6808:251:b0:3a4:6b13:b721 with SMTP id m17-20020a056808025100b003a46b13b721mr61688oie.46.1696350807635;
        Tue, 03 Oct 2023 09:33:27 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s18-20020a056808009200b003af7bac7a8dsm221775oic.28.2023.10.03.09.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 09:33:27 -0700 (PDT)
Message-ID: <0d30e339-f9a1-2957-6613-31a76c8c17e6@gmail.com>
Date: Tue, 3 Oct 2023 11:33:23 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] station: check disabled band configuration in
 station_init
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231002113213.3852482-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231002113213.3852482-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/2/23 06:32, James Prestwood wrote:
> For IWD to work correctly either 2.4GHz or 5GHz bands must be enabled
> (even for 6GHz to work). Check this and don't allow IWD to initialize
> if both 2.4 and 5GHz is disabled.
> ---
>   src/station.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

