Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381BF33DA
	for <iwd@lists.linux.dev>; Tue, 13 Sep 2022 14:17:22 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-127dca21a7dso32425487fac.12
        for <iwd@lists.linux.dev>; Tue, 13 Sep 2022 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=TPHFa5Ytmd0Qlqm9gcdrJCnky6Q12gVdBti4h0LIjpc=;
        b=BPhKSJ6FczXFcogpTlpMZjp+72yxlAcdh1ZdfZg6rQgqjPjnpnmeukaK8gZSUDx51a
         Y2uvZ+Poaf6PSxlhuuTOG7zuEbG1gef4tZu0K9G/maRDYg8eH8tKMynpk2NB2vgITUGu
         E+Zflckan42eFMCKorhEIaYlXMHtO/MSjYPXdpXhwtO1DJG0Os5dtaisRPbvLA7BMWi2
         6s32lF8c/Ru95OyqtQiAha3Mc1RvStct0xQKGSVom2JhbYLQej/KReAqVG3jpWgKox2W
         iO64b9YCacpW1c5CZ1Xy5gIX/mCG5+7pj2v06KFkr9ucA8fXEC1kElUsRonG7sSbYy9E
         Qtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TPHFa5Ytmd0Qlqm9gcdrJCnky6Q12gVdBti4h0LIjpc=;
        b=LyQ3q6tL1cTGbgxQm6e1dySwT/GSxV0F8ocg2mQ/1whZZ7iSr7U+pVmo0jJbYblWj3
         inI0jQxopLXdVQ3apahN0jz2qOnfQsYlfOgMG5bCm+vZgDWiez3eg7JXvfXHCm+3Ul5j
         fPTi68mIR6KvcaHimWBjE1oCz/fHzmdD2FPCIBfc1iHO3sMsj47oLgZ5AJctQHZHMj91
         8Br9rDBOdq1fRqDQUpHxkJhBn+cAcS5rquvjDcg4GyYHXTHN2fO6/eCsGJfE/11GQm2x
         MyZ/AoVkfGSJH4pKsvT1zjHqvL38vO+KpFyAvqkRoFFaGU/r+bDswemkqUhCrZePcaEz
         QZ9Q==
X-Gm-Message-State: ACgBeo1Z9mbQdOWgSp0lFtYrFqBFXZixLsk87g+ORNKVWQoy8+aVekm8
	6ogQjNBPW0MsXIIGIPen64A=
X-Google-Smtp-Source: AA6agR48Z4wwa4KBUb7IDEXZd4Zw1osyoRJ5xfoV9qUcKinKSRMs9jiqaQ9bLWU4g2xAyCw5yI/cmQ==
X-Received: by 2002:a05:6808:130a:b0:344:e23f:811b with SMTP id y10-20020a056808130a00b00344e23f811bmr1570112oiv.82.1663078641062;
        Tue, 13 Sep 2022 07:17:21 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id p43-20020a05687056ab00b0010bf07976c9sm7124190oao.41.2022.09.13.07.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 07:17:20 -0700 (PDT)
Message-ID: <ff518d68-aa1a-2e0b-1226-0da967c05a4a@gmail.com>
Date: Tue, 13 Sep 2022 09:00:39 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/10] doc: Update Netconfig Agent API doc
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220829173601.1963953-1-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220829173601.1963953-1-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 8/29/22 12:35, Andrew Zaborowski wrote:
> Update ConfigureIPv{4,6}() parameters to simplify mapping our sets of
> addresses and routes directly to D-Bus dictionaries.  Split Cancel()
> into CancelIPv{4,6}().
> ---
>   doc/agent-api.txt | 123 ++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 97 insertions(+), 26 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

