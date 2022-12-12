Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440446FD9
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 22:04:01 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id r11so12550283oie.13
        for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 14:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gO+sxz7OR06QSVXFMz8v29W8VNf5fPHmeM3EOt667aA=;
        b=NAQUDdlLJKLUbNhHnF9rqScb37MTrrm31OivLfQWWBOYjN3r0XilC8ues3vQL6vHcJ
         jN3Zl6NIjAvR48A8ECOk0uAb1huPYug2R2c1ZuahZQIoZ3SiLy452Jl1/dI5LZ2VDDOz
         reb27xq9gcNlSZ9kaQZSxD2zABIJg2dJ60F5TDNzQNV+ASZCvGH937Tv/EzB/zF2Hlb1
         mrDJQRSYRcm2PvDfdjH3osVMHec+4SWVA1blEbsSjC7TWKFv1ascgEs4pAh9ipQgfWb5
         q4N7X4ivqKyCwgn0x/E1mG1tMsq5od6RYhXsAmKp/uVps2k2COkkO3mFI/i1tJaoa7gq
         sZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gO+sxz7OR06QSVXFMz8v29W8VNf5fPHmeM3EOt667aA=;
        b=QEGZoAxGJV4nBsFFrGpFS3SdQQk9VV8qYT+uQqZo7zivj5kDQVuc98iOwO9QrfM5mr
         CtO/wQiURhaf4h1vKIHsRY2RIOIRmhQOhAxD9NFV5FKLqxnHTF6JcaPpEPIn2zn6E7Sv
         cPwCMV2Tm7pcf+/Aw0cnEuFEs2HetfUoxH3YXPiCjY10FyjNnSjU2z7T8FMfH6DM/yxS
         v0IErr7g3+VOjMSQVQ86ajAfzzDjOKqtxQoXCQHbCbIoXuk1VC6EDlIkP14M9DiJH5Vv
         0bSINkK/prImaIiLIE5KYyqHWU9UdwL12enZdWLxJddpeDq7K5cAI5D5U++u0LJSCDXO
         KCGQ==
X-Gm-Message-State: ANoB5pleuMqW6mt4LBpDtqB7AJJpuwJw/bhWSfMb3HdZ3I+9SB0frTwE
	/vqvAyuYY6UArjyHwThIOEs=
X-Google-Smtp-Source: AA0mqf4g3KbJ7Faua/iJgA0ESxePr1NrGc6Sh9faKrxiNbSgTHWR/BRVlnZjqgpBO2FBFd0emvTgAQ==
X-Received: by 2002:a05:6808:692:b0:35b:7145:2bd5 with SMTP id k18-20020a056808069200b0035b71452bd5mr7891329oig.16.1670882640372;
        Mon, 12 Dec 2022 14:04:00 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n16-20020a0568080a1000b0035e7d07bf9dsm2431149oij.16.2022.12.12.14.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 14:03:59 -0800 (PST)
Message-ID: <221263a6-0be4-3ca5-12b4-cbc3e5a65bcb@gmail.com>
Date: Mon, 12 Dec 2022 15:55:42 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scan: call scan_finished() when periodic scans get
 aborted
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alvin@pqrs.dk>, iwd@lists.linux.dev
Cc: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>
References: <20221212211050.3109050-1-alvin@pqrs.dk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221212211050.3109050-1-alvin@pqrs.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alvin,

On 12/12/22 15:10, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The blamed commit argues that the periodic scan callback doesn't do
> anything useful in the event of an aborted scan, but this is not
> entirely true. In particular, the callback is responsible for re-arming
> the periodic scan timer. Make sure to call scan_finished() so that iwd's
> periodic scanning logic continues unabated even when a periodic scan is
> aborted.
> 
> Also remove the periodic boolean member of struct scan_request, as it
> serves no purpose anymore.
> 
> Fixes: 6051a1495227 ("scan: Don't callback on SCAN_ABORTED")
> ---
>   src/scan.c | 18 ++----------------
>   1 file changed, 2 insertions(+), 16 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

