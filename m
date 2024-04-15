Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B705139CEC
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207468; cv=none; b=FnHpd1Ta90VVu6IFQ4aM6gQgLPGmK5DXodgaZNsuww6u2A7qvl6NoHmCvAdOWuWmAvAlUUfmXTMahAExbeWKtMKfNOq09QgY7wdn5XbTmV/CUCVKDqTd+1g7r1sC6+TU909xAHwl0b1Tp3OUdLtzc7+71BQ6QK89wTLS0NYHTkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207468; c=relaxed/simple;
	bh=Rd4sYCnhbASNq2MYj4sv3QFoLjOhsYzqRkMN69UH/tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eA4xptarBuOcfiUpKBEs02m2Mb7EifiLEUl8E04/p1WtkGvaAYV5e7yT1GEc/W1sRjUWmdWHWf/nUxi6jhEc5vq3ktEVS88Q6CEiQO6IO223Rj19X0M/AWz02gokt9ozVX6Bb54aw8GGCWSr+E68Cw5/FHF5TF6Ra254EXTf7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arCNkRpB; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arCNkRpB"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-437274f3bd4so5074401cf.1
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 11:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713207465; x=1713812265; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MbXM3tB9tLLaNYlmtCdadeE1zdFI+ULjfmkaemIIVDI=;
        b=arCNkRpBQVP5dq/DdoM/8Pu2SN3PrAr+LPci5j8Bi8Hw4z4d/BTG2ruhIGBybC5dBo
         dZ3zkIKsC3vNIOw7tbKj36FMREX9c0kUG9njAkk3KaBtB/0k4UgBLe7yamNmNuNN/0mw
         v95dVx9mtK7Mne/AyyIdtcIVe21pZg3L4qbnMzVuiNfNZehKvNe13pLxHxNCPEiFQlRH
         p5edbFAz5SFJx16lvJmVYCizZei6JiNKlWwpuEjw1tvyOVb76yFNy+/1aElIJ5bwPgRY
         Tx6Xa+hR62WLNngth3NG36zuZ1hGPlwKNsTrB6f7+sXSAVSiMZ5xEr1zD8SzQxVf0+YB
         4+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713207465; x=1713812265;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbXM3tB9tLLaNYlmtCdadeE1zdFI+ULjfmkaemIIVDI=;
        b=hITJp20aeAbyyMIgAtWdz5wVVPAfK3J4SaNZUXvfnxvhNX+uxWzPFIErYdFMmKIXCZ
         o8HvuTNX8FXnkT82a60ULex3vc71G3D9xzl0zmGil0eA0NqdRfdxGx4LIeHcN8Igw8e0
         UiytxeC7lLAPaNjqav0sIlplKOG4TqekG6koUKoDEufhqZYYew93qOi5PSGx2RVxET9I
         3SMLKW6sxvNeb+Ssj63n/BuvtROuGH3GsD+stc7hBLBnzmlyhWM51D5+95kQvMdhUt1Q
         xFrahvSyT0mTSyUWeGfQVNpKxCNR8V63mIPluCddv50XHjiZb1KTtp1UIoFihvJKTCkc
         tOYw==
X-Forwarded-Encrypted: i=1; AJvYcCUHhnm0Hz3Um8JKnyjdMRNosaTS8NTMm6GK7XtyHL1rXaufyJl/XcGJVY0M72T9z3lPgXA5sasZUXYwgTr/eYe1b2Xf
X-Gm-Message-State: AOJu0Yytz1vravJ+lBWy3HVttSUFtAQSvAZ7mP357V94pc+oNKFzE9+T
	uAgIXLCGcwQbDqasD8Yr5GyHs7jyyhnbZUKZLAasnUP0QdEebZlt
X-Google-Smtp-Source: AGHT+IGTeJGcDiRW0DFfpPf2otQK5gAcTkClICATPr2h5pGxDKdL7L8yxRUU0BSdEDO+CDMFNVf3fw==
X-Received: by 2002:a05:622a:252:b0:436:5616:aacf with SMTP id c18-20020a05622a025200b004365616aacfmr1014148qtx.11.1713207465044;
        Mon, 15 Apr 2024 11:57:45 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id n25-20020ac86759000000b004372541e823sm775043qtp.79.2024.04.15.11.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 11:57:44 -0700 (PDT)
Message-ID: <82b55e12-5f9b-4b31-b44f-18b8de4fce14@gmail.com>
Date: Mon, 15 Apr 2024 11:57:43 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NT/VHT errors filling log
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, KeithG <ys3al35l@gmail.com>,
 iwd@lists.linux.dev
References: <CAG17S_OZt84p8HQ4E189+VTMssSrDBDXNzeMUT_hZb=jbuKE6Q@mail.gmail.com>
 <7978cd1a-8122-4b6b-9e38-b7d65a9c393e@gmail.com>
 <8c99082f-fa0d-4c9f-87ab-e49dc9e0f497@gmail.com>
 <558f87c3-7f6f-4c9b-9ff0-42f261f13ef3@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <558f87c3-7f6f-4c9b-9ff0-42f261f13ef3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/15/24 11:50 AM, Denis Kenzior wrote:
> Hi James,
>
> On 4/15/24 10:15, James Prestwood wrote:
>> Hi Keith,
>>
>> On 4/15/24 4:24 AM, James Prestwood wrote:
>>> Hi Keith,
>>>
>>> On 4/12/24 10:41 AM, KeithG wrote:
>>>> Group,
>>>>
>>>> This is on a Pi5. this is with the 'current from git' build of iwd.
>>>> iwd-git/now 2.17.r0.g468cecdb-1
>>>> These are new errors which are showing up in the log and recur a lot:
>>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capabilities
>>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT rates
>>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing VHT capabilities
>>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capabilities
>>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT rates
>>>
>>> I added these recently as well as a small modification to improve 
>>> fallback behavior for calculating the data rate. This isn't coming 
>>> from the driver, but the scan results. Apparently APs sending 
>>> invalid IEs is more widespread than I thought. I'll need to change 
>>> this to instead maybe a single warning, or maybe hidden behind an 
>>> env var.
>>
>> I sent some patches to the list which should help. You may still get 
>> a warning for HE capabilities though, if APs are advertising the 
>> malformed IE.
>
> Can we find out what is causing the errors?  Is it the low RSSI?
>
> I rather we added a L_WARN_ONCE or L_WARN_THROTTLED or something 
> instead of turning them off.

Most likely low RSSI because I didn't handle -ENETUNREACH, so it treated 
it as an error rather than silently dropping down to the next capability.

>
> Regards,
> -Denis
