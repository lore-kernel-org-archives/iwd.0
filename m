Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053030CEA
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJqn9Q4A"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso443760fac.3
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 07:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700147944; x=1700752744; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ArS26YBkJjtF56HtuHOh7yORZlC0Hp8Gnv35JrulLLo=;
        b=gJqn9Q4AXIs5UlBVkeHKPziPdITht69yv8m6HAqVlBRVnT+UwrPLwa/lZ1W/0oMVsv
         ep8Krn6bn6yn48bAQ1HgRvAuDDcIP5SmNlfX/iEegmGZoHQKKEzXe4FJAZaoc2Nm/txB
         pNlukCgK1aRUOk8ad4zIDz5Cm/wTqyCvEp0d4c8IxSZzlR7YkQLVZMkTnkLIY8GpKli3
         93K9MIWJlkVtKc751V+JpfocT6x11AK62HreqAKIsfqootHJcafhZfU2qsw9ZGlqllSl
         qi+WvS7swmYR81vQbBL6uWN49AWdKYXzLAtktq2A/jeswBIPXtnvtd4tJQomHoLAfDl4
         eXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700147944; x=1700752744;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArS26YBkJjtF56HtuHOh7yORZlC0Hp8Gnv35JrulLLo=;
        b=thwdNZgrIGi6T3Kcm/oPDHw2+1rDQESZBWmlxlU2zIkRGpbz5cJSSP6wp7uyqfrILv
         KBjbNQEBAUdhPYKSa84U88t4ClaZLCrkTxuLolQcnkJoMFzbey1fj+q8rPHsCAfGFLk8
         g7nv1Flz6YwKcKKU2RAk43oVavY4fcOggO1VpuxDUcMsLj4eLFLB51et+HffY/IWz27W
         RCrG5IiqFvgWx7wb6OqGRj5zGk3iQpZAgjN9BFf3MoENRwzqxTIaPxkPBy+ZEJfCvpuW
         c1oU8ONOt0wFx6/HeCCCN7kkFHajOmjNaPESHkgQsj+zugc6t8ruwdjAIHlFRxNVd43k
         qMxQ==
X-Gm-Message-State: AOJu0Yy0zswyq+t3O1pg1fVs+IpvodSWUcoCf/JsVRH8A+HirOF8C5Cv
	2ylRja5JgWnKLSGO7A9niCR3Ir3rWx4=
X-Google-Smtp-Source: AGHT+IF0SSAfH5idaIG+vUjibL+uYZvILgLY4DHs4rdbRjKK3u1NmZjfdAy1KAna79d4e7HpLbFWwQ==
X-Received: by 2002:a05:6870:d07:b0:1ef:b16f:d294 with SMTP id mk7-20020a0568700d0700b001efb16fd294mr19497861oab.38.1700147943785;
        Thu, 16 Nov 2023 07:19:03 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y22-20020a056870725600b001ea4324364csm2168799oaf.12.2023.11.16.07.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 07:19:03 -0800 (PST)
Message-ID: <805ef134-6b99-4f5e-aad8-be5cff7de444@gmail.com>
Date: Thu, 16 Nov 2023 09:18:58 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] dpp: fix fragile scan/connecting logic
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231113175401.343239-1-prestwoj@gmail.com>
 <20231113175401.343239-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231113175401.343239-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/13/23 11:54, James Prestwood wrote:
> The post-DPP connection was never done quite right due to station's
> state being unknown. The state is now tracked in DPP by a previous
> patch but the scan path in DPP is still wrong.
> 
> It relies on station autoconnect logic which has the potential to
> connect to a different network than what was configured with DPP.
> Its unlikely but still could happen in theory. In addition the scan
> was not selectively filtering results by the SSID that DPP
> configured.
> 
> This fixes the above problems by first filtering the scan by the
> SSID. Then setting the scan results into station without triggering
> autoconnect. And finally using network_autoconnect() directly
> instead of relying on station to choose the SSID.
> ---
>   src/dpp.c | 44 +++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 41 insertions(+), 3 deletions(-)
> 

All 4 applied, but one comment:

> diff --git a/src/dpp.c b/src/dpp.c
> index 06ae2929..a95f93e2 100644
> --- a/src/dpp.c
> +++ b/src/dpp.c
> @@ -853,13 +853,42 @@ static bool dpp_scan_results(int err, struct l_queue *bss_list,
>   {
>   	struct dpp_sm *dpp = userdata;
>   	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
> +	struct scan_bss *bss;
> +	char ssid[33];
> +	struct network *network;
>   
>   	if (err < 0)
> -		return false;
> +		goto reset;
> +
> +	if (!bss_list || l_queue_length(bss_list) == 0)
> +		goto reset;
> +
> +	/*
> +	 * The station watch _should_ detect this and reset, which cancels the
> +	 * scan. But just in case...
> +	 */
> +	if (L_WARN_ON(station_get_connected_network(station)))
> +		goto reset;
> +
> +	/* Purely for grabbing the SSID */
> +	bss = l_queue_peek_head(bss_list);
>   
> -	station_set_scan_results(station, bss_list, freqs, true);
> +	memcpy(ssid, bss->ssid, bss->ssid_len);
> +	ssid[bss->ssid_len] = '\0';

Are you sure this SSID is UTF8? station_set_scan_results will filter any SSIDs 
that are not.

> +
> +	station_set_scan_results(station, bss_list, freqs, false);
> +
> +	network = station_network_find(station, ssid, SECURITY_PSK);

And so this can fail.

> +
> +	dpp_reset(dpp);
> +
> +	bss = network_bss_select(network, true);
> +	network_autoconnect(network, bss);
>   
>   	return true;
> +
> +reset:
> +	return false;
>   }
>   
>   static void dpp_scan_destroy(void *userdata)

Regards,
-Denis

