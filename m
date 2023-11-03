Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA81360
	for <iwd@lists.linux.dev>; Fri,  3 Nov 2023 02:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+zpbC+y"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ce2988d62eso864026a34.1
        for <iwd@lists.linux.dev>; Thu, 02 Nov 2023 19:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698977526; x=1699582326; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEmFMP5HvlDicpKhEXKOzHWPBjY9uKdOoxHnWIJzUDQ=;
        b=F+zpbC+ytyXFyA4ojTl0G8xT0t5PnTuL5Fniq+aVvmG0AIjPDL5kUkDpvGAsvrvwoC
         HD3zIRPtCvyAqbIBdNnMyf0QQgzdqh+yw5MbUznZFFI/6T6QnJgMIdYMgtOVjKYjB7Xr
         H38GT20+RqiQIV7H1zexOCU7rXLMLlYM5m+6RVt4rnSzUEA28JeGBJBcQMdopJYTXPJa
         fdCS6tXIuA1Aw44oCw5iiuvaHIhZt6bD4CNNXJe2ruMAKt64fGJdRPu8rsEelQ0dEYNh
         KLvipJXu6Xa0ToDFECff3y7nQBKcUqAdZg4oxyH4rkEb/Row1FCWvWEtP3hWtNr1JL2k
         FATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698977526; x=1699582326;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEmFMP5HvlDicpKhEXKOzHWPBjY9uKdOoxHnWIJzUDQ=;
        b=pq7ajiwhbamJ0hZCiqjGUHkvpacPKaTKAa3kyy7IPa11KYUy4Rej/lLkjyz0c9UnWV
         GmO2DsUPBKMvaG2pOy0F5H/uN3f/6Or3vxUgEXWrmcZGr1NAi6pIYit2yQq7aum6GcoP
         qP4ILwPffCaoVYLHBNuRg+vS+LxRjpVROoAxhXiY9VTmCykVK0yVzd4llE6mVemsbmqJ
         OWFCKeFMWkVNm1ric36Cu9tabQ7ejJarxnHuGmocT/mHP782vpTnLV54n7EQcQl5VZqD
         mvHHs5uYQlvP5jDbn4CHHVaJ9KcEJuYH+RcW6yyvWX+aVZJOy3lt2AuNviczc00ead1d
         aslA==
X-Gm-Message-State: AOJu0YwmWfqxlhvP6uxx/P90u+ROoKPnoILncUpRgfrvYxOcBOgLVZMs
	L2p5Qntydh8CZfbWghZP/6o=
X-Google-Smtp-Source: AGHT+IHpY9eZdRpMgLXwOQdo68gY/tEqe0Xay/Rt5bEVpCEP7WGkHqTJgo6Lqc0oYhSdYQMYFjRKYw==
X-Received: by 2002:a05:6830:22c1:b0:6ce:25da:6e9a with SMTP id q1-20020a05683022c100b006ce25da6e9amr20126520otc.34.1698977526090;
        Thu, 02 Nov 2023 19:12:06 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l4-20020a056830154400b006ce2e6eb5bfsm147528otp.0.2023.11.02.19.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 19:12:05 -0700 (PDT)
Message-ID: <1d8a3e83-defc-4f81-b85e-6ec0f59b4f18@gmail.com>
Date: Thu, 2 Nov 2023 21:12:04 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] dpp: initial version of PKEX enrollee support
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231031184750.722404-1-prestwoj@gmail.com>
 <20231031184750.722404-9-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231031184750.722404-9-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/31/23 13:47, James Prestwood wrote:
> This is the initial support for PKEX enrollees acting as the
> initiator. A PKEX initiator starts the protocol by broadcasting
> the PKEX exchange request. This request contains a key encrypted
> with the pre-shared PKEX code. If accepted the peer sends back
> the exchange response with its own encrypted key. The enrollee
> decrypts this and performs some crypto/hashing in order to establish
> an ephemeral key used to encrypt its own boostrapping key. The
> boostrapping key is encrypted and sent to the peer in the PKEX
> commit-reveal request. The peer then does the same thing, encrypting
> its own bootstrapping key and sending to the initiator as the
> PKEX commit-reveal response.
> 
> After this, both peers have exchanged their boostrapping keys
> securely and can begin DPP authentication, then configuration.
> 
> For now the enrollee will only iterate the default channel list
> from the Easy Connect spec. Future upates will need to include some
> way of discovering non-default channel configurators, but the
> protocol needs to be ironed out first.
> ---
>   src/dpp.c | 765 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 761 insertions(+), 4 deletions(-)
> 

Wish this came before the agent stuff :)

> diff --git a/src/dpp.c b/src/dpp.c
> index 57024a26..8b47be5c 100644
> --- a/src/dpp.c
> +++ b/src/dpp.c
> @@ -53,10 +53,12 @@
>   #include "src/network.h"
>   #include "src/handshake.h"
>   #include "src/nl80211util.h"
> +#include "src/agent.h"
>   

Why is this needed?

>   #define DPP_FRAME_MAX_RETRIES 5
>   #define DPP_FRAME_RETRY_TIMEOUT 1
>   #define DPP_AUTH_PROTO_TIMEOUT 10
> +#define DPP_PKEX_PROTO_TIMEOUT 120
>   
>   static uint32_t netdev_watch;
>   static struct l_genl_family *nl80211;

I'll look at this in more detail once you send v4.

Regards,
-Denis

