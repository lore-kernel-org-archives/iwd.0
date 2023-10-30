Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5ED280
	for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8eiSZLi"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1efabc436e4so1213816fac.1
        for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698678061; x=1699282861; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJBDLyEEldaqk4fcpHD9CL9xTia7nzelZrNlUCAQF0g=;
        b=H8eiSZLif+S8esz8h0ePyU+5QSsmo68y8JFvpZzcUAM6TYE9o9E3TqSkzTJNPHUmeo
         +Oh9s0qRwVd1Nxop3GnJlTzRRto4xg9D/E6RJMX+wL465DmuXG4he/345G/Au97jcpPJ
         tC/G4J+pJ3lzDFSq8kRYu7n4ODwmozHIOdyOAIihb2srOw2Q7J4gxlGYFu4fk1A/QCeW
         83mA21+KuS9SKkrQffGjcd4Pw2wkVWiI+f0E3VUlx8b3AOWi5kmhuC6+0QEjVMihXXYV
         QjX/TksTs8n8H0GKS6RhMJmARSkwYgxmqd1I51ljyYs4LiQi94BHRMMiNhlTNgmfuR2U
         H1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698678061; x=1699282861;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJBDLyEEldaqk4fcpHD9CL9xTia7nzelZrNlUCAQF0g=;
        b=vY0ZFF9znO2dbC+xadpnEjkGXfrmxKx/GwFEuQovWFTxFHP4hlvCWNEVcSskbyyR+Y
         zApgKOUyMaLX+flGMIQUJlNoouCKytM9NLaDGMKYFDWOKnZ6L3v+DRA2QqmXk0QIWpYw
         c/qX2DimsWBXQmDRBpqXhKGWl8Bu/DyMzcvTHXSvONS5wYi5NtOf3gD0s6MWbuNvmceb
         nw997i+9RxHjnQlLT/TE0nNKHa81Twyy91IV0sRZqzDDvj5b5XvRLh45aS5IfBBE/CKF
         MnLFTEhGegamocFwIMgk/vELiLZp2E2Ajie6omX4hSlrGdwT20RK1Dkw052oMuFSk1h4
         kE5w==
X-Gm-Message-State: AOJu0Yx/1r0W/IMCgVrkKyBGkG5XIcLsaXgLycKlbjKB4WlKTSaUYRrB
	SYoohGR30jOSInjyRNDWS6W4GcvCwIk=
X-Google-Smtp-Source: AGHT+IG055RR+FNAxm1TqdhAzEA9+mfZD8JRGlGhdSxfwj1pSx3G2MK3l9M7CIGTesIVe4WSfU/wYA==
X-Received: by 2002:a05:6870:311c:b0:1e9:b550:c05a with SMTP id v28-20020a056870311c00b001e9b550c05amr11690656oaa.53.1698678060902;
        Mon, 30 Oct 2023 08:01:00 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v18-20020a056870e49200b001e988bf0ab0sm1633776oag.3.2023.10.30.08.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 08:01:00 -0700 (PDT)
Message-ID: <b5138012-c4aa-40bd-892e-5b578a29ade4@gmail.com>
Date: Mon, 30 Oct 2023 10:00:59 -0500
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
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231030134837.452957-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> We were seeing beacon loss events not resulting in an immediate
> disconnnect (as I have always expected), still eventually but after

If I recall correctly, Lost Beacon is sent after several beacons in succession 
were lost.  You are right that this could just be bad luck and doesn't actually 
mean that no packets are getting through.  However, in practice mac80211 almost 
always disconnected us soon after.  Didn't we test this pretty thoroughly?

My memory is fuzzy here, but I seem to recall that power save has an effect on 
how lost beacon events are treated by mac80211.  Maybe your recent power save 
patches had an effect?

> plenty of time to roam. I initially added handling for
> beacon loss identical to packet loss (try and find a better BSS) but
> noticed that if IWD did not find a better candidate it resulted in a
> disconnect 100% of the time. I watched a client for a full day and
> whenever beacon loss events arrived they were followed by a
> disconnect within ~5-6 seconds if IWD did not roam. This led me to
> believe that at least on ath10k a beacon loss is still very much a
> sign that a disconnect is going to come, we just have a bit more time
> than other drivers. This was the motivation behind re-using/re-naming
> the 'ap_directed_roam' flag in order to force IWD off the BSS.
> 

ath10k is still a mac80211 driver, no?  Given that we did test Lost Beacon event 
behavior before, I would like some more data points before being convinced it is 
a driver behavior change.

> Again, this is just one driver. Maybe other drivers can
> handle/recover from beacon loss. If we instead want to keep the
> behavior the same as packet loss I'm ok with that (I can keep the
> patch locally), or put the forced roam behavior behind a user
> option e.g. [Roam].ForceRoamOnBeaconLoss

If this is a driver behavior quirk, then this belongs in src/wiphy.c 
driver_infos table somehow.  I'd really rather not add a bazillion config 
options that address the bug-of-the-day.

> 
> James Prestwood (4):
>    station: rename ap_directed_roam to force_roam
>    station: start roam on beacon loss event
>    netdev: handle/send beacon loss event
>    station: rate limit packet loss roam scans
> 
>   src/netdev.c  |  6 ++++-
>   src/netdev.h  |  1 +
>   src/station.c | 61 +++++++++++++++++++++++++++++++++++++++++++--------
>   3 files changed, 58 insertions(+), 10 deletions(-)
> 

Regards,
-Denis
