Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643353B9
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 19:45:55 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id e22-20020a4a5516000000b004a3d3028bafso1066924oob.3
        for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 11:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNR9h1+pMTEpJ6fi4exkoLcBzax4/pRxnO0N0aMNdVU=;
        b=EHBa5TkzASXpEakJlsuDydug7O/UYlkCVx3mnJhwYlongCriARUZraJfeg8J57Xa4R
         FfeFK04mtGlTjeFvzrrSiIV2JoMeSCik0qTdcPZ60TKCsV6Dw+LLtI9RoumH+o550vZC
         d8dTXeiSHp4rrcoNttcgVnd/83+TwNoMECIF1pN2ue+VJxExcrVVXzuWIE6FVu/DgGnX
         3CRwcPiGnISgbHT3VMduFHy6JFU3jXj+NkJTY0vUZCD9Wkdt+nbaWjweuUFFLFceh+3g
         I5Z5uVPaje/FhsFfHKAgWbQspzxNmECBI+0FgZEru4dlX2LBhM4R384EJ6kSGj5CJ/Bp
         XeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNR9h1+pMTEpJ6fi4exkoLcBzax4/pRxnO0N0aMNdVU=;
        b=yjyidzoULtvA4P+JvUiPLiaWvTxSUJLRnAxvtuFypyMifbm8mwkJ5MZ4eSqFovkO+1
         v28HkSR6YsnbYoAyZ+9cLTVeQsjHYV7Qb8utv9ifYFJAbpZolnraJKdY962TsxNPUlHf
         THzxBrZliVtCJXHfsRIzFayEPz4JTY7dfpHzVSlmjcnO6PyDieDgADkkFK90CdGQAlf5
         JQhNvsuOIjtzhhd8X/PRWbu/p5QWXvr0eEZP3Gz5Pl8dvsKoGtbLCgufMm7s5ovSRhmy
         y3segU2IkceKw9YPPefCi3FpBGZo+7L+eKaNa4P9AtfhK//L07o9sND4GoOF1xNgMJRd
         o5OQ==
X-Gm-Message-State: ANoB5pl7aito6hungY9XzKDrNl5mMkkoyl3yfP5SIfGHRXRiF/+9J8Xe
	0rjwrvugkWYEaFh+vU/xBcQ=
X-Google-Smtp-Source: AA0mqf4Guhel4vRgbjxhXWB0ulpxkGQ6vKp4+4mbcdZLUACw6tRPHoSvTIn6GDAA+GBQvOff3Cie2A==
X-Received: by 2002:a4a:96c3:0:b0:4a0:b5a7:2d77 with SMTP id t3-20020a4a96c3000000b004a0b5a72d77mr6955829ooi.0.1670874354804;
        Mon, 12 Dec 2022 11:45:54 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id j7-20020a4ad6c7000000b0049b17794d19sm306886oot.20.2022.12.12.11.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 11:45:54 -0800 (PST)
Message-ID: <3fb7f5f1-04d8-8631-e7b5-70f27c963ac1@gmail.com>
Date: Mon, 12 Dec 2022 13:41:19 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Revert "scan: Don't callback on SCAN_ABORTED"
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alvin@pqrs.dk>, iwd@lists.linux.dev
Cc: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>
References: <20221212164250.3075444-1-alvin@pqrs.dk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221212164250.3075444-1-alvin@pqrs.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alvin,

On 12/12/22 10:42, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> This reverts commit 6051a1495227bbe7ba357f6995d4dbe4a4862331.
> 
> The blamed commit argues that the periodic scan callback doesn't do
> anything useful in the event of an aborted scan, but this is not
> entirely true. In particular, the callback is responsible for resetting
> the station scanning state to false. Failure to do so means that the

Hmm... The callback simply flips the station->scanning variable on and off.  I'd 
probably prefer just calling scan_finished instead of a full-on revert.  But...

> station scanning state remains true indefinitely if a periodic scan is
> aborted, and no further periodic scans can be performed by iwd.

I don't see how the station->scanning being always 'true' would prevent us 
starting a new scan?  station->scanning isn't used anywhere besides reporting 
over D-Bus?  Maybe I'm missing something?

> ---
>   src/scan.c | 18 ++----------------
>   1 file changed, 2 insertions(+), 16 deletions(-)
> 

Regards,
-Denis
