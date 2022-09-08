Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F033C0F
	for <iwd@lists.linux.dev>; Thu,  8 Sep 2022 15:14:26 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11eab59db71so45086638fac.11
        for <iwd@lists.linux.dev>; Thu, 08 Sep 2022 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=K4sl3zRMQp1JWFzI0QGY2ZPAOtHcXPIhZDXnVsRiupQ=;
        b=g2e+zgSq1xW/lOuaB6BlSEnsZ1cWxPGsG91nlpmkiASQ1LdqfPnJJf05eJ03H+ixLx
         M+EkGGAupk9y+Q1g4PBL8r7jXphKunmYG7wE0rAZX8TWle1qr96LUSlr7d9DCtOOnZBF
         qoj72LCM137wEScCr71OsGrQDL/3UfshvPbhTzIyOY3Ha1NqQ5Y1hygHUKp9j51f8XTd
         pylypOAiBrXMTBqUuXnhCEkekhmhxW/fxcQhik26HgmiaKUtbpUZs3hLa6sYQsmxR0co
         ZQiLl5A7FZdXUT8At819jshfXHbmW3Zw+PqtMIoUT3u0dsWnCieb5O18B4JFqaq65KNU
         f7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=K4sl3zRMQp1JWFzI0QGY2ZPAOtHcXPIhZDXnVsRiupQ=;
        b=wAs6IBuJCNDp9BjQju9IY0WC19vtDnvXHh0fwFAXEQEt4qicXudr9mmpdaWJ451+1U
         4nrMpmIezXbTvPKrK5Qbs6+fuS7uEx7EoAwzrimK5RhcyTvCIrTvHhjwcxCDN6KIDJZX
         LOJA/preSc20sARXmA/eximzZYEJj+Cbj48I+U+OHJESol073DS5N9c2P7vMh55R0pUN
         BQoSClMkWWtqRqWmS+KPmlKKKyWMQPsi/dvzgBr8mJnFW06zG/u/YD/uVdAWDQZkfWNc
         P8tOp8UHtaciOm4OXgHMvoxzJCMgfT8unu5PfzHDcDbYAh+k2/fIYCXNyd+Y7bM/NPeH
         gUaQ==
X-Gm-Message-State: ACgBeo2xJzTfzMCASi1FOSaQsoCGXvrU91DBXoj7b77TNaUkyx7T1zt1
	aE/kDqw8PKeTacyT8JoMgkBjkI0Cb+U=
X-Google-Smtp-Source: AA6agR568j8fiQwMCuEgH5MHP70j9p1F0fwRLYKUKzXvmD2HB5a2JYJVm3qfZJCzLCSN0ajK6MBcWg==
X-Received: by 2002:a05:6808:1648:b0:333:45ae:3777 with SMTP id az8-20020a056808164800b0033345ae3777mr1786334oib.4.1662650065400;
        Thu, 08 Sep 2022 08:14:25 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k14-20020a4ab08e000000b0044893e6a2a4sm6237228oon.11.2022.09.08.08.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 08:14:25 -0700 (PDT)
Message-ID: <16a64a4f-5339-e0cd-3fb9-340588cf855d@gmail.com>
Date: Thu, 8 Sep 2022 09:53:44 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] wiphy: remove nl80211 from wiphy object
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220907233201.227577-1-prestwoj@gmail.com>
 <20220907233201.227577-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220907233201.227577-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/7/22 18:31, James Prestwood wrote:
> The nl80211 object is already a global and there is no need
> to track this in wiphy itself.

Wiphy is a bit of a weird case since you have a global and a wiphy-specific dump 
for regdom.  As well as the regdom query.  But wouldn't you actually go the 
other direction?

l_genl_family_new creates a lightweight handle to the GENL object.  Once you 
unref this handle, any requests started on this handle are automagically 
destroyed.  So you strictly speaking do not need to track the command ids 
anymore.  So for example you could get rid of 'get_reg_id' fairly easily. 
'dump_id' is a bit trickier since it is used for conflict detection, but maybe..?

> ---
>   src/wiphy.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 

Regards,
-Denis
