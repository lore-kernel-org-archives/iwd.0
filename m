Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F020E1
	for <iwd@lists.linux.dev>; Fri, 17 Jun 2022 19:16:38 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-fe4ac3b87fso6671543fac.3
        for <iwd@lists.linux.dev>; Fri, 17 Jun 2022 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=s/u1OsGcxQeZErUpioxOIP7+Vma+ftlMiLUvRDrabfQ=;
        b=lEbaNH1sD2MnXF+G8QrBOYh/jGVWuWT36cOnCrpSKcmTDBCESAGefWSyAZVdghaY3U
         RhxKPUbgxksvZJ6yd3Jm5h0R5XvYZ6VD7qdFhjs3FujIW9mIhSVxNAZS+ZBj4qJxFSeD
         WE/NM/H7uq4b6JkP34UidE6o5jXaH89+Rf2XkL3mAsBu4hwzhRL/DWwTepjLVW0MN4Y1
         KWnEzvAQbyEkFWpSiJozxzPbZhgF5EuZfnmI7kVzm5p4IxWB3ifFrcTYDHnis+41hdtm
         xV17lAdLOazwyxnkYyVM9UIswiGF9aDNNBLj4eYygaLWFiC+4zVTLm5GHqkzqOvxjsXA
         tCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s/u1OsGcxQeZErUpioxOIP7+Vma+ftlMiLUvRDrabfQ=;
        b=773WxmBxPQwzDBzrgVRZy8aOHWxsydwtk6eIdvwkxuum3zPg/5TaqEu2m9PGwB4LwL
         eLnK8XXBfcVXN6/AqHlh0JdgzSL2cRqvA5dxz6fFPmE1Za1Kk2m40a2IpQyg7xPA8URw
         DTuHUibCLRewwZmq9Ejo4cWcnnEBjLyUyINgeNFEbYkhYRMq803K0SPFhUUXpOrlYUjv
         fo8+FvbIEQHSkrdhr8XwvkC7SOKI7P2mARkRv9fuqKcVYjrEN3MvhA1bz6UUCUO1m5FC
         FNzIaAuQx7CpqlzMf4Zr9z765knTXM3Xi2J0HwKndCfXLueCYqsheCUqwzb5CgFsCoDZ
         jqng==
X-Gm-Message-State: AJIora8tXksJ2qDgDiRhYW3YCF9pH8LJ5SPJKzT/w4bxt0BNRVhvuY/l
	/z183OMc4ImG/HZmcvCWQ3zWmpp1lhTkwKES
X-Google-Smtp-Source: AGRyM1vL4FR5SOWwWzClbZGeuVUTP8PIBRpbzNIaPd93pSLTFUgN5dRQ/AEg07eo7vkeABKzBMLLxA==
X-Received: by 2002:a05:6870:960a:b0:101:c0a6:2fed with SMTP id d10-20020a056870960a00b00101c0a62fedmr450431oaq.239.1655493397310;
        Fri, 17 Jun 2022 12:16:37 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y126-20020aca4b84000000b00328e70cae5csm2856348oia.43.2022.06.17.12.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:16:36 -0700 (PDT)
Message-ID: <790443f5-9eb2-af1b-e521-92e9c3d6a110@gmail.com>
Date: Fri, 17 Jun 2022 14:13:06 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 04/15] monitor: Print netlink errors from Extended ACKs if
 available
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
 <20220616000231.1966008-4-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220616000231.1966008-4-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 6/15/22 19:02, Andrew Zaborowski wrote:
> ---
>   monitor/nlmon.c | 55 ++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 38 insertions(+), 17 deletions(-)
> 
> diff --git a/monitor/nlmon.c b/monitor/nlmon.c
> index 34c5eed6..ff23140d 100644
> --- a/monitor/nlmon.c
> +++ b/monitor/nlmon.c
> @@ -50,6 +50,7 @@
>   #include "linux/nl80211.h"
>   
>   #include "ell/useful.h"
> +#include "ell/netlink-private.h"

I'm pretty sure this breaks shared-ell builds as netlink-private.h is not an 
installed header.

You'd need to expose this function into public API.

Regards,
-Denis
