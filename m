Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439C7E
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 03:15:55 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-130af056397so11735721fac.2
        for <iwd@lists.linux.dev>; Mon, 26 Sep 2022 20:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jAkW9Q0d3xLMJfdwnWTmJFDLk++6rIXVcufTcjwlfuQ=;
        b=Ityxe5NEthLS1U5Ib9F5jeCwXBvMP1ym8YGctcGf+Yj71nWa3Pwsoj/BVMfB9AT3TO
         B9bMyaE9qkrEluabNMIMKe4Ly2A1vf3RFnpWpxuMnrvmSqFOQbnYvkg/m4s1XxLFT6lU
         +DRco+pKf62PKLRJp0AhPcgO61IW06dnw7913/vBvDogPK1BP8FVOoDA8ZOsWaBBPXd6
         JpxYbK7CqbQs54aZEJCYAOIg+mK4Bta4ataOc5gilfL34w7wP87Ey3e2CBuG9gfEdZgh
         0q4UhLm8m9GtjkS+P3LOF50QBrBOMlSe0XJFU5PMsL3kj24eSZU+PUpmaY4VhWAazzwA
         m/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jAkW9Q0d3xLMJfdwnWTmJFDLk++6rIXVcufTcjwlfuQ=;
        b=QbWLS24dNIVx2c7i/faJKnaZ83K5cu1qKXtSXX2pYUVEgeSdIknehPEuYz8vkxdBJX
         O2wO+LTrML7prWZd11PJCzAFeBjyHtgSJkwLkUrXoFaBjnxm8lUN78WYVMCBDmpmrVg0
         fU925NLZkuIyPEk/JcqRKubiNBQj8sehzkyLPePSpK6QN/YrTW7pOYriK95TlVugdWj2
         wgnTUFXCic48Ph7diyPEZCS3cLdU7N/ps9MJXCLRq0KoCdylJJOUdMioOuwrSaEO0y0j
         z46MCcamWA6Xzoz2VXuFncdOCPOkBhYi/CIOzn7E7ZW24UJjkr26f9jpLQUpyc9klZMn
         8wTw==
X-Gm-Message-State: ACrzQf2i3d//VQ7uxbkcZ6Dj4WJiLQaEy3T/7CmtHXgYCWqDDXaOe9ZQ
	PDZas5Yu5jN0ghKY1DkHVNk=
X-Google-Smtp-Source: AMsMyM6hDqDC5dT6kHyJuIdjhTvoUFPHMcpguBi2b1kUj7NV+hFiM1tJvfYjeNBFtrbH3nRLn1p9pA==
X-Received: by 2002:a05:6870:3041:b0:131:7f3f:a51c with SMTP id u1-20020a056870304100b001317f3fa51cmr614326oau.117.1664248554256;
        Mon, 26 Sep 2022 20:15:54 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y21-20020a056830109500b006391bdbb361sm116785oto.31.2022.09.26.20.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 20:15:54 -0700 (PDT)
Message-ID: <fdfa4dd0-c011-800b-d2f0-6c6e15246a0e@gmail.com>
Date: Mon, 26 Sep 2022 22:15:53 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] netdev: differentiate connect/auth timeouts
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220926223910.109549-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220926223910.109549-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/26/22 17:39, James Prestwood wrote:
> The warnings in the authenticate and connect events were identical
> so it could be difficult knowing which print it was if IWD is not
> in debug mode (to see more context). The prints were changed to
> indicate which event it was and for the connect event the reason
> attribute is also parsed.
> 
> Note the resp_ies_len is also initialized to zero now. After making
> the changes gcc was throwing a warning.
> ---
>   src/netdev.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

