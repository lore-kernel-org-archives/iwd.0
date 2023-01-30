Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E9F3C13
	for <iwd@lists.linux.dev>; Mon, 30 Jan 2023 16:18:04 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id c29-20020a4ad21d000000b00517a55a78d4so103828oos.12
        for <iwd@lists.linux.dev>; Mon, 30 Jan 2023 08:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mcdvu5o8jznplhGmH9VwE/9DmGu2WU9i6Y297+SZ3p4=;
        b=gWBuonPvfpJy8uWs1/P/q2KYafVwnlMakWVcMLKuFnztrYvzHTvO0XJcZ0llJOMPUO
         XDM6SVuxRc0o/TshxDVFMnBKspY860WM9wYQVgIzREYsSjTSOp7FMzjNNLLcx13JQTHK
         PBbaUF6Sb+vypuP9QGqNLHpBz0hb3hI5ApQWNTsZp8RcKbOheIU0y6gLLyEkfrmze2qu
         RkUnlPTG164VDwlo0QcvkpF2Axpdgr/8Nww3v5BzEvtdaOPantdbYs0/aZ1TqLvW6xez
         cJGsFgbszvfpBCa3+5LiS31xW2km97Yu2oLuymYSsHdDy++umdhQGSqWs9uiwVraXkAd
         OSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcdvu5o8jznplhGmH9VwE/9DmGu2WU9i6Y297+SZ3p4=;
        b=u2RfZo9WuMaPdzqJRUfTlJuZNmC3dUErtq9oYtKHY4Kg/0HO/Ite/seoxOlh+7lwbR
         yOH6TBjR42GO6C93MmqHtPxbv0gsVraBrhBNvuwTb0bC7YPNyrEJ0cdLmI0IeAwFmh74
         vvsPXFvlrZ6vQ8kFcU+eh9MST1sq+9R1lKbzcowOVud/YuAogu0JIIc29vF3ZyOlJW5C
         pLITkcJHOZPWf46X77WEzQ7uO7sib0Q79PTak+uocHUXV3mGwA/vmlgYvlig5taJnD8D
         gk6Dk+YSzGKfDd3bU/TMMSwMAGLlh7wFN/wZYYsK8Erl2W7lD/m1E9yic50iAq/d1pnY
         eJ5A==
X-Gm-Message-State: AO0yUKWrVQEMaJaev3tWur1OIENzNPp3jUdf9o6OSo1+wNdXoSI0agsA
	vafH0F03oh3iQgaWDZ/YudE=
X-Google-Smtp-Source: AK7set+U+b2RCvmDB5oh2aumUF54nT1ijW4ieqpo1VSREsf955Ecr8PihgFXWvzc4+djy9fREWz1yg==
X-Received: by 2002:a4a:dbd9:0:b0:512:564a:5bea with SMTP id t25-20020a4adbd9000000b00512564a5beamr7771895oou.2.1675095483147;
        Mon, 30 Jan 2023 08:18:03 -0800 (PST)
Received: from [192.168.1.29] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id o192-20020a4a2cc9000000b00517587f8817sm2606573ooo.19.2023.01.30.08.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 08:18:02 -0800 (PST)
Message-ID: <a57cb590-b65d-6f5f-ecd7-fd24340e7d9f@gmail.com>
Date: Mon, 30 Jan 2023 10:17:56 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] eap-tls: Add DisableEAPTLSCache bool setting
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20230127233323.3317642-1-andrew.zaborowski@intel.com>
 <20230127233323.3317642-2-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230127233323.3317642-2-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 1/27/23 17:33, Andrew Zaborowski wrote:
> Seeing that some authenticators can't handle TLS session caching
> properly, allow the EAP-TLS-based methods session caching support to be
> disabled per-network using a [Settings].DisableEAPTLSCache setting.
> Defaults to false.
> 
> With the previous commit, authentication should succeed at least every
> other attempt.  I'd also expect that EAP-TLS is not usually affected
> because there's no phase2, unlike with EAP-PEAP/EAP-TTLS.
> ---
>   src/eap-tls-common.c | 18 ++++++++++++++++--
>   src/iwd.network.rst  | 10 ++++++++++
>   2 files changed, 26 insertions(+), 2 deletions(-)
> 

I modified this patch and commit description:
  - Renamed the setting to EAP-{TLS|TTLS|PEAP}FastReauthentication to be 
consistent with other EAP-TLS based method settings.
  - Moved the setting to [Security] instead of [Settings].  Again to be more 
consistent.
  - Modified the warning message to reflect the above.

Please double check that I didn't screw anything up.

Applied, thanks.

Regards,
-Denis
