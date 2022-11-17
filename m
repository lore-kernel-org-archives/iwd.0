Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4FEA464
	for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 22:51:39 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-142306beb9aso3939700fac.11
        for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 14:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUGKUShWi2YhlpMvnV9oyp+4gtfEhAUOauuKc8S421o=;
        b=TimxHUS7wMqY249TtiWuasIKbnM9UFStGGyeKpqGjRPSPkyMvfh1MSj8LGOirwGbS1
         wC/kRjfL5jOf9cQj3R9GkEpRt3gY/W2lfqpNj1aS8iL1FdWrHQsUi6uhxhCM+i3xIezB
         G/9q3nv+YIIv4Uufcr0aYNKuMSjy4KeqEuXKyu8rtDfuJFt4tL7OpwHq71vBC+GuTxaa
         nMuLq/ynMdHt6q4dlBtdsxo1fEcJ0bzdl0kKFw5fBp+b56plUUy6Q2iQ/5eOTT5/QbV6
         clXbFoKsXsXQSLbJnVE8JNNS4GUujXfcKFTu9vAqg8hqZY2PTlmG8p+U+bTOPZBjTzFg
         vxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUGKUShWi2YhlpMvnV9oyp+4gtfEhAUOauuKc8S421o=;
        b=lSDPTsKw4cJx/YVoSMEVtxhEuK/Me4hBf48VnEuTlkFQ0FOrQlePrQmnaGCKAkXHoI
         3qJScDnpWZ4qYle0SsJVhAhT4HYGde3iVuOQXlF615yRBLqWXZ2QhBIeN3qCu4a+NroB
         mDDU9F1GaCmW6A/9FicjZhV9PIsj0AhCFQNzW+qnsBuWfaiVqcPTy6boRvn61Fi36S3W
         l3Dpgcq1FWtQBlPjiAUvX1F6qln+h7NiqMQfAyLFG+kjsqiPjlfN1vw7kz52/2hQJfIb
         yJbmZmFSO+PobDflfXJl+eHMb1HxnXFMhCBLGVtf6DayG8DFGRCLcrRCopavV3ZCOm0A
         gZpA==
X-Gm-Message-State: ANoB5pmuv991H3SZ6S+UPI0aY5ztq+38drT0aBYGl5lQlIMNklUMqZ+t
	7o1AKmSvsSXK00nIU20rYdI=
X-Google-Smtp-Source: AA0mqf66KusXRVxXyFnz5t8+6Infdm36GswWXMdyMci0ZpNYRFBYKq9cConB51SsK4Gcy4ekXINgyg==
X-Received: by 2002:a05:6870:5786:b0:13c:476:69 with SMTP id i6-20020a056870578600b0013c04760069mr5642994oap.20.1668725499119;
        Thu, 17 Nov 2022 14:51:39 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y17-20020a4a6511000000b0049ef7712ee5sm841989ooc.11.2022.11.17.14.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 14:51:38 -0800 (PST)
Message-ID: <77304d2b-9f0a-f638-adbe-1d42711b651d@gmail.com>
Date: Thu, 17 Nov 2022 16:51:37 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] scan: retry scan based on scan done events per wiphy,
 not wdev
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alvin@pqrs.dk>, iwd@lists.linux.dev
Cc: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>
References: <20221117211139.2572553-1-alvin@pqrs.dk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221117211139.2572553-1-alvin@pqrs.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alvin,

On 11/17/22 15:11, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> If a CMD_TRIGGER_SCAN request fails with -EBUSY, iwd currently assumes
> that a scan is ongoing on the underlying wdev and will retry the same
> command when that scan is complete. It gets notified of that completion
> via the scan_notify() function, and kicks the scan logic to try again.
> 
> However, if there is another wdev on the same wiphy and that wdev has a
> scan request in flight, the kernel will also return -EBUSY. In other
> words, only one scan request per wiphy is permitted.
> 
> As an example, the brcmfmac driver can create an AP interface on the
> same wiphy as the default station interface, and scans can be triggered
> on that AP interface.
> 
> If -EBUSY is returned because another wdev is scanning, then iwd won't
> know when it can retry the original trigger request because the relevant
> netlink event will arrive on a different wdev. Indeed, if no scan
> context exists for that other wdev, then scan_notify will return early
> and the scan logic will stall indefinitely.
> 
> Instead, and in the event that no scan context matches, use it as a cue
> to retry a pending scan request that happens to be destined for the same
> wiphy.
> ---
>   src/scan.c | 38 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

