Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46728E7
	for <iwd@lists.linux.dev>; Wed, 12 Oct 2022 18:56:27 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so12755633ooi.5
        for <iwd@lists.linux.dev>; Wed, 12 Oct 2022 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lPI/FiSdvpnNWKF3j3ZaPJXK85TfQxAX7S1FZOAofHM=;
        b=mYY0k2UyZvSkpXpl81hVHxfYFMoGcIUJI1vQu7xQ8s+1KcUVvWHFnmhyY94PibwzRl
         mG5mNbyAZZ9B9DJBgW8B54bDf1oDhCUvekrv7n+oiGOUYNOKFM7TbGDRk4srXk3KL/WO
         oMU+PnOTTwv8kgyJnq3Q0Fl9h7wHH2+0RHa5Kg6YfGVxs71N13VINrKHw8rj2dZQtyMX
         UlmctlCw4ZlCREZ2kpmowpXNDBYNNAaTmkzJaigB+pP3gaVrGGKZkg29pykaTnrrtH+t
         ED9SGQGBYl+m+wHxRYSvK3/wR3Pejax7+NbC3zk7enp+AR6DpciVhULlkwBuNWmHCA6W
         0zjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPI/FiSdvpnNWKF3j3ZaPJXK85TfQxAX7S1FZOAofHM=;
        b=vRM8gOTL1RxIbaeNE9bhnDX4FnSStJMrPeUS7KX7dIaP/8ygonQ11MXnM+Hl/Ip9UN
         cmE3VsHny3al/+duydTYNHiRFGoWgqRIX/iPkkv96XDgrJX7fjoM0Qfp1UU4SMqGdhJz
         AwHYxrq9l1ynXBX6ns/6UMML1zcxcvpv5md/4x2IyHc5sAKiFVfhE+YXQCij9yNy3EIf
         TXXj/kCUyLmLcFDQ/RRv0GXypxPOSBWI+sNP8iAchWh7H/YxetYYP4eIUfEKk3yPRAUT
         SVc+Ggs/wsA4LizA4Wwm0aqkfZWwo2RfqsQmHVLKCIdbeGWt4xEhH5RHbRkjbhqv7hzu
         61OQ==
X-Gm-Message-State: ACrzQf1qoDaVU70C2YKeNOEUmZr2i0LQzvJsfG7iZnE+k7nOgNSCGWrh
	OL37oHNahFdefwkuYbvj6Hs=
X-Google-Smtp-Source: AMsMyM6MWRvtA11fYn6Bnva8Xfjk5tQOYfGYRF2baVMT9bWcyK+wmpsHAYs3opUfAnfr9PP5Oq89BA==
X-Received: by 2002:a9d:4905:0:b0:655:fb61:72ab with SMTP id e5-20020a9d4905000000b00655fb6172abmr13822588otf.192.1665600986770;
        Wed, 12 Oct 2022 11:56:26 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id o13-20020a9d404d000000b00661a80d555fsm2958830oti.40.2022.10.12.11.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 11:56:26 -0700 (PDT)
Message-ID: <ece2ffa4-85f1-7966-76b0-70226a18d4cc@gmail.com>
Date: Wed, 12 Oct 2022 13:56:25 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] client: validate utf-8 before displaying row
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221012183522.321041-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221012183522.321041-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/12/22 13:35, James Prestwood wrote:
> In theory any input to this function should have valid utf-8 but
> just in case the strings should be validated. This removes the
> need to check the return of l_utf8_get_codepoint which is useful
> since there is no graceful failure path at this point.
> ---
>   client/display.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

