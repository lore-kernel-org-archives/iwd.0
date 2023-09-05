Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3CE378
	for <iwd@lists.linux.dev>; Tue,  5 Sep 2023 16:52:08 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d7e741729a2so2400021276.2
        for <iwd@lists.linux.dev>; Tue, 05 Sep 2023 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693932727; x=1694537527; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbubUn9M+5jVlcsSx3L3YbNGORX8ORdGrnodi/28qpg=;
        b=cGT5dns4SQsT+/9F6z93dIIiilE6/jMtNoJ73NkoINwzqEZiuys1Fvc2KbTNYvGYrZ
         ZPuzdjftOBwjaeVo3/14DY5fAO6VTndaKmaE4Th++3M8h9CG10m7c5L2TadWufUeOCa7
         O+yKK855lXDN6cqAKYwkPB0LvAovjFxYt7zTIwYK4uV7+e+UJqkY3s4g1Jz/OCL7bcsc
         Y4TEAxvmCUA9WF81FwuLtCYFrZBNf366mvtKpPPJUEuJOBEMQltUcfzPNtqhLplHsskb
         oTpgIKLJwtTpQ0OfP/nv2nQWW614Z5ApQ5Yfl11rclzyms8huAFnR0+ORAjS2MnQYTD6
         W30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693932727; x=1694537527;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbubUn9M+5jVlcsSx3L3YbNGORX8ORdGrnodi/28qpg=;
        b=DQ/S2ZAZiIGu9qXNim5n8fpUaw8KWmskK+q/YZ7MSkNGhT3QMH4sfwSOfEuksYu+cV
         g10J6muDm5Fa9JMnU4gqlmaqF1vH255xSSl59hMI8XrcGQoy1h8k/EicgTzaCgcIDL+3
         afycwfEBYCCU5+IE9w7aOa3VwvmhtPcaGOx0rsc0YR5K1Px+gEo4fojHUp9GjuaJa5u6
         tKi7Gq4vrLHjjvKFIDDTeqbDI3FTZuhOMU0nkZK+wnhJFk/LM9nmxz3PYbJPr+5QyicX
         xPLHD96PkScN91j8zO6hOSifkDBblpOvLwB8wRLQ7JaYKRxViXKCuwd12UFJMT/DbLU2
         Q6CQ==
X-Gm-Message-State: AOJu0YzfVhGvndbwFdTWoe41d6hhso07LIxcSRKMTOqwxpHUNyopHLvy
	Yay0YcIxKuV8rZER1M0duuSNbhS4Yvw=
X-Google-Smtp-Source: AGHT+IFwlM5L/XhjIDMIn+ra0MDgGMLjtpkXKz0vqily8xMNQG9BE1R/oeA3PjGyhqCVcQK8xZFy2w==
X-Received: by 2002:a25:a1e9:0:b0:d62:a365:258c with SMTP id a96-20020a25a1e9000000b00d62a365258cmr13188796ybi.42.1693932727316;
        Tue, 05 Sep 2023 09:52:07 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id g34-20020a25ae62000000b00d74b5e166acsm2873005ybe.10.2023.09.05.09.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 09:52:07 -0700 (PDT)
Message-ID: <82109cb9-3264-4b99-a6f7-e3d71da45270@gmail.com>
Date: Tue, 5 Sep 2023 09:52:04 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Content-Language: en-US
To: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>,
 Denis Kenzior <denkenz@gmail.com>, "iwd@lists.linux.dev"
 <iwd@lists.linux.dev>
References: <20230404203823.384260-1-prestwoj@gmail.com>
 <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
 <f3259b4c-e8e3-8542-247b-9d6bd0ad00af@gmail.com>
 <05e63c78-5373-520c-15db-aa42cecd95b0@gmail.com>
 <3855c8ce-c2de-d1f3-e5d8-8c93610e4b22@gmail.com>
 <5789f7e4-793e-8e42-29d1-1a92696ec2f4@gmail.com>
 <PAXPR01MB921752F18978A3F5A5E53C91F4E8A@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <PAXPR01MB921752F18978A3F5A5E53C91F4E8A@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

On 9/5/23 9:33 AM, Johnson, Bryce wrote:
> Hi Denis and James and all,
> 
> Sorry if formatting is messed up.  Outlook apparently doesn't do plain text emails very well anymore...
> 
>>
>>>> The AP can advertise both FT+8021x and 8021x.  STA can preauthenticate to such
>>>> an AP.  It can then connect to this AP using PMKSA caching, potentially
>>>> selecting FT+8021X as the AKM for the initial association. Table 9-151 even
>>>> hints at this: "0 (open) for FT Initial Mobility Domain Association over IEEE
>>>> Std 802.1X or PMKSA caching".
>>>
>>> Yes I suppose then preauth + FT is broken, or at least incompatible depending on
>>> hostapd version... but fixing this is somewhat impossible right? We don't really
>>> have the opportunity to try both derivations since we don't know what the AP
>>> used (unlike eapol where we have the PMKID KDE to reference).
>>
>> The spec is somewhat contradictory, but I think Preauthentication should still
>> work in this case.  We should not be re-computing the PMKID when we attempt
>> preauthentication, unless the PMKID is not recognized by the AP.  But this can
>> happen regardless.
>>
> 
> We were going wifi certification for a product and using IWD 2.4 and had a failure that looked like it might be related to this.  (SAE-5.2.1 - SAE-5.2.3 tests).  It was related to reassocation and the "STAUT transmits an Authentication frame with the Authentication Algorithm Number field set to 0" and our device returning a 2 (for SAE) instead of a 0.  It looks like with this patch it might be resolved?  I'm going to update our IWD to 2.8 and have them retest.  I can provide more details over DM if anyone was interested, I know the wifi alliance is pretty protective over their test plans so I didn't want to drop all the information to a public mailing list.

The patch you mentioned doesn't modify the auth algorithm at all, just 
how the PMKID is derived. Without seeing the test or knowing what its 
testing its hard to say, but for reference:

An auth algorithm of 0 is "Open System", 2 is "Fast BSS Transition", and 
4 is SAE. But do note that if the network enables FT then a roam between 
BSS will use an auth algorithm of 2 (FT) during the FT auth exchange.

Since the failure is because the field to set to 2 its likely something 
to do with FT.

I don't have my WFA account anymore since switching jobs, but I'm happy 
to take a look at the specific test if its something that can be shared 
externally.

> 
> Bryce
> 
> P PLEASE CONSIDER OUR ENVIRONMENT BEFORE PRINTING THIS EMAIL.
> 
> This e-mail (including any attachments) is confidential and may be legally privileged. If you are not an intended recipient or an authorized representative of an intended recipient, you are prohibited from using, copying or distributing the information in this e-mail or its attachments. If you have received this e-mail in error, please notify the sender immediately by return e-mail and delete all copies of this message and any attachments. Thank you.
