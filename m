Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE912AAED
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120489; cv=none; b=MyWgEHibZvrrdoJC0i5C7iQkJRL7eZJKg0LDkCO75OZplItJwv58BTRn2JRAZDEIUk6Ehrt8oMVzZKpYcVZKQ5QsoNE4LuQ50djLH2acZy01yr18aaj591QCwymo8gTP4NaafSuU7pU2u0f0KpV9bMVFSgbozS1aNDte5WTg900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120489; c=relaxed/simple;
	bh=h33rBbAoWwxJIcf2/Tu1HZ7aZDInC9JXAAmf5G7Onfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E4rrk478SYHxlmIjp8Ivmh3XaoyxNCmxD51ob1C/LrorJhxX+WVg/LjEvVbUdHzGy6c3VHAlUfm8Kom9lUQgUduGcFhMsgdcF3hcqGAOloAzls347qfhvr8OYCZ8hQGn7SWc4rPy+hpHqqhUKnsA46yLaoz/1/9qvDoGe5nD2xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7HSZ6yl; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7HSZ6yl"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5999f3f6ce9so1777138eaf.0
        for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 10:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706120487; x=1706725287; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YC2zjdExBgCvUK024A+n3DFZNO5s4XO2aR5qjhDDUxE=;
        b=H7HSZ6ylZuGmp5TbSEh+g74qXUfVxcor0yow6IdvqzTdHROBey/cJpHeJMXsBAO7eh
         Q42nc9UCtBoOsqui49LyFfr2SIAdQTLe4YFvGTzdxYvJ0iBxpGkeUCql8DYgCj4YFLHP
         5Poa8ITUUcn3YiYA3Ip6tVYFninhJ4g+V+EfLUkFUPmNL1Cp3BtQk2GTEODLG/X729yo
         xMReS2w4rWQWf7MEGLryoNp612ghsVjpjMbRviDmY6rMKbMKRk6VnPS56knLzXTrq/Z1
         fJsKuUeAw3IBzH6GC334JWx+NiCXjTrODykWnZIh3rYbWQfPt/eeTpubuKTHKJIsga3m
         FHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120487; x=1706725287;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YC2zjdExBgCvUK024A+n3DFZNO5s4XO2aR5qjhDDUxE=;
        b=JqgZgvlkONoNqP/4JnJLIaZzK/8ZQ1UHOlRwegA03u8b38ig6xbajyFEq3JT7FiZ+P
         F6o8J5xEkLaml8gXBky+ajVxxRadZ/Hd3Z77YgWAgyzxKHYZ1s0VPF4xxe7sr+zcqQux
         moBnc/4ncfl4Hk6dg65y/Q6mXY07mucUhz1hrFpVxZ7ncJlAO7G9GwKXjupOuK26zj/m
         nAu6BG5+UQBe5G9x6YnWnE4S+zi8RRRQ3wci67bVCfZzKknxAy19sSshCy71oLno6+s4
         DOf7faDAT7dkp2FI5CegIUY72DrDbaXxCL4clHpEtXoaWSDTypvy82/uxsH/w6QsHoUc
         zvFw==
X-Gm-Message-State: AOJu0YymO66GWw9PvEzuhzGYRVLgrcssNpXE/H3WUazyAWfHFDJQc++A
	BJcua54BbK/cEkdw0OPpi+NW1bSyjt0WBURz/TvmxB3heI0Su1hs
X-Google-Smtp-Source: AGHT+IGtyF4BtopWHVuVZ9t0aRfL3HRmTXRDzP7BGc4x/9fuEifCk8kDQt7BPriOO+inOKwYIfdjbQ==
X-Received: by 2002:a4a:de0f:0:b0:599:6199:eecb with SMTP id y15-20020a4ade0f000000b005996199eecbmr1790293oot.14.1706120486874;
        Wed, 24 Jan 2024 10:21:26 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h5-20020a4aa285000000b0059610f4de98sm62110ool.41.2024.01.24.10.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 10:21:26 -0800 (PST)
Message-ID: <36a3aa8a-ac08-44e7-91f7-73e094e69552@gmail.com>
Date: Wed, 24 Jan 2024 12:21:25 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] station: knownnetworks: limit quick scans to 5
 freqs per network
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240124134001.20453-1-prestwoj@gmail.com>
 <20240124134001.20453-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240124134001.20453-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/24/24 07:40, James Prestwood wrote:
> In very large network deployments there could be a vast amount of APs
> which could create a large known frequency list after some time once
> all the APs are seen in scan results. This then increases the quick
> scan time significantly, in the very worst case (but unlikely) just
> as long as a full scan.
> 
> To help with this support in knownnetworks was added to limit the
> number of frequencies per network. Station will now only get 5
> recent frequencies per network making the maximum frequencies 25
> in the worst case (~2.5s scan).
> 
> The magic values are now defines, and the recent roam frequencies
> was also changed to use this define as well.

Yep, I like it.

> ---
>   src/knownnetworks.c |  9 ++++++---
>   src/knownnetworks.h |  3 ++-
>   src/station.c       | 10 ++++++++--
>   3 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/src/knownnetworks.c b/src/knownnetworks.c
> index 6e549e02..fe0fce09 100644
> --- a/src/knownnetworks.c
> +++ b/src/knownnetworks.c
> @@ -518,7 +518,8 @@ struct network_info *known_networks_find(const char *ssid,
>   }
>   
>   struct scan_freq_set *known_networks_get_recent_frequencies(
> -						uint8_t num_networks_tosearch)
> +						uint8_t num_networks_tosearch,
> +						uint8_t freqs_per_network)
>   {
>   	/*
>   	 * This search function assumes that the known networks are always
> @@ -530,7 +531,7 @@ struct scan_freq_set *known_networks_get_recent_frequencies(
>   	const struct l_queue_entry *freq_entry;
>   	struct scan_freq_set *set;
>   
> -	if (!num_networks_tosearch)
> +	if (!num_networks_tosearch || !freqs_per_network)
>   		return NULL;
>   
>   	set = scan_freq_set_new();
> @@ -540,10 +541,12 @@ struct scan_freq_set *known_networks_get_recent_frequencies(
>   				network_entry = network_entry->next,
>   						num_networks_tosearch--) {
>   		const struct network_info *network = network_entry->data;
> +		uint8_t freqs_found = 0;
>   
>   		for (freq_entry = l_queue_get_entries(
>   						network->known_frequencies);
> -				freq_entry; freq_entry = freq_entry->next) {
> +				freq_entry && freqs_found < freqs_per_network;
> +				freq_entry = freq_entry->next, freqs_found++) {

This is getting a bit unreadable.  Maybe a while loop makes this look better?

freq_entry = l_queue_get_entries();

while (freq_entry && freqs_found < freq_per_network) {
	...
	freqs_found += 1;
	freq_entry = freq_entry->next;
}

>   			const struct known_frequency *known_freq =
>   							freq_entry->data;
>   

Regards,
-Denis

