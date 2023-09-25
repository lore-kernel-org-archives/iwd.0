Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AA1C2A6
	for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 14:51:18 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6c4e30a3604so1639324a34.2
        for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695653478; x=1696258278; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2rH2SW/cc10239eirbLqszN4vCIP31jZBZG17wOaGA=;
        b=C3U879NC1qGIg3hmUMS5jJC1LijdMgebTM46GwOpwg0oTJxopYayZaYaaqTbV2hN6h
         66M6vZkXTNnCwETZbk3ef0P8GVzY33BTrEZFIUh9XGCtJ1+LXFVurq4MbnF+1BBVWjQz
         iorud6+r1yRziD6ByT2PC7Aw9nG+/P1QnXDQtztZC3y+JTtiZeusMdUFkizOY1/Prjs+
         kyoMAyHO4KMpD5r1FofK1Z2+jh50IeSGCgf/kDjkA6ECaBsstPPVx38j8goNqU36JDU2
         EgWqFSs6bdTFUu+VaAkKhYvCMfUWvESF83ci8igsqw46wtTPrjDl4ELChOUJM3Phtk7m
         ic0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695653478; x=1696258278;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2rH2SW/cc10239eirbLqszN4vCIP31jZBZG17wOaGA=;
        b=Tle9D1+ErvB92Gs0KS4mbk7LWx77GW+/cThPvgMxa33qoc7oORgG05RWPxLePBpfqS
         iDzANCEXROLZfcNDlBuu65KoJp/2GDKvyUtEdzwVljh/vPYc4NsZogcnpmNUALfRyXUy
         13fv44QwPpfqB8cGHZfxr+J/xyHr0p1hh4+xccD/QKNRrbbFIdPTrolspFy7mDQkKes1
         XUOLPFrqYESg09/3SmEwkPna0QXuioo8gfd/o56iOHleHYGNGMs/3gxEKkQg0iign7lf
         bho9NTI2wN0purjHN55BOSeHjScNw8e+dCyBPQR95mdl41Q4wc2Ro2hCPzpQWLss80dV
         6ZxQ==
X-Gm-Message-State: AOJu0YzOdnR6HIJ/JmOU42+I2ByhoXNKZ+8vZXv4WhN/6MKcqjtlbrw9
	2j8jVuVtrsVGQriGNHt4keEvmA1Nzbk=
X-Google-Smtp-Source: AGHT+IHcABf95ig7M5S6SH8PvIDcQaRMzv8J+I7rvMK6PfxE1DL7k4On1wOvaFUu785h4Ygm0zcr2g==
X-Received: by 2002:a9d:7556:0:b0:6b9:5734:135f with SMTP id b22-20020a9d7556000000b006b95734135fmr7732058otl.28.1695653477659;
        Mon, 25 Sep 2023 07:51:17 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ea9-20020a0568306d8900b006c4d822bea7sm801606otb.31.2023.09.25.07.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 07:51:17 -0700 (PDT)
Message-ID: <e42db21d-3cd3-504a-9f3f-0c3872f63383@gmail.com>
Date: Mon, 25 Sep 2023 09:51:15 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] rank: add option to normalize using defined rate
Content-Language: en-US
To: =?UTF-8?Q?Pedro_Andr=c3=a9?= <PEDA@bang-olufsen.dk>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20230921142302.77637-1-peda@bang-olufsen.dk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230921142302.77637-1-peda@bang-olufsen.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Pedro,

On 9/21/23 09:23, Pedro André wrote:
> BSSID ranking relies on a quotient between the BSS data rate and
> theoretical max data rate. This makes it so that when two or more BSSes
> have the same SSID, the likelihood that higher frequency bands are
> ranked first is high given their increased data throughput.
> Such may not be ideal, for example, if one desires to connect to 2.4GHz
> by default (if possible).

I'm curious why one would want to connect to 2.4 by default?

> 
> This tries to address such scenarios by introducing a new rank
> configuration option where a necessary data rate (in bits/s) can be
> provided. All BSSIDs that achieve or surpass this data rate will be
> ranked identically before applying any other rank factors. If no value
> is provided, the ranking process remains identical.

I can certainly see the use case for non-general purpose devices that have a 
specific bandwidth target.  I think we can benefit from something like this...

> By using this configuration value in conjunction with already existing
> ones, achieving a behaviour like preferring a certain band becomes more
> accessible while guaranteeing that the first-ranked BSSID still complies
> with minimal necessary data rate requirements.

However, I'm a bit worried about the details.  Given that you're only interested 
in BSSes that meet a certain bandwidth threshold, wouldn't iwd want to weight 
the RSSI more heavily?  I suppose one could rely on the 5G or 6G ranking 
factors, but is that going to be good enough?

> ---
>   src/scan.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/src/scan.c b/src/scan.c
> index 5a972efb..16d533e4 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -55,6 +55,7 @@
>   /* User configurable options */
>   static double RANK_5G_FACTOR;
>   static double RANK_6G_FACTOR;
> +static double RANK_NECESSARY_RATE;

Why is this a double?  Might be easier to make this uint64_t instead, similar to 
what wiphy_estimate_data_rate produces.

>   static uint32_t SCAN_MAX_INTERVAL;
>   static uint32_t SCAN_INIT_INTERVAL;
>   
> @@ -1625,14 +1626,15 @@ static void scan_bss_compute_rank(struct scan_bss *bss)
>   {
>   	static const double RANK_HIGH_UTILIZATION_FACTOR = 0.8;
>   	static const double RANK_LOW_UTILIZATION_FACTOR = 1.2;
> +	double data_rate;
>   	double rank;
>   	uint32_t irank;
> -	/*
> -	 * Maximum rate is 9607.8Mbps (HE)
> -	 */
> -	double max_rate = 9607800000;
>   
> -	rank = (double)bss->data_rate / max_rate * USHRT_MAX;
> +	data_rate = (double)bss->data_rate;
> +	if (data_rate > RANK_NECESSARY_RATE)
> +		data_rate = RANK_NECESSARY_RATE;
> +
> +	rank = data_rate / RANK_NECESSARY_RATE * USHRT_MAX;
>   

If you pick a low enough necessary rate, the ranking will be always USHRT_MAX. 
Any factors applied will not affect the rank due to bss->rank being clamped to 
0..USHRT_MAX range.  This also creates some weirdness during FT, see my earlier 
comment in the 'Force use of 5GHz band' thread.

>   	/* Prefer 5G networks over 2.4G and 6G */
>   	if (bss->frequency >= 4900 && bss->frequency < 5900)

Regards,
-Denis

