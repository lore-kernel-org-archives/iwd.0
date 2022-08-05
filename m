Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952D7C
	for <iwd@lists.linux.dev>; Fri,  5 Aug 2022 18:40:32 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id p132so3525422oif.9
        for <iwd@lists.linux.dev>; Fri, 05 Aug 2022 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1bGBysm346XSnZidHQFsxHgB571krddGK+oAF9rHfPQ=;
        b=jdVkZ2u53kidk9kI7qwZt4muQ2oyN6iw0mEr21nkoUyIxpuoJ+jcZj4kYVvD/HG7/P
         /P6mYuMqLlQW8y4EAOOwEbYS27UmRJbBE5+j4Kbv4mzgCNabVqZqLEGGkISXdiSSWUWH
         DhzSx/rOw2R87WizEIv0rvXYcdnKITY2B+/Vkw8Tv5yrD68KZeIxkQZRt15Rz22r5uvW
         aUDFfFsriOQrcWV9GCHDfZCvZHap6LQPE/Xs7rxGQWEtj/mNkYC4AEx4yCdfRNuJQQpx
         4Mb3QA49fdSqA7+VnNm/oWJNihXEoJk9rkW9le2qoWzCzYetRcBWKu6dWOrAhDeDWmoK
         th3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1bGBysm346XSnZidHQFsxHgB571krddGK+oAF9rHfPQ=;
        b=X2MtcXM+hgGBBpNTpsjh7GgVMLAVjLTAK22m6YdJdSWnx6QQRBrUCF+E64PFXg57j+
         nzoQr6QA5hllNo3QWUsMcW4qqrxWcPaJ4csUO3epgYurJ2AbeXjw35QzjtiDLqNetlSM
         BYJAi6ReR+jxgplbCS35tRf9+R3O8gg7xi/dJkkckdyj8h/TlnOAXROy7fgEUiXHfiv6
         kr4ZMywQ5pHYupzWPkMFlAsL0J2T5yE9P3bSuOXa8kRPk5jOGXty5g2ioDD/w2ewxMZo
         iu8kicSIR0IhO71T2UXzODCA5tOWtM43L468Tit01ajvlpiDgLzwp1+f64Lt07ceuLmW
         EsIg==
X-Gm-Message-State: ACgBeo20n4E+7h1sB6PdgAVV2VqzSmnK4phEPAnsqh7V6oEqR/wOqkvi
	zaSpO2GAQJMMXWr6Hp4IZxk=
X-Google-Smtp-Source: AA6agR4sEDyiGstKuZ1u/TyWAZnSseg+tgHJaJ0pMSJGpzURWxKl8/Ydcfc0kVZquJ6q/pXKObUU1w==
X-Received: by 2002:a05:6808:1a1e:b0:33a:add2:63f8 with SMTP id bk30-20020a0568081a1e00b0033aadd263f8mr6360272oib.268.1659724832056;
        Fri, 05 Aug 2022 11:40:32 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id o16-20020a9d7650000000b0061c71777dcfsm823070otl.75.2022.08.05.11.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 11:40:31 -0700 (PDT)
Message-ID: <58abed2b-cfca-971b-abfb-5d8e69e1ded6@gmail.com>
Date: Fri, 5 Aug 2022 13:39:29 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] scan: watch for regdom updates to enable 6GHz
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220805174517.639930-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220805174517.639930-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/5/22 12:45, James Prestwood wrote:
> This functionality works around the kernel's behavior of allowing
> 6GHz only after a regulatory domain update. If the regdom updates
> scan.c needs to be aware in order to split up periodic scans, or
> insert 6GHz frequencies into an ongoing periodic scan. Doing this
> allows any 6GHz BSS's to show up in the scan results rather than
> needing to issue an entirely new scan to see these BSS's.
> ---
>   src/scan.c | 157 +++++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 121 insertions(+), 36 deletions(-)
> 

Applied, thanks.

Regards,
-Denis
