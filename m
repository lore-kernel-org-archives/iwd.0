Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9E717EA
	for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 22:23:35 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id r130so13926347oih.2
        for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 14:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGEHTgMs2CsHrE1qz2GsQ3rtgnCmo9OFf9KFN1W511Q=;
        b=e/8cmLzzH3mgNjuczsoTbNGZ8zyspAwGOohek8G/7Q/Ajfc5FYGGpRNV5jPpHKS3CS
         4F2NEsTtqy1XCMr4ZU3qNAkJabJ1X7RegvEn1QwyehcvDM0aWgcIj5KZWe4JhWOZeNxp
         gX+oHBUtIvrcNpmM9OTSe6AFz5FeRpcFMCP+NA4TGw3/RGswz3VZhlA8dk6gZfpPA3SL
         41WMXYmy3qIN2bhtTmyAmLD2NgrrcyzUBWjiC+Qx9P5fingsZwSIWEMjMWxeUE4pw4Pp
         zHyo3TpWyPTtgM5GwXhNF8Oz6wtIyUM2gqwuj04KKi1WHbShvVmNCMyEJPTOrEtmSQ22
         6+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGEHTgMs2CsHrE1qz2GsQ3rtgnCmo9OFf9KFN1W511Q=;
        b=NDgDzGvus5ust/3t94W8SHC17wwW+RHgjodOaase7W6ocmEM1B2+GoLNiY5DEoQbMw
         8F+w1W4rPvhAI/qzMNjOlZXWlQFeo5bAJhvyYRyxrnVGhzj8iBIbikJR81HOhHd2G0Wa
         U/fwnb4xvKQO2U9OR2qmngqaXabAVLwdqF+2mP6NXI9/pVvc7NB6TPebzeAF7W7K9JKu
         flzWmuZZjTBb6lm80Q8ao4nOWOduBydd+5qD/9KO+pZXVkljrgp6bCmhyOfXkAWToihN
         SMKO1dfGCbiuqJZtGEbI0wCx/nZQb4HONES4bb3kRljiaM0uwP7G9/lswsT9wdI7On6h
         Fpfg==
X-Gm-Message-State: AFqh2kogkOKtEL8zYsGaN7NYrdByflcBYw0AUN4EKChbF5ePQQkTLh90
	BTuk8L+6aCgNTCUs0X8RofU=
X-Google-Smtp-Source: AMrXdXvz7i8jubsjek4tCHGNCaWGs1hFPe2uvPBYh+Mws15GQGDCingvkqaRgDHRdXtRdCzBoObPPg==
X-Received: by 2002:a05:6808:116:b0:35b:52b:9371 with SMTP id b22-20020a056808011600b0035b052b9371mr35474679oie.11.1673475814167;
        Wed, 11 Jan 2023 14:23:34 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u30-20020a056808151e00b0035bd65b776bsm7294706oiw.2.2023.01.11.14.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 14:23:32 -0800 (PST)
Message-ID: <a1b23a20-d356-c674-80ad-d9c2d47a1f6f@gmail.com>
Date: Wed, 11 Jan 2023 16:05:38 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/9] eapol: set secure on message 2/4 properly
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230111201543.397692-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230111201543.397692-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/11/23 14:15, James Prestwood wrote:
> The second handshake message was hard coded with the secure bit as
> zero but for rekeys the secure bit should be set to 1. Fix this by
> changing the 2/4 builder to take a boolean which will set the bit
> properly.
> 
> It should be noted that hostapd doesn't check this bit so EAPoL
> worked just fine, but IWD's checks are more strict.
> ---
>   src/eapol.c | 12 +++++++-----
>   src/eapol.h |  3 ++-
>   2 files changed, 9 insertions(+), 6 deletions(-)
> 

Patch 1 & 2 applied, thanks.

Regards,
-Denis

