Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC433C6
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 14:39:55 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id bb16so21574730oib.11
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fIq1rc1qR9dF0fxjN2psLOLbF75TJjjdMrtXs06sQZU=;
        b=JZ1dHmclk5L8GF36JjRBybNuTRSTmoUsjcZhNRmN2bzPBuUw/y316zGywuT+HDr6xb
         /4dPln8mbAMYP7570pVOLXL4G99tboBB4Yy4+ekP4j4zV1J6gJ54KIvidXYmkVo8kegh
         CiZy3VSto+ISwGBsjBljLZHLcFVAQhBcW6JmRO3TNF6sR3LvQAMOY5Zh7JoAB0vrW7kA
         KGGF6J7wfosvEPLr0TpD0i8Sx+3pzavsXHwaLd4p1RY1g5DCA1PvNDs2sWDtAOEaNaps
         sdaKricsutjLqpY6OLL1Kn/n/0tPeAUtDcucmLaqoUrq8CfKdyPYmFA/3iis8rru/kVS
         +Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fIq1rc1qR9dF0fxjN2psLOLbF75TJjjdMrtXs06sQZU=;
        b=r8ld/FVKOoVirxdQEfksQfa7PkVzilH1oufLCzsUpJ4gXbgE9rK/kdOMKYgOCKE05Z
         e/bRSspnjy0q3BdXTnB32cS9F0ll7v71hp6LcIrLexls3rwBVprctVtGq4su40EIIwRW
         djgv4kurdslKAcUSHwulhJPlABR03MJmX2fjoNWNDKVOZl/0KOpwdWRwYIXfsOSQ2Bsz
         WV4a/po0qFwYFVHYBggS3KKuVaEgg6iUS26OGWCyaONO62xaMnOM7cd6zRDesFwUjpD3
         TF3zk7sLerINc4J2Bt+AKI5s8t+LJjv8/jnOCttg4Gbx5VUyA+Oh7Q/68QC0oakpZi/c
         T2zw==
X-Gm-Message-State: ACgBeo2fmVJrPBdk05FCXH1pqQC1uEe73+r5itE+Ui2FQRi6RY0Erm5H
	Fs4BjTWncNyQzXMXN4dRuxrjKcJPads=
X-Google-Smtp-Source: AA6agR6B/ZGuTtkE2KC0kAmZ5ZNIRunvDajuk5bHSYJytRkiHOrUcne+SbXF4ljWYAFHjJN5xXmPcw==
X-Received: by 2002:a05:6808:647:b0:343:43b8:3a18 with SMTP id z7-20020a056808064700b0034343b83a18mr2217283oih.57.1660228795447;
        Thu, 11 Aug 2022 07:39:55 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f24-20020a4ada58000000b0041ba304546csm1135789oou.1.2022.08.11.07.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:39:55 -0700 (PDT)
Message-ID: <d1fc16b1-d675-ab08-323b-c5b53318d573@gmail.com>
Date: Thu, 11 Aug 2022 09:39:28 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/8] network: make network const in
 network_bss_list_get_entries
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220810231621.372514-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220810231621.372514-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/10/22 18:16, James Prestwood wrote:
> No reason for this to not be const.
> ---
>   src/network.c | 2 +-
>   src/network.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 

Patch 1 & 2 applied, thanks.

Regards,
-Denis

