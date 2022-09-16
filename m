Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04ED5C81
	for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 16:16:39 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id f20-20020a9d7b54000000b006574e21f1b6so6669371oto.5
        for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 09:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1CkBa3HBkUC6/cHhq3czQQK8mtKVg/VYTFc9MizgknU=;
        b=IOGWSUWDDs0RyeA5zuQOVgVzP9hD3upPzrWzrc3aznD2jClpKOsPuypZ4FEEN7IhZT
         vpRCqplSFzcaniwQw3lf1639LajGiMPu9dQN7ORJ2w8BSY/zc3fTbmuEHpiUjttkYb7W
         AdsguUsixhrGQFInEzFiLsOxq6euIiP66fW3RaMW+23M1nnINR9AKIKkMZo9R/upSR0Y
         HIAyiNfABOSu0BAlorfMMFjvawhhi+iFQ9S/jz/AYsI1yZKuk47aMbMmQhxVBmnMMSgk
         pbpWQec8mwK5A5n2/kNb+9BVnQCoUxTefNvXt8lk4GOPJ2dI41NrU5Z+sun53/X/39bz
         Mc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1CkBa3HBkUC6/cHhq3czQQK8mtKVg/VYTFc9MizgknU=;
        b=c7dBeNuBnzrt4L/V+HJtcCQtRDmK7ZhXbjU+DsF1sNOijWNm6tWaxJhJqZsyDAAmKk
         joX9EhhOw7Me16g6z0YNQiHRLP1NdK51b/GrO9tJ6LZretUQnWCkVDJ1ZrmtgQHvuHpa
         vdDEXN1dezEh/+EIqGqaxrULAri3073Duuz7Mkw/dbqz0yZsMmn6u7QFf6PT2ebKQmcI
         eabswcAKa6WJu5JzsJQ7p66mnrYLMcpgvkNImLsB1kzdy833vA+4hHS1PlB3zym2pb9m
         pbybZdLtwsTeBO55i3t8fM4cvVmJkVTQqtUNuP1Cf9X1RMK8N9ajCo0P+IF8BwokUs4O
         QNvg==
X-Gm-Message-State: ACrzQf2Ouydx0pq3PdMi20o9AB6lPKqEFdPLzRTiCDdS5qTnHYzk1+Lk
	Smi9CuaS2V2O4JDR2t6O65w=
X-Google-Smtp-Source: AMsMyM5qvqKILSk0JsSNbVmeronvfOTyXJ+X3vTZdzXvQJfUiuTrQUX1Vt2NTLN3TAUz9AoVqnHpnQ==
X-Received: by 2002:a9d:835:0:b0:654:f1f:7a6b with SMTP id 50-20020a9d0835000000b006540f1f7a6bmr2587683oty.381.1663344998714;
        Fri, 16 Sep 2022 09:16:38 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v21-20020a9d69d5000000b0061b8653b0c9sm10366098oto.22.2022.09.16.09.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 09:16:38 -0700 (PDT)
Message-ID: <41488706-bce4-6160-5eab-78ad4b350c7b@gmail.com>
Date: Fri, 16 Sep 2022 11:05:47 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 03/14] ft: remove OCI element from auth/assoc
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220915220741.1128728-1-prestwoj@gmail.com>
 <20220915220741.1128728-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220915220741.1128728-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/15/22 17:07, James Prestwood wrote:
> FT is moving to authentication via CMD_FRAME which breaks the ability
> to get the OCI from the kernel (since its now an offchannel operation).
> Using OCI during FT isn't that useful anyways, so its being removed.
> ---
>   src/ft.c     | 26 ++------------------------
>   src/ft.h     |  2 +-
>   src/netdev.c |  3 +--
>   3 files changed, 4 insertions(+), 27 deletions(-)
> 

Hmm, why don't we just keep this code in case the kernel starts providing us the 
OCI info prior to Associate?  These paths just won't be hit when ocvc is false, no?

Regards,
-Denis
