Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255B3217
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 17:10:18 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so3931754pji.1
        for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681146618;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J21N4KqtnNZtiKXKsjGWvR9RlMtx3SNbP6bQmMX7cVM=;
        b=TNhYB7wePuFZLDtXIeCsoy+KrLX80RQmNUkeuuosvX9InREJyvx4G52rKytpFmkrHQ
         iZla4w2ygaYuR9fTia5cpu5z0KbUL9NXZqyRBY9W52u/VJwU6J0c03He3mM2AoTFx83q
         6nmqi5hCk6Tm9A5OIZaCV7NLWkWSsh7jZoOnJlDvhXEGJu4PBVhU4jLeNUDmaS4vMYSO
         LuA+AGz2sF5bDbB/JgNHr213iJGqyjMRgky3elHXYV9SYXas61+7PnpwHXvspjHoeqO1
         Y1tOK5iY8vmd87eHaludDlUOEkw0IbMhQUhCFnUVujLDxx3SCsc2mNuIaUhbQTCm3D+E
         yFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146618;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J21N4KqtnNZtiKXKsjGWvR9RlMtx3SNbP6bQmMX7cVM=;
        b=dRS+Fs2eZc9L4npi1vEPpI7sVdm0muJAke20aYdBbsaIAMd4cJU/zw6IHMTLi/j2qH
         EecdFUmuPUpn1GwROgt4jw1dqKWtpxhYRyVeoiP/Bnm3Vqxe3am8+UbezIt3G8WgV/kX
         LXyd3BCgkZNs4fxWsD0KMeR3orye0rSsC2fkeJtRTjuqjj8Sw/9IfGq8KDVAny5ZPnMC
         qJM2r4b6BDLNXifzsvvXNHiAdxVEAGO5rkK/mJ3AaSkTgBTfcNNpdQP2KO/IXs2Hx0Ph
         QMEgGdkVZWJTwSKz2MrQ7KSPW6xqnMfFEGh1eiE0rgIfLISs82aU07jKp7RECODwtZXN
         seRA==
X-Gm-Message-State: AAQBX9f5ycOTND9HUyiuZ99gAXUcvpdcvC09LqfopyfEzx57PKfMyV7Q
	Y2vUH0HRZnyE/zrmolfkm2S7SI2W4yq2jw==
X-Google-Smtp-Source: AKy350ZcId0pp5KwC4W3oqbjfVY21uncduzjWypVz/+ibheCtKgKmOEvqptRbTKnfcq8k+bZ9kZs0g==
X-Received: by 2002:a05:6a20:8b1f:b0:da:66f4:5ad9 with SMTP id l31-20020a056a208b1f00b000da66f45ad9mr8444732pzh.22.1681146618256;
        Mon, 10 Apr 2023 10:10:18 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id k14-20020aa790ce000000b005abc0d426c4sm8093775pfk.54.2023.04.10.10.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 10:10:17 -0700 (PDT)
Message-ID: <f3259b4c-e8e3-8542-247b-9d6bd0ad00af@gmail.com>
Date: Mon, 10 Apr 2023 10:10:17 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230404203823.384260-1-prestwoj@gmail.com>
 <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 4/9/23 10:21 AM, Denis Kenzior wrote:
> Hi James,
> 
> On 4/4/23 15:38, James Prestwood wrote:
>> The 802.11 spec defines what AKMs should use sha256 to derive the
>> PMKID. Hostapd commit b6d3fd05e3 changed the PMKID derivation in
>> accordance with 802.11-2020 which then breaks PMKID validation in
>> IWD. This breaks FT-PSK/8021x AKMs in IWD if the AP uses this
>> hostapd version.
>>
>> Updating IWD to use sha256 in these cases will now break backwards
>> compatibility with *older* APs, but this will be worked around in
>> future commits.
>> ---
>>   src/handshake.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
> 
> <snip>
> 
>>       if (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
>> -            IE_RSN_AKM_SUITE_PSK_SHA256))
>> +            IE_RSN_AKM_SUITE_PSK_SHA256 |
>> +            IE_RSN_AKM_SUITE_FT_OVER_8021X |
>> +            IE_RSN_AKM_SUITE_FT_USING_PSK))
> 
> I don't see that the hostapd commit is actually adding FT_USING_PSK to 
> use sha256 generation? Only FT_OVER_8021X?  Is this a bug on their side?

Ugh, yep looks like its a bug on their side, at least according to 
12.7.1.6.3. There is another API rsn_pmkid(), which also doesn't include 
FT_USING_PSK, but references the 2016 spec (which is ambiguous).

Hostapd/wpa_supplicant get around this by not checking the PMKID KDE 
unless enabled... :/

So I think like you mentioned in patch 2 we just need to try both ways, 
at least for these AKMs in question. So my idea would be to add these 
AKMs to handshake_state_get_pmkid() (plus SHA384), then introduce 
handshake_state_check_pmkid() which will try both (for use in eapol). 
Sound good?

> 
> However, one consequence of this is that preauthentication is likely 
> broken for FT-over-8021x networks?  Do we even test this case?

I don't think we have this problem, 802.11 disallows preauthentication 
for FT networks:

"A STA shall not use preauthentication within the same mobility domain 
if an AKM suite type for which the Authentication type column indicates 
FT authentication"

Thanks,
James

> 
> Regards,
> -Denis
