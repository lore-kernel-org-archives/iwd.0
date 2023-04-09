Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F081185B
	for <iwd@lists.linux.dev>; Sun,  9 Apr 2023 16:38:18 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id bf5so1985874oib.8
        for <iwd@lists.linux.dev>; Sun, 09 Apr 2023 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681058298; x=1683650298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ugz1lFkvNYN5pqOk/C8ckCaiuwJ1k+O3cV5ydtXIvvA=;
        b=NXv73Ntt53NZb+OLZ/FndZq2+q6h+beyVUAVJQ9hGvJcTJzt44qiXYtacyZIA9ipdE
         z/bPWFHG5S1Z/2XQ/RFa0/pfp9rwYeuDtaXqrBDTDsqjHqlu0yPbZMflWlC/4lWVE9T7
         jMcIkwJdGlMRN2PGSDFrvAIYoph4RjIoJ1+keW519qCd/Nz9kokjMOKwgRy4pIo0HTbR
         WFAICeCEb8tutsI8MbCXtVYnkPJiadWAIZP5JY3+jLmyrOlCo/tmnKVvWWyX6k/af725
         rgXDU3ZEL0pAcymJIzaQeORMvIb1pleol5ah4prC9GLsn7vF5YBC6ES+Rn+L3Nnc2/Y+
         K8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681058298; x=1683650298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ugz1lFkvNYN5pqOk/C8ckCaiuwJ1k+O3cV5ydtXIvvA=;
        b=HxmxzRLoUlkufpOXGd/u8JwfWcxBII8FexoJzQ0XemBTHW3xKsf/cuRyS7FCWUDaTq
         XTsAzloG5b3+KAP7KuV4+uQ8R+PfoYXS4fNzRKpEVfmHrAIzPm0fe2nn0o/ANPrDYMgx
         mz9KIXpLj9itAXuAeGLszIHOF62tajFzuYHHmcTAzGWdkuvxHIEZICYWYk1GIqyIDwWA
         +0ixNX4VPa1YBXaQm5ydD8mpvkovn7QKGKoRb1VRXq9HFSS/ZU+E7xNWhaygwCUID1q0
         QPGp17XEN0lnXJpkTtdX4EuKWBh+shg5hzjh7rNR2k9UuAcu2HFTkqqiPuUKY+DjxYmv
         ttww==
X-Gm-Message-State: AAQBX9fGEZ07I5szn5k281on/oaIa01O6Y7y95tDE/0+5GBVOQmnG0K4
	Z39KIilPEexwOKqd9Q1TgAI=
X-Google-Smtp-Source: AKy350aQEuH1y2TxsxEBCqfwPlR+ukoxubgWNxllh5yyp5oZKE9MU3lQjFuSIwdX2f6w/2CfKfXWCA==
X-Received: by 2002:a05:6808:2901:b0:383:f5f8:651f with SMTP id ev1-20020a056808290100b00383f5f8651fmr3248090oib.55.1681058298096;
        Sun, 09 Apr 2023 09:38:18 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u10-20020a056808150a00b0037832f60518sm3560614oiw.14.2023.04.09.09.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:38:17 -0700 (PDT)
Message-ID: <1b9f63f4-19ab-4e15-ccc6-29dc88722e4a@gmail.com>
Date: Sun, 9 Apr 2023 11:36:48 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] band: fix HT40+/- checks when creating chandef
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Cc: Alagu Sankar <alagusankar@gmail.com>
References: <20230404155640.133794-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230404155640.133794-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/4/23 10:56, James Prestwood wrote:
> The HT40+/- flags were reversed when checking against the 802.11
> behavior flags.
> 
> HT40+ means the secondary channel is above (+) the primary channel
> therefore corresponds to the PRIMARY_CHANNEL_LOWER behavior. And
> the opposite for HT40-.
> 
> Reported-By: Alagu Sankar <alagusankar@gmail.com>
> ---
>   src/band.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

