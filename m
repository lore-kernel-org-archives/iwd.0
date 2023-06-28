Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCA7C2D9
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 15:07:55 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1b03fb998c8so3014355fac.3
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687964874; x=1690556874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tLNFKHgKRZJIRr4yM8Y6DygdumfhPxbm7+e5BSKKT80=;
        b=e1lIjxnlp+Mr9l0JTgNDuukB6t3OsBKFPcT7qJRgbPsSFprh3JFYlIOaxB5cJfN1gR
         W3OJEJv33k5sXY9eYZHxwzL9rtzxXOdiI1Djt+xrpwVVduWWkTba/d6Ft7LMir1egY4A
         LMGJuhQyWT0UOZ1K+j8lAjkfZTRuJRc5+U3bOFId6NBs5vNQzFa/dc/eZmxRvG1zF2YW
         NkGWYNM3OuoEcHklkIvgRQvweOpatnP9MVMZPGzynYdkrAR33XbW4k9wxxSgq74s6Doh
         DIhAxEC1E8ZaZycPGE4TIfxUZ20iCmhgL+jTotyGg7fN9hU3THTaH5vJE5Ep7KA6COKs
         wLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687964874; x=1690556874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLNFKHgKRZJIRr4yM8Y6DygdumfhPxbm7+e5BSKKT80=;
        b=ZUoe7fhFFLIDdYifvKYSELN2ocZvpdpOem93gpteuLg3bsgn40HI4L5ZeKM9KfBWO8
         4kQj/IDaSaxDyI+vXEc3nap9Ceg9pSwJ/9twm4ZtdqiyZkIjh3CiNbupMwIFDleQWHKG
         ZfKhX4RDb9eh/H8cBdh15xtnx7RLSSp4ecQepX3qIMdR36VIxOu7yYAQDzgyM8g/26JB
         /lwqM5oNiZte3dNXKCHr5uLweVoFBX0i97G65s2rzwap36aOfXDvGz7pwqqa/S0KFCQB
         9ayRdA80zCTlioPfEVBNQxF7YtCw5ZVeP7FccfAcZi/5ev31+ELN1SfjRfS6Kxh7mHjx
         /7lw==
X-Gm-Message-State: AC+VfDyQT7IDFreee7dnY+UH/kYXzkD7ViLUoupOdjNsJrHgKpRzZ6Zi
	x9LPAFk+wgpGCCw630g+8Mw=
X-Google-Smtp-Source: ACHHUZ4wF+d2fqmjJXHD8L81LfUkSAN112Y7haEs7pD/hrWhiCdB4l7dGgxLYzWWtsQen5Mv3D+pag==
X-Received: by 2002:a05:6871:507:b0:1b0:372e:e2df with SMTP id s7-20020a056871050700b001b0372ee2dfmr8297700oal.40.1687964874448;
        Wed, 28 Jun 2023 08:07:54 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v18-20020a4ade92000000b005630547db40sm2167050oou.41.2023.06.28.08.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 08:07:54 -0700 (PDT)
Message-ID: <303737c5-0191-378f-d164-5434ed0e3c40@gmail.com>
Date: Wed, 28 Jun 2023 10:07:52 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: iwd forgets network
Content-Language: en-US
To: Martin Petzold <martin.petzold@tavla.de>,
 James Prestwood <prestwoj@gmail.com>
Cc: James Tavares <jtavares@kvh.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
 <61D86659-745B-4228-AC0D-216E5CA292D2@kvh.com>
 <85b9e54c-dea7-672e-ecad-9382c8f6a7e7@tavla.de>
 <9d7f0362-67af-bbc4-2cc0-d4f8da123cd3@gmail.com>
 <e6f29266-7a7d-1fcf-2ce9-e96efe75a13d@tavla.de>
 <2f0cc99c-c547-1150-d667-8fd667be86ae@gmail.com>
 <5448805b-253d-eeb6-33f2-881eb8be2157@tavla.de>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <5448805b-253d-eeb6-33f2-881eb8be2157@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

> Unfortunately rename is not atomic across partitions. We have our own cache 
> implementation and hat such issues with separate tmp partition - had to switch 
> to same partition for temporary files as the storage.
> 

The temporary file is created in the same directory, side-by-side with the final 
path.  See
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/storage.c#n132


> Still, it does not actually explain my issue.

Are you mounting ext4 filesystem with non-default options by any chance?  We 
follow advice given in [0], refer to the "Rename, fsync, and ponies" section. 
Still, things may have changed since then.

[0] https://lwn.net/Articles/327601/

Regards,
-Denis
