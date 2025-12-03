Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C50257423
	for <iwd@lists.linux.dev>; Wed,  3 Dec 2025 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800832; cv=none; b=CoAvmhJnzWsW1MsPovx1WvnqHnohO1BLN/dX1lxdvG5DO9XJPeznpd5KivVfxYpj/wxu2rORYqDEVmnlW/Z9AvCO6Y/Ndna2tnkMblj0NKanJq4H399O7dH0pIVzzTDjhslrFL8C+3UoueI+eYJTgw6YpwWWPI0H8BBVyjrR98w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800832; c=relaxed/simple;
	bh=5cnQG6lNcYXYvigRQrOUjKZTgc+04eNXNCr+3K2OYMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b/o2gNyM84K5315ikbndXXVbWqxEBeP13afdQUY4zcCcQKctRrcZElq+/4hf5Sk1cf6a/8aKyFH5wXD5pbw8KhswzRIDqvGIQ8TWHmngWgNEl1RiD6xqOgKjjdGJIJ6s5nD6lZ6QiF0mzfDA6144Cf7iSA/+aS/qQlGKqFnp2wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtZvfes/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtZvfes/"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aab7623f42so241307b3a.2
        for <iwd@lists.linux.dev>; Wed, 03 Dec 2025 14:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764800830; x=1765405630; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O2Z82gdiD0CFhv5ThDIO0sBy8AwtgxGzxTGjmGVm7Ac=;
        b=jtZvfes/gQkMWO+etmTR8rSs7/P3sRv+mBPJ3GEqhpHlOQQh1Fq3ymm3Vmvrwx11Mi
         QCF+PQ7p+MphUxmPhbiQJCUV714dSCCp7CRX4e/Iraf9nqfvjx+hIXXk1kY+SD/L9VyX
         qXGSrjjECnJ2vewFT0oxWU1AwiSjrChbvqG12WThobqCImKksXWlS/2vMvH9bSSAykR3
         uAAKYzRwuZF++p/Yrp5pW/cI14cr2RLXIhKUnxh02/DOhfX0acnOMF3i3hTseoc1gKz5
         KL+/Skv7RbeM7v8wt4SnsiCLJpH4dNtLGEMEBA9BcZDY9CXwuF0eKssoV9pBvxV2pGWo
         tyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764800830; x=1765405630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2Z82gdiD0CFhv5ThDIO0sBy8AwtgxGzxTGjmGVm7Ac=;
        b=V4VWvINJmdNGUQgpWgHYodLCiCFEMEsf/YRvTRTbqVajSdW55UVqyFaHNvfcpZFBWt
         QRrlx7bU9Z0tsoPa6zr1zN8l+U0wapR94tqy8AlKvJY6rAlZqn39D79PbS3/3w6/Yz7E
         wRyZ29PO+RK0twwyjSf2h5tBdA25buYHXRJ46tJMsOZsJ3klt6C13IlqMYgAp8wC+V7z
         9HBWq0dryVdhycbBK7sOpxjdLaZL0SG8/FUI7072Nn2pcdAk3WzhfvyXgA/XfpojA5ue
         jup65ekbrwJLJZ4r2L5zQwpQy1IRO6m/BOMz39rnJIk15aTMDq6cTQHzRJp2KGDtZi1/
         xI4g==
X-Forwarded-Encrypted: i=1; AJvYcCXKR43kuxus5a6q8uRMAVniFi/klD6/w+mn+rSdAhIvNnLNEVpVJr3TSDahTAqJnGS72kQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwkIr38yZbmsCAnXfxcw5Y1cBVoFrEQfnSh7bB+P869oKrxLOfN
	MJhC4QZRCuCPt+UCIUecp/1C/PgHsVcxRwppd6k3+c6RIixPycg4Bbjh
X-Gm-Gg: ASbGncuQa83etovzNbTcio7uW7soizWO64dAf5HsPAOjGClicM8pTRCbG/E4UrsS3ep
	TJAc3bnlPnx1zEcV61WIDNcw+j59Ns8ExKlUWzjDqkSlGFFXisQL+uG0ACVd/xU2Tzj5TLt2V5S
	gbtvx0CMX8xp+wgPeDyut+Dh9W75MNjYa4HJAHcVA8IoqXKYVGG4QdRzRF8gJ+10gcjLt3fbHSE
	xlivwrO4/pkrCHdLORaBOQ+g1XjyMUaptphqF2JDRDmq4L1DK0CP5If3fUp/JM4WnA6g4dZpdLI
	w1g6Gnxwmy+g6oBj7oDvex4Mt/5cbrbbSfI1Wl/7AqHT+nT4q2vPVvugMOo+cM0fRnxu3KDi/ka
	RNMlAWc85FacN2yfUkykyeVuL/anJlxLUlOhePsv+vLqu
X-Google-Smtp-Source: AGHT+IG3pGvJQwoDRZIO9sHn3Xexytnf8nN7j0pDlXXyGzttHX6vE50h1Ef0XT98/0lFrEQlf5eKjw==
X-Received: by 2002:a05:6a20:7f83:b0:35e:824a:dc57 with SMTP id adf61e73a8af0-363f5e2617emr4837382637.37.1764800829960;
        Wed, 03 Dec 2025 14:27:09 -0800 (PST)
Received: from [10.163.2.142] ([12.200.100.42])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fb24942dsm18744324a12.6.2025.12.03.14.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 14:27:09 -0800 (PST)
Message-ID: <3e62dbc6-78f5-4efd-8ae1-874f30e320df@gmail.com>
Date: Wed, 3 Dec 2025 14:27:06 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: check return of handshake_state_set_pmksa
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20251203150321.916124-1-prestwoj@gmail.com>
 <f1fe54f2-8205-477b-8237-506da0e7260d@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <f1fe54f2-8205-477b-8237-506da0e7260d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/3/25 2:19 PM, Denis Kenzior wrote:
> Hi James,
>
> On 12/3/25 9:03 AM, James Prestwood wrote:
>> If this fails num_pmkids and pmkids would get set, but to an
>> uninitialized buffer. This would then fail to build the handshake
>> object later when copying the PMKID.
>> ---
>>   src/station.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/station.c b/src/station.c
>> index 50997f5f..6c9e8d13 100644
>> --- a/src/station.c
>> +++ b/src/station.c
>> @@ -1378,9 +1378,13 @@ build_ie:
>>                       bss->ssid, bss->ssid_len,
>>                       info.akm_suites);
>>           if (pmksa) {
>> -            handshake_state_set_pmksa(hs, pmksa);
>> -            info.num_pmkids = 1;
>> -            info.pmkids = hs->pmksa->pmkid;
>> +            if (!handshake_state_set_pmksa(hs, pmksa)) {
>
> This seems fishy.  Are you sure you're not masking the real issue 
> here?  Would this possibly be related to fast transition re-using an 
> old handshake?  Maybe we should not try to use or set the PMKSA for FT ?

Possibly. What happens is we complete an initial association (call it 
AP1) and establish a PMKSA. Possibly unrelated but IWD did fail to FT 
due to an association rejection status=40, IWD connects again (different 
AP), and we then try to FT back to the original AP1. This is where 
handshake_state_set_pmksa() fails.

Not using PMKSA for FT is reasonable for sure, since there's not really 
a point there...

>
>> +                l_warn("failed to set PMKSA to handshake");
>> +                pmksa_cache_free(pmksa);
>> +            } else {
>> +                info.num_pmkids = 1;
>> +                info.pmkids = hs->pmksa->pmkid;
>> +            }
>>           }
>>       }
>
> Regards,
> -Denis
