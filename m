Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9F5199A6
	for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO4C6zfI"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b3f6f330d4so2940652b6e.2
        for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698687438; x=1699292238; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32igj8uWkVYNyjsQPgLCpZ3FEPXA21N2Vxv6w2wTwL4=;
        b=iO4C6zfIRasO4BO9Ia65JuyWaUyj8UwoLdlJnbAOQ7EFZ2dXLLyZuazZ0DAV5l2mK/
         HNmVTMz8BRU73RUQhtR+bJsNKQZJ480b6vGxcdJoR1L9sI6uN4/tmTe26zB3hKFqNWMx
         wSxLsA9kk7NKFniEL/pZWKm16S1OfDMTUgdd59fUVRySlPY14rdpQNPF1hkT3cidcMrH
         psPFZi5bOTvqy6iS3HQUSpImLH/4SD4nY62kyriYfdVWvY/aYo9lMB/mvEOFpQ+J22Gp
         NRhxrWsjs9xLaS6pTkN6DufHljQQjYTjIn/HFOuMrbDmE/74HQpgGroItk9+qyhvAbM5
         aklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687438; x=1699292238;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32igj8uWkVYNyjsQPgLCpZ3FEPXA21N2Vxv6w2wTwL4=;
        b=VAuTCSiq35n2LWlVUp5QcbprIJga8cKv/3H0QLVHy+QIitqjOmsOVknsNCkyyIblst
         ORiamPSpXhQoEWRr6ULXgWYe3TrfNZ7GGahNyub9QdXmPwR1db0cVmzjwQtMaY9/lSCj
         Rn4yYYuG585T90RtQGTNcBx2/0HX+zrgOotltMOiIFJ+qEPuzx3WBPfEc9XsAEpN8Ws1
         3vGb69RqFJDgYl8p9nieBXTkeIVinVz+bvYJ0gr8GuaNK24dScf7QUGlQmPohcjuoFMk
         CEXDBsJJ5FxGhZEHUpGwAmu2K/6shz6ULG32iju0YtuuKbidw+RssikQeeXGi6G0zjez
         cuvw==
X-Gm-Message-State: AOJu0YxknrsHwWZ5UIcup70YmqJoJq42HyfR7FcvttI9xE2wVQEhy6cg
	kT7GNv7p6jm9TzkWLUDhkBw=
X-Google-Smtp-Source: AGHT+IF4l+kDeOcmM0zIfTF8HIct+QruZoq1Q5KxzTDHyeunkzYZiqlHQCSJYVp9HFBRJlyCw6UTRg==
X-Received: by 2002:a05:6808:42:b0:3a7:4b9a:43c2 with SMTP id v2-20020a056808004200b003a74b9a43c2mr12295040oic.13.1698687437854;
        Mon, 30 Oct 2023 10:37:17 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id m20-20020a05620a24d400b007756c8ce8f5sm3458474qkn.59.2023.10.30.10.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 10:37:17 -0700 (PDT)
Message-ID: <70935a8f-1f38-4e9e-8d77-40179c2b31f3@gmail.com>
Date: Mon, 30 Oct 2023 10:37:15 -0700
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
 <0cf695c9-7abc-40e9-a6fa-fdd10589839b@gmail.com>
 <fb8dfeeb-3f5d-49d2-8a4e-063b4933d905@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <fb8dfeeb-3f5d-49d2-8a4e-063b4933d905@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/30/23 10:05 AM, Denis Kenzior wrote:
> Hi James,
> 
> On 10/30/23 10:37, James Prestwood wrote:
>> Hi Denis,
>>
>> On 10/30/23 8:00 AM, Denis Kenzior wrote:
>>> Hi James,
>>>
>>>>
>>>> We were seeing beacon loss events not resulting in an immediate
>>>> disconnnect (as I have always expected), still eventually but after
>>>
>>> If I recall correctly, Lost Beacon is sent after several beacons in 
>>> succession were lost.  You are right that this could just be bad luck 
>>> and doesn't actually mean that no packets are getting through.  
>>> However, in practice mac80211 almost always disconnected us soon 
>>> after.  Didn't we test this pretty thoroughly?
>>
>> Yes, it appears mac80211 by default waits for 7 missed beacons before 
>> sending the event. It then probes the AP (either nullfunc or probe 
>> request) so apparently the connection could be recovered if the AP 
>> responded. Unfortunately we don't get any notification in userspace if 
>> the AP responded or not...
> 
> So this magic here?
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/tree/net/mac80211/mlme.c#n3215

Yep

> 
>>
>> I can't remember what hardware was tested. But there really wasn't a 
>> consistent way to test this. The testing involved me disabling roaming 
>> and walking away from the AP until I got disconnected. Sometimes this 
>> was due to beacon loss, sometimes the AP disconnected explicitly. But 
>> what I do remember is when beacon loss occurred, a local disconnect 
>> followed near immediately. This is why (I think) we thought there was 
>> no reason to handle this event.
> 
> So what does your ath10k driver/hw do?  Does it send nullfuncs or probe 
> requests?

Based on the driver it sets REPORTS_TX_ACK_STATUS, so nullfunc. Which 
would add an extra second before disconnect by default (2 nullfuncs 
500ms apart).

> 
>>
>>>
>>> My memory is fuzzy here, but I seem to recall that power save has an 
>>> effect on how lost beacon events are treated by mac80211.  Maybe your 
>>> recent power save patches had an effect?
>>
>>  From what I can tell in mac80211 power save doesn't change handling. 
>> Its the driver that tells mac80211 of the beacon loss but maybe the 
>> driver (or firmware) could handle it differently depending on power save.
>>
>> When I was watching this device power save was disabled.
> 
> Okay, fair enough.
> 
>>> If this is a driver behavior quirk, then this belongs in src/wiphy.c 
>>> driver_infos table somehow.  I'd really rather not add a bazillion 
>>> config options that address the bug-of-the-day.
>>
>> Yeah, adding a driver specific quirk doesn't seem like the right route.
>>
>> I think for now there is no harm in trying to roam on beacon loss, 
>> basically the same handling as packet loss. If a disconnect comes 
>> immediately the scan would be canceled. Otherwise maybe we get lucky 
>> and be able to roam.
> 
> So the problem is, we had the _exact_ same behavior you're proposing 
> here.  We took it out.  See commit:
> 836beb1276d1 ("station/wsc: remove beacon loss handling")
> 
> So when we do that, alarm bells start going off.  Why did we get rid of 
> it if it was useful?

Huh, apparently it was handled previously. I really have no idea, 
apparently I thought something changed in the kernel. Maybe based on 
testing only certain hardware.

Looking back to kernel 5.3 (since 5.4+ was mentioned in that commit) I 
really don't see much difference either. This device was on 5.11, and 
again, not much different than current upstream in that regard.

> 
> 7 consecutive lost beacons is actually a lot.  That's ~700ms with no 
> connection with default settings.  And you can maintain the connection 
> after that for another 5-6?  Something smells fishy.

According to the logs, yes. Looking back to the logs in the commit it 
was actually 4 seconds.

Still, I'm not sure how it could get that far without a second lost 
beacon event (e.g. miss beacons, but get a nullfunc reply, miss 7 more, 
nullfunc reply etc.). With a single event the longest it could get drug 
out would be 1.7 seconds (7 beacons + 2 nullfuncs) before either 
disconnecting or recovering but missing more beacons and generating an 
event, unless there is some other reason=4 failure path I'm missing.


> If the kernel has a hard limit after which it expects the connection to 
> be disconnected, we can start a timer for 2-4x that limit?  Looks like 
> kernel uses probe_wait_ms parameter for this with a default of 500ms.  
> Is your setup using the default values for beacon_loss_count and 
> probe_wait_ms?

Yep, everything is default as far as nl80211/driver options.

> 
> Regards,
> -Denis
