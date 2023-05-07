Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE533D4
	for <iwd@lists.linux.dev>; Sun,  7 May 2023 23:08:33 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1929818d7faso28529171fac.0
        for <iwd@lists.linux.dev>; Sun, 07 May 2023 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683500913; x=1686092913;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rg5jVpsC6tz0KA+qxL/NLNeOlv9j7AW1RvPdFd9m3c8=;
        b=VMbrUIaVtcBu0wwbMdwPufMtHaDBgh9dhuuvMNs0QpGdA9KUxzUaUzFxzPzwW4gyUh
         Bppmx/6a6JphiViBQ4/dLFtECMW+ONCPAqFZuy2QUuzwSsRSPAUn+zqIMyqzW/432G3F
         xqT29lyXY9md2r9CjkHgCflyiefkWJvzEIvRFR4G7hi9ahhnnUQxkQ/z10UeeuOtqGXU
         hnYbZyD3w6TDAFYzaUAoiAXGOSfNy0NP9MSvkuh+++aGjl7cmG9j78vziR/9x1oqAHk5
         1QpwVK4aHmRWywngnugbYOU6sGCxVHugx0MHOQXLlobGkNTKzbbNvNBfp9d3PI7H5h0t
         2LGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683500913; x=1686092913;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg5jVpsC6tz0KA+qxL/NLNeOlv9j7AW1RvPdFd9m3c8=;
        b=gCSEI8GnIsFZxBLTDlu8JzqdcXw0GKycx+jFj3e21XlJ0ejzLtC2Wx+IQIDwe1WTqJ
         +3zZd+CivbiUzE/q9bnIofVDeXiUecWzwOqhbdi+RcH4CxbP+/C3tw6a9DOkWImf4csy
         HNOqbkmi3MB7gIjOxbxTBGe8yZFqIjoPvgU15tXEBEMbTd9IUM+wGMNGLTXJwM/M18eX
         sudtyYTzzurNc9C93AXyxX9IAmAqmiSCTm0b62vK7vlIv5NhRLXaatzpbMPp2onlnpqa
         NbSjDpBH8saZ3Cc3M3g/IsV/b7mbK7GI37pOsiJlMpkNvAkdiufHNbWwH5WhNYsDb5wR
         D/Bg==
X-Gm-Message-State: AC+VfDxy6QuvwY3aiQXkiKcyDzqc4fmaFmG8PP/jYkui+bvPuBxL1qtn
	UohtgFebsFHa6lQU7Mcq40APthhxmk0=
X-Google-Smtp-Source: ACHHUZ5Dbzl/ryroxC1jOq9Gh6TxPEvsdR0UYJZIvL2++zVNdMT6Twygtvgy7bo89EYLp2SDsaibXg==
X-Received: by 2002:a9d:4d84:0:b0:6aa:f1ac:a715 with SMTP id u4-20020a9d4d84000000b006aaf1aca715mr2069233otk.4.1683500912671;
        Sun, 07 May 2023 16:08:32 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id do6-20020a0568300e0600b006a5e0165d3esm3532746otb.19.2023.05.07.16.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 16:08:32 -0700 (PDT)
Message-ID: <1f99600d-a154-e757-17bf-18078b0f3d71@gmail.com>
Date: Sun, 7 May 2023 18:06:22 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] station: allow roaming before netconfig finishes
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230502185941.436015-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230502185941.436015-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/2/23 13:59, James Prestwood wrote:
> If IWD connects under bad RF conditions and netconfig takes
> a while to complete (e.g. slow DHCP), the roam timeout
> could fire before DHCP is done. Then, after the roam,
> IWD would transition automatically to connected before
> DHCP was finished. In theory DHCP could still complete after
> this point but any process depending on IWD's connected
> state would be uninformed and assume IP networking is up.
> 
> Fix this by stopping netconfig prior to a roam if IWD is not
> in a connected state. Then, once the roam either failed or
> succeeded, start netconfig again.
> ---
>   src/station.c | 151 ++++++++++++++++++++++++++++++--------------------
>   1 file changed, 90 insertions(+), 61 deletions(-)
> 
> v2:
>   * Reworked to allow the roam to finish then start netconfig.
>     Now netconfig will be reset and resumed after the roam.
> 

I went ahead and applied this.  But the question still remains whether this was 
tested somehow?  Is there an auto test for this maybe?

Regards,
-Denis

