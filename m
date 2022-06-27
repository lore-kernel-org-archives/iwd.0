Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D92833FB
	for <iwd@lists.linux.dev>; Mon, 27 Jun 2022 17:24:59 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-f2a4c51c45so13765011fac.9
        for <iwd@lists.linux.dev>; Mon, 27 Jun 2022 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=g4BR3dAbGyew6xr0RXq9PtoIqNJy7ZthryD88uL88Hs=;
        b=LeD/0XpVc8yDWf5HudHUnYKJW+Y3Govo7gMsBm4eMxJBlE3ScgLqGCOiLOY9f5a6qh
         U7ZL6WAX+8RYfUQWmZduHOvrYz/SnqWJC7p+rE22abzuoOc+6Z+MqP0txLUAYv/5fFbl
         XxpP4z5/Klpmaq8TuVT9k3tqwu3C0ST7H3Xs4Bg50LcHdEe8NWwf0tywfft1PMTlmB2C
         TtB1HEAww1iQ/+owql9t6zDwxBQkEboAV1oX/PpDWyiV57R9zAp4mtkTSyUYLvURiUCr
         peprZ9RzuVCwJCITTcQAk5lskiKuUpRiaBTuSDpA13YfQV2UVQmrK3hRaFNSWwZ7PxVb
         rYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g4BR3dAbGyew6xr0RXq9PtoIqNJy7ZthryD88uL88Hs=;
        b=0iE5DsVCLfnrBGxTMNZKuFtnwh0o/DR+bE9zhy+Qxv+PeZcZbp6fFI/SYNpYtm80rK
         pyIgHMjfhHUFb2f/Nt4q8pHCvxA7rTJDMEYSRuBl9+HLSO1XNHLMe31xxjWHBy917gA6
         zlQrA7e+LeM8tpHfUT5BmFeucIfsL9Cvu3usY0x36pCZ7DCo9LLGIo32SZSckc8UBGqJ
         gcpWD/D+ZCjL7hutdL2GRIQqkppuctUVzGVFnb7YjdMxu+qUJS2DxoQHPfazGitLuT5o
         cotUEsHKmuAvTswM+FCvOqDP/N1VKE4uzfbqz5HxZoi86aIJSw/t7NeYC+1caJq2SN2x
         /JmA==
X-Gm-Message-State: AJIora/dLZtuXSBNG4+Zi4CqnK9efDOF36txx/u3hu9VR/+t/RtjDZ9Q
	CFpGwB9wOACUjVxwLanRvM5a+LGpcwQYA0Bz
X-Google-Smtp-Source: AGRyM1s0MLM8S11VrmZeuR/MguU32plgNfP5kVEBIqvSUAnYi2OytUiEFYPngVExEJhxBUyMsBQeAQ==
X-Received: by 2002:a05:6870:89a9:b0:101:d81d:e970 with SMTP id f41-20020a05687089a900b00101d81de970mr10990221oaq.43.1656350698470;
        Mon, 27 Jun 2022 10:24:58 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bq11-20020a05680823cb00b00325cda1ff99sm5774532oib.24.2022.06.27.10.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 10:24:57 -0700 (PDT)
Message-ID: <bae45365-7357-08e9-2cf0-f88e5ed32168@gmail.com>
Date: Mon, 27 Jun 2022 12:08:06 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] dpp: Add Started, Role, and URI properties to API
Content-Language: en-US
To: Jesse Lentz <jesse@twosheds.org>, iwd@lists.linux.dev
References: <20220624164346.254771-1-jesse@twosheds.org>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220624164346.254771-1-jesse@twosheds.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jesse,

On 6/24/22 11:43, Jesse Lentz wrote:
> Add three new properties to the DeviceProvisioning API: Started, Role,
> and URI.
> ---
> Unlike the previously proposed State property, the Started property
> proposed in this patch only requires l_dbus_property_changed() calls
> near the dbus entry points.
> 
>   src/dpp.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 

Both applied, thanks.

Regards,
-Dens

