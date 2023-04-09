Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD692185B
	for <iwd@lists.linux.dev>; Sun,  9 Apr 2023 17:24:13 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1842eb46746so3695620fac.4
        for <iwd@lists.linux.dev>; Sun, 09 Apr 2023 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681061053; x=1683653053;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVfLuiLxtA2FtAbK75Y5o4f6jQvZ73US6qSVjIt9dtU=;
        b=cYH2pNX/u9AhP8D4aIVPvxOux2lBCPg3UgUCkK+oQJrbNtrqPqRb2lO/49bgwAzVT1
         BFeN+LkK6i9JNJLs8yDe1nb8TgdruZDQRnIva6L9tfP1bVo71IfSz2YewsdQcDJTbHMp
         2JrlXYj+XDMv+nMkI/8eIL4uqFyx8bW6JR+IQn5KwNBU4wqes3WKrPY/GrkxVzoGiq9d
         ow4LfcseEGsGG1yCdGgY3yZJ665E9WTDHoWA27+rUYfOHUouQOMwEG7Sn8KIvzxPzAel
         kmWY641rug4RXL7et+4N41yYacpl6Ys3P5yFN81Jk10EjikLy/XIuBjmSk3XvLgY2VvX
         4xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681061053; x=1683653053;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVfLuiLxtA2FtAbK75Y5o4f6jQvZ73US6qSVjIt9dtU=;
        b=CJrx8pujDVcQKNjePWtoejoGANORlB0LKrMc7oJ84KmvadUCk4t3C+6UlFKXMzl6nf
         y8FEjAUtPI977R1dgACu1nsKxgmJ64JkX0JLkP9m6mCL0vkqBCMO0aNT6it5yd+wyPgM
         ZW1R0czZVrgIFumFXXPFr8gTIMLcujBAFNUy2t99wFbKB5jqV8nhc2AZ+Dxm/7R8SS6+
         pJKH65oKzIKoqEgJA7NnCnhBHtqm2L3zMDOtZ0ubYsbSWyrSFu/R7bkkrYVNLCORTE3y
         COfcfTSJhPS7KLfHoMkTQzu2BT4MFBPK7M590Zs6noG2n9TBCSDHoujnb1pmoT4k+LQj
         p7/g==
X-Gm-Message-State: AAQBX9fC4PeMF/OgyFXadQio0HxLhZbRq7sYevvzw93cnagw4AF6i/gD
	uExsDgzvtOVkJFpzH1Sak1o=
X-Google-Smtp-Source: AKy350Z807CbnuTILVVEcLxr5Nygb9Ly1eHPvmhZU0lZaMejpp5Hk/c0xgiHwnAn9dZ9LufNUkeMqA==
X-Received: by 2002:a05:6870:568c:b0:177:ae97:c499 with SMTP id p12-20020a056870568c00b00177ae97c499mr2631843oao.33.1681061052924;
        Sun, 09 Apr 2023 10:24:12 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id zq36-20020a0568718ea400b0017f647294f5sm3320119oab.16.2023.04.09.10.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 10:24:12 -0700 (PDT)
Message-ID: <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
Date: Sun, 9 Apr 2023 12:21:02 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230404203823.384260-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230404203823.384260-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/4/23 15:38, James Prestwood wrote:
> The 802.11 spec defines what AKMs should use sha256 to derive the
> PMKID. Hostapd commit b6d3fd05e3 changed the PMKID derivation in
> accordance with 802.11-2020 which then breaks PMKID validation in
> IWD. This breaks FT-PSK/8021x AKMs in IWD if the AP uses this
> hostapd version.
> 
> Updating IWD to use sha256 in these cases will now break backwards
> compatibility with *older* APs, but this will be worked around in
> future commits.
> ---
>   src/handshake.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 

<snip>

>   	if (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
> -			IE_RSN_AKM_SUITE_PSK_SHA256))
> +			IE_RSN_AKM_SUITE_PSK_SHA256 |
> +			IE_RSN_AKM_SUITE_FT_OVER_8021X |
> +			IE_RSN_AKM_SUITE_FT_USING_PSK))

I don't see that the hostapd commit is actually adding FT_USING_PSK to use 
sha256 generation? Only FT_OVER_8021X?  Is this a bug on their side?

However, one consequence of this is that preauthentication is likely broken for 
FT-over-8021x networks?  Do we even test this case?

Regards,
-Denis
