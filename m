Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4F32EAF1
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcaT0oGQ"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b2f5aed39cso553244b6e.1
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698330746; x=1698935546; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oCnENr+2oPyAS8OUrc+O0vmbjJqM/BWsB0Q9JB4OHWs=;
        b=AcaT0oGQXSzcEwOnEd7zbGy8pIb4x8bmdO/h2UAwOefdgCoYucYJdcCEBijJUdUf7u
         YHQMDinDbT2Pmd/vmX+He0nadXE4xmu/eGje7cjCp2Gzwq7TQsdUfRpgz1hiJdYpdttA
         UZIi4hyw0KQcs2WJjBbzdyihmB1vbUTfg2e93YKHriMiIAv0fww08ARDERJVQToVQps7
         css5qUkOEVuYYxXff8x6d54OycajpMvfv3xNSQzxgAeByPpupVNnFNmuEsyaKbP5BZ2G
         wgqgwTgYHPzMzSwYwyh0dpqF7YjBqTjFPeG0nbHXUcIWW/dgS1Lf+6YM3fOiImwwH6vv
         iiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330746; x=1698935546;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCnENr+2oPyAS8OUrc+O0vmbjJqM/BWsB0Q9JB4OHWs=;
        b=SmvLLF47yNbXnDEv5QK1GeIAwUktVG+uZw197AlfW5TtX3C6+qsLw3eKLnKXl3QZu3
         Yfd92xyP6qIdpuODSVl965dvfDUcFHqpY8DRe+b9daguvev/PpK/q4ypT4vOlY/4qy2m
         2KOL0BIqEJh8mH1yhm7IKoxAJat7fQC0l2kopGJh1FZEzj0YoUBnuRp+mQy2Wzk9Yiez
         LRhTF1s6fsKVU5dqJr9PyB8VvFyTwJfOO9mPNhT2klbc5sdVySXFf2KcMiWXjafstXCK
         9sMcJsstJiZ27WKaRCbgdhLPzezKofESe/pojYMDsfYrgEB2q+mvl2o7GXnRz+R0Kp2d
         GX5g==
X-Gm-Message-State: AOJu0Yy7zj5cpjgw4DDo0TtHvWhlqql7OZTODJUUhciI+rDDzV2oRncl
	WPZF2IFHlSWHA7TWWFk7UWs=
X-Google-Smtp-Source: AGHT+IFylFNtGoS2DmRsmRWh64wA4GAsoXubNI8gEbuy87aikS2OEtH+7DoyIOJWjHZO+D+AW992tA==
X-Received: by 2002:a05:6870:10d8:b0:1ea:2e2c:e9e7 with SMTP id 24-20020a05687010d800b001ea2e2ce9e7mr17529782oar.59.1698330746053;
        Thu, 26 Oct 2023 07:32:26 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bt33-20020a05683039e100b006c61c098d38sm2673406otb.21.2023.10.26.07.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 07:32:25 -0700 (PDT)
Message-ID: <e8833170-5df6-47e3-91a3-3e991cc7358a@gmail.com>
Date: Thu, 26 Oct 2023 09:32:22 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] offchannel: handle out of order ACKs/events
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231025175639.262390-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231025175639.262390-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/25/23 12:56, James Prestwood wrote:
> Its been seen (so far only in mac80211_hwsim + UML) where an
> offchannel requests ACK comes after the ROC started event. This
> causes the ROC started event to never call back to notify since
> info->roc_cookie is unset and it appears to be coming from an
> external process.
> 
> We can detect this situation in the ROC notify event by checking
> if there is a pending ROC command and if info->roc_cookie does
> not match. This can also be true for an external event so we just
> set a new "early_cookie" member and return.
> 
> Then, when the ACK comes in for the ROC request, we can validate
> if the prior event was associated with IWD or some external
> process. If it was from IWD call the started callback, otherwise
> the ROC notify event should come later and handled under the
> normal logic where the cookies match.
> ---
>   src/offchannel.c | 58 +++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 43 insertions(+), 15 deletions(-)
> 
> v3:
>   * Handle the various cases in a for loop rather than two separate
>     lookups
>   * Fix incorrect comment about the request not hitting the kernel
>   * For the "normal" case I didn't bother checking
>     info->roc_cmd_id == 0 as you suggested since this _should_ always
>     be true if the cookies matched. Adding that check shouldn't cause
>     any issues but it just looked wrong:
> 
>     if (i->roc_cookie == cookie && i->roc_cmd_id == 0) {
>         info = i;
>         break;
>     }
> 
>     // It would _appear_  we could reach this point with the cookies
>     // matching but have not found the info object (which is
>     // impossible, I know). Its up to you and doesn't functionally
>     // matter either way, but this makes more sense when visually
>     // inspecting the code IMO.
> 

Applied, thanks.

Regards,
-Denis

