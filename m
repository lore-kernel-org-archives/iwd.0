Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1D60BA7
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPYm1xFg"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-67ad5b37147so663056d6.2
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 10:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701888243; x=1702493043; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCLYUsQU5i6HEFim8Et2QPoAyipmFm/eywxqDOalErU=;
        b=PPYm1xFgZOpk6VdUxMu9nB0JzpTMOXUmmq161Hajv3HHeJ6DR3hipHKCfFwsA+cLxN
         UldEeM8jbG53W5PlDP00JyJbRiPTqPouqzrCL/EesCSjHqHnPzIGLmkatGWtnVr/TAO6
         boaNmg5mvO7MwIa5kliFyvV1nh9Y0xUi9u5jN3Z3yh4zm7wG+W2zEJp3oPc5JHI1O93G
         gM/u4KxfQV8j+sfeUDprNN1pzBXKEnHUBm/W5+v3OZ9YVpDYDJ2ai8zudoMOaN9F/UZO
         fbQ4Nbc8H9qxIDXoW0DMzC+naEyGg1VrOnF9lIiT9rrogVjS5BvSBTB4QKa32z8806mZ
         uNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888243; x=1702493043;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCLYUsQU5i6HEFim8Et2QPoAyipmFm/eywxqDOalErU=;
        b=Pp/aaTVzqliG2Dx3TfOucoXQHop+lhd61avwuvb3ZWu8hSEDbJXIycmg/ytFrJDs9s
         VqoD0VND31h4C0/rOprNs0CPYxVwZoXYxu4p2cidxJZiwWkqCfkXRb/XQ3W7wudURpFu
         cSVBi45aKbRK5MwsjFRxEkx/ire6fjfjmCUXPr04nDLzsDHHfjWGhdieGji8tpvt3CGa
         MseeoAn522RuYB9CwEogoq2Yqdebfkf5WD78C88H3a7MjoTa8PkO+mk6Gpu2QVfH7yHe
         JX3g/9itKKe5jqNg9X+Lpaf0yOvWZnsJKHrtu4jkS8oYysLJp8arDTWq0wXR21kymfAL
         nOTQ==
X-Gm-Message-State: AOJu0YztfdopF2J3XuCFNeeTVjGyUeZdI+LIFuXbdoSoK9mAg4uNeI6q
	qCi8OlQfelkZZOrRN/VBDd9OCgnPqEg=
X-Google-Smtp-Source: AGHT+IEG0b5wjUzxnIZ2jKLI8g9tM5WdQvyIrBtEKveBCDDO7zYq1ZOHgBXDFse0Bqmn/gmTo4Of/g==
X-Received: by 2002:a0c:f90f:0:b0:67a:a721:e127 with SMTP id v15-20020a0cf90f000000b0067aa721e127mr1278521qvn.84.1701888243531;
        Wed, 06 Dec 2023 10:44:03 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id y13-20020a056214016d00b0067a0b2d88e4sm178071qvs.132.2023.12.06.10.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 10:44:03 -0800 (PST)
Message-ID: <6faf5c3d-cb78-47c0-a3d2-aec8211e79cc@gmail.com>
Date: Wed, 6 Dec 2023 10:44:01 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] network: add support for SAE password identifiers
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231205154647.1778389-1-prestwoj@gmail.com>
 <20231205154647.1778389-4-prestwoj@gmail.com>
 <03c0874e-0f64-493f-b9c8-cb302045938c@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <03c0874e-0f64-493f-b9c8-cb302045938c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 12/6/23 09:08, Denis Kenzior wrote:
> Hi James,
>
> On 12/5/23 09:46, James Prestwood wrote:
>> Adds a new network profile setting [Security].PasswordIdentifier.
>> When set (and the BSS enables SAE password identifiers) the network
>> and handshake object will read this and use it for the SAE
>> exchange.
>>
>> Loading the PSK will fail if there is no password identifier set
>> and the BSS sets the "exclusive" bit. If a password identifier is
>
> I'm not so sure about this.  The trouble is that this logic is 
> sufficient for the initial connection, but isn't sufficient when you 
> consider re-association.
Your right, roaming would be entirely broken between BSS's that mismatch 
using password identifiers. Maybe even hunt-and-peck and H2E? not 
entirely sure. We would need to re-derive the point for each roam, like 
in network_set_handshake_secrets_psk().
>
>> set and the BSS doesn't indicate support the setting will be ignored
>> (with a debug print).
>> ---
>>   src/network.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 49 insertions(+), 1 deletion(-)
>>
>
> <snip>
>
>> @@ -641,6 +657,32 @@ static int network_load_psk(struct network 
>> *network, struct scan_bss *bss)
>>           psk_len = 0;
>>       }
>>   +    /*
>> +     * Sort out if the password identifier is required, should be 
>> used, "
>> +     * or should be ignored.
>> +     */
>> +    if (is_sae) {
>> +        if (bss->sae_pw_id_exclusive && !password_id) {
>
> This likely needs to be taken into consideration much later, when 
> building the actual handshake state.

Yeah, we'd need to move this into network_set_handshake_secrets_psk and 
rederive the points. And actually if we do this storing the points in 
the network profile doesn't make a whole lot of sense anymore since its 
being rederived every time.

Alternatively we just keep it how I have it and tell they user they're 
network isn't configured properly :)

>
>> +            l_error("BSS requires SAE password identifiers, check "
>> +                "[Security].PasswordIdentifier");
>> +            return -ENOKEY;
>> +        }
>> +
>> +        /*
>> +         * If the profile contains a password identifier but the 
>> network
>> +         * does not support it IWD will still attempt to connect. The
>
> Password identifier is only used by SAE H2E.  One can easily imagine a 
> weird network of mixed APs with some being SAE H2E, some not.  This is 
> why I didn't bother implementing this, it is a half-baked feature.

Ugh, ok. I guess we have to keep the identifier around then.

>
>> +         * caveat here is if the connection is successful the sync will
>> +         * remove the password identifier entry. Though this might be
>> +         * unexpected to the user, retaining this (invalid) setting
>> +         * isn't worth special casing.
>
> And this doesn't sound nice at all...  I think the setting should be 
> preserved.
>
>> +         */
>> +        if (!bss->sae_pw_id_used && password_id) {
>> +            l_debug("[Security].PasswordIdentifier set but BSS "
>> +                "does not not use password identifiers");
>> +            l_free(l_steal_ptr(password_id));
>> +        }
>> +    }
>> +
>>       /* PSK can be generated from the passphrase but not the other 
>> way */
>>       if (!psk || is_sae) {
>>           if (!passphrase)
>
> Regards,
> -Denis
>
