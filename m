Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C241AA1D2
	for <iwd@lists.linux.dev>; Tue, 28 Jan 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087578; cv=none; b=gvLXkOmzuLieCfsYjHlD1GvjnF4UiMSEAclaOP5EJ+xkzE5QTdcaJMsZjtcvHpqJsddsBd5drqWYsxdXyzfyneMo+lzMpKevFRzR0/tVBJYtxwTtmjRzgBvdRwGgNTFS/hl0TjfHiXQYRQvwZpurbbp008ib2neFRakHxR5KWtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087578; c=relaxed/simple;
	bh=b+7ilEyNSBscXwvwTOgsdy004Z9/0inwR9wDoHjamOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4mrofdMDJsl8xz0CYy0Sz2un2o4zyOungbNI6FHUEpfBS4QPbzUYEen1JQaVzS5IvKqSHe8RCdQRX+39w9176ZzkdE0yFOClf2vsbbNPtYt4QL0IPYVzQCnCiFgLzQEEnIyC3qHbtvlWyNqkOk7QcZTkCPNr2ixRuoGySj1gMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1Uus9vV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1Uus9vV"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21c2f1b610dso139662105ad.0
        for <iwd@lists.linux.dev>; Tue, 28 Jan 2025 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738087575; x=1738692375; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HuZAFXSXpQ09K/j+v7WPJ8gLc97nXaSiimvECzvWmgA=;
        b=f1Uus9vVpiOuoBCvuX2fWObV55m7w1qcVu2Bhc9DCVZoj5SZeB0fiol6mDZGht7uhd
         vFP0lAJpBXa4FxwLDnF7ruotq8X/TQiEOLCLsB6NNgdZ2AhOX5l0XNE86arZK/7FneOa
         IVlh5VKIZgF/A1DD5hKvTdi9MJKoMp75wilIF3MMcljRuoPwqcqovyowH0o1jDQn+wYi
         HOgvi27zLMgx3I2zS6n58rd6kHCD+LqLorG2DGtpLSw5MfrA+FcOhhFE+RJ4RTAFkwRr
         u7jiwIYUnjxdMSpLwcDZOfVM/AkYYnksLnY9r8Q31d1HXvUoZmjcyTrD74y3sUMvhSSV
         Glaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738087575; x=1738692375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuZAFXSXpQ09K/j+v7WPJ8gLc97nXaSiimvECzvWmgA=;
        b=V4pj6Sb3QWV6CMbXDT9fREjzWnSgBRWfVDvbXhwjAI2rc26Y1pWZQHCauavhGb6Kym
         E39GKhJb4mEz61a8L054FXEFQ2Mv1p15Bv6ekxPc965DTAnl7HE2re/4mR7QteN5AMo7
         zDzjH76jkiRzrGpUUb7BawKTuv5Z4MQp2p19yQxiquGzT9n+cHpVQSvJ9aQ98F7eegsG
         IznL6pi1cH45AgLhoTu7RoenNPiSUFh0Al7URBNk4hDxleSv8EhbXmem6StW01reuvoW
         96gso6GCVyuyek6zLfFvZlc2Qa8sn9O2ZOUMAbK4uWWmiy8lkmnxAzZl+phRx+wIEOmp
         bY8w==
X-Forwarded-Encrypted: i=1; AJvYcCVEeFDoAe0i2uUkzDWnWzV2X7gfVdlh1IPm85CLYFdzzv3MwlqnJYBjQo8ZHGUzDebYPys=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywwcv2xSvF0oY5OYC9CTAxobvTiDguJdhI+9U6ePPROkzAIu7pV
	ScFdeiranVTn7M04BdngQXVFZcBvle4k0xm90fDWAs4yjFcCk/QzBeVXdw==
X-Gm-Gg: ASbGnctze/fmtE/9WIhGkpjJBr5P3xZHi4JHigLP2v7qBEL3tkAdvIjx45hm5O/lhlx
	RHf3rkQE6jPMhY/lzx72UqhUpQIZPKm009HkP9mAxWGgRBp9W+XqSgJrvx1IELI1b1aOkPhQkO/
	JA6oVrorH/m7VTCm9T78QfdtbBvQIAunJZteMJ8FtpwRlojIiNmtJgxVp8gMeu2z4/pLBa24zrG
	9s+W7xGZZH/mKOHiGy5MONo+fY6NJbQymWGsCMBXvKei+pfC37z6ZKcHg0CP17Nudn8N4ptlABi
	y4h9JdUZxQJp6j9c9HL1rhmrgbkaAFIEo9oYLqhTfqIrlZfBCUith2cH/MjeOkMNPx+CWg==
X-Google-Smtp-Source: AGHT+IHhtL9UluJP8kuzisQzFLp+uJHnbs9Yl2OYm1q4MnoGkg4ph8okdIouYZmIqfdGHFmfYjo2Iw==
X-Received: by 2002:a17:902:fc4b:b0:215:72aa:693f with SMTP id d9443c01a7336-21dd7c44298mr620335ad.9.1738087575309;
        Tue, 28 Jan 2025 10:06:15 -0800 (PST)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424d65asm83936055ad.246.2025.01.28.10.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 10:06:14 -0800 (PST)
Message-ID: <fdc44a38-27d4-4dd5-993f-318c8ce52202@gmail.com>
Date: Tue, 28 Jan 2025 10:06:13 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: KeithG <ys3al35l@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com>
 <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
 <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
 <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com>
 <CAG17S_MfQ+FjWQJoiNs30rt4u1O9Z_FXFB7BiS6RAQsG9ReNkA@mail.gmail.com>
 <CAG17S_OigLj3j=tS2BKYpoKOWKVs=XOBS-YFn26SzF9r+ZpLzA@mail.gmail.com>
 <CAG17S_Pj6UaA-yaGDUCwr8+M+L760PU0NvB1sAzGGNCp4xKatg@mail.gmail.com>
 <8c36a8c0-0246-4009-b79b-890e1f0a7aaa@gmail.com>
 <CAG17S_NNtyU0eXzsWgrjJEjcqDHPLrbSkvnEboSg-fZebdV3dg@mail.gmail.com>
 <76b2f0b5-641d-43e6-9c6d-4073fbc61dd8@gmail.com>
 <CAG17S_MxYjoYBGmNDPPuVUTBfRmksfiJ4X==SAPF+6Hz3j8eKg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_MxYjoYBGmNDPPuVUTBfRmksfiJ4X==SAPF+6Hz3j8eKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 1/27/25 8:47 PM, KeithG wrote:
> James,
>
> I patched the latest iwd-git. First time after reboot, it will
> connect. If I remove the config in connman:
> connmanctl
> config wifi_blah_blah --remove
> then try again:
> connect wifi_blah_blah
> it will not connect and I get the error:
>
> Jan 27 22:24:01 Pi4 kernel: ieee80211 phy0:
> brcmf_cfg80211_external_auth: External authentication failed: status=1
>
> It will not get a DHCP address.
>
> When I add the directive in the main.conf, even with this patch, it
> seems to connect every time.
> DisablePMKSA=true

Thanks for testing this. I've got yet another patch which should avoid 
the need to use DisablePMKSA anymore. If you have a chance to try it out 
to confirm that would be appreciated. Again, remove the DisablePMKSA 
option for this test and IWD _should_ be able to connect/reconnect 
without an issue.

Thanks,

James

>
> Keith
>
> On Mon, Jan 27, 2025 at 10:21 AM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi Keith,
>>
>> On 1/27/25 7:09 AM, KeithG wrote:
>>> I just tried this and it connected 2x once from a saved key and a
>>> second time from a new key.
>>> Will continue testing and let you know, but this may be it!
>>> Thanks so much for all the support.
>> Would you mind testing the latest RFC patch I put on the mailing list?
>> Please remove the DisablePMKSA option in main.conf with that patch. I'd
>> like to see if PMKSA will actually function with brcmfmac without
>> external auth, or if we're stuck disabling it entirely.
>>
>> Thanks,
>>
>> James
>>
>>> On Mon, Jan 27, 2025 at 8:29 AM James Prestwood <prestwoj@gmail.com> wrote:
>>>> Hi Keith,
>>>>
>>>> On 1/25/25 8:37 AM, KeithG wrote:
>>>>
>>>> <snip>
>>>>>> With wpa_supplincant, before the AP sends the 'PAE:', we get this
>>>>>> which is not in any of the iwmon logs with iwd:
>>>>>> < Request: Set PMKSA (0x34) len 92 [ack]                              14.561627
>>>>>>        Interface Index: 3 (0x00000003)
>>>>>>        PMKID: len 16
>>>>>>            05 cb 9d 0d 9a c6 7c 42 77 b5 d2 23 f0 62 f7 4d  ......|Bw..#.b.M
>>>>>>        MAC Address D8:3A:DD:60:A3:0C
>>>>>>        Unknown: 287 len 4
>>>>>>            c0 a8 00 00                                      ....
>>>>>>        Unknown: 288 len 1
>>>>>>            46                                               F
>>>>>>        PMK: 254 len 32
>>>>>>            35 28 07 cb 94 de 82 e7 0a 5c 73 d3 e4 1f 88 ae  5(.......\s.....
>>>>>>            74 84 82 66 86 8d b5 aa 79 cb 75 d9 75 8d da 3a  t..f....y.u.u..:
>>>>>>> Response: Set PMKSA (0x34) len 4 [0x100]                            14.562171
>>>>>>        Status: Success (0)
>>>>>>
>>>>>> Is there any more info or help I can provide?
>>>> Looks like the only difference between IWD working and not working is
>>>> when it includes the PMKID. This is due to the new PMKSA feature which
>>>> looks like it requires some extra work on brcmfmac (using SET_PMKSA).
>>>> Try disabling PMKSA in main.conf with:
>>>>
>>>> [General].DisablePMKSA=true
>>>>
>>>> This should hopefully get IWD reliably connecting.
>>>>
>>>> Thanks,
>>>>
>>>> James
>>>>
