Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45872585
	for <iwd@lists.linux.dev>; Thu,  4 Aug 2022 15:37:48 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id p132so23591379oif.9
        for <iwd@lists.linux.dev>; Thu, 04 Aug 2022 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=0J+Y82BogjT/xgni5KZxb1lhplbaS0hD9PWGEnAQFjU=;
        b=Vyfj7Rlz6z/c8e3h5DIocGdjoPn1aRg+/9nYHCquPvuQDXaYhSASggvD5VomKQZOAT
         mifVf1CXkxvQv77VrkakmtFiDU4hSEltf9KpNWXQohFYjlf997fvx3SPbl9hquCtN4h2
         mPkK+yKBk6rsmbZstjm1zcisHjNH1+GjoBqq+S6WFLXmmCT/5xv8OReqNHJBYJXxCeVi
         bdj6I3FjkGzhTdh+tVWvzneoKCHJV5nAW0qjeFZ0hVYJUsS+kkfn7b4R9GY7/S/kHKL1
         83e24GgLF/hwP55+B4w74F6X2cR0UlHKOBsioh70zW0GWicclj5szGb4kp6JPbReki8X
         GFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0J+Y82BogjT/xgni5KZxb1lhplbaS0hD9PWGEnAQFjU=;
        b=d2m1+oebC9q5PVQp1f2CV0MLADggFW+toDu4qf6x/Kfi2CraTBZTI/kHerTEFMP1UG
         F02fh9SVcduz8Kitb76y8xPpKVU1RuHQLwn4F4QZbUigfXzsJQB7h6deeMe6Sl4m1AJo
         Pv6chZda8kPGk9p4tO0zyat+vYm32mD3MgMPxlXOUSOBCtYXPxctXLjtVSWnWJrC4dsT
         2UTIBKkpELiipwA2mSVgmArRze5vTc+O9FnCWc0mpiuFckzys0PZxNO0xeomQYmThiFr
         TEJ7By814GLX4piyfxD5bCbAo4kRjQuyDtTOO7L3tat5WPEnvqNC4g4Dg9S2Jo5G4U+H
         CV9g==
X-Gm-Message-State: ACgBeo1lNQLUWic/uT5ZN0wDfUl4jwHLoMebf5paU784ezDsrl4TUcw7
	K3UfoO7eZeoYw0QtgexIubI=
X-Google-Smtp-Source: AA6agR6UzVU7fm+Zcw3IXDtT/3DKsz5uSha9G9g5q42p5jxLLOSh3ofSib+EV5GF6SsEisabcOcfRw==
X-Received: by 2002:aca:1e05:0:b0:33a:afcd:9bf0 with SMTP id m5-20020aca1e05000000b0033aafcd9bf0mr4043523oic.213.1659627467807;
        Thu, 04 Aug 2022 08:37:47 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t15-20020a056871054f00b001089aef1815sm168481oal.20.2022.08.04.08.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 08:37:47 -0700 (PDT)
Message-ID: <50dc2a0a-dc46-49b2-2bdf-bf079242579b@gmail.com>
Date: Thu, 4 Aug 2022 10:27:01 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 03/13] nl80211util: add
 nl80211_parse_supported_frequencies
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220803213644.277534-1-prestwoj@gmail.com>
 <20220803213644.277534-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220803213644.277534-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/3/22 16:36, James Prestwood wrote:
> A helper function to parse supported and disabled frequencies.
> ---
>   src/nl80211util.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   src/nl80211util.h |  4 ++++
>   2 files changed, 49 insertions(+)
> 

<snip>

> +int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
> +					struct scan_freq_set *supported_list,
> +					struct scan_freq_set *disabled_list)
> +{
> +	uint16_t type, len;
> +	const void *data;
> +	struct l_genl_attr attr;
> +	struct l_genl_attr nested;
> +
> +	if (!l_genl_attr_recurse(band_freqs, &nested))
> +		return -EBADMSG;
> +
> +	while (l_genl_attr_next(&nested, NULL, NULL, NULL)) {
> +		uint32_t freq = 0;
> +		bool disabled = false;
> +
> +		if (!l_genl_attr_recurse(&nested, &attr))
> +			continue;
> +
> +		while (l_genl_attr_next(&attr, &type, &len, &data)) {
> +

I squished this empty line when applying.

> +			switch (type) {
> +			case NL80211_FREQUENCY_ATTR_FREQ:
> +				freq = *((uint32_t *) data);
> +				break;
> +			case NL80211_FREQUENCY_ATTR_DISABLED:
> +				disabled = true;
> +				break;
> +			}
> +		}
> +

Patches 1-5 applied, thanks.

Regards,
-Denis
