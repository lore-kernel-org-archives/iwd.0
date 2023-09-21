Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A09199A9
	for <iwd@lists.linux.dev>; Thu, 21 Sep 2023 15:14:32 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59c0b5f984aso13319827b3.2
        for <iwd@lists.linux.dev>; Thu, 21 Sep 2023 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695309271; x=1695914071; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fi7lmU9I8hvr37XyBku5WIM13ZuMWNLgbfdQNYVWP2o=;
        b=bPioFDUnSI1uUI/LcoNs6Fmxrb5EDU1nTIcxExkQQOzXc8zVkQ2RgZvYEuIbDEzqHE
         oaV3XUR73WxoiWvfYMP6/rajjfP5z1oXt3Sb2GOBiCFltoezGXhDyvJHwTgzdvF/NGPN
         qCPElTwhZ57PC6/7qoMc+LMCjaAbb9DmY+5QkvP2r71BRvFXcAnNjL4zowckUuvGI7Oh
         Pun7AFz+BAizthWG9s4XRi2Ea8BHwsLnAQi6qvNDKT1S5VaR3GmuJt8PO96ikqXC28VR
         TraQJc9scEcmt5CW16ek4hmm94KvtQYyAvSCx5OZ+LwNS5o6D4EeJTbQWRbXf+LphAyQ
         6FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695309271; x=1695914071;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi7lmU9I8hvr37XyBku5WIM13ZuMWNLgbfdQNYVWP2o=;
        b=D9jVDSpZ3u/ValLZFzmyzNPgPmXwCSU2nFcBeWgLIPolRwHWVWD6xh3zGvgVsihIm2
         9cfSUH5oulqr8zQl7czMjqvMC5Prkaon/9oNVKApyvLnuROdpK+ApEOvji/baFmL7jYp
         bA7tq/vGQstgu3skKMUgcW0+a3z/NZo6f9Sze7extH2xFBgjlfLUstvJ/I7ZJs+XxC94
         ORGlA6wgC4c52RbWT83okGFlc+vXcNmUNAqep5G6jTgXvFNNAFMTSM2TvuTgq3Vpx1ia
         isVZcL+0mhnVG4WlnM4W5alfttYPMoEtuQzRNVo5CkKTzCwiiEK8tixmlrcPtydxaDhy
         LVfw==
X-Gm-Message-State: AOJu0YwFcp7uOhWyZ7mIv2fYA5M5CDyBoCJWPitU8l/SfCpXzTatUjhW
	0YfHyzntY8m0zqzra+96LB9RoZPfBVY=
X-Google-Smtp-Source: AGHT+IHgXPIe1Bd3reRhUAg4IWox5Pt9yf+VpUV6E7AT3yFEXOILmqWx2omfV6ShAimXiuFXXemODA==
X-Received: by 2002:a81:5c45:0:b0:59b:fda7:9d7f with SMTP id q66-20020a815c45000000b0059bfda79d7fmr5759079ywb.49.1695309271279;
        Thu, 21 Sep 2023 08:14:31 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id w126-20020a0dd484000000b0059c0629d59csm370293ywd.115.2023.09.21.08.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 08:14:30 -0700 (PDT)
Message-ID: <d06e14d0-661d-4471-b742-b8ea2bb96c56@gmail.com>
Date: Thu, 21 Sep 2023 08:14:28 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rank: add option to normalize using defined rate
Content-Language: en-US
To: =?UTF-8?Q?Pedro_Andr=C3=A9?= <PEDA@bang-olufsen.dk>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20230921142302.77637-1-peda@bang-olufsen.dk>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20230921142302.77637-1-peda@bang-olufsen.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Pedro,

On 9/21/23 7:23 AM, Pedro André wrote:
> BSSID ranking relies on a quotient between the BSS data rate and
> theoretical max data rate. This makes it so that when two or more BSSes
> have the same SSID, the likelihood that higher frequency bands are
> ranked first is high given their increased data throughput.
> Such may not be ideal, for example, if one desires to connect to 2.4GHz
> by default (if possible).
> 
> This tries to address such scenarios by introducing a new rank
> configuration option where a necessary data rate (in bits/s) can be
> provided. All BSSIDs that achieve or surpass this data rate will be
> ranked identically before applying any other rank factors. If no value
> is provided, the ranking process remains identical.
> By using this configuration value in conjunction with already existing
> ones, achieving a behaviour like preferring a certain band becomes more
> accessible while guaranteeing that the first-ranked BSSID still complies
> with minimal necessary data rate requirements.
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
>   	/* Prefer 5G networks over 2.4G and 6G */
>   	if (bss->frequency >= 4900 && bss->frequency < 5900)
> @@ -2363,6 +2365,14 @@ static int scan_init(void)
>   					&RANK_6G_FACTOR))
>   		RANK_6G_FACTOR = 1.0;
>   
> +	/* Maximum rate is 9607.8Mbps (HE) */
> +	if (!l_settings_get_double(config, "Rank", "NecessaryRate",
> +				&RANK_NECESSARY_RATE))
> +		RANK_NECESSARY_RATE = 9607800000;
> +
> +	if (RANK_NECESSARY_RATE > 9607800000)
> +		RANK_NECESSARY_RATE = 9607800000;
> +
>   	if (!l_settings_get_uint(config, "Scan", "InitialPeriodicScanInterval",
>   					&SCAN_INIT_INTERVAL))
>   		SCAN_INIT_INTERVAL = 10;

So this just bypasses the data rate weight (for BSS's at or above the 
NecessaryRate), leaving only 5/6ghz rank modifiers, utilization, and 
signal strength (if ranks are equal).

I know its behind a non-default option, so I guess "use at your own 
risk", but... This significantly increases the pull of the rank 
modifiers and utilization (which was kinda your point in doing this). My 
concern is that you could run into a situation where IWD connects to a 
BSS with poor signal because utilization is lower than others. Since 
signal strength is only considered if the ranks are equal you could have 
the following scenario:

BSS A: utilization 192/256, RSSI: -55dbm
BSS B: utilization 60/256, RSSI: -88dbm

Correct me if I'm wrong, but assuming BSS A/B both met the NecessaryRate 
requirements IWD would choose BSS B to connect to since the only factor 
now is utilization. I do realize this only applies to very loaded APs 
(>= 192), but its something to think about.

This is more of a nit, but I wonder if we want to have the option in 
increments of Mbps rather than bytes. Just easier to read that way.

We would also need to add this to src/iwd.config.rst

Thanks,
James
