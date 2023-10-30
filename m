Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09B33F9
	for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5GP12mb"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d8a000f6a51so3547791276.3
        for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698665739; x=1699270539; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXRNyFUcLb01fZvtVN28k6w8ynj1q49igAn04W6IbY8=;
        b=l5GP12mbKfSJ7S5ZkHJSMQMGrsOCah37tbzgkpmLAcCBgQAhRlEFcPwbmLcTd2gNjN
         +v2jnoETxnwNjnLuGNot9zNvuugFyp+B1Y5bs+W9zFL3CigegLWQ2yrc1U8L7bSYHCue
         FFGbDfx78s/rg6r4AsAfZCrsWCX745BUEVXrEsOJroS0MQ9X/DcUjWN1h6WfNj7PUoD8
         mWmqNP7COEUd4cPqPw8VBlz1mK8aRc0q4XssSadjHKe9ql8SAjg9H2n6l3KcR0qvwh3e
         NALnFmno8O5UY1EE4padg/aQsIyNmxhknggL0pMJ4XV+evKLLcBSQPMbKUHer1LpsCBx
         814A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698665739; x=1699270539;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXRNyFUcLb01fZvtVN28k6w8ynj1q49igAn04W6IbY8=;
        b=YtPgGoIhk4hGMp6vJ0b34pLYDzNsH4xsmy1cwqCID6kEwXF0ElPdYNv7vafwiObZHG
         ExqE7Z4/Go9MaP+AcwxHvRM5MH2j3Y/Fm4bsxh54EfhaJ7Tywmcc62XcURqY6dJsBd0U
         1iRsZ1yHh6nN7nKuU1yBFrxso7f4DGu2uc8NPVYIkosU2JqRknGPFffSmNlNwyOHstzN
         I81TDgV1SygrjalrumZv+8C08g5XwqGsqFCfUCK4zL0a7lWnV09MfPY8IR+atMxaZTxa
         40c9n+W2xUPHNTeCW9vF1UoSxQc+0qvrKlI3Iw6KEqgN4mytSHQ7FU77Y7/F1U7zwO1u
         Lyzg==
X-Gm-Message-State: AOJu0Yzgvu7nt9o/2tIS2aAhVC5w4tsoETK2vu/sw16KMf3m0GRtc+Gg
	fGle4/OtdNmad6d3jJEdYK0=
X-Google-Smtp-Source: AGHT+IHas+7PSzkyZw7lMD6l++2fjqrEr2JHZw8krR/TaqzI7JtgDCp0LYfyEODirytbKVKiYXkDzw==
X-Received: by 2002:a25:fc12:0:b0:da0:4ba8:35fe with SMTP id v18-20020a25fc12000000b00da04ba835femr8583748ybd.60.1698665738781;
        Mon, 30 Oct 2023 04:35:38 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id t16-20020a05622a01d000b0041e211c5d0bsm3352269qtw.6.2023.10.30.04.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 04:35:38 -0700 (PDT)
Message-ID: <70cf034a-485c-4cdf-a042-39eb45fd190f@gmail.com>
Date: Mon, 30 Oct 2023 04:35:34 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] dpp: remove connect/scanning and resume periodic
 scans after DPP
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231026202657.183591-1-prestwoj@gmail.com>
 <20231026202657.183591-3-prestwoj@gmail.com>
 <428501e8-9ad3-4b83-adb7-e60530e98270@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <428501e8-9ad3-4b83-adb7-e60530e98270@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/29/23 3:04 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 10/26/23 15:26, James Prestwood wrote:
>> When DPP is started periodic scans are stopped but never started
>> again. This means if DPP fails IWD will never resume autoconnecting
>> without some intervention.
>>
> 
> Okay, but why are you not removing scan_periodic_stop() calls then?  If 
> the intent is to use station_set_autoconnect, then do that.  And this 
> probably requires a separate patch.

One thing I overlooked here was the fact that offchannel requests are at 
a higher priority than scanning, and since we "block" the work queue in 
DPP they will resume afterwards.

So these patches aren't very useful and instead I will remove 
periodic_scan_stop calls (to retain the autoconnect state) and change 
station_connect_network to be callable without a dbus message (to fix 
the state problem).

> 
>> This also removes the internal scanning/connecting logic from DPP
>> which was done for two reasons. First its unknown how long the
>> DPP protocol took and its safest to explicitly scan to find the
> 
> Isn't this being done by invoking scan_active?
> 
>> target network/bss, and second the connect logic was flawed because
>> station will not transition into a CONNECTING state since
>> __station_connect_network shortcuts the state change. If DPP failed
> 
> Okay, so use station_connect_network?
> 
>> station would never resume autoconnecting, and if the post-DPP
>> connection failed the state was set incorrectly so station would
>> also not resume autoconnecting.
>>
>> The downside of this is it takes slightly longer to connect after
>> DPP since IWD must scan, but the DPP logic is simplified and keeps
>> all connection logic in station.c where it belongs.
> 
> Well, the downside of this approach is that you're relying completely on 
> autoconnect logic to pick the right network instead of having DPP 
> connect to the network that was just configured.  So if autoconnect 
> picks a different network you get results the user doesn't expect.

Yeah, this too.

> 
>> ---
>>   src/dpp.c | 76 ++++++++++++++++++++-----------------------------------
>>   1 file changed, 27 insertions(+), 49 deletions(-)
>>
> 
> <snip>
> 
>> @@ -315,7 +313,17 @@ static void dpp_reset(struct dpp_sm *dpp)
>>           dpp->retry_timeout = NULL;
>>       }
>> +    /*
>> +     * Set station back to its original autoconnecting state if an
>> +     * enrollee and DPP failed
>> +     */
>> +    if (station && dpp->role == DPP_CAPABILITY_ENROLLEE &&
>> +            dpp->station_autoconnecting &&
>> +            dpp->state != DPP_STATE_SUCCESS)
>> +        station_set_autoconnect(station, true);
> 
> So what if autoconnect was false originally?
> 
>> @@ -830,16 +805,9 @@ static void 
>> dpp_handle_config_response_frame(const struct mmpdu_header *frame,
>>       offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
>> -    if (network && bss)
>> -        __station_connect_network(station, network, bss);
>> -    else if (station) {
>> -        dpp->connect_scan_id = scan_active(dpp->wdev_id, NULL, 0,
>> -                        dpp_scan_triggered,
>> -                        dpp_scan_results, dpp,
>> -                        dpp_scan_destroy);
> 
> Likely this needs to be a filtered scan (with SSID) as opposed to wildcard >
>> -        if (dpp->connect_scan_id)
>> -            return;
>> -    }
>> +    dpp->state = DPP_STATE_SUCCESS;
>> +
>> +    station_set_autoconnect(station, true);
>>       dpp_reset(dpp);
>>   }
> 
> Regards,
> -Denis
> 
