Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB7468D
	for <iwd@lists.linux.dev>; Mon, 26 Sep 2022 19:15:34 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id d64so9439472oia.9
        for <iwd@lists.linux.dev>; Mon, 26 Sep 2022 12:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2etmf0Um7xeaaeTWpzlMzYKPa+32jGWW0IKdax+CVBk=;
        b=Hobmlitqh6u6BpYhhh9XmOXxO8qXmO1TcknVGbjTcNp5c/d7v03vm0cT9l3V1QzTjR
         hqHLJxmdOmNVl4jFZ4E+e5b5hVZzn5Fk59XOrYRajBpLWqFJp7l2g/m8Ow8jYNxF7NsT
         76k0foCV89+hnJSiApb/7umAbbHkD+/Ma1x7hnaYV8s9jpG8MoucOXbTntHnDXw420/D
         dByEZvNG18cIN3IPi5y+1ROD3jA+HAaOPhD9i34P8cGNxa6JEwiVZliiEBaLOIcs4Fm1
         jF45LvaAHM2rIBKnDNzAjDvgNEmngqFgzspd8ZC5qKLNud4fzn7AGu02hPra8WOoGxw8
         cBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2etmf0Um7xeaaeTWpzlMzYKPa+32jGWW0IKdax+CVBk=;
        b=5j7w6kF96acN7uTwGoaJaL+fSXsc17SSdnQFXxhTLdsHLj2Sl48MDjCwKPNxgVRyCl
         JAIgNNEik6BK+Wj9u7DvJfGzRHtRiZ9k96pH7r1kiWzZM40d9MFUb4OSefM7ION99HfM
         lkIC0davOeF32MRxY6TDwn5GmQVjIdRH6/w9/HSFpnoBB6ShTGwcLoPXjXEaKKEniBMl
         j8fGrX47uY8l9n6C3EN31epevH18LeS3uhjvJ6oph/Be8jqsUqz7qRusRiUkAsuiGEQv
         2FgA9Cn20jmNmrieJRG7Qn2ZnnBwARGV6wr5dnkT1uSMpIEGinZAeSc7Tg63IMVBfw7+
         5H8A==
X-Gm-Message-State: ACrzQf0VwugD8zqRQR+SH016jmmmyEEfa98EbFIFyuvZrnw1YEgVE1cp
	rO4+fi57wvUto/fFotZdtNM=
X-Google-Smtp-Source: AMsMyM5I+eVk6biNy1eJukCQXknyTnnb4pBM+b+hf3GHHv8Bll0jciDqAyv9XsnGLUYoJsMPFCrvjg==
X-Received: by 2002:aca:1110:0:b0:34f:f950:ed78 with SMTP id 16-20020aca1110000000b0034ff950ed78mr129148oir.74.1664219732358;
        Mon, 26 Sep 2022 12:15:32 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id q185-20020a4a33c2000000b0044ae10c5974sm6946008ooq.34.2022.09.26.12.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 12:15:31 -0700 (PDT)
Message-ID: <22c964e0-cfb9-e473-5997-cb66ac8bf1f0@gmail.com>
Date: Mon, 26 Sep 2022 14:15:30 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] sae: add IWD_SAE_DEBUG for more SAE debug messages
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220926185202.52479-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220926185202.52479-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/26/22 13:52, James Prestwood wrote:
> SAE will now check for IWD_SAE_DEBUG and enable more debug logging
> using the new macro, sae_debug.
> ---
>   src/sae.c | 70 +++++++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 58 insertions(+), 12 deletions(-)
> 

Both applied, thanks.

Regards,
-Denis

