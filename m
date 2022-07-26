Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE907F0
	for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 20:52:52 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-10d8880d055so20133351fac.8
        for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=CuEWUE3pejzTEPdfHm7ki7JyhxKGLgCOdJtuVEchCQo=;
        b=FYGK2bFbrHRxPUICXKmPzafoQSMnNgynyXP7RwNYysT9an4NdQBFng2KCWaMcmVdoU
         rDBsDqv2/kcMSqvv8YPOdXAGHRV2lOTse6ZSZK1dBpsFOnsKn9gO1aD5zp5MDVXuU8wk
         UhMKb01zcaafnGQ8MKpMA/EDA2Hgr0oVMvMaqC7YKbTdLV/P7jh2VwgnTdgQ1qPmbA/X
         zXnufvy5GCawlV3UhnmjY8lcT63nveDFdkKw4Bg4odwKnhmMqhc4xGrtD349/UyTSqmq
         9WoeRntj4MOltl4FIXIgmT7KlzsflLXVBKxMU6L38n6iywRYvJRvuPbsHHvuDbtoD5cJ
         JlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CuEWUE3pejzTEPdfHm7ki7JyhxKGLgCOdJtuVEchCQo=;
        b=ncfCkEH8RZYdQSzKHsm9Qik41JV/R8U4AO/AniIlp959inrNURZptXdzE1u5EL61PF
         EECCNVieP9PT6FkrcEFpSDNKu5UCinPjoDmQ7L0EagDw9FPjDBTyUa0l8Qpf4pfd+FDS
         /uD/i+NOLWjVYMp8UAwfDmtYuEGLt874KallehGlMfNY+mpICgwkSeAf+oFnfMcz77c4
         Jo9xjz58GXvPiys2m7+wZSbca3n4yrrNpvIJM47nljSnJAeblWC3QibFIsmtQpf8YS8F
         LxuIORBsxDH8/w4tBfXfSPmU2g6dtgxA1T7IVhu5e173EUtkjBVLyxcedGcPlMOSNaG9
         f1hg==
X-Gm-Message-State: AJIora+cUjnarbP/B8All3roqisp9ezZYKV+859GNghd2vkoNCTRptaN
	FRP+kz5f2mE/jccpA3MIywU=
X-Google-Smtp-Source: AGRyM1suuLRVwKdvJmw9X6qrT4d43nNdAiRgZ5MiMiiA6geGnSjgWcuy6LB7x+68IbVH2D8gc09H4g==
X-Received: by 2002:a05:6870:f222:b0:10b:7326:18c2 with SMTP id t34-20020a056870f22200b0010b732618c2mr511144oao.55.1658868772065;
        Tue, 26 Jul 2022 13:52:52 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l4-20020a9d7084000000b00616d25dc933sm6527203otj.69.2022.07.26.13.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 13:52:51 -0700 (PDT)
Message-ID: <1ce38f3e-8bc0-d82c-6507-7c25b6560bb3@gmail.com>
Date: Tue, 26 Jul 2022 15:52:20 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/10] manager: unregister nl80211 config watch
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220726170920.15929-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220726170920.15929-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/26/22 12:09, James Prestwood wrote:
> For consistency unregister the config watch when manager exits
> ---
>   src/manager.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 

All but patch 4 applied, thanks.

Regards,
-Denis

