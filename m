Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27520E0
	for <iwd@lists.linux.dev>; Thu,  6 Oct 2022 14:02:14 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id n83so2093888oif.11
        for <iwd@lists.linux.dev>; Thu, 06 Oct 2022 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2wJwq7SAPqkExEUOPF1OrWSNPjGqwbATxUd3G/338k=;
        b=FGSgTSkrmeCuZY83wpsR9+m5vMmnz27A2yGT88j+sPmG74cXhYhN5CvBOx3E89B7I5
         SpHPlS/VILiPNipi09FalwpEuGBz3mrYA6uaExj5yXsA9hN/J6/ajyt0SMOXgwt2oel4
         rH5qvM9H2A8BrPbA1aHscIDmp2vFsNvJZyeHSt93vMnHB1qIYN9XotOnFC+EAzQRiSpb
         o0BRPun/QJJCjSA01xP06/UN7Tx3UybVN1s8f0NqI34qqgClp1O4UwuUdQxC3emSzNcg
         etul1b0KSf3N6BhoIRdYnkYyC+ZfrLTMUVtlaH1ANQG6uNI2wJsXZtW6K/urR5+HTUvK
         OUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2wJwq7SAPqkExEUOPF1OrWSNPjGqwbATxUd3G/338k=;
        b=rcgB6L7QPY8qmPnBIG9HVD0cbru0+K+cPK1TXm5UfkMLGcV52paHpgSnvcg0p7+iy4
         3DcfdqY94uKEAOOYV7uHRD0S+pwtNrO62QwaBzE8yChJ4bOQrNrWJqyanZObxppMHqqa
         FqYriUpt7Tpbk+32G31Gh5CrfK7aDX2EvHpkfhGgov+bHMr7i+bMJvdvzdv4bbcasahR
         NA437F0nV9D0Y2K0puIvZsP+s32besuFqbg5b1ItnD/1eoKSxBjJHB3m8RRGxwgkKsXR
         PUuvUvEUrLnaRM36yu+9Ja6ZKEO6VR5s5gtwA6yNcwP2YwgvswvwTVPpRZ5Qoo/avuIC
         ERww==
X-Gm-Message-State: ACrzQf1ieTvgcG65e1yF5yLKXES6RSZPxgKU462pWnu1iFFS2hIr9FQt
	7VA/fUgKnUEfPX2/uGGD2G15eUnBPdU=
X-Google-Smtp-Source: AMsMyM6yja0Aw1MZAriEzGUbpkQob5cWRBJuUZMwdEf3n42qtW+Q2Bh2pvalCAC8ZHRk87lCdrl15Q==
X-Received: by 2002:a05:6808:1529:b0:350:2872:4077 with SMTP id u41-20020a056808152900b0035028724077mr2488935oiw.41.1665064932944;
        Thu, 06 Oct 2022 07:02:12 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y40-20020a056870b02800b0012d130c2fdasm6771897oae.48.2022.10.06.07.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 07:02:11 -0700 (PDT)
Message-ID: <185244f1-c2cf-2a4e-7081-514dc682cbcc@gmail.com>
Date: Thu, 6 Oct 2022 09:02:10 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/6] station: add two debug events for FT
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221005224632.780575-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221005224632.780575-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/5/22 17:46, James Prestwood wrote:
> These events are sent if IWD fails to authentiate
> (ft-over-air-roam-failed) or if it falls back to over air after
> failing to use FT-over-DS (try-ft-over-air)
> ---
>   src/station.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

