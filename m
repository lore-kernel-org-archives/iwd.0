Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86C17C7
	for <iwd@lists.linux.dev>; Mon,  7 Nov 2022 03:46:17 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-13b103a3e5dso11440370fac.2
        for <iwd@lists.linux.dev>; Sun, 06 Nov 2022 19:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hf4pt3VnsRebYQ1P1s11lCaJH/zVAe94KKBZw54G3R8=;
        b=Yk246PD4ddnzb094EeTpCDupa8/xbwV4H5kKpxLNvIfc5a55KQwxBwmKFXbQAuCX/U
         2SAyAUdxi1iO8+svaGAwhTgilFpYdRQkkW9Ap71orVR3eLeweWUGk1w65q90h2ZIqvHf
         iWEdle3e7j6vHiFk1RIVMKt6l+SVUQMFJyrDc1RxcrUKcq6oyR9493uCoZIPj7fQoZvB
         ObhO9+cItJr1N1eaD0C8yrPxSU5Ar8sjKcgJ3q/8gN0OFPw3NaMSzUOnTUP/DkFTe70k
         TKhLnkBhLChWKswewO1goGAvv/iH64KPolEJFQAJM4ylgssQyKKRXtzU5sKup42rWFxJ
         sHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hf4pt3VnsRebYQ1P1s11lCaJH/zVAe94KKBZw54G3R8=;
        b=M856P1LhB+56E5Rn3aCyW20Ch+TQc3TWg/VKLlvvYcIYEig0N/HftI99nXBLAGV8WL
         P3wM3CboDcfBGvo4ABTK43oXdPlIVeMbDmw+CNgMuO3ulOD+IoTRMQP5w4tpaw0ZOSLK
         Ut+8HdUAIAZL3OfVKzsDwLe5usu5ooH5GYwQ5E8QMnRS8IG7gRO6ZL1gBp7rvYm9xgE7
         2mBKUIFKAqqRcXhHO8tp1WSuADjJD9KsDl09vhUo4BDgeJrearqIB1xDBxlujromNIj0
         BAIRu/EO+Wtm6Zetx0Y2wu+j1y/vK2Pn+YZQWOy6Q9Oz0B2/om4tZfuOmR98LLpZ3oN1
         3SYQ==
X-Gm-Message-State: ACrzQf1r3oXVlXGJtgkSbyHSS3ek4qQ/XEUqak3ByZ0TTtmK92xv/+4Y
	WP06Q7Mz5kt9DLn9w16ceRM=
X-Google-Smtp-Source: AMsMyM4eJFwargL+oAl+V5Pulq4cfyD3N9+hsZLjV7NRiH2IphZDoCxQbuy51H2z4x47GKS0NDdOCw==
X-Received: by 2002:a05:6870:40d2:b0:136:9ebc:9350 with SMTP id l18-20020a05687040d200b001369ebc9350mr28655317oal.151.1667792776885;
        Sun, 06 Nov 2022 19:46:16 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s13-20020a056870610d00b0011f22e74d5fsm2558574oae.20.2022.11.06.19.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 19:46:15 -0800 (PST)
Message-ID: <4d50da71-40e3-f888-be79-b52fa8208e88@gmail.com>
Date: Sun, 6 Nov 2022 21:46:13 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Sometimes RxBitrate of 1000 Kbit/s
Content-Language: en-US
To: =?UTF-8?Q?Patrick_H=c3=a4cker?= <pat_h@web.de>, iwd@lists.linux.dev
References: <5893463.lOV4Wx5bFT@mmm>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <5893463.lOV4Wx5bFT@mmm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Patrick,

On 11/6/22 08:36, Patrick Häcker wrote:
> Hello all,
> 
> from time to time my RxBitrate (sometimes the TxBitrate, too) goes down to
> 1000 Kbit/s, whereas it otherwise is in the usual 5 to 6 digit range. This
> seems to especially happen some time after waking up from standby (S3), maybe
> also from hibernate (S4).

iwd doesn't do anything on sleep (it isn't even aware of sleep).  So it is up to 
the kernel driver to do the right thing.  Maybe it isn't?  You'll have to ask 
the kernel / driver / firmware people for your hardware.

> 
> When it happens, wireless usage is super slow to non-existent.
> 
> Restarting iwd immediately solves the problem. I routinely also reloaded the
> involved kernel modules, but I think this was unnecessary as I
> skipped it the last few times and only restarted iwd and this was enough to
> get it back to a working state.

Killing iwd most likely power-cycles the card (since it brings the interface 
down, or even destroys it completely), and probably reloads the firmware. 
Removing the kernel modules probably doesn't matter.

We have seen some reports where (for example iwlwifi) behavior can change 
between kernel versions due to different firmware behavior.

Some network managers (like NM) will explicitly IFDOWN wireless interfaces on 
suspend and bring them up on resume.  This isn't cost free and we'd rather not 
do this.

<snip>

> This is how it looks after restarting iwd:
> # systemctl restart iwd
> # iwctl station wlan0 show
>                                   Station: wlan0
> --------------------------------------------------------------------------------
>    Settable  Property              Value
> --------------------------------------------------------------------------------
>              Scanning              no
>              State                 connected
>              Connected network     *redacted*
>              IPv4 address          192.168.0.10
>              ConnectedBss          98:9b:cb:4b:b1:cd
>              Frequency             5180
>              Security              WPA3-Personal
>              RSSI                  -72 dBm
>              AverageRSSI           -72 dBm
>              RxMode                802.11n
>              RxMCS                 9
>              TxMode                802.11n
>              TxMCS                 3
>              TxBitrate             60000 Kbit/s
>              RxBitrate             60000 Kbit/s
>              ExpectedThroughput    31125 Kbit/s
> 

Some of these numbers seem suspect, but iwd has no influence on them.  RX/TX MCS 
selection is done by the driver / firmware.  All iwd does is report what the 
driver is telling it.

<snip>

>  From https://iwd.wiki.kernel.org/debugging I would assume, that IWD_GENL_DEBUG
> might the relevant environment variable, but I am really not sure.

This isn't what you're looking for.  That variable is for debugging generic 
netlink communication which we haven't needed to do in years.  We probably 
should take this out completely.

> I could obviously implement some kind of watchdog checking the output of iwctl
> every some seconds and restarting iwd in case, but I would avoid that if there
> is a cleaner solution available.

You could try adding an ifdown / ifup for the wifi interface triggered by 
suspend / resume (or rfkill) and see what happens?

You can also try to run run iwmon in order to capture what is happening on the 
nl80211 API level when entering / leaving suspend.  The driver people might be 
interested in this information.

> 
> I think is problem started to occur some months ago. It might be related with
> some kernel or iwd update some time ago. But due to the long time until
> occuring, a sound bisect might take more than a week.

I'd start with the kernel, it is hard for me to imagine what iwd might be doing 
to trigger this.

Regards,
-Denis
