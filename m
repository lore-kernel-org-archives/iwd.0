Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30557365
	for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLbArp+R"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d31f3e8ca8so854271a34.0
        for <iwd@lists.linux.dev>; Thu, 09 Nov 2023 18:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699583949; x=1700188749; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31U21mqW2P5eN7+B26kmJLED3qcXhs7i6ThOrA8lFmU=;
        b=gLbArp+RVfheVBXw4+l4q5c/aOJbCpVE06XkQ3ENVxnUeUXCfK0g/rtc9F0zHgKZ2L
         zSGFr6fFBFrzuJ4t3t6zHIkQROQu6SFI9sXk8U7kN7qUeRgITJ+90hUITy/RoDTuXMG1
         rZeKQ1oXDsYvnN5HlHpUS34uSQmYYS36Jm61kM0/2//BJTQV1ZTCJZh+pwDC3qD4Yjon
         HM5Pe4Gu2RY+r9ICB8Gak2+J1JxxKY++4JzH5zUDMTmGpWqCu8HWloeuk92EnXtsHzgF
         Z6dkwIlSUomIA+/rfyBCpRooTVOjX1zXDSXS2WL4jQLVbxF49uimbh+rH3KBF+0ZHtVV
         LcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699583949; x=1700188749;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31U21mqW2P5eN7+B26kmJLED3qcXhs7i6ThOrA8lFmU=;
        b=u/CWLlq7Gu04E7YZLJJkmXCzFL5BrKJDN2y5BKo913+YkO9zNhi3KlN3F8CQVXvbrx
         6LEm8w1uj2MiWjkyaSlWuzEjQI9Jde0WGnyJxyH3orqizHMp5ckhJKvkE7M2gbbVyfWB
         h1lmS7me0SPYMQa8GzL2bYQmwMU+WGNWXViq2B9YRZ0Q2vHxhqBP2eDwuwtaepr5+taz
         io0K+co0dM4QrwzZlRIq2fsjipZMdvzdFTaKv+3HrxVv9aWOfb4jO8Y3eWn+xmY/4ucx
         c62SLjP91FiP5OsU/P0xsUGfF6vM3bg4MLn4ij2RbMgyS6vfHfX8KRiapsbwkS8bRSqB
         9qZw==
X-Gm-Message-State: AOJu0Yw49lYPFicCGCGTEzucWdV8aKl2VxeeswNkehcmmPFFAt7kzNTX
	DADfHoLhSirPp5ky/qzRgMQ=
X-Google-Smtp-Source: AGHT+IHxfnHDLd+TPEBHaQZaTZkjtMMXLxi6FN+bkDSEQzpA1rKAR19oJ4axHX+onEEtVwuQeJGJAw==
X-Received: by 2002:a9d:7606:0:b0:6b7:4a52:a33a with SMTP id k6-20020a9d7606000000b006b74a52a33amr6604877otl.14.1699583949116;
        Thu, 09 Nov 2023 18:39:09 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id dc11-20020a0568306b4b00b006b8b55297b5sm2471741otb.42.2023.11.09.18.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 18:39:08 -0800 (PST)
Message-ID: <68c1a1eb-02ea-44c7-8286-8f60f5a415b9@gmail.com>
Date: Thu, 9 Nov 2023 20:39:07 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dpp: scan to pick up extra frequencies when enrolling
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231109195720.56352-1-prestwoj@gmail.com>
 <20231109195720.56352-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231109195720.56352-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/9/23 13:57, James Prestwood wrote:
> The DPP-PKEX spec provides a very limited list of frequencies used
> to discover configurators, only 3 on 2.4 and 5GHz bands. Since
> configurators (at least in IWD's implementation) are only allowed
> on the current operating frequency its very unlikely an enrollee
> will find a configurator on these frequencies out of the entire
> spectrum.
> 
> The spec does mention that the 3 default frequencies should be used
> "In lieu of specific channel information obtained in a manner outside
> the scope of this specification, ...". This allows the implementation
> some flexibility in using a broader range of frequencies.
> 
> To increase the chances of finding a configurator shared code
> enrollees will first issue a scan to determine what access points are
> around, then iterate these frequencies. This is especially helpful
> when the configurators are IWD-based since we know that they'll be
> on the same channels as the APs in the area.
> ---
>   src/dpp.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 93 insertions(+)
> 

Ok, sounds good to me.

> @@ -3994,10 +4008,64 @@ static uint32_t *dpp_default_freqs(struct dpp_sm *dpp, size_t *out_len)
>   	return freqs_out;
>   }
>   
> +static bool dpp_pkex_scan_notify(int err, struct l_queue *bss_list,
> +					const struct scan_freq_set *freqs,
> +					void *user_data)
> +{
> +	struct dpp_sm *dpp = user_data;
> +	const struct l_queue_entry *e;
> +	_auto_(scan_freq_set_free) struct scan_freq_set *freq_set = NULL;
> +
> +	if (err < 0) {
> +		dpp_reset(dpp);
> +		return false;
> +	}
> +
> +	freq_set = scan_freq_set_new();
> +
> +	if (!bss_list || l_queue_isempty(bss_list)) {
> +		dpp->freqs = dpp_default_freqs(dpp, &dpp->freqs_len);

This can return NULL.

> +
> +		l_debug("No BSS's seen, using default frequency list");
> +		goto start;
> +	}
> +
> +	for (e = l_queue_get_entries(bss_list); e; e = e->next) {
> +		const struct scan_bss *bss = e->data;
> +
> +		scan_freq_set_add(freq_set, bss->frequency);
> +	}
> +
> +	l_debug("Found %u frequencies to search for configurator",
> +			l_queue_length(bss_list));
> +
> +	dpp->freqs = scan_freq_set_to_fixed_array(freq_set, &dpp->freqs_len);
> +
> +start:
> +	dpp->current_freq = dpp->freqs[0];

So you'd crash here.

> +
> +	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
> +
> +	l_debug("PKEX start enrollee (id=%s)", dpp->pkex_id ?: "unset");
> +
> +	dpp_start_offchannel(dpp, dpp->current_freq);
> +
> +	return false;
> +}
> +

Regards,
-Denis

