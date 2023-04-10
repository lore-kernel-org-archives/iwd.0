Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1383C04
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 14:59:58 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so10096778pjb.5
        for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681138798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lbNYHggf8vWquliUvH76QfpMoQDpGtgfHTzYBokLjrU=;
        b=phQaEh0EOpWlaeJXMGIHJC9+7SsmZTtpbjSrFFM5Z8XrADvrG6NB5WT3XAhcWDjUIM
         pg0EylBN711dDEQrbzH2jHtXLt9+di7VAny+E9nyKln67E6KYGBMiay4aqWhWTa6EQpK
         QJGvHUdu3adzLYwgsZXc4rd6LrgRJka+WNo13WUPkDIvqn/PmT5W+xtFnxr1u8X/w31H
         KsLOX7b4aqKLNTOQjaNIrn8H8UtHWwcxy4JdJ7FifSPI8Kh1Lwte9hfF+DwdrIi15acP
         C7mJGdjRSOqMm0kItrUbujxfvHqiSaZ5414ZSJ8tblSWuQ1mkBna57ZfH1UY35n+5Y+G
         ZrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681138798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbNYHggf8vWquliUvH76QfpMoQDpGtgfHTzYBokLjrU=;
        b=TrfPvQJfBZUg8MXHr81ksb/0AWsbu9fxbYIKNHQimBqskangaIasNbu/FDccjRKxQd
         XWQx+Xs8BGcLo1Bu4HejMNy118/QgVkfR+0UgJVyZ22Xkpp2ze3vJ2jbbgfCf5WBt0El
         8bUrh5/Jf5S9kpKBsiMBVipBLc1ggqacLC3LKN60UzFbs0UMBACjzt9AzBhuTH+XbqnT
         CDpvcPFax7oA9NxW7MPawjrchOkiNKXDJMXEJ3fTtTcUfHl4v4Pc+RylXtu8xN2ge6JP
         5loe5B0pfx6w08T9p9wMdt7aDZW175PvB+JMioLA0f+KHJVI4OTHSXJCbQFiNLWchnnl
         7pYA==
X-Gm-Message-State: AAQBX9edh4ZgfVIFGxlsoQH4mSPFBTWxVIXJtB/P3mKwKBglGbE5y5PW
	31kN+Kf7Y6WR/QSBHFLbYdeEIrVQ9DvyXw==
X-Google-Smtp-Source: AKy350bYvb7+RNqNZ29KAJ3SUxd8cqnL5W5Iuwt2olTicUgADc1iKA4cCdWrfV89NWVOZcrzrskeOg==
X-Received: by 2002:a17:903:1211:b0:19e:7d67:84e6 with SMTP id l17-20020a170903121100b0019e7d6784e6mr15547425plh.0.1681138798414;
        Mon, 10 Apr 2023 07:59:58 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ab9000b001a1d4a985eesm7869932plr.228.2023.04.10.07.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 07:59:58 -0700 (PDT)
Message-ID: <8cc82b09-3a8c-d4fe-192b-4f8ae0c686f6@gmail.com>
Date: Mon, 10 Apr 2023 07:59:56 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Initial choice of network should consider RSSI?
To: Cedric Sodhi <ManDay@openmail.cc>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <ZDKinaeLzoAvaIb1@air>
 <9fcce33b-22ad-bb56-d5d3-724450b709b6@gmail.com>
 <CAPv5Ue6KEZVxT2Mb15bBH_8n53abvJbu_+aCTHJgP9ODU3AT5Q@mail.gmail.com>
 <ZDOm8xHuEXQ7l1EZ@air>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <ZDOm8xHuEXQ7l1EZ@air>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Cedric,

On 4/9/23 11:04 PM, Cedric Sodhi wrote:
> Hello and thank you for the responses.
> 
> Denis, perhaps I misunderstood something, my description wasn't clear or/and (most likely, after I looked at iwd -d), my diagnosis was wrong in the first place, but I thought that the problem was that iwd will connect to a network as soon as a network can be connected to and it will not _revise_ that decision (connect to a better network afterwards). That would become a problem if a "bad" network becomes known moments before the "good" network becomes known.
> 
> Looking at iwd -d, however, I get the following list, before it attempt to connect to BAD_NETWORK
> 
> src/station.c:station_add_seen_bss() Processing BSS '24:5a:4c:25:f4:71' with SSID: BAD_NETWORK, freq: 5220, rank: 736, strength: -7200, data_rate: 90.0
> src/station.c:station_add_seen_bss() Added new Network "BAD_NETWORK" security psk
> src/station.c:station_add_seen_bss() Processing BSS '68:72:51:48:72:c2' with SSID: GOOD_NETWORK, freq: 2412, rank: 492, strength: -5400, data_rate: 72.2
> src/station.c:station_add_seen_bss() Added new Network "GOOD_NETWORK" security psk
> src/station.c:station_add_seen_bss() Processing BSS '24:5a:4c:24:f4:71' with SSID: BAD_NETWORK, freq: 2462, rank: 472, strength: -7300, data_rate: 57.8
> src/station.c:station_add_seen_bss() Processing BSS 'cc:2d:21:5d:dd:95' with SSID: BAD_NETWORK3, freq: 5240, rank: 443, strength: -7600, data_rate: 65.0
> src/station.c:station_add_seen_bss() Added new Network "BAD_NETWORK3" security psk
> src/station.c:station_add_seen_bss() Processing BSS 'cc:2d:21:5d:dd:91' with SSID: BAD_NETWORK2, freq: 2417, rank: 197, strength: -7400, data_rate: 28.9
> src/station.c:station_add_seen_bss() Added new Network "BAD_NETWORK2" security psk
> src/station.c:station_add_seen_bss() Processing BSS '24:5a:4c:24:f4:73' with SSID: BAD_NETWORK, freq: 2462, rank: 90, strength: -8300, data_rate: 11.0
> src/station.c:station_add_seen_bss() Processing BSS 'd8:32:14:ee:a3:d1' with SSID: BAD_NETWORK2, freq: 2422, rank: 37, strength: -8500, data_rate: 5.5
> 
> so from what you write James, I think the problem lies in the estimated data rate, given how it appears high on the network with bad RSSI.
> 
> I suspect the recommended course of action at this point is just blacklist the station which seems to yield a "misleading high" data rate!
> 
> Unless my assumption about how iwd doesn't "revise" network choices during an initial scan period is somehow valid or related to my probelem, I suppose this is an issue with the particular station then and has nothing to do with iwd's behaviour, so thanks for the help!

Yes, as I suspected the "BAD NETWORK" just advertises better 
capabilities which then ranks it higher. I think for the short term, if 
you don't want to connect to "BAD NETWORK" automatically you can add 
AutoConnect=false in the network profile, or remove it completely if you 
never want to connect.

This unfortunately is one of the downfalls of heavily weighting data 
rate to network selection. Maybe something we need to look into more or 
possibly set (or allow to configure) hard limits on RSSI. We are also 
open to suggestions.

Thanks,
James

> 
> Cedric
> 
> On Sun, Apr 09, 2023 at 10:07:34AM -0700, James Prestwood wrote:
>>     Hi Cedric,
>>
>>     On Sun, Apr 9, 2023, 9:58 AM Denis Kenzior <[1]denkenz@gmail.com> wrote:
>>
>>       Hi Cedric,
>>
>>       On 4/9/23 06:33, Cedric Sodhi wrote:
>>       > Hello,
>>       >
>>       > I have a permanent problem with IWD when multiple known networks
>>       (different SSIDs) are in range: With a large probably (although it is
>>       most likely just random, depending on when the beacons fire) IWD manages
>>       to connect to a network with an unusable low RSSI while better networks
>>       are available.
>>       >
>>       > I suspect there is currently no logic in place which would somehow
>>       work in favor of making a "good" choice? RoamThreshold, for example,
>>       doesn't seem to apply and InitialPeriodicScanInterval seems to have no
>>       effect either, given that the (initial) connection to the (bad) network
>>       happens immediately before InitialPeriodicScanInterval passed, and that
>>       choice does not seem to be revised even if the better network becomes
>>       visible within InitialPeriodicScanInterval.
>>
>>       Periodic scans are attempted every N seconds, with exponentially
>>       increasing N if
>>       no connectable network was found.  InitialPeriodicScanInterval simply
>>       sets the
>>       initial timeout N.  It isn't that iwd scans constantly during that
>>       period.
>>
>>       Once a periodic scan completes, and there's something to connect to, iwd
>>       attempts to do so.  If there are multiple somethings to connect to, then
>>       iwd
>>       prioritizes networks based on estimated throughput (this is where the
>>       RSSI is
>>       taken into account) and which network was most recently used.  There are
>>       some
>>       other factors.
>>
>>       >
>>       > Would it possible to either extend the meaning of
>>       InitialPeriodicScanInterval or introduce another option which would
>>       allow IWD to connect to a better, different SSID (thus not covered by
>>       roaming) within an initial period?
>>       If you have a more concrete proposal please share it.  And patches are
>>       always
>>       welcome :)
>>
>>     It would also be helpful to see the debug logs too see why IWD chose the
>>     network it did. This would answer questions I have like:
>>     Did the scan only see one network?
>>     What was the estimated data rate of both networks?
>>     How good/bad was the RSSI between the two networks in question?
>>     Thanks,
>>     James
>>
>>       Regards,
>>       -Denis
>>
>> References
>>
>>     Visible links
>>     1. mailto:denkenz@gmail.com
