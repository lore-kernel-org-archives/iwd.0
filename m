Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55E1CACF7
	for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564159; cv=none; b=oNIY4jyl6If0yVq4fawikO2ZbtPROomZNJOeH0tkOdm2/HXoexyizbcr7/UXa4IPAPdngqVGtv9tonRHUBpsT9iHVoWN/99VBlFIsp8JVsZ7Crc2UcDzSBfpaBroDPqaCGqcMIdaGjvXTeZ7gWtK4QEEwOG1CPZJfgUM56CeuzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564159; c=relaxed/simple;
	bh=+/EFl8rkpIURvx82+HiWDiYc3TfvO3L3DRsawMvbPeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELZ35FgGONUsm+iaeWiftuGAx72d65mnfaDsKb0L7LhCr0tjsiG8BwH6QylCno1iFNL0WCu7JAQU+JcUeZJlDU7T2cLp19OqXgnO6NwpVhjaRQ/1MHDobSIz41bxlzw3a7uuqDi65EuEPhjWer9Pj17QwZDq1Ms7eG6UkkFVufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEfb4Y6o; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEfb4Y6o"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46686a258f7so17241231cf.1
        for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 11:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732564157; x=1733168957; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0Iv2fATjgBAtbBJAPGIyrrRDICGBfBMifgC93zqHRo=;
        b=PEfb4Y6oRdjUzpC7lLcslqzWdB1BBHmIZcip778CTkgkOuw1U+fiuSwvj1m+fr72LA
         JandSv81VvH0dXUSyAwuXjHQGGissmsYT33gdq8n9fOkraaBc6Wu0OzvGKCHc2sefQj3
         uvLlgC6X+Ycob8MX2UvWpYUQRw0ithla11MHDA7IDSaJP4hohpmWJPL8n81TFcRI6zSb
         /Bjao+PSmuyJr1tNA2mUp4vMGnfPJ3pSx81Eus0j94hIfOIYDz7BBeRcBcdList5hRRz
         a2edupb/B8qsPrz4XMoj1I/Sk9DEcLn9mrpajmDIZix+U+MCU9seh4gHcbjHqXmA2gWA
         BnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564157; x=1733168957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0Iv2fATjgBAtbBJAPGIyrrRDICGBfBMifgC93zqHRo=;
        b=X5UKlDST2C5aGTWgzoCkw9T0/160+UTAp5JsuKSoyjwSJf0w1Hh+H+Aw2rlMX3Uywi
         k0Zo5Rovj6suDbMBbtGgEzhAa0lgyTYInc62uoNBnPGnNQF28GQ4X9sVzz1PkuXyY751
         xJzPDtaNVIjwoID3G/L5qmpjsHb8o89CLUkC8x7uROgrAZs+vQZelYSSynWNfExm3mLb
         zr6wKxbDkGfHIzVifXERINL3RoCB89wdM3nsPvsKNHH8vQC9FB8LgVhZfy0yzAGhZdNn
         /GDOnpZit7IuPEFQgcuR2DEHUrMN2l0wnTMqk+Tccx6nguDErUVxowVoKo4UaXJapcib
         vEEw==
X-Forwarded-Encrypted: i=1; AJvYcCXrzX5ZklfmOkK9Twl6LZeWG8NtFw3zOP4se/kKM/Z7KY8KyIYEtpU60KYyySPqPBJ4OH0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwooeZCTMnz+AtKbyWRNp9V5CFw5nOgr9I2PMGEjLsPZH436BKj
	we7oRyLaCohyxPYHYYX8vlHLuQtof8Td7ZnL1fJzgPP2CKTFS66xQFQ82Q==
X-Gm-Gg: ASbGncvxu0Lf50RuJZ9mL6C5OccMzNSu9JF9OQHy1HAhAelEoWCEs38cW/CzFJe4kOC
	MVwjlN8AxAsm13zldr5oboSs8WxNrdtmXpNiNu6NFuVvXw03PGcioQ02b2ReGV/4En4iFehLuev
	066pfe5Mzq1fnOwj714Pf9z4UpRjcKceuhVXmJ1hJZ4wtzGuL09LNytuxn+DDY2RojAwr6fjCwY
	SQW9tuGNY5kvvQkVh000sK9EG6EycxOBQuQ3IKDJGgpNLCZFscpPA==
X-Google-Smtp-Source: AGHT+IGZtoB+hoH/PkImHYGa2C1ULdmM813x9RddUX/MYfow40aYV7rLvwmnda9Xtw57MbKWF46XEQ==
X-Received: by 2002:a05:622a:1817:b0:460:90aa:ba8e with SMTP id d75a77b69052e-4653d63ec53mr204948331cf.52.1732564156492;
        Mon, 25 Nov 2024 11:49:16 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f55esm49403851cf.68.2024.11.25.11.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 11:49:16 -0800 (PST)
Message-ID: <8c9f273b-b983-429d-b397-552e05650ace@gmail.com>
Date: Mon, 25 Nov 2024 11:49:13 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] handshake: Add pmksa setter & stealer
To: Bryce Johnson <bryce@redpinelabs.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20241122151551.286355-1-prestwoj@gmail.com>
 <20241122151551.286355-10-prestwoj@gmail.com>
 <7fd01a53-53a0-45b5-993f-6bec6ba16a1a@gmail.com>
 <94bdf4e3-2617-4c3d-a2c3-5c34cf684906@gmail.com>
 <CADXxVSLt1t3TdWConKv2rLBb1HdD0xd3gckaeCYyrjXeA0K4Sw@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVSLt1t3TdWConKv2rLBb1HdD0xd3gckaeCYyrjXeA0K4Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bryce,

On 11/25/24 11:25 AM, Bryce Johnson wrote:
> Hi James,
> Thanks!  We will running another product through wifi certification in
> the next 3-6 months with a new chipset from TI (cc3301).  I'll check
> with TI to see if there is a pretest so we aren't running into issues
> at the lab.  We got our last product certified reverting back to
> wpa_supplicant just before the wifi alliance pushed out the latest
> changes/requirements.
Great, eager to hear how it goes.
>
> Also annoying the cheaper automatic testing uses wpa_suppliant pretty
> integrated, hopefully wifi alliance will create a way to do that with
> IWD in the same way if enough people are using it.
I'd be interested to see what they are doing with this. If they are 
letting wpa_supplicant act autonomously and triggering things on the AP 
side, or if they are using the CLI to interact with wpa_supplicant 
directly for "force" it to exercise some of the features they're testing.
>
> If anyone got a product through certification I would be interested in
> any experiences with IWD!
>
>
> Bryce
>
> On Mon, Nov 25, 2024 at 8:01 AM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi Denis,
>>
>> On 11/25/24 6:56 AM, Denis Kenzior wrote:
>>> Hi James,
>>>
>>> On 11/22/24 9:15 AM, James Prestwood wrote:
>>>> From: Denis Kenzior <denkenz@gmail.com>
>>>>
>>>> The majority of this patch was authored by Denis Kenzior, but
>>>> I have appended setting the PMK inside handshake_state_set_pmksa
>>>> as well as checking if the pmkid exists in
>>>> handshake_state_steal_pmkid.
>>>>
>>>> Authored-by: Denis Kenzior <denkenz@gmail.com>
>>>> Authored-by: James Prestwood <prestwoj@gmail.com>
>>>> ---
>>>>    Makefile.am     |  4 +++
>>>>    src/handshake.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    src/handshake.h | 11 ++++++-
>>>>    3 files changed, 91 insertions(+), 1 deletion(-)
>>>>
>>> <snip>
>>>
>>>> @@ -141,7 +142,12 @@ struct handshake_state {
>>>>        bool supplicant_ocvc : 1;
>>>>        bool ext_key_id_capable : 1;
>>>>        bool force_default_ecc_group : 1;
>>>> -    uint8_t ssid[SSID_MAX_SIZE];
>>>> +    bool have_pmksa : 1;
>>>> +    union {
>>>> +        struct pmksa *pmksa;
>>>> +        uint64_t expiration;
>>>> +    };
>>>> +    uint8_t ssid[32];
>>> I changed this back to using SSID_MAX_SIZE instead of the magic number.
>>>
>>>>        size_t ssid_len;
>>>>        char *passphrase;
>>>>        char *password_identifier;
>>> All 15 patches applied, thanks.
>> Thanks!
>>
>> Bryce, I know you were interested in this. It would be good to see if
>> this allows IWD to pass certification with the wifi alliance. Let us
>> know if you run into any more problems on that front.
>>
>> Thanks,
>>
>> James
>>
>>
