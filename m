Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBABAD23
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 19:55:14 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-13c2cfd1126so2815134fac.10
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 12:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6+kgJG8sAg893qHTZVnoxFVmVhy3WUm4/iibUbVreE=;
        b=FPqGRiSnvlddqp2U3sflaJLdbp8iHZvw5aJckH1VjQKL+s9FmA/+XJp2nVmGPvg+XW
         gZh5XMJqxwm7mLkYpm0BwtH9ljKEqm+gAG8NZ1thSB8htYFiVirBNiMf6S7v3ppNCjf8
         QyzVSWVi8lG6HUFA/IEGMLdSco5s3dIKKY+BNZkpSkOGIEl/i9OwTjaiERrpE9nZSifz
         /L9HBPOmW11zcxAC0ierNARo65NOJJ/0/AFuuwPu8wNPOSzIrsvS1nmzw9iUMUvXAvBw
         8tDJaW1NTWou40U8cizhp90vNMLIEmFGxN/5geq/irHUE3MSX6VglkBaRJi4y5TB5sMQ
         HA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6+kgJG8sAg893qHTZVnoxFVmVhy3WUm4/iibUbVreE=;
        b=ZzYuyEjGuTC5WMMWAWYErrtt6lIY1t5ElJYFCqFK74lRnKH3pk6XM3HYHq3BmHWgI8
         chxaceEd4iRVM4WxfjrHBVlc64wccsyTTGi0V5ZXG+8f+YiEgMDQfAt7D319ylggALF6
         dTTGAg4Vc7RNP0zqluldXX5OJt2IamYBuRBvOBEtODsKIKu3kb0MAUMhkofcZTS4vVcD
         Q31xa9h5d0j0JMSrVeF80NpUrrNHUSO8VyiKLMJd5S/VOsjyvXz43cMg0g5HurKxgIk7
         drpSecQITQEy/zCPi6suHp30tAxDRlP4SWt+TaZUVpZFI8R3ugpDFyEmOLioFrWcucti
         hDMg==
X-Gm-Message-State: ACrzQf34IS0bIkyHml2n7Lpn84mOTMd5yI/+C3pw5B6L7PM6n4uAswXI
	dF5KyiNlIALeggX/QTL+vKvOeMBPjCw=
X-Google-Smtp-Source: AMsMyM7/aSx//XgMYfRv3BJoGtrBA6dX/7zPqCHH25/DpGhU+00Roggyt/BcfRyQbyFArb9YE/Fdlw==
X-Received: by 2002:a05:6870:51d:b0:136:26d3:4ee5 with SMTP id j29-20020a056870051d00b0013626d34ee5mr3361845oao.11.1666814113693;
        Wed, 26 Oct 2022 12:55:13 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h24-20020aca1818000000b003546fada8f6sm2392167oih.12.2022.10.26.12.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:55:13 -0700 (PDT)
Message-ID: <34d2913e-26e7-b425-2b33-80fa18f169c7@gmail.com>
Date: Wed, 26 Oct 2022 14:55:12 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/5] eapol: choose key descriptor version in AP mode
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221026185656.489888-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221026185656.489888-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/26/22 13:56, James Prestwood wrote:
> The key descriptor version was hard coded to HMAC_SHA1_AES which
> is correct when using IE_RSN_AKM_SUITE_PSK + CCMP. ap.c hard
> codes the PSK AKM but still uses wiphy to select the cipher. In
> theory there could be hardware that only supports TKIP which
> would then make IWD non-compliant since a different key descriptor
> version should be used with PSK + TKIP (HMAC_MD5_ARC4).
> 
> Now use a helper to sort out which key descriptor should be used
> given the AKM and cipher suite.
> ---
>   src/eapol.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

