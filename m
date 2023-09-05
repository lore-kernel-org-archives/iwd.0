Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986EFD537
	for <iwd@lists.linux.dev>; Tue,  5 Sep 2023 19:09:22 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-57128297bd7so1885846eaf.0
        for <iwd@lists.linux.dev>; Tue, 05 Sep 2023 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693940961; x=1694545761; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/fN27pltbS7/xXpppFfRT7Pzx2uEGD59jikf25Q8r0=;
        b=g5ptDIAJs/PM3LeN7Q5jIGTPkhVgvE0lNuCnmYQ7PUe9MBo6+036GegNO/SyDSweEM
         as26qTBos8Tdjh++mFJTeRc/t2cPRA4d4pmWnuoNQsyYUsV7eVyEimdXejWGj1v9e6Sv
         IwI2KtFN8uii9AODM7USnjp3IcmcHhRs/XE0jPk/WToWC4oIEfTI6la0NQVPssO+uB6c
         Y6EIjUB3Fkqz5VKmlJmVtJgo2oAFndrMSPdktRZwcLv2f61kmmk45slX7I0C4hFRO9Yh
         aHykbAWRmjl89ynEjtIs5lHscgm5yKNRjS3/ypAX3ZaIzvloiPEghhMebD0O2be62TiB
         A/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940961; x=1694545761;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/fN27pltbS7/xXpppFfRT7Pzx2uEGD59jikf25Q8r0=;
        b=hLA4WXaYVLogfIkhEFGetfFhr+NCf66z168eIKNPO7LEjZi1YeC2VcO+D3UMM2lxDA
         I7UkBOdgoNvnPfmmhDzqY4JrkJ5VEdblkSuVMYtZ946imAgQum7r9CzKYUM+wYNi9JF/
         mv/v9G40RULNFEx0wUu/JiFt/5GX8q0R4gCEZUHLE0qFqxDJkNJot2+4knNKMLTi50mU
         NN/yuyvsNwTmNuDY1VZUij2ol2ZIJWRucRV79t+rBJCJZ/J7m9xmsPz+SNwJf96+i4q2
         CI4Jhk9o6u01uGKqyuYkg/TdJPPMpsB7A/yYTqB8STbYZaL3BerrRhxHZk5Vg4Dk5c8o
         eY8A==
X-Gm-Message-State: AOJu0YxaJVDPDU9Gt2kgjy5mINyuieSABbrrbxICzbZ1h0qJWzbVgzmv
	TGLJ1mx4NgSzTF0GSb+zc6Y=
X-Google-Smtp-Source: AGHT+IFmT4FIf7kyBpAUxBxoMFbJMD00m19ONx9uOJeXWPZOxz5XP30p+5njEDBLxZU3kvHf+FhmBg==
X-Received: by 2002:a05:6358:7f0f:b0:129:d05d:691e with SMTP id p15-20020a0563587f0f00b00129d05d691emr781267rwn.19.1693940961247;
        Tue, 05 Sep 2023 12:09:21 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id y8-20020a056902052800b00d748501d9b4sm2801826ybs.21.2023.09.05.12.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 12:09:20 -0700 (PDT)
Message-ID: <c69115a4-858b-4602-acf7-f968be707ea4@gmail.com>
Date: Tue, 5 Sep 2023 12:09:18 -0700
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
From: James Prestwood <prestwoj@gmail.com>
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
 <82109cb9-3264-4b99-a6f7-e3d71da45270@gmail.com>
In-Reply-To: <82109cb9-3264-4b99-a6f7-e3d71da45270@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

All,

On 9/5/23 9:52 AM, James Prestwood wrote:
> Hi Bryce,
> 
> On 9/5/23 9:33 AM, Johnson, Bryce wrote:
>> Hi Denis and James and all,
>>
>> Sorry if formatting is messed up.  Outlook apparently doesn't do plain 
>> text emails very well anymore...
>>
>>>
>>>>> The AP can advertise both FT+8021x and 8021x.  STA can 
>>>>> preauthenticate to such
>>>>> an AP.  It can then connect to this AP using PMKSA caching, 
>>>>> potentially
>>>>> selecting FT+8021X as the AKM for the initial association. Table 
>>>>> 9-151 even
>>>>> hints at this: "0 (open) for FT Initial Mobility Domain Association 
>>>>> over IEEE
>>>>> Std 802.1X or PMKSA caching".
>>>>
>>>> Yes I suppose then preauth + FT is broken, or at least incompatible 
>>>> depending on
>>>> hostapd version... but fixing this is somewhat impossible right? We 
>>>> don't really
>>>> have the opportunity to try both derivations since we don't know 
>>>> what the AP
>>>> used (unlike eapol where we have the PMKID KDE to reference).
>>>
>>> The spec is somewhat contradictory, but I think Preauthentication 
>>> should still
>>> work in this case.  We should not be re-computing the PMKID when we 
>>> attempt
>>> preauthentication, unless the PMKID is not recognized by the AP.  But 
>>> this can
>>> happen regardless.
>>>
>>
>> We were going wifi certification for a product and using IWD 2.4 and 
>> had a failure that looked like it might be related to this.  
>> (SAE-5.2.1 - SAE-5.2.3 tests).  It was related to reassocation and the 
>> "STAUT transmits an Authentication frame with the Authentication 
>> Algorithm Number field set to 0" and our device returning a 2 (for 
>> SAE) instead of a 0.  It looks like with this patch it might be 
>> resolved?  I'm going to update our IWD to 2.8 and have them retest.  I 
>> can provide more details over DM if anyone was interested, I know the 
>> wifi alliance is pretty protective over their test plans so I didn't 
>> want to drop all the information to a public mailing list.
> 
> The patch you mentioned doesn't modify the auth algorithm at all, just 
> how the PMKID is derived. Without seeing the test or knowing what its 
> testing its hard to say, but for reference:
> 
> An auth algorithm of 0 is "Open System", 2 is "Fast BSS Transition", and 
> 4 is SAE. But do note that if the network enables FT then a roam between 
> BSS will use an auth algorithm of 2 (FT) during the FT auth exchange.
> 
> Since the failure is because the field to set to 2 its likely something 
> to do with FT.
> 
> I don't have my WFA account anymore since switching jobs, but I'm happy 
> to take a look at the specific test if its something that can be shared 
> externally.

In case it helps anyone else, the issue was that the test was expecting 
the PMKSA procedure to be used which IWD does not support. When using 
PMKSA (even with SAE) the Open System (0) auth algorithm is expected to 
be used when reassociating. IWD was doing a full initial association and 
using the SAE (4) auth algorithm (it must have been a mistake by the 
person administering the test that said it was using FT (2))

> 
>>
>> Bryce
>>
>> P PLEASE CONSIDER OUR ENVIRONMENT BEFORE PRINTING THIS EMAIL.
>>
>> This e-mail (including any attachments) is confidential and may be 
>> legally privileged. If you are not an intended recipient or an 
>> authorized representative of an intended recipient, you are prohibited 
>> from using, copying or distributing the information in this e-mail or 
>> its attachments. If you have received this e-mail in error, please 
>> notify the sender immediately by return e-mail and delete all copies 
>> of this message and any attachments. Thank you.
