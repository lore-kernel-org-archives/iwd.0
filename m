Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B5C28DC6
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW0+M0IH"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59446cd46e9so337344eaf.3
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 10:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704392273; x=1704997073; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cM6lU3G3LLqObeDYv8sVUQxoFzIwECJGUprFViuY72w=;
        b=aW0+M0IH7TbfsMezsI/3aAvPKEFsoI+LT7t3zFoLCRIEIv2YlFDpzi/s7bB0GtI+5R
         NLn691Jd+9Et7HdYbn39nkx5yiQnMVXA66kBDDo3fvS4qZGrRMAZmPoeR5J/dVYEe6Ju
         PIU8iCMxGmmPsSLLGkM0yU0Co1pVQTkBpQFWJjySJVKerWEyZdFkBZrdrqBrxAn0D7VE
         WlFY8CbhIyX3TwNnisEd/yUI50nv+4sjAypfP4oYDQJa+axJoeSHlZTAm4/PuIFEWLFk
         UHbYzwxJcMXnfAp+PEqqmTgxpvAMpeV4B6Djcb1QY41Hf4rLPzVD2PdXr9ISaRspVW0y
         ZaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704392273; x=1704997073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cM6lU3G3LLqObeDYv8sVUQxoFzIwECJGUprFViuY72w=;
        b=jak4vS7EvMhYRRBIyKSkqcvaxXHwrHa0xPfIxl6hX99i4D6MlF2swsVIpn3bQaZIVe
         JvA9az4Bj1x1UGxIttAWtghxczxnS/mioPWyCIuoqTtWmQ7aNAbrvPDSeYbEeW5SDmdx
         HHSIm+z++oSgqP+WY4RZA/VmTrsOaAqMpRWsLq82OW9w/Dbr7UPEVAQavEayMPRtQkAG
         SXR/0PcNz9Duqq+o7B91nluO0ZVbbzeRc1Wi4osugNRD95/sBi9QoygQIaWKs+fdSjd+
         gx0o7IfnakDnQwKhhSumPhAZOhriWKoDsXg9I9CxP9C+T8rT00BKFe8Msh3R232VQdFF
         4IPQ==
X-Gm-Message-State: AOJu0YxyyvY6QX7iK5uowhIPeuyfUdv4xxcW3aLMVx3fSHcEZAfEwy/q
	2e3WOnk+7rETUNQ72nKw5hHGE+V7qO8=
X-Google-Smtp-Source: AGHT+IHxnMdjxErYW1GvxOd2ThyMuper7VQDvuOP9gBMe5mJZnUym7+1tJnozlwyMGhHTcK0H3F5QQ==
X-Received: by 2002:a4a:9893:0:b0:596:312b:6950 with SMTP id a19-20020a4a9893000000b00596312b6950mr145917ooj.5.1704392273131;
        Thu, 04 Jan 2024 10:17:53 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id o185-20020a4a44c2000000b005954c783f46sm2188877ooa.20.2024.01.04.10.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 10:17:52 -0800 (PST)
Message-ID: <4dcbc730-034a-4e3d-afb6-992cbc03a8ac@gmail.com>
Date: Thu, 4 Jan 2024 12:17:51 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scan: limit COLOCATED_6GHZ flag to 6ghz devices
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Cc: Keith G <ys3al35l@gmail.com>
References: <20240103125638.243820-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240103125638.243820-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/3/24 06:56, James Prestwood wrote:
> It was seen that this flag seems to cause issues when in AP mode on
> brcmfmac devices (e.g. the raspberry Pi 3). When in AP mode an a

Seriously?  Why would this flag do anything for non-6E devices?

> scan is issued clients will disconnect. After testing this behavior
> was isolated to the use of the COLOCATED_6GHZ flag.
> 
> Besides working around the problem on this specific hardware the
> patch itself makes sense as a non-6GHz capable device shouldn't use
> this flag anyways.

I guess if you're super paranoid and don't trust the kernel to do the right thing...

> 
> As stated in the patch comment, this isn't really a catch all
> workaround since the flag is still used for devices supporting 6GHz.
> If additional hardware exhibits this behavior we may need additional
> changes like a hardware blacklist or an explicit option to disable
> the flag.
> 
> Reported-By: Keith G <ys3al35l@gmail.com>
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

I'd just drop this comment entirely if you still think this is needed.

> +	if (wiphy_band_is_disabled(sc->wiphy, BAND_FREQ_6_GHZ) != -ENOTSUP)
> +		flags |= NL80211_SCAN_FLAG_COLOCATED_6GHZ;
>   
>   	if (flags)
>   		l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, &flags);

Regards,
-Denis
