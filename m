Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63634185B
	for <iwd@lists.linux.dev>; Sun,  9 Apr 2023 17:29:25 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-18436e0b673so2955422fac.0
        for <iwd@lists.linux.dev>; Sun, 09 Apr 2023 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681061364; x=1683653364;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HajUozQgO5fkUtNjYa1VN4K3l695dVm/OV1yA5q9ejI=;
        b=E38qAiwGL9e10lr/EH3f05nd2EunmUYE3qMpBWo5sh12SvrWQzJShZmG51wKmG4q7u
         WlwShgxl5bs0Y2c9/0dnFw1Cah9Z/rJIToqOgqN/KU++MKf9AJxeX8HVTfKDu4hciLQT
         2XHfcTfVPYqgmD49GVYa/52PAdnxFuGV9LuqQ1UPDHfiS0B2eAST0VYzQ9tMEwcTJgTH
         k8PcfyIOkS2zozOc7GvXvudUgUhG/vpFWEFYrbtlXGYVuWZxhe3G+QkCfxl8gaV4Lj+D
         yZfd4aDIy8hY32FbJ1jeRYQ4r/KgxuY4vXNF1Wzr0AZrmZ/fDYHGxsTbq9OaXwnTY/0b
         p2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681061364; x=1683653364;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HajUozQgO5fkUtNjYa1VN4K3l695dVm/OV1yA5q9ejI=;
        b=2DP8a70aWrINPI09W7kA5M1D8OdSaD1nh6OdAPoA3jWeFvA1n4ITzLveJbayqKe//C
         lXrgldrmEgPB+tO8kEXlIjON1GSu9sdFK5STsvegl8C9c+OUKxq6Dq7fD1+WfswsXWEv
         nuCOkfN+2hJ6XAETpJHGtk1jeRfPAHZbzHmDv+oW+dKyu4PxOPSP2qFUDP4hSYVX8OTO
         Csdv/h1TO0sQ+6CFdJLE+i43E+Of+nUQikSVVLbQXa9DvCemqr3EyPnBbw4RN13OeCsr
         9RLslcCVBJ3FfIgO1hLUgoxzyp2vh7ctaoqUZjWis5lw7yzqj+9tQ3sY8jiVlC5ItRC1
         G3/g==
X-Gm-Message-State: AAQBX9fgGH45rXsNgXhqIzC6C6k/HIviANkoXyvVon8rcYbYz/f2AiN2
	te69vwRYK9NJ0tKSnEe+szmhmO9ghnqGgw==
X-Google-Smtp-Source: AKy350YPpsP5am2AWJQKXfbfZbmvO3OVFL2nbOf/fZ9FrFR/MZY0JN9x2itCmG6kq5yC3eLzLWoWdw==
X-Received: by 2002:a05:6870:a115:b0:172:6d0c:e98c with SMTP id m21-20020a056870a11500b001726d0ce98cmr3213961oae.29.1681061364494;
        Sun, 09 Apr 2023 10:29:24 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id tr15-20020a0568718c0f00b001802d3e181fsm3337538oab.14.2023.04.09.10.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 10:29:23 -0700 (PDT)
Message-ID: <504042cf-1704-a590-391c-009b500cf505@gmail.com>
Date: Sun, 9 Apr 2023 12:23:52 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230404203823.384260-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230404203823.384260-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

>   	if (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
> -			IE_RSN_AKM_SUITE_PSK_SHA256))
> +			IE_RSN_AKM_SUITE_PSK_SHA256 |
> +			IE_RSN_AKM_SUITE_FT_OVER_8021X |
> +			IE_RSN_AKM_SUITE_FT_USING_PSK))
>   		use_sha256 = true;
>   	else
>   		use_sha256 = false;

Oh and we probably should extended this and crypto_derive_pmkid to use sha384.

Regards,
-Denis
