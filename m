Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8646F8BE0
	for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 17:49:05 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-142612a5454so2393680fac.2
        for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 09:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAO7TH7kYj5Jc8kLNVIR6qRubcmhyqJX3T5xpmoOYZc=;
        b=APVXijd7bsMdlrnAYel2u/cdUqm4QRrcH76xpy/vRu+dHF6F+hsC9fKbBtXDPf5Ehm
         lEQvG32PEuzQJL7ssAZfCE0SscGCUb8Hdi7mo8iY1i6/nrcZ1+MK/MIg6NPz4aSY6gbc
         eWYcI3P5zAvQwr6XFJ0shMroZgrK6NCcYTfqqYIM4wC10nMyKvyuksFFyuzH/SPLTC7l
         3u4+ubZ2DAlqCFPjktdJb/WHrBMleKN4w46oBWC0lSoXw2xaxZp0mSVZGk0Gdgk6JWhg
         OkYSbyibi7UYjh1D8ZLY8EPeTFVJnDLO773qAZt5nFCWrlWzOVikQ4tXsNVjB9X1Z+gd
         SqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAO7TH7kYj5Jc8kLNVIR6qRubcmhyqJX3T5xpmoOYZc=;
        b=cD8ZhbM47+KNuhGIiSB1etmL5raBoEbDezGV0AYz030MXWJvdzgzuB73kHqU1ho7th
         DLaw77RWYdhJc/hf2nvlpg9t68GeI0pXww7hxXXuTSioLAQ0Ssz+sKkdotvdRB4xMp4A
         7kQRfE/w/szR3ksIqbrI5S8I2MejgWFUhp2JMUg18C2zpqL+k2dlR4urz1qT7peraSQx
         Tu2TFzjHJro9m6fgaytLFkgwaOG9VMld00kO+FfAdRMbp6nZvYvr5HFmTn1IM81xq5LF
         FVfXcPf5JvWHIAAkXCOQxNfdBIbWg2gKnyinhVz+ooFSebEQUPpua5NTNJEO76zuDkfy
         7bwA==
X-Gm-Message-State: ANoB5pnFPg0tx56r9HfrYf9h00J76qC0dTLUWZxW+Z/CQwLQ6ihMZJui
	Dw7xG8N1/i6rbYPh8mATgbA=
X-Google-Smtp-Source: AA0mqf59tQ6N/a440YgNCIANCvodsMe8xsb+dtuZG3HfgDyDWemac6RGHiJny+VEN0CJNK6fgozfHA==
X-Received: by 2002:a05:6870:d252:b0:141:85b2:b3be with SMTP id h18-20020a056870d25200b0014185b2b3bemr4946273oac.58.1668707344670;
        Thu, 17 Nov 2022 09:49:04 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n20-20020a9d6f14000000b00661a3f4113bsm580213otq.64.2022.11.17.09.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 09:49:03 -0800 (PST)
Message-ID: <eead8130-e13b-e1eb-6453-e27b1d293c31@gmail.com>
Date: Thu, 17 Nov 2022 11:49:02 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] scan: retry scan based on scan done events per wiphy,
 not wdev
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alvin@pqrs.dk>, iwd@lists.linux.dev
Cc: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>
References: <20221117172901.2459224-1-alvin@pqrs.dk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221117172901.2459224-1-alvin@pqrs.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alvin,

On 11/17/22 11:29, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> ---
>   src/scan.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/src/scan.c b/src/scan.c
> index 5548914a12de..c3763ee41173 100644
> --- a/src/scan.c
> +++ b/src/scan.c

<snip>

> @@ -231,6 +247,7 @@ static void scan_request_triggered(struct l_genl_msg *msg, void *userdata)
>   	if (err < 0) {
>   		/* Scan in progress, assume another scan is running */
>   		if (err == -EBUSY) {
> +			l_debug("XXX busy");

This might need a nicer message

>   			sc->state = SCAN_STATE_PASSIVE;
>   			return;
>   		}
> @@ -2044,6 +2061,29 @@ static void scan_parse_result_frequencies(struct l_genl_msg *msg,
>   	}
>   }
>   
> +static void scan_retry_pending(uint32_t wiphy_id)
> +{
> +	struct scan_context *sc = l_queue_find(scan_contexts,
> +					       scan_context_match_retry,
> +					       &wiphy_id);
> +	struct scan_request *sr;
> +
> +	l_debug("");
> +
> +	if (!sc)
> +		return;
> +
> +	sr = l_queue_peek_head(sc->requests);
> +
> +	if (L_WARN_ON(!sr))
> +		return;

Also you could simplify out the need for this L_WARN_ON by using 
l_queue_get_entries() style for loop on the scan_context(s) instead of using 
l_queue_find.  But that's just me nitpicking.

> +
> +	l_debug("XXX retry pending request");
> +
> +	sc->state = SCAN_STATE_NOT_RUNNING;
> +	start_next_scan_request(&sr->work);
> +}
> +

Otherwise this looks fine to me.  Does it work?

Regards,
-Denis
