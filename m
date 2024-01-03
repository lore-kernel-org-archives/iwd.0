Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541919442
	for <iwd@lists.linux.dev>; Wed,  3 Jan 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqyM1E7a"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28ca63fd071so1942859a91.3
        for <iwd@lists.linux.dev>; Wed, 03 Jan 2024 04:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704286723; x=1704891523; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZjBKBlN5zWPb5IXWIFWgkSogfn5f/z6KZif0C1DU7s=;
        b=SqyM1E7a4yCLKY0fgu3ftnp8Izf9wiYLAj6pqCYQcFgENZSogFPI8iupzZNZnj+dlo
         oBUg2iZUvsF1hI9SxxxMaYwtGk8ReBaUcQ0UkqUgU5g/+iarEzyhjwMeU2z17McZY69z
         EuQtri5lIQmQVIB9H4VJKWJOGq9ply5XvOrIL065UNCFS6bNh6ukZYmW0bqjxclSQe8c
         abmpiciwSx3+ByawUi35e4G1o+n0YjlheQr4BELtEzwj2z2A91L47kVHsE74r9QcbtZ9
         b+4+7Qrlhv/QCUAiXIxYoCBsPLqTHjKDP0Gk/kmwZ1jGY5juCk5J+itbst3LKL4+uHFz
         Ooyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704286723; x=1704891523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZjBKBlN5zWPb5IXWIFWgkSogfn5f/z6KZif0C1DU7s=;
        b=fAi6qKoCdndEcu92+hHtaOD5kjirUEO3+t/1vnLhE+XrbhvhGAP6339rAN7V7LQuGW
         BRz1ZKOgLZFPq2ipR8ST90dFWmWhR9F78GDffrEoQRRyJfHfNyN9dCHrNq/znl5SBZTC
         jk09JjEfgLMdOChwXLFP/5JQk/57SxaEyTsFnoG5ygcbYXsn+PEYyNrMOYOkIELMdKJW
         Twul9kbUTMMFkpRsCaZTJyep9IPEFCIpVd/o6T220RQIW8znlp+tFfUOfdnyQVmUvjI8
         n8V8BTqrFAK5D8DZPkz+53qQEQyBjVsGK79DB8N97aMPyQGOvGBuUCriDqvgCA61VkuU
         0wgQ==
X-Gm-Message-State: AOJu0YzxxYLbn9IiZ7XIPL4M12YnRKIihJyKcsXqJFPXY6VPOPR0CkrE
	YESP7vjOqyIceaTGxUVOc5NFAykNG+UH7g==
X-Google-Smtp-Source: AGHT+IEWmcLxD/kMnBTKww0ZdFZMSvZRInFu7YZF/gtP1bP5Iqod/kkTHr/kdD81eUBxnfYLLdSqBQ==
X-Received: by 2002:a17:90a:9704:b0:28b:cbfb:63af with SMTP id x4-20020a17090a970400b0028bcbfb63afmr6602867pjo.86.1704286723146;
        Wed, 03 Jan 2024 04:58:43 -0800 (PST)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id sg15-20020a17090b520f00b0028b5812c477sm1586726pjb.35.2024.01.03.04.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 04:58:42 -0800 (PST)
Message-ID: <271dfdff-903d-4ff4-abe7-34526aec3580@gmail.com>
Date: Wed, 3 Jan 2024 04:58:42 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scan: limit COLOCATED_6GHZ flag to 6ghz devices
Content-Language: en-US
To: iwd@lists.linux.dev
Cc: Keith G <ys3al35l@gmail.com>
References: <20240103125638.243820-1-prestwoj@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240103125638.243820-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 1/3/24 4:56 AM, James Prestwood wrote:
> It was seen that this flag seems to cause issues when in AP mode on
> brcmfmac devices (e.g. the raspberry Pi 3). When in AP mode an a
> scan is issued clients will disconnect. After testing this behavior
> was isolated to the use of the COLOCATED_6GHZ flag.
>
> Besides working around the problem on this specific hardware the
> patch itself makes sense as a non-6GHz capable device shouldn't use
> this flag anyways.
>
> As stated in the patch comment, this isn't really a catch all
> workaround since the flag is still used for devices supporting 6GHz.
> If additional hardware exhibits this behavior we may need additional
> changes like a hardware blacklist or an explicit option to disable
> the flag.
>
> Reported-By: Keith G <ys3al35l@gmail.com>

Could you double check it still fixes the issue you were seeing on brcmfmac?

Thanks,

James

> ---
>   src/scan.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/src/scan.c b/src/scan.c
> index f48ffdef..8c6fdc08 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -394,7 +394,20 @@ static struct l_genl_msg *scan_build_cmd(struct scan_context *sc,
>   	if (params->ap_scan)
>   		flags |= NL80211_SCAN_FLAG_AP;
>   
> -	flags |= NL80211_SCAN_FLAG_COLOCATED_6GHZ;
> +	/*
> +	 * TODO: This flag appears to cause some undesired behavior on brcmfmac
> +	 *       when the device is in AP mode, or has a secondary AP interface
> +	 *       running, causing clients to disconnect when a scan is issued.
> +	 *
> +	 *       Only using this flag for 6GHz capable devices will limit this
> +	 *       behavior to only 6GHz devices and in reality makes sense
> +	 *       because a non-6GHz device shouldn't use this flag anyways. If
> +	 *       more issues still are seen related to this we may need an
> +	 *       explicit workaround, either brcmfmac-specific or a disable
> +	 *       option.
> +	 */
> +	if (wiphy_band_is_disabled(sc->wiphy, BAND_FREQ_6_GHZ) != -ENOTSUP)
> +		flags |= NL80211_SCAN_FLAG_COLOCATED_6GHZ;
>   
>   	if (flags)
>   		l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, &flags);
