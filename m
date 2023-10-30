Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A1611E
	for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBner8EW"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7788ebea620so331233285a.3
        for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698680251; x=1699285051; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gwgbQlmRVoAuISdR5BCCc3kvkl3qCKe4QF3M3LqqpU8=;
        b=DBner8EWHA2fJ9Aa8uCZY3WU+RgcFXnpTjHq06z8A7WIGQEFqFoe9RklMNpr1bIrLO
         fXXNsoeBw1siIdPqOeU8V0tYrSNi4d1e+5VYqozsvEK4CnMP24fjJ0m2anuC8+WDXc9F
         gqbvYwenQ7QC/WNJQbmmb3sguCzmYKhBGmSJrM9y4lzr5F+6tenZzEnu8TnO0Tos/zvx
         dcQjFpKRLkwU5p2s9+9t0n0B+dJKZ2JtsoxFDdr1cA4ZopfpmWFwluknJ3A1ISWZT6dq
         B/LkAJsK5A0NG0OVpB3Xtsd4ySGTN8Kpww4MfUXHS+nIu8Gswzd/p8A9RGYJL383oXHr
         9QFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698680251; x=1699285051;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwgbQlmRVoAuISdR5BCCc3kvkl3qCKe4QF3M3LqqpU8=;
        b=ClBDnenrcffOtVKK1Kme/sl7rguUH/s9h4xfouJYVhoC7/9Fq/hRH3P/KCQXWOATaG
         rZUj26HRocEH8UDqD0nmOWZ0550Q1foSd58j+UUJr3o2Nj0o/5KnQMT9DK7JnQpTZgp7
         YkAS2J/Piz1U+f4OKshvJDtZzFcNdRNDh16TXmCPHXWvZxx528YBrTerETTWwV1l7XQD
         bqddLAvfr3g6JB2SGGZx9GpbnlTvKAHQEP5lb6GgnialIiPeCz7OVptmZyzBIzPPy01i
         qJzOb6h8mQBiUdCt9JdhpYeMUmfQLk3Aj8mkSuJ2whLUuiWqMpHgDzIXwEpDJbLo/zRS
         zyYQ==
X-Gm-Message-State: AOJu0YxK2RJOkzAPwmk5i/87q9t2E8UWSBjb7cUmBmPCisPhcTy2+NK+
	sgcH9t+IXbJY7vBT2r79zIfypxLtL/w=
X-Google-Smtp-Source: AGHT+IEMA9PP19/fmN29YtVFkx0l9Lqaqfxwzk4T3vjbHIYuYkUqtWziTo13oKWxkEduNr0NgMbHaQ==
X-Received: by 2002:a05:620a:258b:b0:779:deae:628c with SMTP id x11-20020a05620a258b00b00779deae628cmr10891007qko.67.1698680251530;
        Mon, 30 Oct 2023 08:37:31 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a11a300b00767dba7a4d3sm3415313qkk.109.2023.10.30.08.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 08:37:31 -0700 (PDT)
Message-ID: <0cf695c9-7abc-40e9-a6fa-fdd10589839b@gmail.com>
Date: Mon, 30 Oct 2023 08:37:28 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Packet/beacon loss roaming improvements
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231030134837.452957-1-prestwoj@gmail.com>
 <b5138012-c4aa-40bd-892e-5b578a29ade4@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <b5138012-c4aa-40bd-892e-5b578a29ade4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/30/23 8:00 AM, Denis Kenzior wrote:
> Hi James,
> 
>>
>> We were seeing beacon loss events not resulting in an immediate
>> disconnnect (as I have always expected), still eventually but after
> 
> If I recall correctly, Lost Beacon is sent after several beacons in 
> succession were lost.  You are right that this could just be bad luck 
> and doesn't actually mean that no packets are getting through.  However, 
> in practice mac80211 almost always disconnected us soon after.  Didn't 
> we test this pretty thoroughly?

Yes, it appears mac80211 by default waits for 7 missed beacons before 
sending the event. It then probes the AP (either nullfunc or probe 
request) so apparently the connection could be recovered if the AP 
responded. Unfortunately we don't get any notification in userspace if 
the AP responded or not...

I can't remember what hardware was tested. But there really wasn't a 
consistent way to test this. The testing involved me disabling roaming 
and walking away from the AP until I got disconnected. Sometimes this 
was due to beacon loss, sometimes the AP disconnected explicitly. But 
what I do remember is when beacon loss occurred, a local disconnect 
followed near immediately. This is why (I think) we thought there was no 
reason to handle this event.

> 
> My memory is fuzzy here, but I seem to recall that power save has an 
> effect on how lost beacon events are treated by mac80211.  Maybe your 
> recent power save patches had an effect?

 From what I can tell in mac80211 power save doesn't change handling. 
Its the driver that tells mac80211 of the beacon loss but maybe the 
driver (or firmware) could handle it differently depending on power save.

When I was watching this device power save was disabled.

> 
>> plenty of time to roam. I initially added handling for
>> beacon loss identical to packet loss (try and find a better BSS) but
>> noticed that if IWD did not find a better candidate it resulted in a
>> disconnect 100% of the time. I watched a client for a full day and
>> whenever beacon loss events arrived they were followed by a
>> disconnect within ~5-6 seconds if IWD did not roam. This led me to
>> believe that at least on ath10k a beacon loss is still very much a
>> sign that a disconnect is going to come, we just have a bit more time
>> than other drivers. This was the motivation behind re-using/re-naming
>> the 'ap_directed_roam' flag in order to force IWD off the BSS.
>>
> 
> ath10k is still a mac80211 driver, no?  Given that we did test Lost 
> Beacon event behavior before, I would like some more data points before 
> being convinced it is a driver behavior change.
> 
>> Again, this is just one driver. Maybe other drivers can
>> handle/recover from beacon loss. If we instead want to keep the
>> behavior the same as packet loss I'm ok with that (I can keep the
>> patch locally), or put the forced roam behavior behind a user
>> option e.g. [Roam].ForceRoamOnBeaconLoss
> 
> If this is a driver behavior quirk, then this belongs in src/wiphy.c 
> driver_infos table somehow.  I'd really rather not add a bazillion 
> config options that address the bug-of-the-day.

Yeah, adding a driver specific quirk doesn't seem like the right route.

I think for now there is no harm in trying to roam on beacon loss, 
basically the same handling as packet loss. If a disconnect comes 
immediately the scan would be canceled. Otherwise maybe we get lucky and 
be able to roam.

Since our specific hardware/use case seems to benefit from the forced 
roam I can keep that change out of tree (just set ap_directed_roaming), 
at least until more testing can be done, or if others report similar 
behavior.

Thanks,
James

> 
>>
>> James Prestwood (4):
>>    station: rename ap_directed_roam to force_roam
>>    station: start roam on beacon loss event
>>    netdev: handle/send beacon loss event
>>    station: rate limit packet loss roam scans
>>
>>   src/netdev.c  |  6 ++++-
>>   src/netdev.h  |  1 +
>>   src/station.c | 61 +++++++++++++++++++++++++++++++++++++++++++--------
>>   3 files changed, 58 insertions(+), 10 deletions(-)
>>
> 
> Regards,
> -Denis
