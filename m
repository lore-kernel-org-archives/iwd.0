Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA19E18E776
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127373; cv=none; b=QPfpH+VlTgSlMzkFt4lDIrCTns1r0vGjzZqwTVk9dQ1Rf+KjLsZg8AdSy9h3PiAmH+JkhMoKXYWMm3cgPMNUSK53cvoNPp/uHWHue+jQGTmjsKe86L/SR0P4cwu2e5IO9pj4Mv1Y7ULN0VUz0cn3uE+UBX5chS8NjDVAW4TjM+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127373; c=relaxed/simple;
	bh=w7+jfy/WFa0UHEu43rjut35uEPKQoMe1SKsQPREq5/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cX5aLl6fr/OS5DVfQl0Jt6akFwyCCUIJaOtmsnx3kL+WYFZdDQeAqNMbkCpeQwZW7Rc8dCfkvTMXgIvKtM5GsE/N7O45+eRtwfdnewHRAvT2vE6cBn+jqpxrvxfhiWMxDtJemQp//k3lLaWQwWn3lHPRrXIwaCb/qjYur7ABybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeHDaS2n; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeHDaS2n"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5c6661bca43so611433eaf.0
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723127370; x=1723732170; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=af+KniiSY7Wf3bXURqD5qUyZyTKgZMI3GVU60W72ayw=;
        b=KeHDaS2neQdR8Gq0uhPMJLYz2AMtvDB6OI8d//GMNGyDiRT6p+z8Esq8eedLfOoEIq
         h5NXQMMDwkg+9f+buRJSKHOT2qu2S8yC1f+pyw0sGo6dgHpeGwrt5GFR+rA8P1xZ9cFX
         +dqHNRRyluxkDWXihJd53EG0VLXN/SgJ2ibSmpG9UFMdS+xHDdpty5lEsRhPrInHBKY8
         ojBOQuQEjXCO/emOIn2+A9bjtIVCs5NIlVwyHKKHSSDLaeIk6/XxBZhS8PqpDVB5m46B
         9/GKGTWr4Wzw0a4Tm5048bou/YLMfM+YxjjgA5zZo5BSnxFQe4FPeh09XploUxp4n0df
         Dhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723127370; x=1723732170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=af+KniiSY7Wf3bXURqD5qUyZyTKgZMI3GVU60W72ayw=;
        b=chcD8O0gexd9zNucwU1TpxqIuQ1DEEVLcL4i5nPoulON0TQGKRap5WimpGpH3RhPB6
         W4NCHQGyF5odZOwN9hQVE2R9KkeP7eX4IdIlyf4xEmkRDRKCJcY/OM6EsQfMKRjy5Lpf
         Iac5QbCfnHUQYHWgnV8Z9APAypuz/8txv0POc2V2br7Pvi21f0aUj/FgDP/b36aIQkoI
         JMykuXfbj0WckgyuwkONy0xn+eYE9EUVseKKiYtB7Zj7YXuSPx6m2Ap8A694E3mhps/r
         rs5tieSD6g7RPd/a0JGuFOKYZpnvapmuvjsHf+xq+f7b7cp0gn2lSPo7no9WxJ7o+nhn
         r9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUILGBitXwY4Fyzl60t3zPt1bP8W+aLDPYgR95vx26/jSLKWST2bkmvQSFt5J70stfnOdBarXBvO0f6QtrsWC7z9FnB
X-Gm-Message-State: AOJu0YzL0BZeFjaWtla+Gkyl58oTPTz3dq/UIJbs9PqJANAgzHmn75pF
	oPhaOGnO1zLE6oMhIyDKcekomWT+yP8AH+tjy5Gmk/N0gQdyE6kEBzeRCw==
X-Google-Smtp-Source: AGHT+IHYaQegOb3WdXvJzR0308374XMRNFi0xcHXhwqK2xd1BcvUBOiucbJhLz4U0qjbugUvv3oheg==
X-Received: by 2002:a05:6870:a10f:b0:261:9fc:b8fb with SMTP id 586e51a60fabf-2692b8240f2mr2241726fac.46.1723127369730;
        Thu, 08 Aug 2024 07:29:29 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70a31eaf0c6sm5457421a34.17.2024.08.08.07.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 07:29:29 -0700 (PDT)
Message-ID: <fe42fb8d-b159-4988-924c-81cdfd2531df@gmail.com>
Date: Thu, 8 Aug 2024 09:29:28 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] station: use network_bss_list_prune
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240807181427.170515-1-prestwoj@gmail.com>
 <20240807181427.170515-2-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240807181427.170515-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/7/24 1:14 PM, James Prestwood wrote:
> Use this to clear only entires that were not found in the newest
> scan results.
> ---
>   src/station.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/station.c b/src/station.c
> index e373b03b..2c4d686b 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -943,7 +943,7 @@ void station_set_scan_results(struct station *station,
>   	l_queue_foreach_remove(new_bss_list, bss_free_if_ssid_not_utf8, NULL);
>   
>   	while ((network = l_queue_pop_head(station->networks_sorted)))
> -		network_bss_list_clear(network);
> +		network_bss_list_prune(network, new_bss_list);

You're sending the new list without vetting whether the SSID matches the 
network.  That will likely come to haunt you later.

>   
>   	l_queue_clear(station->hidden_bss_list_sorted, NULL);
>   
Regards,
-Denis
