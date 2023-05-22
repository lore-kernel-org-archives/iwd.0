Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E08BE70
	for <iwd@lists.linux.dev>; Mon, 22 May 2023 14:37:51 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-397eba8b82aso1028879b6e.0
        for <iwd@lists.linux.dev>; Mon, 22 May 2023 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684766271; x=1687358271;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txVMzR3ahZsJepevClt6qZDezAoXhqBR89x4pK475UQ=;
        b=rhKk2ZpuAEUSAsFBud3VikDwAUstuR5oIEzzp+qp34R6QyLCp28Jk/NNuD3BfKJnNi
         3GZOkRt5c54u5YDhGjdtSHF/6KCp5z3V2KDd9g9hvQM4vy9VY74qUsn6pMKddP1+TnzT
         vk96zFvfbwi1KvFmHOjwS6gm5EnBgziVQQQbG00YuIeBmPIW+AH1o+LiDKAJHZw5TnVy
         yTZ2kyl78TRphkDYFeb87o/Ol/HTqODql77RH0r2IOGGLe2sAmBFXTvG3HDxv4wy6Kul
         qIMjTi0ygKVT9hWYpuyrwRJnRTyDVVpaO3M8D1VL7YvQS8DOW+Wddb1sSatTBVpiK+sn
         Pazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684766271; x=1687358271;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txVMzR3ahZsJepevClt6qZDezAoXhqBR89x4pK475UQ=;
        b=cCNWwLS7d9OCSx5k7Am3dCqtKYpkZteesinTjYX1BtQo2IrJlFEVMovrGMUhfSO6R9
         e2Zs1BtnwIko3AhR+7tmsIhl/6j/vB+WCillE/BwKpBcm4a3K145ZyvJAVFQvxJp8gpu
         UY4Ik3s7IFNeTNxv3hauXsv1GqG7v7HGQSOew4TEq/MZ+Tvm3jAWkminLSBRmdYUChxd
         hbAW7zK2ey2/Aya/Td3RvUNk2nAxB24tEWSngz4B1Hv31So2OCp53eBi4XE3EEHRFb6i
         lmWu8oy3qwVUAsMfNp1m4rqrdYdogH94aiVV2zpI3buYSZT2mPhWC/GbyMVaRkux4x4O
         zziQ==
X-Gm-Message-State: AC+VfDzQB1Irl0sLc7W8dIN6xBnTf/4RHbaMhIKfHMpdF74zsmTHgnWg
	Vt7wHge8BTyW0SMccv67udA1tuPf1aY=
X-Google-Smtp-Source: ACHHUZ7kPADt+SVFxc353BphTnlfdvP0ZTECMHfcaZIgunF623EoijOkbrog7KiAQ7IV+qmwfkYyNA==
X-Received: by 2002:a05:6808:205:b0:38e:b92:dbc3 with SMTP id l5-20020a056808020500b0038e0b92dbc3mr5793347oie.49.1684766271052;
        Mon, 22 May 2023 07:37:51 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s205-20020acaa9d6000000b00397f453aae6sm2158736oie.38.2023.05.22.07.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 07:37:50 -0700 (PDT)
Message-ID: <3717a7d8-e9e8-2dad-c02b-cb66c4807df6@gmail.com>
Date: Mon, 22 May 2023 09:37:49 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/4] auto-t: modify PSK-roam test to use FT failure
 path
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230518165000.275611-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230518165000.275611-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/18/23 11:49, James Prestwood wrote:
> This adds another radio so IWD hits the FT failure path after
> authentication to the first BSS fails. This causes a wiphy work
> item to be rescheduled which previously was unsafe.
> ---
>   autotests/testPSK-roam/connection_test.py     | 13 ++++---
>   autotests/testPSK-roam/failed_roam_test.py    | 33 ++++++++++------
>   autotests/testPSK-roam/ft-psk-ccmp-3.conf     | 39 +++++++++++++++++++
>   autotests/testPSK-roam/hw.conf                |  3 +-
>   .../testPSK-roam/roam_ap_disconnect_test.py   |  4 +-
>   5 files changed, 74 insertions(+), 18 deletions(-)
>   create mode 100644 autotests/testPSK-roam/ft-psk-ccmp-3.conf
> 

All applied, thanks.

Regards,
-Denis

