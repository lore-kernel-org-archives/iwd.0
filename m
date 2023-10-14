Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541D15E80
	for <iwd@lists.linux.dev>; Sat, 14 Oct 2023 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM3pggH9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso24121875ad.3
        for <iwd@lists.linux.dev>; Sat, 14 Oct 2023 09:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697299367; x=1697904167; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wUBmC6xOMVC9i6kSB/zBA8ljKUJH9Gv69vyTN9IKCUQ=;
        b=dM3pggH9JacbtAVO1gIStSR0ppNa5IAAa00sOgNRydrVYr/nLhuBaqA/rPXmBYAxsh
         lFRC5zjWRkdlFMsh6oU6ClPvVJRNZro0OFOx71lKei1bvLgUJ9eB5UexQUm73Hq+Uadu
         O2d+mXpm+K+ZZpzg5vbGKaPx3ShrymKeDzw8C55u9/4oxuh0K68t2LFSWGXAx4k7khag
         1J/8ItEHSUUepzWv1OoJzcFLRHoLigmqj01IzOATghKcAj9yir12QIjW6Pa585tRK+zc
         T0l20TZGKfXiv/D3N7q/Bl8Y7ixoOGF2Bu/ncH0LJhEXL8RnaMUq7yFsZp3pG8r3b0hf
         Ed1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697299367; x=1697904167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUBmC6xOMVC9i6kSB/zBA8ljKUJH9Gv69vyTN9IKCUQ=;
        b=C04Vk+KFGCG3EBkmwj1/vCzN1KD3mXSp1ZW+vPqkjxJ4erG2S+7OoGf/65IwFHRyBk
         vE7BhDki6jdpNVLhOtHaoW7cm7Wta5HmTyzTCJiiVsgJ4jZKO7e2ArQxxaxOyTGORVTp
         G+h9eym7SQCe6olWT6C2vPVLcU43y0MKoxPV1dW0Gq0VYvTwU5rPU/aO9/8jvqAXCEmh
         BTNlBqP5nssDYMi6JQrvkFA96/dExA78W2wAukRf08cORtiIeEvk52avNvZpWT2ov3AY
         wn12Vk7E4uXEYyAIFzJB5qcFYrly14xsvVvONfz6KKpiC37fYC7PRB8+2GpKqX2UFstN
         rY+w==
X-Gm-Message-State: AOJu0Yw+/ycZbEHkIV1kV0ZQOV3LwSBE8qXh/ju57QG1eyUZoESiVYk3
	UHkJOQMTJJYcVQEUCWs9FH8UslVbJF8=
X-Google-Smtp-Source: AGHT+IFep2iG6kS38jhodZBbzCyVeWMq1rQorFWQz5SfWWENgzFwaEP8FfJguCvkYJZjZ6M3CwUBmA==
X-Received: by 2002:a17:902:da85:b0:1c9:db23:705f with SMTP id j5-20020a170902da8500b001c9db23705fmr8710372plx.45.1697299367320;
        Sat, 14 Oct 2023 09:02:47 -0700 (PDT)
Received: from [192.168.1.73] (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id iy1-20020a170903130100b001c736370245sm5733434plb.54.2023.10.14.09.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Oct 2023 09:02:46 -0700 (PDT)
Message-ID: <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
Date: Sat, 14 Oct 2023 09:02:45 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
To: Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>,
 iwd@lists.linux.dev
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Simonas,

On 10/14/23 2:23 AM, Simonas Kazlauskas wrote:
> Hello everyone,
> 
> I’ve been seeing some weird behaviour with iwd in my environment with 
> multiple Unifi access points, which has led me to run iwd with debug 
> mode enabled that I look through once in a while. I anticipate writing 
> more about my woes in the future, but this is the most apparent 
> weirdness I’ve seen.
> 
> In my situation, when a scan occurs, I’m seeing that 2.4GHz channels 
> will have throughput estimations that consider be realistic – the data 
> rates reflect the rates I get after connecting to those APs. On the 
> other hand, the estimated rate for 5GHz channels is extremely low & 
> incorrect from what I can tell:
> 
>      [2023-10-14 11:23:46.006184] src/station.c:station_add_seen_bss() 
> Processing BSS '00:00:00:00:00:01' with SSID: SSID1, freq: 2437, rank: 
> 1126, strength: -6600, data_rate: 137.6
>      [2023-10-14 11:23:46.006293] src/station.c:station_add_seen_bss() 
> Processing BSS '00:00:00:00:00:02' with SSID: SSID2, freq: 2437, rank: 
> 1126, strength: -6600, data_rate: 137.6
>      [2023-10-14 11:23:46.006405] src/station.c:station_add_seen_bss() 
> Processing BSS '00:00:00:00:00:03' with SSID: SSID3, freq: 2437, rank: 
> 844, strength: -6700, data_rate: 103.2
>      [2023-10-14 11:23:46.006514] src/station.c:station_add_seen_bss() 
> Processing BSS '00:00:00:00:00:04' with SSID: SSID4, freq: 2437, rank: 
> 844, strength: -6700, data_rate: 103.2
>      [2023-10-14 11:23:46.006618] src/station.c:station_add_seen_bss() 
> Processing BSS '00:00:00:00:00:05' with SSID: SSID3, freq: 2462, rank: 
> 422, strength: -7600, data_rate: 51.6
>      [2023-10-14 11:23:46.006731] src/station.c:station_add_seen_bss() 
> Processing BSS '00:00:00:00:00:06' with SSID: SSID4, freq: 2462, rank: 
> 422, strength: -7600, data_rate: 51.6
>      [2023-10-14 11:23:46.006889] src/station.c:station_add_seen_bss() 
> Processing BSS '00:00:00:00:00:07' with SSID: SSID2, freq: 2462, rank: 
> 422, strength: -7600, data_rate: 51.6
>      [2023-10-14 11:23:46.007017] src/station.c:station_add_seen_bss() 
> Processing BSS '00:00:00:00:00:08' with SSID: SSID1, freq: 2462, rank: 
> 422, strength: -7600, data_rate: 51.6
>      [2023-10-14 11:23:46.007135] src/station.c:station_add_seen_bss() 
> Processing BSS '00:00:00:00:00:09' with SSID: SSID3, freq: 5180, rank: 
> 140, strength: -8000, data_rate: 17.2
>      [2023-10-14 11:23:46.007259] src/station.c:station_add_seen_bss() 
> Processing BSS '00:00:00:00:00:10' with SSID: SSID1, freq: 5180, rank: 
> 140, strength: -8000, data_rate: 17.2
>      [2023-10-14 11:23:46.007374] src/station.c:station_add_seen_bss() 
> Processing BSS '00:00:00:00:00:11' with SSID: SSID3, freq: 5220, rank: 
> 16, strength: -9200, data_rate: 2.0
>      [2023-10-14 11:23:46.007474] src/station.c:station_add_seen_bss() 
> Processing BSS '00:00:00:00:00:12' with SSID: SSID1, freq: 5220, rank: 
> 16, strength: -9200, data_rate: 2.0

The signal strength for the 5GHz BSS's are very low. Anything below 
-80dbm is _really_ bad. So it makes sense why IWD is choosing 2.4GHz 
instead. IWD's estimation is based on data from the 802.11 spec, and 
capabilities advertised by the APs.

> 
> This leads iwd to try connecting to the 2.4GHz channels first as they're 
> ranked higher. Authentications to those channels timeout, which I 
> believe is caused by the band steering being enabled on the APs. So 
> eventually IWD connects to the 00:00:00:00:00:10 AP anyway.

Band steering should be done after authentication. APs shouldn't refuse 
connections like that, otherwise what would be the point of having a 
2.4GHz network anyways if its impossible to connect to. Something else 
must be going on here.

> 
> Once it does that, iwctl shows rates in the region of 200-300Mbps, which 
> is what I observe in practice as well, and a big difference from the 
> 17.2Mbps that iwd estimated initially:
> 
>      RSSI                  -78 dBm
>      AverageRSSI           -79 dBm
>      RxMode                802.11ax
>      RxMCS                 8
>      TxMode                802.11ax
>      TxMCS                 4
>      TxBitrate             206400 Kbit/s
>      RxBitrate             206500 Kbit/s

This is probably because IWD doesn't take into account any of the newer 
802.11ax IEs when estimating the data rate. So its estimation is based 
on VHT and not the newest EHT rates.

> 
> 
> Is it expected to be that way? If nothing else, this misestimation I 
> believe results in WiFi connection times to increase from sub-second to 
> at least 1.5 seconds, due to waiting for all the 2.4GHz channels to 
> timeout authenticating first. I’ve attached the entirety of my iwd debug 
> log (with redacted BSSs and SSIDs) from today.
> 
> For posteriority my config contains these entries:
> 
>      [General]
>      EnableNetworkConfiguration=false
>      RoamRetryInterval=120
>      RoamThreshold=1
>      RoamThreshold5G=-85
>      UseDefaultInterface=false
> 
>      [Rank]
>      BandModifier5GHz=5.000000
> 
> but as far as my code reading goes none of them should affect the 
> data_rate estimation.

Since the 2.4GHz BSS's are giving you such problems you could try a 
recently added feature to disable the 2.4GHz band entirely. You can set 
[Rank].BandModifier2_4Ghz=0.0.

Also your BandModifier5Ghz setting has a typo, its using an uppercase 
'H'. Someone else got hit by this recently, we need to add support for both.

Thanks,
James

