Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E11803B
	for <iwd@lists.linux.dev>; Sat, 14 Oct 2023 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkOjEbPP"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ae388eb437so2235490b6e.0
        for <iwd@lists.linux.dev>; Sat, 14 Oct 2023 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697306850; x=1697911650; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IGrHm8r/cnmznoYiyCDEwRzVU0t8QwF7/X3ndwkC+w4=;
        b=VkOjEbPPi0P3dd/crnPo2TFEBomYLbBpST002agudqySsnixOq6Rt9hoqc1JolodKR
         gZD81BAHfVv3QbprZZcJ9NsGb6rWWb0AE5qmAvmn3CUgM27po4RfvDAC5pPd6L4+ON73
         HNOWm1glKUatBKSYXikzPCkxOzjzVqDCzr1DLi5oZ0CjJTDmvo/7mEt97dhkxwLGGtAB
         CXV5oR89FtfeSzrbvqs0V7DcXgbPGqmDSBMaerHQZCawFEZuTCEnDnM3fpPYQ/5ilveo
         aT9C06cpJNqt2xnBA4qCevcMCnnwN3kTLJTMarS0tM7lzKU1Jm2I74UAndOawNvtw9MM
         eUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697306850; x=1697911650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGrHm8r/cnmznoYiyCDEwRzVU0t8QwF7/X3ndwkC+w4=;
        b=M2QeT/Cfde/8b9jp1+BseKwp2Qa5J62GW8PpCqKPUf0kRyF4p9AzcEwQ6FPGdQwDyD
         ZteIqyVYUVsRsJ5n2WihdYt81jM2eBSvGN0vp57spVINwuxInXSyCB2Am0ODMD6fFY5Q
         6paDXNznAqS0+bBJFYJYylq5IOPq3Y0IzliaQFv5CYrha5byiSXw0hAgfO63iOTSbGSc
         TAuqKyRS4he4D9MfbPkmoWSKYnU6JsTgEqzk4MCGJKj69/2cJHSjlnGTclrxR8ZD2WU2
         KA6jFFSozNRVJhS44C5ubjzdnnKwsbrf7SC7f9np+kXcV3k9L143BehJl/8fSk6U4MkF
         5ilw==
X-Gm-Message-State: AOJu0YxTgBxz5LD6y8Q94cpeBXfqV7BSAfz6kZHJjLwL2O7he5FuJMwS
	HzlHzdz/W2L1T+FS+jbPDoPX1nkTGuA=
X-Google-Smtp-Source: AGHT+IGBKMoo9CkObfeutSNfTp8V1ssMPLFHyS4meNzYaENccxottmsQBK+fZZKQ8amkaeUOI9kNlg==
X-Received: by 2002:a05:6808:4c2:b0:3a9:cc99:81a8 with SMTP id a2-20020a05680804c200b003a9cc9981a8mr1829239oie.0.1697306849695;
        Sat, 14 Oct 2023 11:07:29 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d15-20020a05680813cf00b003ae3768ba4csm1209599oiw.58.2023.10.14.11.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Oct 2023 11:07:29 -0700 (PDT)
Message-ID: <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
Date: Sat, 14 Oct 2023 13:07:27 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Content-Language: en-US
To: Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
Cc: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
 <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
 <bwuu4ra65fpfpenytgu5a6ftjpvyury4omx7ucy65cshorqskl@5ikhebki4wnk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <bwuu4ra65fpfpenytgu5a6ftjpvyury4omx7ucy65cshorqskl@5ikhebki4wnk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Simonas,

On 10/14/23 12:45, Simonas Kazlauskas wrote:
> Denis Kenzior wrote:
>> Hi James,
>>
>>>>
>>>>      RSSI                  -78 dBm
>>>>      AverageRSSI           -79 dBm
>>>>      RxMode                802.11ax
>>>>      RxMCS                 8
>>>>      TxMode                802.11ax
>>>>      TxMCS                 4
>>>>      TxBitrate             206400 Kbit/s
>>>>      RxBitrate             206500 Kbit/s
>>>
>>> This is probably because IWD doesn't take into account any of the newer 
>>> 802.11ax IEs when estimating the data rate. So its estimation is based on VHT 
>>> and not the newest EHT rates.
>>
>> We should support HE rates just fine.  Just look at the unit tests in 
>> test-band.c.  Probably need an iwmon log of the AP IEs and local capabilities 
>> to see why the estimate is lower than what happens in practice.
>>
>> What hardware is being used here?
> 
> Intel’s AX201 on the client side and Ubiquiti’s U6-Pro are the AP(s).
> 
> Thank you for pointing me at iwmon, I’ll fiddle with it :)

It may be we screwed something up with HE since hardware was still pretty rare 
when the feature was developed.  But we do treat RSSI values below -82 as almost 
unusable.  Perhaps this needs to be tweaked for newer hardware.

If you want to get your hands dirty, it should be fairly easy to modify 
unit/test-band.c to test what our estimate code does with your specific 
circumstances.

The local HE capabilities can be found via 'iw phy', looking at what iwd prints 
at start, or using iwmon.  Similarly, remote capabilities can be sniffed using 
iwmon and running an iwd scan or 'iw scan trigger'.

Me or James can walk you through all this if needed.

Regards,
-Denis
