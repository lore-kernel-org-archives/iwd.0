Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26D1308A
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 18:02:12 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6b74791c948so2449037a34.3
        for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 11:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687888931; x=1690480931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OLLsthZZvvtF0GUcRUtyY4NVCHUNENf5q4JQ48ko9Xc=;
        b=LdrqpvI/ml8QXiibVjdMI5gOQvlR34tqn3oXpTHb3Xdsg1iDA/oQ+ZaiIr6HJnkx67
         zvKSEZ795J3UrfzLFYB/vVPK/J8DOEzf67xHab5byS9lHDHB6a298u6lKEteI4uzf846
         Ss2lNi3p8Y6xpm9de+DQ2AgMH5TNmJxDtWMFFrBNU0DYWcVLfuBTupd8qFrjaAsjo28p
         umgm0F7iR49kRZOtROpldt4nw0rk9kA54s0WrGNbcfNjK3s1QrgCLfdrw3FkTYjQVuDC
         mOkpmLbS1toszynLQDtiFdr1/y00uR+dDpTJvBLZjDrjusxlZPrgB18jSE5ibVoirBuV
         sxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687888931; x=1690480931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLLsthZZvvtF0GUcRUtyY4NVCHUNENf5q4JQ48ko9Xc=;
        b=XO2sYSX7ED6oQ9kvHuNYi4GaKorO7eICWq+3NrIzVrzq7/MmM5xg6ZU+/ZiRc30o/2
         Z9GDMB2Tv3DVc2mAzpE/nUPSW8FzI0QqPxaSEd5XNt3z6FYJUvRfhusgAmdSgDhPkV0h
         3ymY8Q0qZfyeyUQCyv9k33cmmdUtNgqHbjhM+7seyS0sipaW9V0Vz6NFL6u8gabZEsj0
         qbFn11M0E79ONZG4M9C3kS/B1ULw/1JMacTG8OOggXQ9bm3OYmGCaEZ858RP/Uj6Zr+9
         XxeLZnw8Frur7Fl8r4w73gmWWX8hZU+BjgPbyBsTYagf1qFSvYcIhEX2r9TVeCizlDf2
         a+Ow==
X-Gm-Message-State: AC+VfDzlPKkC7HFdLj+1wNPS6wb0uDkDkRm7A5vnp2XOhqmAYBxcJnr7
	vidkmxadh8RQupiAIAUA5MhNJXx419k=
X-Google-Smtp-Source: ACHHUZ54Ns2tlJ/pm/E0XEzXiHqChvPygwtGCM0a3Wq6esMpPf3jjP2BX3knf0dsJJbd1hWlP476Zg==
X-Received: by 2002:a9d:7847:0:b0:6b6:ad29:7ac3 with SMTP id c7-20020a9d7847000000b006b6ad297ac3mr16305052otm.11.1687888931493;
        Tue, 27 Jun 2023 11:02:11 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v5-20020a05683011c500b006b867fa10eesm987274otq.74.2023.06.27.11.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 11:02:10 -0700 (PDT)
Message-ID: <280831cf-933a-95b0-3889-ddca6ca544cc@gmail.com>
Date: Tue, 27 Jun 2023 13:00:21 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230504215247.581443-1-prestwoj@gmail.com>
 <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
 <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
 <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
 <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com>
 <d2d0841b-62a0-c8df-924f-851df5f88203@gmail.com>
 <865cf0a3-1be4-34cb-0535-e76cf43d6753@gmail.com>
 <63162827-5b8b-3c70-7f6f-fc7b513f2b6d@gmail.com>
 <1742c6eb-bbd5-7883-5a72-53021a771ca6@gmail.com>
 <3790483a-442f-9602-03c9-b205376d9262@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <3790483a-442f-9602-03c9-b205376d9262@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> You can try to see whether HWSIM_CMD_ADD_MAC_ADDR works?  See commit 
>> 5cc58a9ecfa1 ("mac80211_hwsim: notify wmediumd of used MAC addresses")
> 
> I hadn't seen that before, but looking at it they don't expose that as an API, 
> its only for internal use for scan address randomization and monitor interfaces 
> (see mac80211_hwsim_config_mac_nl()).
> 

It is used as an unsolicited event / notification.  Yeah I know, HWSIM_CMD_* 
prefix is confusing ;)

It looks like we should start using this since most of our autotests are forced 
to include the following main.conf:

[Scan]
DisableMacAddressRandomization=true

Having support for the above event would allow us to get rid of this hack.

<snip>

>>
>> Hmm, but radios are namespace independent.  They can only be added/removed via 
>> HWSIM_CMD_ADD/DEL_RADIO, no?  Since phys are moved wholesale across namespaces 
>> (you can't only move a given interface), you could assume that once a radio is 
>> created and populated, its interfaces do not change for the duration of the 
>> test, even if they're moved to a different namespace.
> 
> For testing yes this is probably fine. It may require some adaptation in hwsim 
> to do it better from a test-runner perspective. Currently we just use ip to 
> create/delete namespaces and move radios. It may make more sense to add this to 
> hwsim so there is one path. Then at least when hwsim gets a DEL_WIPHY event it 

It shouldn't matter really who invokes the namespace move.  hwsim would know 
whether it is a hot-unplug or a namespace move by virtue of being the one who 
triggers HWSIM_CMD_DEL_RADIO.

> doesn't have to assume the radio was moved (I'm thinking if we ever added 
> hotplug tests this could be important).

We should add these, but the above still stands.  hwsim is the only thing in our 
tests that triggers HWSIM_CMD_ADD_RADIO.

Regards,
-Denis
