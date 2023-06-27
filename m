Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E616D5380
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 20:09:34 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b69ff54321so43388511fa.2
        for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 13:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687896573; x=1690488573;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSygWEKCsCKED22f89CjJVeL9FPODNfaO0010bIbcFE=;
        b=AthshJJsaziMaZNOfrMStbkG5SxQMjSTZkCGBjsQZPFCZmsA11E4ly+NHL66Vi347/
         jEaDQcgAuZPH5zL7zEvEf+zWXwkPIqcNw84EniSimkby4W5FagMBLopgsYzGg8tzScFl
         tg6HkFg7ckA6hxNz+VTEa49Pepat50jrc3wd1fErM/lMmS9UGyK7iSnB7mx/7ffjwJrm
         CFKudFHM+gh30OPTQR3kK6LtG+C1bYZDrDlPW1acamUX4qvKs/SmiaY7wfOfAk4dmZak
         C65KStSF7Mxotfm5AhVDzYPJL9wD9788XJSklgrH+sAIZ4mYeQp8OE4YUp569qfGWwSn
         UxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687896573; x=1690488573;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSygWEKCsCKED22f89CjJVeL9FPODNfaO0010bIbcFE=;
        b=jUtQSdEQwBvTbUU0QjP8TE6CeEX7MXFU2nG3jIWNZc6kRCvyw9RWqy7dWqHvd+l1tE
         LX++vnXfJ1RLFhR+m13wr5cz77UTFyF1nw4WWzkTj7NDHhUGwHwFPyJF6Qri22ESBrSh
         CN4PE/uaI3Nt/nbsTDDNbdu4/P62Hr5cAIYytrt3wT8TcS66k+H/PIHY0koI2/src2Ci
         U7/1RxYgH2pHpyf5hsJCPpclsI8r38ihDQQvVz01SA6Hz1jfnW++vt2w9u2YPRq8I9TE
         7A0vxrMgMc2KIVBAU0grrh2Gye1c0DjsGEpiYZeHC0Z9TMRMHsUrxQunYWswiyBsX9Hv
         xRUw==
X-Gm-Message-State: AC+VfDwgCBBr7xSVLVIl/IvFqtqPBAW+UPozaWT9q8pHnLv4DN/yhWKm
	5al6asaRT1trgSecHHwVGrE=
X-Google-Smtp-Source: ACHHUZ7l0rj+ckKWYd8vEN8iKl6dq3De9YEjb1TbHsnVM0x7fh5VGFwGFMWpss8NYy26cAdAjrKtxQ==
X-Received: by 2002:a2e:8004:0:b0:2b6:b5a9:5047 with SMTP id j4-20020a2e8004000000b002b6b5a95047mr1622189ljg.5.1687896572443;
        Tue, 27 Jun 2023 13:09:32 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651c102200b002b69eb2d680sm1415723ljm.24.2023.06.27.13.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 13:09:31 -0700 (PDT)
Message-ID: <24a0ae5c-529b-a061-0fb4-0ba8a66fe76b@gmail.com>
Date: Tue, 27 Jun 2023 13:09:28 -0700
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

So one other caveat with this is that IWD creates its interface while 
inside the namespace. So we actually cannot track that. Only thing we 
could do is force the interface creation ahead of time, and make 
namespace'd iwd's use the default interface.

> 
>> doesn't have to assume the radio was moved (I'm thinking if we ever 
>> added hotplug tests this could be important).
> 
> We should add these, but the above still stands.  hwsim is the only 
> thing in our tests that triggers HWSIM_CMD_ADD_RADIO.
> 
> Regards,
> -Denis
