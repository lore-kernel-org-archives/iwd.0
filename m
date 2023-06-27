Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC615EA1
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 03:19:13 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-38e04d1b2b4so2998782b6e.3
        for <iwd@lists.linux.dev>; Mon, 26 Jun 2023 20:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835952; x=1690427952;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UETgT0Er679L9h8wt6EXGFca/8UT1Kl/CWGcbSx9gJo=;
        b=i1g1Ry5nBdxojkvKS/bkK+2UeDRYPgccN4GuNP/tgMInHSOSfiZrYpL4foG4dxRbuZ
         Qmv+CAL2Diad2hOgnWXnQ5QodGRGFrkE3nIJCGU/NOGw5RQ6T70+d6MdXSCVgTUDr+qB
         ga2nn4xmRLoBCX8RxjxBIr1zqolKRFesTNSVkrvELMScdeUuAHjcNwqH/2k4bIhxhS+g
         KkxgGJ7Lv9IOIHtRzV4eJ3fLmma9TcxeUYTzlah0xanJBBYcUW3bn/s1hJe1zCfvypJw
         iNfxEWdODYiqeNd58aheO+dRshXsipJ92KtwNFl9ai2QZmHn1fOszhC71GDpoX6qGh9o
         pI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835952; x=1690427952;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UETgT0Er679L9h8wt6EXGFca/8UT1Kl/CWGcbSx9gJo=;
        b=aZ11LWJWLJvF+C1gr1ZnzMirkojoHiWdhrkHqiyVGOOK9Ux5zy8d/mIUgAvhNjFKWp
         WVOuA0uCqSqefKOmZp6tUtE9umzfCJJdeMQ4NDInQ8qQi11Yhs/YfWTxpDWQkMOWndAY
         OMSVZOSJB2NFYgwJzNdcPFHm5yChyK8hNt+QlTk1nxiro5IDYlkwBB3nwOBNzQH35YeM
         gzLpp7ia4RJQ3Oa+I0ctnDlY2vqoRKu/wFryTNOMZSwiPltB0eMnkzr+jrTYiMpIU9/p
         tsU+W97g57jBeIB+1pGHq6n8Bf/fh4Dt6MblLW1FKj08hY7DqQphtRLD0hvIR1zmnCKH
         ZcDQ==
X-Gm-Message-State: AC+VfDyTl92l1fRj/jY5EoiOW3hc2yu5CQIQhpuzyVzAWzz1/MkfLdY3
	TUBRAweSnBlqmd+iONr2uLI=
X-Google-Smtp-Source: ACHHUZ4vYViW4EhnljAsLplg7yj1VXRuEjSSKjj8X8BmqgAHKbdiDM49QdZSR0+mADBJe9YOP1famw==
X-Received: by 2002:a05:6808:f0d:b0:39e:8678:4058 with SMTP id m13-20020a0568080f0d00b0039e86784058mr40852007oiw.41.1687835952613;
        Mon, 26 Jun 2023 20:19:12 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id fa14-20020a0568082a4e00b003a1f1933957sm458918oib.16.2023.06.26.20.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 20:19:11 -0700 (PDT)
Message-ID: <061334b2-e4eb-dcf2-275d-fc604909c9cf@gmail.com>
Date: Mon, 26 Jun 2023 21:59:27 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3 v2] PMKID changes
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230620172533.727504-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230620172533.727504-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/20/23 12:25, James Prestwood wrote:
> v2:
>   * Pass checksum type to handshake_state_get_pmkid
>   * Added back in comments regarding AKMs and SHA sizes
>   * Moved comment regarding preath/SHA1 into station.c
>     where SHA1 is passed directly
>   * The older discussion from past patchsets about preauthentication
>     was mostly left out as it pertains to when you choose preauth
>     as opposed to the SHA sizes that this patchset is about.
> 

All applied.  I changed the wording of patch 3 description slightly since it 
referred to forthcoming patches that I assume are no longer needed.  Please make 
sure you're fine with the verbiage.

Regards,
-Denis

