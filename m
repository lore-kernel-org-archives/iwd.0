Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14377F
	for <iwd@lists.linux.dev>; Mon,  1 Aug 2022 17:24:59 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so14414950fac.13
        for <iwd@lists.linux.dev>; Mon, 01 Aug 2022 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1LLaPP1iXo6Ynk/z8/GMsl6lAZSEUuEtokWJPCRWhbo=;
        b=Qau/KL7y4YKdWhfRri5xVnAQv+vrp5sb23eoAaJPnvSD4epbuI+Szrg8qRhBH+8VRr
         VWk9dmLu4IHlla6i32g/KZcRiGGKVmJGBcBNMw7WZ3j4DHA4jfwGWTEFh6JvniGrSAkr
         GBqu88Q2yKffkXsH8HK/8bTiM22OmNhQgWvsvHNdYApACFSHpKuc89OTfJfqMQQMVic3
         p+zDgK3XLbuQ2xQhUuQhitPWgb59ZvtUGqKNsOi4ygsABxoIUBZVhsAgr9U+u2ZpARBr
         /uuwQxo5uop+2OfqLyvWP7Vd17OQK9Qia9B97HPfuIWZvXrgpB222g8EE7+j5dQyaQXy
         ziZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1LLaPP1iXo6Ynk/z8/GMsl6lAZSEUuEtokWJPCRWhbo=;
        b=qDChRhSz8yvfPfZk6ppBRnSY0vqbVqsN4892xtVSDF5RoQh75RY90ubaoD6iOOt3dD
         3MEwFmbvFtuBqSh0mgRYbHd1JBzH+Mqc4n7ftaBD3eLyI/D5mcLkJRVOhB46i4jc+iJy
         hZVFf4YaiGgdNJg15HypXxqEjOysf2L2t6KOfdltUYN2TToJ4bhbsdJdIa8Ln630ZUJq
         /O1sc9yKAVB8MzZTsLeiXejk0Vu1oxPeNiKmMI0qEbQFT3DlsQPKyfBqZFM2cYzDqQwe
         ByXJc3WRrpfdsI4zQUh86z66qq6QM4i4iqBAmhhKHUc70spG2WuNwSBdSlL8HKmh95tQ
         eKDQ==
X-Gm-Message-State: AJIora9vqxhChccQpEcchKIcbgS3Ut0RdydHzyUdgy4oMssbpi0pOgWr
	XyIgJyky8GAXVD+4UhuANJM=
X-Google-Smtp-Source: AGRyM1uKNCALA5+FKC8ysi2JAeh7qvYTLr2wMSO2/7ZFefuGMlsjgSFCqmgk8HTp8LExEPaSgTXNZw==
X-Received: by 2002:a05:6871:9b:b0:10b:c5d0:4377 with SMTP id u27-20020a056871009b00b0010bc5d04377mr8113702oaa.197.1659374698651;
        Mon, 01 Aug 2022 10:24:58 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f24-20020a056870899800b0010db1a8d931sm3250050oaq.28.2022.08.01.10.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 10:24:58 -0700 (PDT)
Message-ID: <c012837a-9d79-1909-dd2f-3fcd98828d52@gmail.com>
Date: Mon, 1 Aug 2022 12:14:03 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] netdev: Add logging for CQM messages
Content-Language: en-US
To: Michael Johnson <mjohnson459@gmail.com>
Cc: iwd@lists.linux.dev
References: <20220801100631.41605-1-mjohnson459@gmail.com>
 <6bc199e2-2f40-b192-9de6-30fceb2510ea@gmail.com>
 <CACsRnHULBH=jmCiG4=kczJALPsy7Whx+TmDf-JhQryyc5GwBow@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CACsRnHULBH=jmCiG4=kczJALPsy7Whx+TmDf-JhQryyc5GwBow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

>> I'm not sure 'above=%d' is going to work.  rssi_event is only set on
>> THRESHOLD_EVENT_LOW/THRESHOLD_EVENT_HIGH.  If RSSI_LEVEL is being reported, that
>> pointer is still NULL.
> 
> Should the top level `if (rssi_event) {` not cover that case? I
> believe it checks both
> pointers before the info statement. I didn't add any output in the case of an
> RSSI_LEVEL but no THRESHOLD_EVENT_* as I haven't seen this actually occurring
> so assumed iwd didn't set up non-threshold events?

Ah you're right.  I guess the kernel does send the threshold event attribute as 
well.  I'm really not sure why actually?  This seems useless since it depends on 
knowing the currently used high/low thresholds, and only the kernel knows those.
>>
>>> +                                                     *rssi_event, *rssi_val);
>>>                        netdev_cqm_event_rssi_value(netdev, *rssi_val);
>>
>> Hmm, I don't think wpa_s uses RSSI_LEVEL stuff in the kernel, does it?  The
>> reason I ask is that we do have UIs that setup RSSI level reporting for
>> displaying connection link quality (in number of bars for example).  Since such
>> events are quite common, I think you're going to get quite a bit of spam in the
>> logs.  Are you only interested in cases where the roaming threshold is reached?
>>    If so, you may need to modify netdev_cqm_event_rssi_value() instead.
> 
> Sorry, I should have included more reasoning behind the change.
> 
> In my use case the client is running headless and so the logs are
> really the only
> insight into why the network might have degraded to the point of causing issues.
> For example, if the client stops receiving data, it is useful to know
> what the rough
> signal level is that caused it as that might imply a dead zone or
> interference. All
> debugging is done remotely as well so we can't ever debug the network while
> it is currently in a bad state hence the log part.

I wonder if we should report this over D-Bus instead?  I mean you can always 
setup your own SignalLevelAgent, or we could even add more reporting via 
StationDiagnostic interface?

> 
> The useful data isn't just the threshold but the general signal level
> at the time of
> an incident. If all is working then we would have roamed before the signal gets
> bad enough  to cause issues (it follows that we don't really care about _good_
> signal values so maybe we could reduce spam there?)
> 
> As for the general spamminess, does the UI RSSI reporting cause more events
> than running normally? I believe I was only seeing events when the signal had
> changed more than the hysteresis value in netdev_build_cmd_cqm_rssi_update
> (5 dBm). This doesn't seem too frequent (for me at least) when the client is
> mostly static. When it is moving it is generally useful information.

It would.  By default we program only the low signal threshold value.  So you 
should only see signal changes around that value.  If an rssi agent is used, 
then multiple thresholds are programmed, so you'd see rssi events even when the 
signal is very good.

> 
> For wpa_supplicant, I'm not sure the exact mechanism it uses but it does report
> almost identical output at a fairly high frequency if the client is moving e.g.
> ```
> May 08 08:56:04 p3-2019 wpa_supplicant[842]: wlp2s0:
> CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-62 noise=-93 txrate=6000
> May 08 08:56:14 p3-2019 wpa_supplicant[842]: wlp2s0:
> CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-76 noise=-93 txrate=6000
> May 08 08:56:27 p3-2019 wpa_supplicant[842]: wlp2s0:
> CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-79 noise=-94 txrate=6000
> ```
> 

Right, but I think it sets a single CQM threshold, not multiple like we (might) 
do.  Also, wpa_s is very spammy since it is really (only) meant for testing wifi 
implementations in a lab ;)

> Finally, the reason I made this `info` level was in the hope that I could
> remove the `-d` flag from iwd which does produce a lot of spam in the logs.
> This isn't really feasible at the moment as there isn't enough `info` logging
> to track down any issues that might occur on production systems where
> changes are harder to make. If the `info` level becomes to verbose, maybe
> iwd could set the default logging level to `warn` to reduce spam?

You can use a glob match for the -d flag.  Something like:
	#iwd -d '*Signal change event*'

So you can make the rssi messages as 'debug', and have iwd only print those you 
want.  Multiple globs are supported too, separate them by ':' or ','.

Regards,
-Denis
