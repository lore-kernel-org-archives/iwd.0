Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FCB1A73F
	for <iwd@lists.linux.dev>; Wed,  3 Jan 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfF30Amg"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9b267007fso2726262b3a.3
        for <iwd@lists.linux.dev>; Wed, 03 Jan 2024 07:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704294097; x=1704898897; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ci1nOH4X91IqELaXbRuGJIrsqgZ8EISBnATXnA9vDk4=;
        b=gfF30AmgVfuB2LgpsS30O81F3hkX/nmS5cWwlaHZPb7mYOHZ0fYeVatqjQA0SOvmvh
         8bKFtT9PUF/0SfXdvN6v227KpvsLZ20n7yrki4r3a1uISRWT5fPNzSz18TKgcCXCU/Mw
         JvlkQIFpdEkbYg6ZjY7eT1S21m7mamfEPZs/XHwBO9wuH2UhxuykSFKfe0kr5UUsZcS1
         BL7q0KjxN7Dsr/QCKfD/oskFR0eEJpuCy/sdcwnmOVCEHZ5zFwPSow/04nKMxJFRPOxk
         liDsjZisY0fvo3EjXB3JpAIrEE96yz6HuBHFxpoPb0nYu9ENz1Nt4ray1kkOieykS5uI
         fAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704294097; x=1704898897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ci1nOH4X91IqELaXbRuGJIrsqgZ8EISBnATXnA9vDk4=;
        b=bJtS6tow0G/9sgn1XN7YIn2sB4339SWmJkYBxtd/v4lbLXVj7D4Es1FHATEeDqlSTo
         h74k7kDASnOnwwzvhwnOGH7VGtpqALVLnmsbDcXO7JNSflmKWkBAPLXXeBn9RUS7Qvkn
         Bn8KRqZ5LHGwRmyfOF3AXtuBpjrAI/o7pPH096vTvZfaejaLN8ID6GfeTbNVjyEWIhTY
         nCE0CZ7zNy53N4Aq76eQV/OweN3wWOoRWFRjV3aDhf2fw1kOVGudNKvPlHM6hUNCYJmn
         Hg/fYn5zXR6xper1c7HfJNIymmSTruvv8EB3sXTkDtKt10uoCmMxmnDoEmtAzLhcO7Bz
         nmeA==
X-Gm-Message-State: AOJu0Yyd1CWGCcDuKvdktOuW1Vu53pwOrM58iSkjLTizhGcuOJ542STE
	Op71au9JwpVmltkHo7aq0/YpDlmAViH7Lw==
X-Google-Smtp-Source: AGHT+IFso4Y/IRlb9j/J7+JkHolDWV3eZYHZiRa423FJvjaotz0o4b+4XGTEjINOxUkgaE8pGBX7Dw==
X-Received: by 2002:a05:6a20:9383:b0:197:5969:a6e7 with SMTP id x3-20020a056a20938300b001975969a6e7mr1772378pzh.50.1704294097188;
        Wed, 03 Jan 2024 07:01:37 -0800 (PST)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id p2-20020aa78602000000b006d9ac45206bsm18316108pfn.206.2024.01.03.07.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 07:01:35 -0800 (PST)
Message-ID: <16330cf3-e6d3-4855-8b65-28b2fe8a905f@gmail.com>
Date: Wed, 3 Jan 2024 07:01:34 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scan: limit COLOCATED_6GHZ flag to 6ghz devices
Content-Language: en-US
To: KeithG <ys3al35l@gmail.com>
Cc: iwd@lists.linux.dev
References: <20240103125638.243820-1-prestwoj@gmail.com>
 <271dfdff-903d-4ff4-abe7-34526aec3580@gmail.com>
 <CAG17S_Pf2YeN8WMj8K6i5RfZTdFXy7S4Ry_zcqPYFdQQ57v52g@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_Pf2YeN8WMj8K6i5RfZTdFXy7S4Ry_zcqPYFdQQ57v52g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 1/3/24 6:57 AM, KeithG wrote:
> On Wed, Jan 3, 2024 at 6:58 AM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi Keith,
>>
>> On 1/3/24 4:56 AM, James Prestwood wrote:
>>> It was seen that this flag seems to cause issues when in AP mode on
>>> brcmfmac devices (e.g. the raspberry Pi 3). When in AP mode an a
>>> scan is issued clients will disconnect. After testing this behavior
>>> was isolated to the use of the COLOCATED_6GHZ flag.
>>>
>>> Besides working around the problem on this specific hardware the
>>> patch itself makes sense as a non-6GHz capable device shouldn't use
>>> this flag anyways.
>>>
>>> As stated in the patch comment, this isn't really a catch all
>>> workaround since the flag is still used for devices supporting 6GHz.
>>> If additional hardware exhibits this behavior we may need additional
>>> changes like a hardware blacklist or an explicit option to disable
>>> the flag.
>>>
>>> Reported-By: Keith G <ys3al35l@gmail.com>
>> Could you double check it still fixes the issue you were seeing on brcmfmac?
>>
>> Thanks,
>>
>> James
>>
>>> ---
>>>    src/scan.c | 15 ++++++++++++++-
>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/src/scan.c b/src/scan.c
>>> index f48ffdef..8c6fdc08 100644
>>> --- a/src/scan.c
>>> +++ b/src/scan.c
>>> @@ -394,7 +394,20 @@ static struct l_genl_msg *scan_build_cmd(struct scan_context *sc,
>>>        if (params->ap_scan)
>>>                flags |= NL80211_SCAN_FLAG_AP;
>>>
>>> -     flags |= NL80211_SCAN_FLAG_COLOCATED_6GHZ;
>>> +     /*
>>> +      * TODO: This flag appears to cause some undesired behavior on brcmfmac
>>> +      *       when the device is in AP mode, or has a secondary AP interface
>>> +      *       running, causing clients to disconnect when a scan is issued.
>>> +      *
>>> +      *       Only using this flag for 6GHz capable devices will limit this
>>> +      *       behavior to only 6GHz devices and in reality makes sense
>>> +      *       because a non-6GHz device shouldn't use this flag anyways. If
>>> +      *       more issues still are seen related to this we may need an
>>> +      *       explicit workaround, either brcmfmac-specific or a disable
>>> +      *       option.
>>> +      */
>>> +     if (wiphy_band_is_disabled(sc->wiphy, BAND_FREQ_6_GHZ) != -ENOTSUP)
>>> +             flags |= NL80211_SCAN_FLAG_COLOCATED_6GHZ;
>>>
>>>        if (flags)
>>>                l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, &flags);
> James,
>
> I will do this tonight. I was playing a lot with iwd that I had
> patched with your suggestion last night. I was trying to resolve a
> related problem and I did note that it was significantly more stable
> with this patch, but I was still getting disconnected periodically. I
> do not yet know if those disconnects were due to me or iwd and am
> still investigating. I will continue this investigation with this new
> patch applied. SHould this patch be against HEAD or can I safely patch
> 2.12?

Either works, there haven't been changes to that area in a while.

Thanks,

James

>
> Keith
