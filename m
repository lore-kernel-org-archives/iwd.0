Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8725C81
	for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 16:18:31 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1278624b7c4so52841755fac.5
        for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=E3XTNDSD0PCOm/4ubKdae53JOB1djhrn4wjbB1fdVc4=;
        b=hZ5p4f9RCFeDRoM1aRDTJbgqZctk0L+5fHpGofpnf+0VVICr9xJM5g6/KRCBc1pZO5
         aM2LyfZesh5zRvpZq/ka8LTWfyr23ERL5SCSeXr2/5cOWve6WXGkaNRVzPPKQ6acAhs9
         pd7v1gZnD5IKckOj5/ktuYvzR3NUD1ivZG8mihL6FX5YhAC01//ZtAT0Fz2+rVXo5jT/
         DG6uOX0SjayAIQTssX7D8/9Agmm/X/vPd0BToVSow+riRAIjoV4hjWYYtmU7VXOBFpX7
         NV5+XzGWZuGUdPbtIkzXOv9L2BQd81IUWxIuTpX2V1DHXvKFfRXqM69fiKJJ+nHN3WgA
         v8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=E3XTNDSD0PCOm/4ubKdae53JOB1djhrn4wjbB1fdVc4=;
        b=N/c9FVjpvxOr0HX/U6dyol3lHIoH25TX90DxZ2cXn13ercoyic+NCq3Wj9UWp110DX
         +v5/YMPiLY7wgVj12ecQ6FHBFeiOzc7ozu9dKBWQKvuu7WaybPgaCRzivd+q7hQhNQP0
         08qHnvbZpgg2NmBXmtSxPXzDs44Zn45XQEH4KuGy+X4MZtE0Pw8obtdpUAXE9+X6v0de
         0n/G4iwUCGRBA1bM9rEtXr5c1nN3t5qyP/Wt1qCi4Ah7q56W+TZ0RYMTMb9eA2dtFj6p
         gII8P3kSG8mb66K2Hb/3KbED8sGQHw3VraE3B9lng0C6yQGT0UkmjoDa8i4p5lcRCATc
         +SQw==
X-Gm-Message-State: ACrzQf2HSKJx+6wF5v370LwbHFvQtx24U5ErZ8ysmJNbVJEv0UpGENzi
	iY6I8yRj/w+oNaM33xQJjfc=
X-Google-Smtp-Source: AMsMyM5MeU3jXxL7ICDkJtPbnHtjcbnr+/AKES6SNfOxgd+N1voxv16hfw50oAGHIBCT9vAB+NNleQ==
X-Received: by 2002:a05:6871:80d:b0:126:d6b:e3fd with SMTP id q13-20020a056871080d00b001260d6be3fdmr3344604oap.205.1663345111195;
        Fri, 16 Sep 2022 09:18:31 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t6-20020a4a8246000000b0044b491ccf97sm8964528oog.25.2022.09.16.09.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 09:18:30 -0700 (PDT)
Message-ID: <bebd8b2e-2b65-6da5-5d66-2d164aaee5d1@gmail.com>
Date: Fri, 16 Sep 2022 11:06:54 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 04/14] frame-xchg: create global group enum
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220915220741.1128728-1-prestwoj@gmail.com>
 <20220915220741.1128728-4-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220915220741.1128728-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/15/22 17:07, James Prestwood wrote:
> Only P2P utilizes groups for now but to avoid conflicts in group
> numbers for other modules create a global list which can be added
> to as needed.

A non-zero group implies opening a new nl80211 socket.  Do you really need/want 
to do this for FT?

> ---
>   src/frame-xchg.h |  7 +++++++
>   src/p2p.c        | 24 +++++++++---------------
>   2 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/src/frame-xchg.h b/src/frame-xchg.h
> index 360bb4d4..5b55ded8 100644
> --- a/src/frame-xchg.h
> +++ b/src/frame-xchg.h
> @@ -37,6 +37,13 @@ struct frame_xchg_prefix {
>   	size_t len;
>   };
>   
> +enum frame_xchg_group {
> +	FRAME_GROUP_DEFAULT = 0,
> +	FRAME_GROUP_P2P_LISTEN,
> +	FRAME_GROUP_P2P_CONNECT,
> +	FRAME_GROUP_FT,

Anyway, I dropped the FT enum for now.  It doesn't belong here anyhow. 
Applied, thanks.

Regards,
-Denis
