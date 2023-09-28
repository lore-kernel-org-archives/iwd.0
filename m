Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56D746A
	for <iwd@lists.linux.dev>; Thu, 28 Sep 2023 11:35:45 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3add37de892so6424156b6e.1
        for <iwd@lists.linux.dev>; Thu, 28 Sep 2023 04:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695900945; x=1696505745; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2ZNtGeEiWX1ooz6enRepfPYFSc8wg+9O341+0K9eEs=;
        b=OX2qGCCiksrlkDFxICxcVA9YVYPNt19urspOeALDeBh89ekqfmQPFtfOdrJUxkw0ck
         ToNHzuyUr3kZEFUAk/gHEDyzu1cIuis16wrh6zs1JXQeT2sx2H0Kf+grliQI0g+KLCps
         9oN6f1kfBhofkxjkX+yQGjryVIP9hINZrMCOP72HpJ93jBIPd+Jx+Kny1/IpzLUdCHg6
         Kdp2bdNT10pAwnfWzj7cUuX+KmGrMbV8Ue2XdYAS/pWqn+og2yvxklvXhLgLdl+zXqmC
         WXkMSghujEkNnAQtcIKUjUk3xkfnBnJC6Rh7ViQbFlr9yQs/iIjv7iOCAOlqKPCnnV4K
         EixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695900945; x=1696505745;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2ZNtGeEiWX1ooz6enRepfPYFSc8wg+9O341+0K9eEs=;
        b=Avx97G9EsadEiDZRlKAAjx9NEpT3j4BLyE2w75oB4X/dYPbhbElN+7FyVlAgtRHSRO
         iGVq5gD+JoAPjPakvE91LsRXJgns1rmHhTZzQQdjOgMArPifhX2w0/JvgJoEqymai9ZJ
         5MWM9k3dUL/FV7kmwO3sWgAqxqb40r0FZQohpHI3hfPXC+sciiYFOvs8XygxgKneI9VE
         TYTubyxQe6pfh50YYopo4+vkhNMi77/Dv8VFSmDXgAaCzq2h/g/pEOyjLYVPertwbKbQ
         3JUWDSazeIqrGoL2sKHUlurYxs3687qwlgFblIsH8x/V26odwWQPSXtHpI+vnUWiJjkC
         MLcQ==
X-Gm-Message-State: AOJu0YwbVy7is5+14SU9FxBpoWryDuMI1tKZoxDkA8e6cC35yS2Tz/SY
	l5THC5Ekvd9pAtTJhatOdfZKDpOr1VY=
X-Google-Smtp-Source: AGHT+IFYAltaLqgyGakNl4NisY4T8IEe5kIzZM3FVGFOU2+li5BWdDJQxIKQ840n9BTP/PjaogUv6Q==
X-Received: by 2002:a05:6808:a8a:b0:3a9:bc8d:42ed with SMTP id q10-20020a0568080a8a00b003a9bc8d42edmr822637oij.43.1695900944550;
        Thu, 28 Sep 2023 04:35:44 -0700 (PDT)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id i17-20020aa78b51000000b0066a4e561beesm13708982pfd.173.2023.09.28.04.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 04:35:44 -0700 (PDT)
Message-ID: <46e482ed-e650-4d0b-9b92-8ee27616ed0c@gmail.com>
Date: Thu, 28 Sep 2023 04:35:43 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] station: support user-disabled bands
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230925185422.2242494-1-prestwoj@gmail.com>
 <20230925185422.2242494-7-prestwoj@gmail.com>
 <5c617a95-af44-5c20-a111-77b15d3a6439@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <5c617a95-af44-5c20-a111-77b15d3a6439@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 9/27/23 1:49 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 9/25/23 13:54, James Prestwood wrote:
>> This adds support to allow users to disable entire bands, preventing
>> scanning and connecting on those frequencies. If the
>> [Rank].BandModifier* options are set to 0.0 it will imply those
>> bands should not be used for scanning, connecting or roaming. This
>> now applies to autoconnect, quick, hidden, roam, and dbus scans.
>>
>> This is a station only feature meaning other modules like RRM, DPP,
>> WSC or P2P may still utilize those bands. Trying to limit bands in
>> those modules may sometimes conflict with the spec which is why it
>> was not added there. In addition modules like DPP/WSC are only used
>> in limited capacity for connecting so there is little benefit gained
>> to disallowing those bands.
>> ---
>>   src/station.c | 134 +++++++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 110 insertions(+), 24 deletions(-)
>>
> 
> <snip>
> 
>> @@ -1326,6 +1329,20 @@ static bool 
>> station_needs_hidden_network_scan(struct station *station)
>>       return !l_queue_isempty(station->hidden_bss_list_sorted);
>>   }
>> +static struct scan_freq_set *station_get_allowed_freqs(struct station 
>> *station)
>> +{
>> +    uint32_t band_mask = 0;
>> +
>> +    if (!band_2_4ghz_disabled)
>> +        band_mask |= BAND_FREQ_2_4_GHZ;
>> +    if (!band_5ghz_disabled)
>> +        band_mask |= BAND_FREQ_5_GHZ;
>> +    if (!band_6ghz_disabled)
>> +        band_mask |= BAND_FREQ_6_GHZ;
> 
> You might as well compute the band_mask in station_init directly.
> 
>> +
>> +    return wiphy_get_allowed_freqs(station->wiphy, band_mask);
> 
> Same question here as the previous patch, should this be supported 
> instead of allowed?
> 
>> +}
>> +
>>   static uint32_t station_scan_trigger(struct station *station,
>>                       struct scan_freq_set *freqs,
>>                       scan_trigger_func_t triggered,
>> @@ -1411,6 +1428,7 @@ static void station_quick_scan_destroy(void 
>> *userdata)
>>   static int station_quick_scan_trigger(struct station *station)
>>   {
>>       _auto_(scan_freq_set_free) struct scan_freq_set *known_freq_set 
>> = NULL;
>> +    _auto_(scan_freq_set_free) struct scan_freq_set *allowed = NULL;
>>       bool known_6ghz;
>>       if (wiphy_regdom_is_updating(station->wiphy)) {
>> @@ -1440,9 +1458,14 @@ static int station_quick_scan_trigger(struct 
>> station *station)
>>               known_6ghz)
>>           return -ENOTSUP;
>> -    if (!wiphy_constrain_freq_set(station->wiphy, known_freq_set)) {
>> +    allowed = station_get_allowed_freqs(station);
>> +    if (L_WARN_ON(!allowed))
>> +        return -ENOTSUP;
>> +
>> +    scan_freq_set_constrain(known_freq_set, allowed);
> 
> This looks fine, but does bring up the question.  If we're now enabling 
> 6G frequencies to be put into scan requests (even if they're not allowed 
> now, in hope that regdom allows them after the split scan) should this 
> logic be using supported frequencies and not allowed ones?

I suppose there isn't any harm in that. I was more or less keeping 
things the same as they were, where only periodic scans are responsible 
for splitting and re-issuing 6ghz scans. But if IWD is doing a full scan 
via roaming, dbus, hidden etc. we might as well try and use 6ghz.

And here specifically, yes, I should retain 6ghz frequencies in the set.

> 
>> +
>> +    if (scan_freq_set_isempty(known_freq_set))
>>           return -ENOTSUP;
>> -    }
>>       station->quick_scan_id = station_scan_trigger(station,
>>                           known_freq_set,
>> @@ -2656,6 +2679,11 @@ static int station_roam_scan(struct station 
>> *station,
>>                   struct scan_freq_set *freq_set)
>>   {
>>       struct scan_parameters params = { .freqs = freq_set, .flush = 
>> true };
>> +    _auto_(scan_freq_set_free) struct scan_freq_set *allowed =
>> +                    station_get_allowed_freqs(station);
>> +
>> +    if (L_WARN_ON(!allowed))
>> +        return -ENOTSUP;
>>       l_debug("ifindex: %u", netdev_get_ifindex(station->netdev));
>> @@ -2666,8 +2694,14 @@ static int station_roam_scan(struct station 
>> *station,
>>           params.ssid_len = strlen(ssid);
>>       }
>> -    if (!freq_set)
>> +    if (!freq_set) {
>>           station->roam_scan_full = true;
>> +        params.freqs = allowed;
>> +    } else
>> +        scan_freq_set_constrain(freq_set, allowed);
>> +
> 
> Same as above?
> 
>> +    if (L_WARN_ON(scan_freq_set_isempty(params.freqs)))
>> +        return -ENOTSUP;
>>       station->roam_scan_id =
>>           scan_active_full(netdev_get_wdev_id(station->netdev), &params,
> 
> <snip>
> 
>> @@ -4268,38 +4308,77 @@ int station_hide_network(struct station 
>> *station, struct network *network)
>>       return 0;
>>   }
>> -static void station_add_one_freq(uint32_t freq, void *user_data)
>> +static void station_add_6ghz_freq(uint32_t freq, void *user_data)
>>   {
>> -    struct station *station = user_data;
>> +    struct scan_freq_set *set = user_data;
>> -    if (freq > 3000)
>> -        scan_freq_set_add(station->scan_freqs_order[1], freq);
>> -    else if (!scan_freq_set_contains(station->scan_freqs_order[0], 
>> freq))
>> -        scan_freq_set_add(station->scan_freqs_order[2], freq);
>> +    if (freq > 5935)
>> +        scan_freq_set_add(set, freq);
>> +}
>> +
>> +static void station_add_5ghz_freq(uint32_t freq, void *user_data)
>> +{
>> +    struct scan_freq_set *set = user_data;
>> +
>> +    if (freq > 3000 && freq < 5935)
>> +        scan_freq_set_add(set, freq);
>> +}
>> +
>> +static void station_add_2_4ghz_freq(uint32_t freq, void *user_data)
>> +{
>> +    struct scan_freq_set *set = user_data;
>> +
>> +    /* exclude social channels added in initial scan request */
>> +    if (freq < 3000 && freq != 2412 && freq != 2437 && freq != 2462)
>> +        scan_freq_set_add(set, freq);
>>   }
>>   static void station_fill_scan_freq_subsets(struct station *station)
>>   {
>> -    const struct scan_freq_set *supported =
>> -        wiphy_get_supported_freqs(station->wiphy);
>> +    _auto_(scan_freq_set_free) struct scan_freq_set *allowed =
>> +                    station_get_allowed_freqs(station);
>> +    unsigned int subset_idx = 0;
>> +    if (L_WARN_ON(!allowed))
>> +        return;
>>       /*
>>        * Scan the 2.4GHz "social channels" first, 5GHz second, if 
>> supported,
>>        * all other 2.4GHz channels last.  To be refined as needed.
>>        */
>> -    station->scan_freqs_order[0] = scan_freq_set_new();
>> -    scan_freq_set_add(station->scan_freqs_order[0], 2412);
>> -    scan_freq_set_add(station->scan_freqs_order[0], 2437);
>> -    scan_freq_set_add(station->scan_freqs_order[0], 2462);
>> -
>> -    station->scan_freqs_order[1] = scan_freq_set_new();
>> -    station->scan_freqs_order[2] = scan_freq_set_new();
>> -    scan_freq_set_foreach(supported, station_add_one_freq, station);
>> -
>> -    if (scan_freq_set_isempty(station->scan_freqs_order[1])) {
>> -        scan_freq_set_free(station->scan_freqs_order[1]);
>> -        station->scan_freqs_order[1] = station->scan_freqs_order[2];
>> -        station->scan_freqs_order[2] = NULL;
>> +    if (!band_2_4ghz_disabled) {
>> +        station->scan_freqs_order[subset_idx] = scan_freq_set_new();
>> +        scan_freq_set_add(station->scan_freqs_order[subset_idx], 2412);
>> +        scan_freq_set_add(station->scan_freqs_order[subset_idx], 2437);
>> +        scan_freq_set_add(station->scan_freqs_order[subset_idx], 2462);
>> +        subset_idx++;
>> +    }
>> +
>> +    /*
>> +     * TODO: It may might sense to split up 5 and 6ghz into separate 
>> subsets
>> +     *       since the channel set is so large.
>> +     */
>> +    if (!band_5ghz_disabled || !band_6ghz_disabled) {
>> +        struct scan_freq_set *set = scan_freq_set_new();
>> +
>> +        if (!band_5ghz_disabled)
>> +            scan_freq_set_foreach(allowed,
>> +                        station_add_5ghz_freq, set);
>> +        if (!band_6ghz_disabled)
>> +            scan_freq_set_foreach(allowed,
>> +                        station_add_6ghz_freq, set);
> 
> Is there a better way to generate 5G/6G freqs than 
> scan_freq_set_foreach?  Isn't this wiphy_get_allowed_freqs() with a 
> relevant band_mask?
> 
>> +
>> +        /* 5/6ghz didn't add any frequencies */
>> +        if (scan_freq_set_isempty(set)) {
>> +            scan_freq_set_free(set);
>> +        } else
>> +            station->scan_freqs_order[subset_idx++] = set;
>> +    }
>> +
>> +    /* Add remaining 2.4ghz channels to subset */
>> +    if (!band_2_4ghz_disabled) {
>> +        station->scan_freqs_order[subset_idx] = scan_freq_set_new();
>> +        scan_freq_set_foreach(allowed, station_add_2_4ghz_freq,
>> +                    station->scan_freqs_order[subset_idx]);
>>       }
>>   }
> 
> Regards,
> -Denis
