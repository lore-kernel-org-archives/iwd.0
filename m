Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9BD13FF1
	for <iwd@lists.linux.dev>; Sun, 27 Aug 2023 21:44:47 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-68a3f1d8be2so2075012b3a.3
        for <iwd@lists.linux.dev>; Sun, 27 Aug 2023 14:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693172687; x=1693777487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iAJLbApeStoJvumZV8YpJZ5gTuCvCgJrnVIJuc2a8eg=;
        b=jZB/XgyYAlDd5t/oI5197uHwmFZo76cXTH1d3yeQjAFsM1PWMdydKxcoTMnNlyg08W
         07nw8lxU2DDeVsT0aIU+67X+Q+LWjklJrGIBr8XznFmaSrEyTt3nlFFPMocgjAKJJ9Sv
         J5j59KG3Ge+npLt/FPQspikBPhtMhEvHneCYpmcljDEF9QSjrMjZ9GAwC0KNCIxChCaE
         VJ9UTScbBLB2bssNUNbp4wGnj34wF2m/gbkhtcxysVrLd3/EdqHzZEtE++M4vhHbPylP
         dHeBfo0IDG7hI9RpADLu6s0h7RhoFgEDFBVvBVdvjgg6mHgUCz1PZUNCfYIko6cO9t+r
         0MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693172687; x=1693777487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAJLbApeStoJvumZV8YpJZ5gTuCvCgJrnVIJuc2a8eg=;
        b=Vv2FdWj06dmwysVVEYu9cpoQz/8lud0TkRyWI61SbNBLzbYAfuZaJEN9UfEfskiIqO
         U3gCXL0kdDrNKBezUbCEu78Ddnhw9VAywC0n5o/Gqna3ODv2IGlS9pFnv9FYR2qqU5Zd
         kibEg6lurjwNJB9ZdPj95I/LWp+kYdS/BCD9EeWylluT1/WYEHBzoAbu0gT8tUJKXbXG
         cw4Th8M7BVfTzxI1uRAD0Ucf9ahBJtvhAfbqe8f6GOAT551XJtLioxM6WNonVPGw3CoE
         zAHRQq21tRz764Zhr9KZQIRVFKiWvGY9o52/OD0Ar80InbmblAf+U+TzpgrTgjO3oKpP
         Nkbw==
X-Gm-Message-State: AOJu0Yznm6bnZoPMRVIDI46cxOqJZquT1r9QRNJYwZE/Ih9eqvko2gsV
	wIgfNUM/zsLgZ8EFmBUuepxRxpc0e3E=
X-Google-Smtp-Source: AGHT+IGb6kobD7a+kxqgUA5fIMHU41FHteCtuZCl3e4fS2YK7BspnP8bHQYIgPQGYX3Hoq2a3d4UmQ==
X-Received: by 2002:a05:6a20:160b:b0:143:f4dd:dfae with SMTP id l11-20020a056a20160b00b00143f4dddfaemr30381587pzj.43.1693172686941;
        Sun, 27 Aug 2023 14:44:46 -0700 (PDT)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id l1-20020a633e01000000b0056c2de1f32esm5843511pga.78.2023.08.27.14.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 14:44:45 -0700 (PDT)
Message-ID: <a6522b7e-0cec-4f15-9bf3-8e53d832f0d4@gmail.com>
Date: Sun, 27 Aug 2023 14:44:40 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] station: fall back to reassociation under certain FT
 failures
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230822152931.276136-1-prestwoj@gmail.com>
 <20230822152931.276136-3-prestwoj@gmail.com>
 <4ed15cee-23cc-ded0-ef37-5e1f4424ddc6@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <4ed15cee-23cc-ded0-ef37-5e1f4424ddc6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

<snip>

> 
>> where its rejecting the PMKID. When this happens it eventually leads
>> to a disconnect due to packet/beacon loss. Its a much better
>> approach to at least try reassociation.
> 
> Okay, but you should really explain that what is the strategy if IWD has 
> multiple FT candidates and the first (or many) reject the FT 
> authentication step.

In this patch the strategy is to always try the first candidate: try FT, 
and if failed with status=53, try reassociate.

There are drawbacks and benefits to this:
  - The drawback is if reassociate also fails we have to disconnect, and 
can't FT to any other candidates. This would mainly hurt if there are 
other good candidates to connect to.
  - The benefit is if there is only one available BSS to roam to and we 
failed FT but reassociation succeeded. This prevents us from trying and 
failing FT over and over. In addition if there are additional FT 
candidates but poor ranking we would still connect to the best candidate 
even if we do so via reassociation.

The decision to retry with reassociation mainly boils down to if there 
are other "good" candidates. If yes we should try FT on those since its 
faster and failure tolerant. But if all the other candidates or lack 
thereof are poor, we should reassociate to the one that failed FT, since 
its the best. Doing this logically is hard because we need to define 
whats "good" and whats "bad".

One option to make this better would be to recompute the BSS rank after 
FT fails, without RANK_FT_FACTOR, and re-insert into the queue. Although 
a 1.3x factor likely won't make a huge difference. The idea here being 
that if other candidates are closely ranked we try those via FT before 
falling back to reassociation.

Another option is to introduce some cutoff RSSI or rank value that 
determines if we retry with reassociation or move on to the next BSS 
with FT.

At the very least (mostly applicable to 1 roam candidate) we should keep 
track that all FT attempts failed and try reassociation on the next round.

Thanks,
James

>> ---
>>   src/station.c | 129 ++++++++++++++++++++++++++++++++------------------
>>   1 file changed, 82 insertions(+), 47 deletions(-)
>>
>> diff --git a/src/station.c b/src/station.c
>> index 2473de2a..733b4196 100644
>> --- a/src/station.c
>> +++ b/src/station.c
>> @@ -147,15 +147,49 @@ struct roam_bss {
>>       uint8_t addr[6];
>>       uint16_t rank;
>>       int32_t signal_strength;
>> +    bool reassoc: 1;
>>   };
> 
> <snip>
> 
>> -static void station_transition_start(struct station *station);
>> +static void station_transition_start(struct station *station, bool 
>> no_ft);
>>   static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
>>   {
>>       struct station *station = l_container_of(item, struct station, 
>> ft_work);
>> -    struct roam_bss *rbss = l_queue_pop_head(station->roam_bss_list);
>> -    struct scan_bss *bss = network_bss_find_by_addr(
>> -                    station->connected_network, rbss->addr);
>> +    L_AUTO_FREE_VAR(struct roam_bss *, rbss) = l_queue_pop_head(
>> +                            station->roam_bss_list);
> 
> _auto_(l_free) is prefered to L_AUTO_FREE_VAR
> 
>> +    struct scan_bss *bss;
>>       int ret;
>> -    l_free(rbss);
>> +    /* Already failed FT, then failed reassociation, disregard this 
>> BSS */
>> +    if (rbss->reassoc) {
>> +        l_free(l_steal_ptr(rbss));
>> +
>> +        rbss = l_queue_pop_head(station->roam_bss_list);
>> +        if (!rbss)
>> +            goto assoc_failed;
>> +    }
>>       /* Very unlikely, but the BSS could have gone away */
>> +    bss = network_bss_find_by_addr(station->connected_network, 
>> rbss->addr);
>>       if (!bss)
>>           goto try_next;
>>       ret = ft_associate(netdev_get_ifindex(station->netdev), bss->addr);
>> -    if (ret == -ENOENT) {
>> +    if (ret > 0) {
>> +        if (ret != MMPDU_STATUS_CODE_INVALID_PMKID) {
>> +            station_debug_event(station, "ft-roam-failed");
>> +            goto try_next;
>> +        }
>> +
>> +        rbss->reassoc = true;
>> +
>> +        l_queue_push_head(station->roam_bss_list, rbss);
>> +
>> +        station_debug_event(station, "ft-fallback-to-reassoc");
>> +
>> +        /* FT failed, attempt reassociation as a last resort */
>> +        station_transition_start(station, true);
>> +        l_steal_ptr(rbss);
>> +        return true;
> 
> So shouldn't you prefer FT over associate?  If there are multiple FT 
> candidates, then should iwd try those first? >
>> +    } else if (ret == -ENOENT) {
>>           station_debug_event(station, "ft-roam-failed");
>>   try_next:
>> -        station_transition_start(station);
>> +        station_transition_start(station, false);
>>           return true;
>>       } else if (ret < 0)
>>           goto assoc_failed;
> 
> Regards,
> -Denis
> 
