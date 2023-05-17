Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367119F
	for <iwd@lists.linux.dev>; Wed, 17 May 2023 00:53:26 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1967cd396a1so111861fac.0
        for <iwd@lists.linux.dev>; Tue, 16 May 2023 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684284806; x=1686876806;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVM0q0TR5wVvw5X6+F0v31k2GrtdZdxcyAZ89fKtMTI=;
        b=OBa57eNE9fcLUag0G2t5D0HRTONX0NW59HK0QlRyqgemN2a5VbTzpJk+m38fSXtBah
         JVLcUGiiMTdYOVU2TATR02Pw8FGu0BDdQnWhHbe6c1b5ZvQDK9LLQeauXTyXqU9C2ujg
         iUEqoVCEVeGksjK4mTvvgTu9dZSdmaWcWqIvMRGsrQpSEEtSUg9JEeOwTQwwLOhlVTG0
         BSeBHTKHxu1cHFyXmCjGxOgGy1ah9g1v0lYs7AipT+uaKhakNc95CtaCpjLhxqCopTfw
         uhZB9z56aGPCphMKTMoIKukCF4hmfl0WemK1oZdZbW/bgricCPa0Mzbbl7XbfLGv6uQg
         vYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684284806; x=1686876806;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVM0q0TR5wVvw5X6+F0v31k2GrtdZdxcyAZ89fKtMTI=;
        b=jpojyfoiUDv7MawPWL02WAcyxGlVX1e4sxrM+lQBho2HOmomuprzWJ77k4y+YVLfuY
         m0IJgtHIhFYG7HXGB98Wsvk82HVltjTI3t9KA/ORCMye9eN2KQR05Pgm5zUXR2pnYglW
         UJ3VKsHETFSX+49GRgO+wvYhj5tg18IjuRutzcgyAZoKO98z3rt380D23rAejKacjPt4
         Onj2woOI1TuN3Xm1sgWVSAYx90S7E8LO+vUOtzXINomoKFe3a/9jv67Yn+F4Tn3CTHiL
         FFeNogBQ8FSgw5I4D3Ls2FeyRDWfsYmjlrdFkR1YlsCCecFKbYMnCvMv10KLts1xPBAK
         Ysmw==
X-Gm-Message-State: AC+VfDwSNVMgr+7RvbUEx/e7lE6cO3cxYnCH1L1lTl3XdaxihHR+HS8G
	qW/UqSZT9oQV+47lp6GqPf4=
X-Google-Smtp-Source: ACHHUZ56g2BF4Hudc3t0FgMFirVdRHsmsqS8caOLXpU5TUINvX5svtzjEaSvFsqfkFGEBfcLVHMJBA==
X-Received: by 2002:a05:6870:7684:b0:192:8095:3d05 with SMTP id dx4-20020a056870768400b0019280953d05mr21551639oab.19.1684284805762;
        Tue, 16 May 2023 17:53:25 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g2-20020a056870e1c200b0017aafd12843sm13684010oab.32.2023.05.16.17.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 17:53:24 -0700 (PDT)
Message-ID: <c144e8f9-90e9-bca2-745f-b25e596f5600@gmail.com>
Date: Tue, 16 May 2023 19:53:22 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] wiphy: fix regdom change wiphy dump logic
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230510204508.715558-1-prestwoj@gmail.com>
 <20230510204508.715558-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230510204508.715558-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/10/23 15:45, James Prestwood wrote:
> Certain drivers change the regulatory domain when the client roams.
> First XX, then the country the roam target is using. Depending on the
> timing the second regdom event can come while the first is still
> dumping. This was not handled gracefully/nicely in IWD and it would
> just issue another dump (it tries to cancel but if the dump started
> there isn't anything that can be done). AFAIK the kernel should be
> able to handle this but based on the behavior we saw it seems to not
> be able to, or at least not reliably.

Okay.  Might be useful to know what the kernel actually expects to happen in 
case we send on a socket during an ongoing command.

> 
> When the second dump comes in and GET_WIPHY is issued the kernel
> stops replying to any messages which obviously causes IWD to completely
> hang up waiting for various acks (set_station, set_key, etc.).
> 

Sounds like genl isn't doing the right thing...

> Now if another dump is ongoing (and cant be safely canceled) a flag
> will be set when another dump is needed. The first dump will be
> waited for and only once completed will another start. This also
> ensures there is at most 1 pending dump when before any number of
> dumps could be queued which is pointless since only the last dump
> request matters.

NAK.  Please stop right there.  genl is already a queue.  There's no sense 
adding queuing on top of it in this particular case.  If l_genl_family_cancel 
isn't doing the right thing, then fix that instead.

> ---
>   src/wiphy.c | 103 +++++++++++++++++++++++++++-------------------------
>   1 file changed, 54 insertions(+), 49 deletions(-)
> 

Regards,
-Denis
