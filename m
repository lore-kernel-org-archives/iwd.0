Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57A26D1D2
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPOokCGB"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-425860bf009so3053781cf.2
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 09:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701885543; x=1702490343; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/fcBe/uIbR1AVRnyLZFlkICXH5c1sPBlWvKhtZAU4k=;
        b=PPOokCGBW4GkQerGgNudlNr3repG3SfVaWfEmelryYLsbQmp+HYopX2W5O9tC6yAuu
         rF5eYZSEIUW4SjIvlJY/anLxYd8K0RVIeJId39Cn9y7UZX5Fk1Fv7UaBaWvrnollUEim
         lUD/aSeJJSQN3x0PFNFLRJeqFrh9YHa9SkZKC8CftF+djpX/xtYQqLz+BRjqzR0dsaXf
         lpXP1hboDFBv0aad27VUgROtly0XSuI19Tc8/OQINQMMEmVudSgA+0rmAE5zXbeLsq51
         iAqEpJ/5RvDfFM2WbabainFNwNAJlue3QEKiHr8ZQZjjWgEr0xN1N+rBC3iCi6DMHxBH
         c4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701885543; x=1702490343;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/fcBe/uIbR1AVRnyLZFlkICXH5c1sPBlWvKhtZAU4k=;
        b=vsoWE46KAtZddzhpWvv1Leeu98I+AhchplZk4zHf52tupS0+Q4qBrmzVARI4p0l9lC
         iV+NEF0y7qzRFZxsoW7bnCQlYO5oCiOKQwBTwXYuO1G8IO4O6scFIW3F4cm1kHyaxQOp
         L1kxVKSyGeNfobMT8NXr7oHuiS7KTgzMGNo832hJvCfTfvk7I3Pu1P4mXtdSY+NJw4OR
         E0+vizzbxHSFj2iXHg9q+aeJL3OgpOHGG5R49cRzVrw1olDTQreUHmiHhn0Dvk1VWwSU
         wR7BABHVa3qFLzyTws4Dt9d8n8aPbga6GHI3dniaTBFN3S21hAw+lx8lk3xpIuERehya
         +xTg==
X-Gm-Message-State: AOJu0Yz3GPCnyqS3/CnL8/iD4SpeWh3Fh8jjVzO8ZwfpycLQVIL6DLI2
	1Jjyy2QzpqABFUAOKxljpvtNLogkU9Q=
X-Google-Smtp-Source: AGHT+IH8k78bAgpMCjXBLUEL4XoUTyQprDHExVjAKghurtuVvtC77xyQ5lCwZcC8ofRKOxUicmpLYw==
X-Received: by 2002:a05:622a:190a:b0:425:8930:fdbc with SMTP id w10-20020a05622a190a00b004258930fdbcmr581928qtc.96.1701885543633;
        Wed, 06 Dec 2023 09:59:03 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id x22-20020ac84a16000000b004257e4c5e21sm132687qtq.28.2023.12.06.09.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 09:59:03 -0800 (PST)
Message-ID: <d494b581-f4bc-4e62-9dda-3917b768317d@gmail.com>
Date: Wed, 6 Dec 2023 09:59:01 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] ft: add FTE/RSNE building to ft_prepare_handshake
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231206150708.2080336-1-prestwoj@gmail.com>
 <20231206150708.2080336-5-prestwoj@gmail.com>
 <620a779d-e694-4057-846d-23e6eea35252@gmail.com>
 <14c4906e-099e-4e9d-90c0-fca8d5eb38dd@gmail.com>
 <76d133cd-e0b1-4a8f-8ade-891af9331dda@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <76d133cd-e0b1-4a8f-8ade-891af9331dda@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/6/23 09:14, Denis Kenzior wrote:
> Hi James,
>
>>>> +    handshake_state_set_fte(hs, fte);
>>>
>>> However, this is less clear to me.  Looking at how FILS and FT uses 
>>> this API, it seems that set_fte is meant for the authenticator FTE 
>>> element?  So I think rekeying after FT would be broken by this change.
>>
>> Good question. Rekeys do appear to work as-is but you are right, 
>> FILS/FT uses set_fte() for the authenticators element, but eapol 
>> seems to use hs->fte for 
>
> I'm pretty sure the intent was for the FTE element to be from the 
> authenticator.
>
>> building message 2/4, as well as checks that the handshakes FTE 
>> matches what the 
>
> I'll have to look at how ptk_2_of_4 uses it.  Memory is fuzzy now.  
> Need to open the spec.

All I could find quickly was:

12.7.6.3 4-way handshake message 2

"and that the FTE and MDE are the same as those provided in the AP’s 
(Re)Association Response frame"

So it does appear for EAPoL its the authenticators FTE.

>
>> authenticator sends in 3/4. maybe this is actually a bug in eapol? I 
>> think the reason everything "works" is because the FTE should be the 
>> same between both peers.
>
> Yes, but also we have logic in: netdev_connect_event() that sets the 
> FTE from the response IEs.  So that's probably how things end up 
> working in the end.
>
>>
>> We may want to refactor and do:
>>
>> handshake_state_set_authenticator_fte()
>>
>> handshake_state_set_supplicant_fte()
>
> Yeah, that seems reasonable.
>
> Regards,
> -Denis
