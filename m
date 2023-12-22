Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6832EAFA
	for <iwd@lists.linux.dev>; Fri, 22 Dec 2023 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNgYGARZ"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35fd8662acaso4653315ab.0
        for <iwd@lists.linux.dev>; Fri, 22 Dec 2023 14:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703283223; x=1703888023; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKkhbTqV//67XQnB/nFltHhTR++aMCeHT+QCLe7HIM4=;
        b=fNgYGARZ8tolAD28mTpCWpkf6XVJqdXAeicQgBW39+ex/19pqXlhrh5qk9sncvG/Fr
         l6d3nLpr1FTiVxAWZCJjjgsbwks7Fl/kiy0zP7LU+r0AxBPx0LYVfjd+nMuVwBCoGKiO
         TObVwlwI6eX2W8YnWATjdtRzMvExF6grXaFt/R0CqyaFeXaY1iuA5NbxjbxCSXBYDhbh
         0Nqdy8R4QKZq96p4ozIgBnnD8wCCZ7B+3V8qmJP45gwoeYmA4iklBLQguQG/7o65swGC
         SpfuE02MmWQTcMhhdOxX6Qbd+XsR9CrwwLwGmPiLwBrweKY9AVXabyOyK452wAfVpyaM
         mnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703283223; x=1703888023;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKkhbTqV//67XQnB/nFltHhTR++aMCeHT+QCLe7HIM4=;
        b=ifzdR2clLiN3Zj+nUbagnoSIuDswt6QfFhIy8CUBA/ZPtc3kzItGaS2UdQ0MTIX8QA
         1+JREePxRKaB67u9HR5W+kffxISjBZ/UUUA5IwAScMlFTr5diqBXcwhjmV8Mu8BwDblI
         ey2hrKUqYslsensJLagKXSbVgbDOvjJozhTPZ9VosNxnuvyni5UUfHv7sN5bcyht28uS
         6B/78hn50Bs2peQnge3HLYhqoEJg/BcShUMbijNgVFoAmcpuWX3AqqTtSpZa5qx0PKdf
         rujeWIQflbCii1ckzrLRGcqTKAsnJDhnPPDRRt5vj7pINbIvzDYjc4bVmOWF0vIBB2vn
         J5XQ==
X-Gm-Message-State: AOJu0Yxwbvsy++JgJuMxmJpMymPeUE5J9aALokb6nOEAee9WNZbZQ3o0
	rJz1TQbymO4UCeJpC95FCAFOmQY6bMc=
X-Google-Smtp-Source: AGHT+IHp6pDRm9eBEXUV/6aF5unAYYqZfkd+madQ2f0USUjO80OUkcT6Fn9w3ZwmzFbSsucFjE9+Sw==
X-Received: by 2002:a05:6e02:16c6:b0:35f:c7e8:fa73 with SMTP id 6-20020a056e0216c600b0035fc7e8fa73mr1439334ilx.14.1703283222840;
        Fri, 22 Dec 2023 14:13:42 -0800 (PST)
Received: from [172.16.49.130] ([136.33.23.24])
        by smtp.googlemail.com with ESMTPSA id bs17-20020a056e02241100b0035aeaed5112sm1352547ilb.84.2023.12.22.14.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 14:13:42 -0800 (PST)
Message-ID: <34a92d63-b37f-4f37-a29b-9e632bb94d5a@gmail.com>
Date: Fri, 22 Dec 2023 16:13:41 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] knownnetworks: add
 known_network_add_connected_frequency
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231220131200.267489-1-prestwoj@gmail.com>
 <20231220131200.267489-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231220131200.267489-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/20/23 07:11, James Prestwood wrote:
> This should be called when BSS is connected/roamed to which will
> insert the frequency ahead of entries which were only seen in scan
> results.
> 
> Providing this and the 'seen' variant sets up the frequency list
> into two adjacent sections:
>    [Most recently used]...[Most recently seen]
> 

So why not just keep two lists?

> Doing this will allow scanning to be more optimized and limit the
> number of frequencies while prefering BSS's that have been connected
> to prior.
> 
> Note that this list format is not synced to the file system.
> Frequencies will be synced in the order of this list but not
> containing the 'connected' bit. When IWD restarts this information
> will be lost, but the list is still sorted on disk in a better state
> than it was prior.
> ---
>   src/knownnetworks.c | 59 ++++++++++++++++++++++++++++++++++++++++++++-
>   src/knownnetworks.h |  3 +++
>   2 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/src/knownnetworks.c b/src/knownnetworks.c
> index eac6c66b..e44109fd 100644
> --- a/src/knownnetworks.c
> +++ b/src/knownnetworks.c
> @@ -562,15 +562,70 @@ static bool known_frequency_match(const void *a, const void *b)
>   	return known_freq->frequency == *frequency;
>   }
>   
> +static int known_frequency_compare(const void *a, const void *b,
> +					void *user_data)
> +{
> +	const struct known_frequency *ka = a;
> +
> +	/*
> +	 * Only meant to be used to insert 'seen' frequencies. Any existing
> +	 * entry that has 'connected' set should preceed an entry that was

precede?

> +	 * only seen.
> +	 */
> +	if (ka->connected)
> +		return -1; > +
> +	/*
> +	 * Otherwise, insert immediately after the last 'connected' entry,
> +	 * i.e. the most recently seen
> +	 */
> +	return 1;
> +}
> +
>   /*
>    * Adds a frequency to the 'known' set of frequencies that this network
> - * operates on.  The list is sorted according to most-recently seen
> + * operates on. Frequencies added here will follow frequencies which have been
> + * connected to and inserted according to most-recently seen
>    */
>   int known_network_add_seen_frequency(struct network_info *info,
>   					uint32_t frequency)
>   {
>   	struct known_frequency *known_freq;
>   
> +	if (!info->known_frequencies)
> +		info->known_frequencies = l_queue_new();
> +

I'm not thrilled about the implementation...

> +	known_freq = l_queue_find(info->known_frequencies,
> +					known_frequency_match, &frequency);

You walk the entire queue once, then walk it again to remove the known_freq 
object, then walk it one more time for the insert.

> +	/*
> +	 * If no match, create a new one.
> +	 * If connected to frequency before leave that entry in place
> +	 */
> +	if (!known_freq) {
> +		known_freq = l_new(struct known_frequency, 1);
> +		known_freq->frequency = frequency;
> +	} else if (known_freq->connected)
> +		return 0;

So 'seeing' a frequency that has been connected to before doesn't change its 
sort order?

> +
> +	l_queue_remove(info->known_frequencies, known_freq);
> +
> +	/* insert the entry immediately after the last 'connected' entry */
> +	l_queue_insert(info->known_frequencies, known_freq,
> +			known_frequency_compare, NULL);
> +
> +	return 0;
> +}
> +
> +/*
> + * Adds a frequency to the known set of frequencies that this network operates
> + * on. Frequencies added here are assumed to be most recently used and inserted
> + * at the head of the queue.
> + */
> +int known_network_add_connected_frequency(struct network_info *info,
> +						uint32_t frequency)
> +{
> +	struct known_frequency *known_freq;
> +
>   	if (!info->known_frequencies)
>   		info->known_frequencies = l_queue_new();
>   
> @@ -581,6 +636,8 @@ int known_network_add_seen_frequency(struct network_info *info,
>   		known_freq->frequency = frequency;
>   	}
>   
> +	known_freq->connected = true;
> +
>   	l_queue_push_head(info->known_frequencies, known_freq);
>   
>   	return 0;

Overall I'm getting the feeling that the linked-list is the wrong data structure 
for all this.  If the intent is to maintain a bounded shortlist of frequencies 
to scan for a given network, then that's what we should do instead.

Regards,
-Denis
