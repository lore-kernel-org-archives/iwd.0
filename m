Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE9C14A9F
	for <iwd@lists.linux.dev>; Wed, 10 May 2023 15:02:22 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-61af33bdf1dso35143516d6.2
        for <iwd@lists.linux.dev>; Wed, 10 May 2023 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683730941; x=1686322941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/8KhD+FxX1+owNfRal3qdiyRnhyKUAl841plR30+7c=;
        b=hK+ai1yfP79k1JpcZyPyRkYuK3I96YYX7MgYSF7ncuo/cfHdLtbpW+DrfX5p3oGOWw
         HrTT4ikcKKxadVwMLakyKfoqE6wgwizPogq1AiM5lH+kbDZ/clO3AmrB52jNi+8VmAG7
         YqHdL98m9a4+8EY+B7dRsCfn6ct3shAjL7n6uElFEsuA3jtFz9l4uP4XF+BOu0ROR+2S
         nwAta9UtYLnPX5qBHMqYzYddRpTZznkcECnwQOhLXICC+qiZ0yEJ1h+WTj3yzksuSZZp
         Ymj5bSAzBaC4jPZRoBLA5G5dVxmvammR729m+F+apw14rv+TiG564x07YltYt2MbtjdY
         18NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683730941; x=1686322941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/8KhD+FxX1+owNfRal3qdiyRnhyKUAl841plR30+7c=;
        b=HC5Gb4p6XMDJYrtXU0BTvlFR1JbRucfE5C+BJBrKuIkypy98rffHYgY8jw9HgH0bpU
         kSNOKvSU/Wy53UJtapnLkBWaoVqKIEj9wnRu5obOz8Tmqea8wMQhI3C5pCjw9ecSTNUm
         uzDuNiuvGf4o3rtv8eNPJo0Dr65lXPghRW9l9yZxZDp2yKGy1rd0H+4018suQOTeEESC
         T9wGYUCdfBdEgrfwes3Y8JoDXE5tzMarHAWR2Ytw+tV1ucZ4ceIruLXOJCH63ZAfllne
         PAKKY8Xei0Wnt1JEM6dikf8dUSS+vV2uPizXzVmhD7ib7Xtqg6uqDZyGGlFD722WLGPD
         dmfg==
X-Gm-Message-State: AC+VfDy8KLPMBu52tB+o2zmgAI9iNViXxfptFcSQZV5pRq1HfUKcJzWj
	jbeWFqXiqvZOs0WicWCyVOjBTiDFfac=
X-Google-Smtp-Source: ACHHUZ5cgcvaBNd813CZa+TIAeN53YnBqWcZJXg2hZrnlEvmS8gq2I80Woz5n2J1aZolu8FepnFoQQ==
X-Received: by 2002:a05:6214:1cc4:b0:5c7:d03c:f2b2 with SMTP id g4-20020a0562141cc400b005c7d03cf2b2mr23516617qvd.28.1683730941275;
        Wed, 10 May 2023 08:02:21 -0700 (PDT)
Received: from [10.193.157.43] ([208.216.218.212])
        by smtp.gmail.com with ESMTPSA id ph1-20020a0562144a4100b005ed90bf69efsm1590157qvb.114.2023.05.10.08.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 08:02:21 -0700 (PDT)
Message-ID: <daf56327-df05-4598-776a-f875a4e5bf45@gmail.com>
Date: Wed, 10 May 2023 08:02:19 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: iwd ap mode changed?
Content-Language: en-US
To: KeithG <ys3al35l@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAG17S_OaL_VK9e-s=DbwwKOAdjX9jR_B9ogifs9Di1-VW=ksmQ@mail.gmail.com>
 <152dff569b6fba0baadd7ac14673cf2a67c42eb4.camel@gmail.com>
 <CAG17S_OvMmYKJP==2bn-XoCtkUDC7b+sMRk+woeSN9Q_GR9PTw@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_OvMmYKJP==2bn-XoCtkUDC7b+sMRk+woeSN9Q_GR9PTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 5/9/23 9:52 PM, KeithG wrote:
> On Thu, Mar 2, 2023 at 10:15 AM James Prestwood <prestwoj@gmail.com> wrote:
>>
>> Hi Keith,
>>
>> On Tue, 2023-02-28 at 21:26 -0600, KeithG wrote:
>>> I am playing with ap mode and I previously used this page to set it
>>> up:
>>> https://iwd.wiki.kernel.org/ap_mode
>>> Now, when I use iwd 2.3, I get
>>> "Operation failed"
>>> when I use the iwctl ap start or start-profile command.
>>> when I revert to version 1.28, it starts to work again.  Is there a
>>> changed parameter in the main.conf or something that I do not have
>>> set
>>> right?
>>
>> Indeed AP mode has changed in recent releases to support HT. The logic
>> now tries to pick the highest channel width possible, and in theory
>> enable higher throughput.
>>
>> But perhaps some hardware doesn't like this, or the logic is wrong. For
>> the time being you can set this in the AP profile (with upstream IWD).
>>
>> [General]
>> DisableHT=true
>>
>> But if you could also send an iwmon/debug log of the problem I can take
>> a look. Make sure you start iwmon before IWD starts so I can see the
>> advertised hardware capabilities.
>>
>> Thanks,
>> James
>>
>>>
>>> Keith
>>>
>>
> James,
> 
> I am finally back on this. I have switched OSes. I was on Arch and am
> now on RPiOS.
> I built and installed iwd/ell for this os but on the same hardware
> (Rpi 3B+) and am having the same problem:
> root@runeaudio(rw):~# cat /etc/iwd/main.conf
> [General]
> EnableNetworkConfiguration=true
> UseDefaultInterface=true
> DisableHT=true

Ah, DisableHT should be in the AP profile, not main.conf.

> root@runeaudio(rw):~# cat /var/lib/iwd/ap/RuneAudioAP.ap
> [Security]
> Passphrase=RuneAudio
> [IPv4]
> Address=192.168.5.1
> Gateway=192.168.5.1
> Netmask=255.255.255.0
> DNSList=192.168.5.1
> root@runeaudio(rw):~# iwctl device list
>                                      Devices
> --------------------------------------------------------------------------------
>    Name                  Address               Powered     Adapter     Mode
> --------------------------------------------------------------------------------
>    wlan0                 b8:27:eb:xx:xx:xx    on          phy0        ap
> root@runeaudio(rw):~# iwctl ap wlan0 start-profile RuneAudioAP
> Operation failed
> When I try to start iwmon, I also get an error:
> root@runeaudio(rw):~# iwmon
> Wireless monitor ver 2.4
> Failed to create monitor interface nlmon: Unknown error -95

This is either a permission issue (sudo iwmon) or a module problem 
(modprobe nlmon).

> 
> In the journal, I get this when I try to start in AP mode:
> May 09 23:47:03 runeaudio iwd[1747]: Could not register frame watch
> type 0000: -114
> May 09 23:47:03 runeaudio iwd[1747]: Could not register frame watch
> type 0020: -114
> May 09 23:47:03 runeaudio iwd[1747]: Could not register frame watch
> type 0040: -114
> May 09 23:47:03 runeaudio iwd[1747]: Could not register frame watch
> type 00a0: -114
> May 09 23:47:03 runeaudio iwd[1747]: Could not register frame watch
> type 00b0: -114
> May 09 23:47:03 runeaudio iwd[1747]: Could not register frame watch
> type 00c0: -114
> May 09 23:47:03 runeaudio iwd[1747]: START_AP failed: -52

"Invalid exchange", that's a new one...

Try putting DisableHT in the AP profile and hopefully it lets you start it.

On this same topic I have a feeling drivers that I don't use or didn't 
test on have issues with setting the channel width. Prior to adding HT 
we let the driver decide, now we set it explicitly. Maybe HT needs to be 
an opt-in rather than opt-out...

Thanks,
James
