Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD2A2108
	for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwdSgC4Y"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b2ec5ee2e4so2925860b6e.3
        for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 10:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698685510; x=1699290310; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWg5GuL6JpN6m+bjRs4Sn64EgCu988FmN2n2FiDx20M=;
        b=iwdSgC4YijYIjuNvFVC/6KTXJVUqBaEto4DCTuQD8LSMBEBs1Y6p+XUZGOV7Youa5r
         ZUHVVKNOW3CN53vEX9QSGyIKWqaV0MyBg/vc4gf/noSDuix5k3LaAMiAzOWER+p+Qlh9
         1lvDZ1Vb4wXPfRCt//Dz/05OgP/ekZOcVNHi0bl4bgntRXuT9W6lcRxMvI3kMWTH38f4
         /qrUQi+FdmV0OA3Xmy+N+fCAoU/x5EVgV6gyPf9yefl+f+ka+v6igKfrzLM5UL35UyEz
         AgQSPHc1T9oxpV/OG0Zot1c24cRxoIH4/06JbqLbOw5gsgnwOhN7u37DKin9+Zd7S+5/
         ueQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698685510; x=1699290310;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWg5GuL6JpN6m+bjRs4Sn64EgCu988FmN2n2FiDx20M=;
        b=IkOMuzOGC2Kyp62G9KullqTVVynHLATZZObJSkzBIGzXVRBILzDzFKwZPN7dlJ20Qq
         Ju1hiFkYkB04X2FfSSIbao/d34u2TpotSX0VpRoaz3T1aMnkiKA+ihcla1Eb/bYs25pD
         dfxS/Fl5spvX+fuM3VpTP7xs+jHR2ZZ7a35lJ/0NSgFZoop0b/3nOq9Ol/d2NdHfgXa/
         D6nYKyuiVw2x4hE55xsMezc0Nr5EDrGCl/ZDULU9mxxdHdXTr3VnIqhTkrch3qKM24J2
         UyOYgQgrL0AY+QrsqNy2pZkhEmxRjoJUAat4gAXUwakgHP85rL/vJnS/v+ViAuXZwxju
         5Y0Q==
X-Gm-Message-State: AOJu0YyLldYmecjO0TrWnMuH0Poxs49cXCjXhHN/CNBJqMimHSqSg8d5
	HyATaKTksivUOW1uVEmFtXmfLDmqbOY=
X-Google-Smtp-Source: AGHT+IF4sVzdZNomNPt3i/5zvGJb2QjbYzo0WRgZGZnrQ3YIPX+ZDu+Q992rWP6UdSvbm9va2PQ1BQ==
X-Received: by 2002:a05:6808:1385:b0:3b2:f54b:8b3a with SMTP id c5-20020a056808138500b003b2f54b8b3amr13958612oiw.27.1698685509962;
        Mon, 30 Oct 2023 10:05:09 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d4-20020a05680805c400b003b2df32d9a9sm1430455oij.19.2023.10.30.10.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 10:05:09 -0700 (PDT)
Message-ID: <fb8dfeeb-3f5d-49d2-8a4e-063b4933d905@gmail.com>
Date: Mon, 30 Oct 2023 12:05:07 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Packet/beacon loss roaming improvements
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231030134837.452957-1-prestwoj@gmail.com>
 <b5138012-c4aa-40bd-892e-5b578a29ade4@gmail.com>
 <0cf695c9-7abc-40e9-a6fa-fdd10589839b@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <0cf695c9-7abc-40e9-a6fa-fdd10589839b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 10/30/23 10:37, James Prestwood wrote:
> Hi Denis,
> 
> On 10/30/23 8:00 AM, Denis Kenzior wrote:
>> Hi James,
>>
>>>
>>> We were seeing beacon loss events not resulting in an immediate
>>> disconnnect (as I have always expected), still eventually but after
>>
>> If I recall correctly, Lost Beacon is sent after several beacons in succession 
>> were lost.  You are right that this could just be bad luck and doesn't 
>> actually mean that no packets are getting through.  However, in practice 
>> mac80211 almost always disconnected us soon after.  Didn't we test this pretty 
>> thoroughly?
> 
> Yes, it appears mac80211 by default waits for 7 missed beacons before sending 
> the event. It then probes the AP (either nullfunc or probe request) so 
> apparently the connection could be recovered if the AP responded. Unfortunately 
> we don't get any notification in userspace if the AP responded or not...

So this magic here?
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/tree/net/mac80211/mlme.c#n3215

> 
> I can't remember what hardware was tested. But there really wasn't a consistent 
> way to test this. The testing involved me disabling roaming and walking away 
> from the AP until I got disconnected. Sometimes this was due to beacon loss, 
> sometimes the AP disconnected explicitly. But what I do remember is when beacon 
> loss occurred, a local disconnect followed near immediately. This is why (I 
> think) we thought there was no reason to handle this event.

So what does your ath10k driver/hw do?  Does it send nullfuncs or probe requests?

> 
>>
>> My memory is fuzzy here, but I seem to recall that power save has an effect on 
>> how lost beacon events are treated by mac80211.  Maybe your recent power save 
>> patches had an effect?
> 
>  From what I can tell in mac80211 power save doesn't change handling. Its the 
> driver that tells mac80211 of the beacon loss but maybe the driver (or firmware) 
> could handle it differently depending on power save.
> 
> When I was watching this device power save was disabled.

Okay, fair enough.

>> If this is a driver behavior quirk, then this belongs in src/wiphy.c 
>> driver_infos table somehow.  I'd really rather not add a bazillion config 
>> options that address the bug-of-the-day.
> 
> Yeah, adding a driver specific quirk doesn't seem like the right route.
> 
> I think for now there is no harm in trying to roam on beacon loss, basically the 
> same handling as packet loss. If a disconnect comes immediately the scan would 
> be canceled. Otherwise maybe we get lucky and be able to roam.

So the problem is, we had the _exact_ same behavior you're proposing here.  We 
took it out.  See commit:
836beb1276d1 ("station/wsc: remove beacon loss handling")

So when we do that, alarm bells start going off.  Why did we get rid of it if it 
was useful?

7 consecutive lost beacons is actually a lot.  That's ~700ms with no connection 
with default settings.  And you can maintain the connection after that for 
another 5-6?  Something smells fishy.

If the kernel has a hard limit after which it expects the connection to be 
disconnected, we can start a timer for 2-4x that limit?  Looks like kernel uses 
probe_wait_ms parameter for this with a default of 500ms.  Is your setup using 
the default values for beacon_loss_count and probe_wait_ms?

Regards,
-Denis
