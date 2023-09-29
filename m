Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E554521DA
	for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 16:23:57 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-69335ddbe16so3871478b3a.1
        for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 09:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696004637; x=1696609437; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iE46dpfhNvaWmneXoCyiCoTWRy4oJkadhDihYaFPYpU=;
        b=eUwdZBm84nx/4xjqF9GPz1hutjksquOdzsw3PW4w7m1KTtTc4ooRlDYOQ9F9F5I0OF
         BoNSJTex8zeKtPSxOLUGGAISbRGyRC2d3d+mzKDNchBGojKS2H66aOahyTCwh6MHXKow
         EQL4U0aHcdAhwBAt5b887FQJnouMzSKK9YCCw4QWSN0acmyNSm2Or3/tLBduTvgVH7fv
         Qnl0ebI8tu2f7tkwxQlB2hZw+Qbtwuvyeb1cIx2BKXPqqNr7RGMqA/WvAl2lrI/Fz6r2
         q5jujLGzz4Lxn5J9/GszUbf0+t7Wx4g/H5trVCyAtcU1WWOxURebrMFjB7zsANEiM9yD
         brzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696004637; x=1696609437;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iE46dpfhNvaWmneXoCyiCoTWRy4oJkadhDihYaFPYpU=;
        b=J6ARis8SwkIewdtk74suubTifKn3yXqFnJ1YEA8vRI/3CBlunAFK4Ix18pDe2tzhzy
         HPot7gWmynbBkAuNt+FcriiYpnaJ+FxL0NNCekvtNPQQG+OpTHMcfNE/4ay/r3HFK0vu
         Jjgfsa5LRkrIYnV7lrEceRC+Z3QjkaV0G99LXTBnLtE1201kS1lfNOvGK28vNPaD1UBI
         rs6Q8r4rewiTXXRTU8nnIqiWEIxN/P/l9lBL12Es86NQasyu/H/CH5rX+RtcpbbAwura
         BTsZgM+mSwtREFGzVluZkRju28hjXkT5KbSBbsAsK/tpRY1jFQS1YipXXdg/frs+pfOx
         iiFg==
X-Gm-Message-State: AOJu0YziIiGJrDcgW6I/+vv3cSZ8TO7gwCBGBAKxBccekbdBV/XcFOhw
	XGxH8BLgES25D5NV+On7Qdg=
X-Google-Smtp-Source: AGHT+IE1CiNYP/yIX7v/8kx/by/ZqGbr4K9BIXHnlkVXvJf2Ofl0AK9dB/D380Qgw7SsOgOLMgicOQ==
X-Received: by 2002:a05:6a21:6da9:b0:14c:d5e9:14d5 with SMTP id wl41-20020a056a216da900b0014cd5e914d5mr5075503pzb.14.1696004637102;
        Fri, 29 Sep 2023 09:23:57 -0700 (PDT)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id q26-20020a62ae1a000000b0068ffd4eb66dsm15146379pff.35.2023.09.29.09.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 09:23:56 -0700 (PDT)
Message-ID: <73b79593-7fe2-4a5c-abd6-b25859d9d5b0@gmail.com>
Date: Fri, 29 Sep 2023 09:23:52 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] station: support user-disabled bands
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230928124128.3793788-1-prestwoj@gmail.com>
 <20230928124128.3793788-3-prestwoj@gmail.com>
 <0e6036b3-09a1-ef34-85e3-dcd86a041b1e@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <0e6036b3-09a1-ef34-85e3-dcd86a041b1e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 9/29/23 8:37 AM, Denis Kenzior wrote:
> Hi James,
> 
> On 9/28/23 07:41, James Prestwood wrote:
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
>>   src/station.c | 120 ++++++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 97 insertions(+), 23 deletions(-)
>>
>> v2:
>>   * Compute an allowed band mask in station_init rather than separate 
>> bools
>>   * Let all scan paths include frequencies which may be disabled but
>>     supported. This opens up the potential for 6ghz to be unlocked, 
>> and if
>>     a frequency is disabled the kernel filters it anyways.
>>   * Optimized the dbus scan subset creation. Clone the 5/6ghz sets based
>>     on supported freqs rather than foreach.
>>   * Added a warning after computing the subsets if none were created
>>
> 
> I went ahead and applied this and 4/4.  Couple of comments:
> 
>> +static struct scan_freq_set *station_get_allowed_freqs(struct station 
>> *station)
>> +{
>> +    const struct scan_freq_set *supported =
>> +                wiphy_get_supported_freqs(station->wiphy);
>> +    struct scan_freq_set *allowed = scan_freq_set_clone(supported,
>> +                            allowed_bands);
>> +
>> +    if (scan_freq_set_isempty(allowed)) {
>> +        scan_freq_set_free(allowed);
>> +        allowed = NULL;
>> +    }
>> +
>> +    return allowed;
>> +}
>> +
> 
> This is almost identical to the function in scan.c.  Maybe consider 
> using a shared implementation?
> 
>> @@ -1440,9 +1457,14 @@ static int station_quick_scan_trigger(struct 
>> station *station)
>>               known_6ghz)
>>           return -ENOTSUP;
>> -    if (!wiphy_constrain_freq_set(station->wiphy, known_freq_set)) {
>> +    allowed = station_get_allowed_freqs(station);
>> +    if (L_WARN_ON(!allowed))
>> +        return -ENOTSUP;
> 
> You have a lot of this handling sprinkled about.  I think this is fine, 
> since someone can still disable the single band their hardware supports 
> or something. But maybe its worth checking the really bizarre cases and 
> fail initialization early?
> 
> Somewhere in station_init or scan_init?  Sanitize that at least a single 
> band is enabled, or at least one of 2.4/5G if 6G is also enabled?

Yeah I thought about that. If all bands are disabled IWD will still 
start, but just hang since it can't do anything. But maybe it is best to 
actually fail init, that would make it more clear since someone is 
likely just checking systemctl to see why they don't have wifi.

I'll send a follow up for this.

> 
> Regards,
> -Denis
> 
