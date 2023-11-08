Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121831366
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aE3TtCkh"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ce2ee17cb5so3996244a34.2
        for <iwd@lists.linux.dev>; Tue, 07 Nov 2023 19:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699413229; x=1700018029; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1FUjQThjeiHNgnrgEC3ibzPzyB2jzcVKXaY7FwiKrOg=;
        b=aE3TtCkh1gD0PITPZ0B0MaeG8yKV2+HLNIGYWMmcTv5UGoPpMvu7e2bXFjT/OiEnIE
         ugxdyYbcDwIKBBaMk9l6Ml7yHmOZ/Y3EjtwQrem4dQD3yx8SbUMrdASYIeQmUrwRdBxc
         volb2ruvhxn38eTdD3IEYb8HIsy93eTFdvMwPrEYp2n9rfG1kiqsXDMgAFBzk+Ph16Nu
         euyAVeKXKh4krKLUMIFn7Gw5CfdKPn755+PT0Py9grt/vg7ROGS5u10LRb5ZW0WFxYsD
         rNO9dW7o7fFVvLXLNzPTu35Pt7q3Bwfu8lo+YKtm9UOmcnM/HHqXti0wigPk7hvmjz+Z
         WPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699413229; x=1700018029;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FUjQThjeiHNgnrgEC3ibzPzyB2jzcVKXaY7FwiKrOg=;
        b=XCPyRuJyqpaZLJ0RmKzX+wa68uT5dhkHMulr901Vk81wo1dMV0xyVS9vpQhZYzdGsY
         G/9JODdnz8adj48T5Rc9qCrjrKhS+AY7rVjrXb/DA2GTMLdu9YCu02etEUWUQnNGIX4i
         Ec09VaUzGdb1gBHtg2C3DaZEubVeR8Uq0/93UDmQt1mdmV3YrA0uPTtKn92qlphrjXZw
         SlBvqoVtcrMhxN839xN58mXDu6Slz2ddE3EK+PbdiST2ZMd/+7gbfcVrRbcXT9gg4ee4
         sd/U5S+KWwZ0SH+37d6u4TdPBqvbBpEFFjhgF0GVCsLkL4+lRVBva+BsSaZWCPYll6Xx
         B02Q==
X-Gm-Message-State: AOJu0Yyrtdt3ier47VGmng6jbPKJ3EjRzO4lqOGQ7ZxQ45Ezd80bjsnX
	TXyrf/0KcAob/ncF6kYlLAPztxOuL5Q=
X-Google-Smtp-Source: AGHT+IGWXCtjUF6pqNOgGEGMNwnYkSvijor/+zMAcomN+wkED10MQqQ8FIfnsg9TyE8S8V1sZdBjTg==
X-Received: by 2002:a05:6870:d09:b0:1e9:9742:7dfd with SMTP id mk9-20020a0568700d0900b001e997427dfdmr738128oab.31.1699413229055;
        Tue, 07 Nov 2023 19:13:49 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id el33-20020a05683071a100b006ce29a19dcesm1786373otb.26.2023.11.07.19.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 19:13:48 -0800 (PST)
Message-ID: <1b69b849-4d82-4fc4-8007-d8474e933eea@gmail.com>
Date: Tue, 7 Nov 2023 21:13:47 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tree-wide: correct the spelling Ghz -> GHz
Content-Language: en-US
To: Ronan Pigott <ronan@rjp.ie>, iwd@lists.linux.dev
References: <20231108013445.59080-1-ronan@rjp.ie>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231108013445.59080-1-ronan@rjp.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ronan,

On 11/7/23 19:33, Ronan Pigott wrote:
> This mispelling was present in the configuration, so I retained parsing
> of the legacy BandModifier*Ghz options for compatibility. Without this
> change anyone spelling GHz correctly in their configs would be very
> confused.
> 
> ---
>   TODO               |  2 +-
>   monitor/nlmon.c    |  2 +-
>   src/ap.c           |  4 ++--
>   src/iwd.config.rst | 10 +++++-----
>   src/scan.c         | 14 +++++++++-----
>   src/station.c      |  2 +-
>   src/wiphy.c        |  4 ++--
>   unit/test-band.c   |  4 ++--
>   8 files changed, 23 insertions(+), 19 deletions(-)
> 

All applied.  Thanks for doing this.

Regards,
-Denis

