Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6797713062
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 18:56:42 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso44084481fa.0
        for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 11:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687892200; x=1690484200;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3N0KW4hjhETQcXTBxCIESil5dK2zzn0t+FydmuVE0w=;
        b=fB82hJcKLi2Lbynt3UgUfrNNd3AGHbUmyB1yS5va/jJ5sRSS1vjTRrH4Y7JLDx6TDI
         FjV8GDJDcU/asbRyJ3IDzZURjdsDy7WDtV4PbDthDLL4bRs2EjjTlhuTrCIOuxPcYtQq
         UsDG3T85t2FcfI8PBLN7C9t+9R5QAK5n4GuN1ilII6HxrDWqWvhMN2A1bCz1MlCeFoQ3
         kq08k8RZnTuoH2lGG6iDU/Q8YX0p4NTotaU+xGdvZh2IPQOLz6R3EDszj9IB0/6IjrtI
         nSIFEaF2m+VvC2niIt53oZ0npCB5VupwWh5QpvcQrhK//Jhj2zWuu8qNgZbAcx1U0pfH
         udow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687892200; x=1690484200;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3N0KW4hjhETQcXTBxCIESil5dK2zzn0t+FydmuVE0w=;
        b=evr+NRDg+e/LRxDY/kWF4/vTeOUbk24T/IWfDbJ0a8DI+pHDghSnzZaseVMBnZI8eL
         ORRe0QStghBpiDcQ+7AVqBABcET6qiFlXHSgVVnZuuWvbVNJkuFsbkh9b/htCILFFC7t
         IyGh7SEhsYSYMmxiPkxVLx4j3FjC62RvtgLXAO2/Gyi82PK52HAJYHm8GkNrHded+1Uc
         Y/kwRMn/ZBzhQg17gzZ/5Mh+/CWnBhkr9XhwbYJBEmn0LH9tK4W/rnQ6G/R+KfNhUW+/
         WWm2mzv94drn2tnrrcI6epDJSM47qrnGSgQWRUGy8LcETqS998ikOXG0T7HAT3/N3arV
         1fvA==
X-Gm-Message-State: AC+VfDy8Oo+EW7QxhQllZZuw2SacMGKpdQtnp1xcYZBrPOgeBjedllFe
	Qjs/yCUSy+CzyRrojQFzVDA=
X-Google-Smtp-Source: ACHHUZ6gJpH3p+0xvuhB/FWsgVYxk/JABocFwPZq+1aCnfRESq47cQ3urYk5bON1A6xacG643Rq3wQ==
X-Received: by 2002:a2e:9998:0:b0:2b6:a344:29cf with SMTP id w24-20020a2e9998000000b002b6a34429cfmr4419210lji.17.1687892199830;
        Tue, 27 Jun 2023 11:56:39 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id g7-20020a2e9e47000000b002b1b92910c8sm1866853ljk.86.2023.06.27.11.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 11:56:39 -0700 (PDT)
Message-ID: <ae4b9dc2-c88f-dfe9-2146-cbc3cc63f3c8@gmail.com>
Date: Tue, 27 Jun 2023 11:56:33 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
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
 <280831cf-933a-95b0-3889-ddca6ca544cc@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <280831cf-933a-95b0-3889-ddca6ca544cc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 6/27/23 11:00 AM, Denis Kenzior wrote:
> Hi James,
> 
>>> You can try to see whether HWSIM_CMD_ADD_MAC_ADDR works?  See commit 
>>> 5cc58a9ecfa1 ("mac80211_hwsim: notify wmediumd of used MAC addresses")
>>
>> I hadn't seen that before, but looking at it they don't expose that as 
>> an API, its only for internal use for scan address randomization and 
>> monitor interfaces (see mac80211_hwsim_config_mac_nl()).
>>
> 
> It is used as an unsolicited event / notification.  Yeah I know, 
> HWSIM_CMD_* prefix is confusing ;)
> 
> It looks like we should start using this since most of our autotests are 
> forced to include the following main.conf:
> 
> [Scan]
> DisableMacAddressRandomization=true
> 
> Having support for the above event would allow us to get rid of this hack.
IIRC Tim started adding that into tests a long time ago, and had said 
improves reliability. If I remove it (e.g. in testPSK-roam) things start 
breaking, but its very random and not repeatable, some pass and some 
fail between runs.

I would expect all hwsim tests to fail if we are dropping all frames 
with and unknown TX or RX address so something else must be going on 
here. But indeed, this *should* work if we handle these events similarly 
to wmediumd.

> 
> <snip>
> 
>>>
>>> Hmm, but radios are namespace independent.  They can only be 
>>> added/removed via HWSIM_CMD_ADD/DEL_RADIO, no?  Since phys are moved 
>>> wholesale across namespaces (you can't only move a given interface), 
>>> you could assume that once a radio is created and populated, its 
>>> interfaces do not change for the duration of the test, even if 
>>> they're moved to a different namespace.
>>
>> For testing yes this is probably fine. It may require some adaptation 
>> in hwsim to do it better from a test-runner perspective. Currently we 
>> just use ip to create/delete namespaces and move radios. It may make 
>> more sense to add this to hwsim so there is one path. Then at least 
>> when hwsim gets a DEL_WIPHY event it 
> 
> It shouldn't matter really who invokes the namespace move.  hwsim would 
> know whether it is a hot-unplug or a namespace move by virtue of being 
> the one who triggers HWSIM_CMD_DEL_RADIO.
> 
>> doesn't have to assume the radio was moved (I'm thinking if we ever 
>> added hotplug tests this could be important).
> 
> We should add these, but the above still stands.  hwsim is the only 
> thing in our tests that triggers HWSIM_CMD_ADD_RADIO.

Yeah true, I'll just flag the radio as moved but keep it around for 
processing frames.

> 
> Regards,
> -Denis
