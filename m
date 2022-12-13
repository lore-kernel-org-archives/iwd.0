Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37C23A7
	for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 20:32:57 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1443a16b71cso13998193fac.13
        for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 12:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SN85B7KdDCQ489RiUnNs9138f8N4uTYp8eonpQoy4mc=;
        b=ewQSWDGmSP/s2d6kyvZ3iQIFHjKelcls+Ogn3EGoISGr78VR6wt0VR3ESLx3DJKbPm
         bXchG8HVqU1kGWZOnUjoGCp1gB1tAyE5DVcuE9Qu+u+YGbyjSKao4oQGQj0l8oMtOPK4
         4/XSk8WTm7YwErvYqPcn7dvDbDJTwZGLZVftbIG4IAycEIDjvDbwlY42NwYuvg3++Nc7
         gVD1yYijVbR55Pdsmkgmu7m5eFHH3UQWqnFUyVp41D+g9WIrqgPbe+FLftdYJZIuC/6l
         /wRLvQoTH02L28NFx9aBbw0WDFpQ2uv6KI5tRrTtBheYnlGvr9KU+J192wO9HhjcphP0
         EXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SN85B7KdDCQ489RiUnNs9138f8N4uTYp8eonpQoy4mc=;
        b=wXkWOSnuZ6K+QfKbDaDJmuLCt1BC4zggdpIUzNMaH6rSWSXEBYCmA6spdpQG3d696g
         Duaw19QGEcd2WzQ4FXoj8fwdocvbgDBA9ASOPXRReMtlR1S3zEILBFCpyYdBccoHOzVy
         CagRPG4FlpyFsTWdKzLl0vZaabjw9rY6kb6ZDobf8UuXb+xm22nucxshnm7JXN/AnzoV
         3XHlhLLfENTYr2Gk9a3LLwlv+aBicV4k9JbkehmFh3ohzt/HKDvVaqKpvX7/zr+R++vr
         bFdiyhLLSCTGTo3n5owoXsKa/C7ktRkrFW9/M56LFmrmmUICmrCfgYV1FY67lZ8HUYKQ
         UKEQ==
X-Gm-Message-State: ANoB5pnZNLoZV4vZeyuqYKKGYF3cFipWhSNjsl/9RTY/H/nAN3IYrlU4
	VfnDjMn1Qfdh5TLnsn8Cdd8=
X-Google-Smtp-Source: AA0mqf7g6BNsvwqFmIfAhXby7keDda+oCxtKIyqC8qAwkMtMQExqiHXHOCo00RF58bpMYHQJtHKvOw==
X-Received: by 2002:a05:6870:c908:b0:144:f6f0:4e0c with SMTP id hj8-20020a056870c90800b00144f6f04e0cmr10352792oab.37.1670963576872;
        Tue, 13 Dec 2022 12:32:56 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r19-20020a056870439300b0014474019e50sm1873558oah.24.2022.12.13.12.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 12:32:55 -0800 (PST)
Message-ID: <fbe236df-b6ff-a486-fcc1-adb47cd89e98@gmail.com>
Date: Tue, 13 Dec 2022 14:19:19 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scan: remove early supported check for 6ghz in wiphy
 watch
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221212220857.1284874-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221212220857.1284874-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/12/22 16:08, James Prestwood wrote:
> If the regdom updates during a periodic scan the results will be
> delayed until after the update in order to, potentially, add 6GHz
> frequencies since they may become available. The delayed results
> happen regardless of 6GHz support but scan_wiphy_watch() was
> returning early if 6GHz was not supported causing the scan request
> to never complete.
> ---
>   src/scan.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

