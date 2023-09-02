Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E2D17EF
	for <iwd@lists.linux.dev>; Sat,  2 Sep 2023 04:04:18 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1c50438636fso1708258fac.1
        for <iwd@lists.linux.dev>; Fri, 01 Sep 2023 21:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693627457; x=1694232257; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmJnWiOVNdxux6esowmvRo0AQfYCiYnckvaGzhHPF0s=;
        b=Tn3uwVSV4HnJdkduIlC5CCEHUd3FPkIWqmtizAm3mxCNdRQyeJ6hw9zrl0wtwcFz9p
         T1Esdvk3Dh0ndieEq9dOnU8gvKbJtV01M1BFaVCVbhhw2dsc+PeijTwc58r+vlotWjMG
         Ziyn/bKpoTgKJGQDhDoFhKMhkz8Nparyl91QjJL1I9PPaNybu25jsdV01Aar5wXWoTMl
         sNyX2RF0yPTqS5DMRCC1fXEnCQwwRyiWmQYCWpNH1oFLQDG669Mrq12Vy+L5Czq2YmWz
         HApfWJSKYpqBW/D+M1VGlyHwSMgkqnqdNNWSnrILMbSpAgHAlUa9jadLZ0bQOMmtaMJi
         7DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693627457; x=1694232257;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmJnWiOVNdxux6esowmvRo0AQfYCiYnckvaGzhHPF0s=;
        b=LfNPWJ08WfgM/5mISvR+Fa5m5vjnh4F3Qqj09l0rCN8Fky+reXr5YCwlLPTk3qKR8g
         VdwHMMBU/AqIRKsLNk6yNBAZ1gNn4apwAZf9pZZFHh4oc/nfjin4r96oAv95Rm0AhVYZ
         j21FSJ3bT8AfF1acuJjfDPdkKt4dcW027MOFaIYLn50Yb1jNZCZcGR2qIkXITS+Vya4a
         IOusVAGX2XWjIitUFtCnJyr+K5R0oVf46bHjirRP3yCbY91m2z4iUW+4QzIW47dKu8lF
         nWWW8eVtPJeoq6+3V08vTaDTL3ykyvS2X5lc3fiQxl/QXooeoXVP0ewpq8y42zGRh0f7
         SRyA==
X-Gm-Message-State: AOJu0YyzB601/dGBoIl93+u6rJ1aDVMyZETpmjOJ2o7Adzp7joWHvZSw
	w4RZysQJ0VhATbCAgB/Zw9Q=
X-Google-Smtp-Source: AGHT+IGYI1rP/gTGQJqyYxHbTarDSyU7slWda2I9yPr1MlMTXuOqBZg1ypXhHPx+GUJ98l6oO5Vr/g==
X-Received: by 2002:a05:6870:f587:b0:1d0:fd8d:2a10 with SMTP id eh7-20020a056870f58700b001d0fd8d2a10mr4598024oab.44.1693627457206;
        Fri, 01 Sep 2023 21:04:17 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s2-20020a05687087c200b001cc6b64d5f3sm2926313oam.44.2023.09.01.21.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 21:04:16 -0700 (PDT)
Message-ID: <7411f381-f09c-252a-9886-14315b0af2e0@gmail.com>
Date: Fri, 1 Sep 2023 23:04:15 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] station: fall back to reassociation under certain
 FT failures
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230831123924.531560-1-prestwoj@gmail.com>
 <20230831123924.531560-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230831123924.531560-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/31/23 07:39, James Prestwood wrote:
> The auth/action status is now tracked in ft.c. If an AP rejects the
> FT attempt with "Invalid PMKID" we can now assume this AP is either
> mis-configured for FT or is lagging behind getting the proper keys
> from neighboring APs (e.g. was just rebooted).
> 
> If we see this condition IWD can now fall back to reassociation in
> an attempt to still roam to the best candidate. The fallback decision
> is still rank based: if a BSS fails FT it is marked as such, its
> ranking is reset removing the FT factor and it is inserted back
> into the queue.
> 
> The motivation behind this isn't necessarily to always force a roam,
> but instead to handle two cases where IWD can either make a bad roam
> decision or get 'stuck' and never roam:
> 
>    1. If there is one good roam candidate and other bad ones. For
>       example say BSS A is experiencing this FT key pull issue:
>           Current BSS: -85dbm
>           BSS A:       -55dbm
>           BSS B:       -80dbm
>       The current logic would fail A, and roam to B. In this case
>       reassociation would have likely succeeded so it makes more sense
>       to reassociate to A as a fallback.
> 
>    2. If there is only one candidate, but its failing FT. IWD will
>       never try anything other than FT and repeatedly fail.
> 
> Both of the above have been seen on real network deployments and
> result in either poor performance (1) or eventually lead to a full
> disconnect due to never roaming (2).
> ---
>   src/station.c | 82 +++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 60 insertions(+), 22 deletions(-)
> 
> v3:
>   * Removed FT ranking division. This is expensive and was actually
>     incorrect since rbss->rank never actually included this factor
>     in the first place
>   * Include the FT ranking factor in the rbss->rank, then if FT
>     fails use the original scan_bss rank. This also keeps the ranking
>     the most up-to-date in case scan results come in prior to calling
>     ft_associate.
>   * Use a switch for checking ft_associate return.
> 

I like it.  I went ahead and applied with just a minor fixup:

>   
> -static struct roam_bss *roam_bss_from_scan_bss(const struct scan_bss *bss)
> +static struct roam_bss *roam_bss_from_scan_bss(struct handshake_state *hs,
> +						const struct scan_bss *bss,
> +						uint16_t rank)

I removed the hs parameter from this function since it was no longer needed.

> @@ -2581,7 +2617,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>   		 */
>   		station_update_roam_bss(station, bss);
>   
> -		rbss = roam_bss_from_scan_bss(bss);
> +		rbss = roam_bss_from_scan_bss(hs, bss, rank);

And fixed up to drop hs here

>   
>   		l_queue_insert(station->roam_bss_list, rbss,
>   				roam_bss_rank_compare, NULL);
> @@ -4584,6 +4620,7 @@ static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
>   {
>   	struct station_roam_data *data = user_data;
>   	struct station *station = data->station;
> +	struct handshake_state *hs = netdev_get_handshake(station->netdev);

And this one was not needed

>   	struct scan_bss *target;
>   	struct l_dbus_message *reply;
>   
> @@ -4603,7 +4640,8 @@ static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
>   	/* The various roam routines expect this to be set from scanning */
>   	station->preparing_roam = true;
>   	l_queue_push_tail(station->roam_bss_list,
> -				roam_bss_from_scan_bss(target));
> +				roam_bss_from_scan_bss(hs, target,
> +				target->rank));

Fixed up to drop hs here.

>   
>   	station_update_roam_bss(station, target);
>   

Please double check you're still good with this.

All applied, thanks.

Regards,
-Denis
