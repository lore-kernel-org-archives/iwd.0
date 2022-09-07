Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC389CF
	for <iwd@lists.linux.dev>; Wed,  7 Sep 2022 21:08:14 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id 92-20020a9d0be5000000b0063946111607so11084571oth.10
        for <iwd@lists.linux.dev>; Wed, 07 Sep 2022 14:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gxINwNfSgowKkbiind+a7NNBKagz52/5lMu05GtQoBs=;
        b=d1tTmQY9HUjSOGUust1M5bSPkK/OpCrgWRhJJh1TQ9MkDtPPPSb5dmKOJE7TfOQ91l
         jD1834a/sla5/r8rrby7fX6I8V3C9Oo9eer5J//TUaJ3lwjS1kvRyLp+FZU4e85ch3TN
         FKEQt2MlES3pDduhe9mGVkGriN7NWIQhDBJO0ByYjYf5Rz7Ppa7EtpfER6UyQWzytPbu
         TPC5KnH8j1RiDD1a2Th6bHIGBG7vs3Mq7Nl3+1sTy3swbqpr+KlU+z1uoZbrpks1znWh
         b1Cag4pvkEdGPrGsNPcdfPwfWulcHHh3Gv8BlVgMZv+5rT8UKe0OM2m5fEdRpC4Hfysn
         7T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gxINwNfSgowKkbiind+a7NNBKagz52/5lMu05GtQoBs=;
        b=MelBZZCAtNclF6orXMVXLYSTCX3ZV9Z5IpMeKyUUHUgr+8oL0lW0caSZXbjUNKwuzJ
         Jo/xSpxTshlbGjP9715/R/IUU4Ia7HLv6R5KA0ps3Eivb3kOtRXBYm8W20I3UJmzHD0E
         t3vB+qW85oLyyMoB8BdqmFHaVC6dCgzC7YDywCk+6vOJqMvyhgsalburisU02erTxkEm
         mxTWmlsL1cOKMKBygkHFcTymbLjwN2ynjQDqUpLVL7UcmPASCHVpzFkERD3x0QlvYVR4
         asEtfRHeyRVXS4GSvNoHkYBOYgYaVTtC13RCp+eeTlk5qUOd2wWSyHfT8Z1MtkBkC1qi
         pbMw==
X-Gm-Message-State: ACgBeo3bTHnhYfkqOITgZK69zv1ljLvJLdG1rL89NSSAfdG0Zt+WkBDz
	jFjgNMLB3iZ0xN/vIRWaSP8=
X-Google-Smtp-Source: AA6agR6bxHNWHV9ZyEcZyI6D2BpNdeDKXnalzNo00e0NVxCutL6OyxK4Rgrxi3wfc9i1gh8ABsK8sw==
X-Received: by 2002:a05:6830:608b:b0:638:d739:a18d with SMTP id by11-20020a056830608b00b00638d739a18dmr2332960otb.144.1662584893248;
        Wed, 07 Sep 2022 14:08:13 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g3-20020a4a8943000000b0044b22632d51sm5443286ooi.2.2022.09.07.14.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 14:08:12 -0700 (PDT)
Message-ID: <7077ad03-3cf9-7165-d1a9-698d8ddf1195@gmail.com>
Date: Wed, 7 Sep 2022 15:48:36 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] Update nl80211.h (wireless-next/main)
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220906192207.84986-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220906192207.84986-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/6/22 14:22, James Prestwood wrote:
> ---
>   linux/nl80211.h | 459 ++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 440 insertions(+), 19 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

