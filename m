Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511E2F28
	for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 17:56:12 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id b10-20020a4a9fca000000b004e6f734c6b4so282485oom.9
        for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 09:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obx0Em5EGJGdgAJKXkQu6R0ERkh2EZ/89QcBAqHToFM=;
        b=G+6DSAmgEn+kgbHx2P4BUKaHgTQjhq+28CETvYxGA2LgVHu0WYAsk3cbcSjf+5c11Y
         5zpn1+zB1R/CprHP1E6xzUKIiSVf+OQ1pT6WCEITPV97dIoj7hzDOIA0Lr5kx05exi79
         wkbUkOtbN74yKLLnQIUEL74M+WtW7ygWEyD1RemOP32QO9FGzamuf/kj0SI0O7B2Mbw2
         osPmvcXproCdLFugTFIWBhIigOW87WoOUHK/jMLAU7sVeTyyBbJbyZCnBRGKRdI1+v7r
         /nIp1ZIK/4s4AY4sOAK1+e3x6EdTvbLTNuJcL5OHTDwGpngGPy69f2kvWONDm/0/PoKB
         FCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obx0Em5EGJGdgAJKXkQu6R0ERkh2EZ/89QcBAqHToFM=;
        b=eP7cpMomFAmUZ3/522Sg4j8ZfL7vXHymcmHHHwkcBLnX1PZs1kOX3pZfVwGQnb2sCu
         SBNbHrLv2m5Eeztqs0/LHqNF9AN8e/NBNFLi251jdNADdXRNfc0LDzzhDfawClN0dQ+l
         kd0yZZx3oUQijwvwAKm7FCKjIINxNCj2kJjO7oRv6O55Kd3f5QGgoSAFmJc2WReWxSyX
         UsgEYMyuDrkituMBAtmwz2Ko/VffK321BobtkI1zCkyHAhVNv6Xbv2kWgwsIJsLyMf3a
         Au5om8vnfiW9NA34eVgNQKa/LGrzuJ7UPsbSclExrdl6/j7yycwtZXaFnoDgSe43WiAD
         ogtw==
X-Gm-Message-State: AFqh2kr/FPMnSB9hnyqnp0SiYo2OG5cofdDCXloEC2dnV7yY/qIgCC5O
	YRglAzhGo8j909AOa3SwYYE=
X-Google-Smtp-Source: AMrXdXv31uKzTItS0Vx9gzTYqxg7za00Ys/qCqL4GqpL0PS0363krPtGLUm0bt7ZXR1sreBu+o/yyg==
X-Received: by 2002:a4a:ac81:0:b0:4a6:5afc:9a51 with SMTP id b1-20020a4aac81000000b004a65afc9a51mr15956168oon.8.1672422971670;
        Fri, 30 Dec 2022 09:56:11 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w9-20020a4ae4c9000000b0049f9731ae1esm119285oov.41.2022.12.30.09.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 09:56:11 -0800 (PST)
Message-ID: <2a78fd9f-a6e9-83da-77ff-62735b447580@gmail.com>
Date: Fri, 30 Dec 2022 11:38:53 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/4] band: generate HT chandef from frequency
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221228223231.2686276-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221228223231.2686276-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/28/22 16:32, James Prestwood wrote:
> For AP mode its convenient for IWD to choose an appropriate
> channel definition rather than require the user provide very
> low level parameters such as channel width, center1 frequency
> etc. For now only HT is supported as VHT/HE etc. require
> additional secondary channel frequencies.
> 
> The HT API tries to find an operating class using 40Mhz which
> complies with any hardware restrictions. If an operating class is
> found that is supported/not restricted it is marked as 'best' until
> a better one is found. In this case 'better' is a larger channel
> width. Since this is HT only 20mhz and 40mhz widths are checked.
> ---
>   src/band.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/band.h |  2 ++
>   2 files changed, 89 insertions(+)
> 

All applied, thanks.

Regards,
-Denis

