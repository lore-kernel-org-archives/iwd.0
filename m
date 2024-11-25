Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA617BB35
	for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546867; cv=none; b=G4ka558PhjNt4h+35DFgyHhTkdrWHeolTHAglaPggrd+AaoWi0yWYC1czYroxnZYiGAD2AuMnvP8Hl9uzY5E2B4t3kDXwsgegQ7PFqWJGRqDwuFMcagxtoIOezlCcG5ASGdtExk0jnM1munB1JhqEWK2Zupibl28F0/1jNG2XGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546867; c=relaxed/simple;
	bh=/RxKz1DCphklh5z3whhRP7f249MfeuMmzcn4eW4oqYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=buaGOqp+RIApZGKWMgY5dK/7Uh331My4OPUDJqn5+p/Wx81abh2kpbi3OkKVH/Qvb/X2g3vj8jzq3Gc1pPGhNPSohMA72rMis+cKT8RlTuRYTZyvnEHV42aD0ZEqW5Yn1Zn4k23IuDBXM1lsMNoW0pFwjwHg+4glrxkn6hJdUFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCmNHjXw; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCmNHjXw"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d41eeca2d6so34923996d6.1
        for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 07:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732546865; x=1733151665; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gv+vBPxP2+P1UwljHfa34EdKDzmh50k4rjvEhKbWyCY=;
        b=SCmNHjXw7++EEdu/OyXqiedpngElnROm64/CGPYnh5fDP11ASJ0FF3SjhhMSt1XRG7
         QgW8Xdq7kC35mMnOVHf5WmycWyzIvl/EE4cok0XiIPEDZHqEblSQ9OqJA7ojiW0cpth0
         oeBzhbZFHw/jL55nSQBvc/V/6lyKHWikNLGAMWPk2+QzfNUF/V02d49BzSdZhVNF7i8S
         eZ8nd34j/qWe7V0aNwRTvAYGwkgcKDHD5kx5qd9yJ2QsNJ2iDWf8pkpZod8F/u6bPWu7
         lPalDtqR+cmBA+9KUR7uh5nVzJF55urwzdIILV3s4ss0dgAVuke37O0b3cqlfGRhUjvl
         Fzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732546865; x=1733151665;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gv+vBPxP2+P1UwljHfa34EdKDzmh50k4rjvEhKbWyCY=;
        b=vf60jYBWpKbFmZIunL3EzQ9m3Bcotp0lDP+klBWh1qePdvoEu5kOwj2BfgteDe1ySd
         2OGamrNpARvo/O3u4wu5S0Lrt4QFo5F809VcsxsO+iSFf5jzQbRa+u2rHWA6dxanUiK+
         0brXZfXMgSKeYCLuw8lVUOA7sDDaT9x3TmDV4LCRkNcH6ViIGB1+wmh9wqgKeXUV/XMZ
         XThywJueOiCOTNMM/uT9wNZ1wSg047bjSkkUnDF/nTNzL1ucKigTn10mqhE+9EL3cViN
         lwyYKktPzrsglkqga8CQR0zUIu9EmImQ8kFW7pNiRCDzgRi/VWKxbFxtOfFcrjpaQrZT
         KOyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbWXWP9SRWaCtTUafJojr1RvkXamUNjhg4Z4VF/w7hqdLIs0VxiClugVNQGAnQ2xHeBKA=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywn3WZs2sTbMxj/9narHq9YqKJxr4/TIA4iM3Iz4EtcvfeNrDWs
	qT+W4JqRWkw+1KX10/e1QqsG7i5+8u6hNWvEUQAB0aL9jRIzmfQ1
X-Gm-Gg: ASbGncsD+bMRIpv1qdUyvTj7mKtza3LH7e7xgNLtEaz+YdKeg9nz+4nhbMENGxRjeN5
	R1j2UpwWqYTpmxYvr+Jg6TP2VaTehto2bq1QuzhiFbPRF7njDRutO9Y6cJ2A1ItcwJXgWCImblQ
	Tk1kFZfROiBZOVcCTodo/e0o7ajoG2eJd2Pj3gUdJLtJHSX3j08eE2RLrJozyaus24s4YpyWouQ
	dmD1r1BqzBbVP0RyRHmYL2rEI5pac3oMpEK3aIPNTh9M1UvC7Q49w==
X-Google-Smtp-Source: AGHT+IHJtgk1+vFCOtMlNEo74zzsQAcVNuwOxcCDPNWISQshuYMgGCDCrYd85paBY7G6Bb71WmsFRg==
X-Received: by 2002:a05:6214:c6b:b0:6cd:f6de:8ad2 with SMTP id 6a1803df08f44-6d451361dc7mr157833536d6.45.1732546864296;
        Mon, 25 Nov 2024 07:01:04 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513fb4b2fsm355819585a.55.2024.11.25.07.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 07:01:03 -0800 (PST)
Message-ID: <94bdf4e3-2617-4c3d-a2c3-5c34cf684906@gmail.com>
Date: Mon, 25 Nov 2024 07:01:01 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] handshake: Add pmksa setter & stealer
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20241122151551.286355-1-prestwoj@gmail.com>
 <20241122151551.286355-10-prestwoj@gmail.com>
 <7fd01a53-53a0-45b5-993f-6bec6ba16a1a@gmail.com>
Content-Language: en-US
Cc: Bryce Johnson <bryce@redpinelabs.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <7fd01a53-53a0-45b5-993f-6bec6ba16a1a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 11/25/24 6:56 AM, Denis Kenzior wrote:
> Hi James,
>
> On 11/22/24 9:15 AM, James Prestwood wrote:
>> From: Denis Kenzior <denkenz@gmail.com>
>>
>> The majority of this patch was authored by Denis Kenzior, but
>> I have appended setting the PMK inside handshake_state_set_pmksa
>> as well as checking if the pmkid exists in
>> handshake_state_steal_pmkid.
>>
>> Authored-by: Denis Kenzior <denkenz@gmail.com>
>> Authored-by: James Prestwood <prestwoj@gmail.com>
>> ---
>>   Makefile.am     |  4 +++
>>   src/handshake.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   src/handshake.h | 11 ++++++-
>>   3 files changed, 91 insertions(+), 1 deletion(-)
>>
>
> <snip>
>
>> @@ -141,7 +142,12 @@ struct handshake_state {
>>       bool supplicant_ocvc : 1;
>>       bool ext_key_id_capable : 1;
>>       bool force_default_ecc_group : 1;
>> -    uint8_t ssid[SSID_MAX_SIZE];
>> +    bool have_pmksa : 1;
>> +    union {
>> +        struct pmksa *pmksa;
>> +        uint64_t expiration;
>> +    };
>> +    uint8_t ssid[32];
>
> I changed this back to using SSID_MAX_SIZE instead of the magic number.
>
>>       size_t ssid_len;
>>       char *passphrase;
>>       char *password_identifier;
>
> All 15 patches applied, thanks.

Thanks!

Bryce, I know you were interested in this. It would be good to see if 
this allows IWD to pass certification with the wifi alliance. Let us 
know if you run into any more problems on that front.

Thanks,

James


