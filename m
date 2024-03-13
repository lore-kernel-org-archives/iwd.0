Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE8D51C33
	for <iwd@lists.linux.dev>; Wed, 13 Mar 2024 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710364652; cv=none; b=TW0GHwZIoVPjzte8W/XDZhWcN00JbfNPro4MJAKyE0TsJJNcMk/KPoLZn622dOPKw2RVpN8/ZtmBS8dTsdwzXc7vsO8ZChE7NROfLam9uKbsIJkZxaIHY3/dxNdw8VNq2Ue3YbJ7ggfADGoxjdMLMiwOHjYW2aHrWfx8e69gUf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710364652; c=relaxed/simple;
	bh=ZZ1yvqhV88L8Fdbidzu5N0f/JeBcdFJbua0aS7dkUOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTSNP7zcg1FHc34KEFpVfBkNpSTpBPVsQ22LeuelJuW5mx3jmlqkVGz21Ve47cf635YFDeiXlY+oYzCi77lE/X/NEZr5kzJGWpzAfyGDvp2tvSmN5e2Dmw66PAbkVtO3aIrs38N5m6wNFCVebK36S70WH7bCyKoW1CbLRaNe180=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYR42qD8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYR42qD8"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dd59b95677so2330915ad.1
        for <iwd@lists.linux.dev>; Wed, 13 Mar 2024 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710364650; x=1710969450; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUlXrKT9EnIj18amwCty7VMhLzOsFE6rwuzLJc3R0iA=;
        b=ZYR42qD8YYEJ76YBFjyJLv0NQmVmWetm1cGyMEITbgl2CYxd/E4XxbB1di4Eu3bgv1
         FotR9j6wp2gFyOuKfrjXZ/f6E2T50TS0srPUCx5eF4TrU/5Jzm/kTGDwPoc/hdIbRLLL
         lfjx6+mEPb7xKKHj9M23tg05+IopuIELV6NUQsMbJaMh4vZvUTGVWE9kr2/PmcER51tc
         S9Jc3mysdcUbyhwh6N7+OgRbG8/d+J8Y/7pDSjraSzF1wCtRYVmJNuYyuFIsUeFWYXkl
         csTfoOVchNRkNz4ZTcvMCdYJk3tehIpeFJcd2di1yPXbiwUOQyBE8JrvdNz4cXPpw+Y8
         9jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710364650; x=1710969450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUlXrKT9EnIj18amwCty7VMhLzOsFE6rwuzLJc3R0iA=;
        b=Q4yCcNM8RqFka94OfYXWcO2XIj6JW+dilS0oMMqj6rwSWct7tKVfdijK8bsUHPAKSl
         Cbf2nEuowQbrEgAH+xrGPcZnhRfQZrwmO/behgB5+RExsEHbHrFsCDfRiH31N502LBaX
         i4GoTl2oyB9cViOXSuUk3TSPh9HOI7bwflb8Z1qOoUGbntnskMOUkmIWEDfWXfAnsIXG
         e0PvRrUbJdsaGHRkivgXhby6xf8HDA029j+wGatXiGEf70KuZ/aTnQ5KgGuSXxXQ1L8B
         tOwWGyhrecBiU35xfcqCundpb+Z5Vtojvc1hh1LtIqWcy76DyMGVoL7woGPCOIGVegqp
         pjdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhxiWYLHkyBmEDDVwARfLd8RLg1w1uiNUucUh8UgexvPndyqORb6IsWBYcbd5vmVzmTCSrWQGBdwHCk8PT4eEreLsF
X-Gm-Message-State: AOJu0YwARASO/bYp9i8PurObTUWbIQEFg3EC1e7INctELvDeIQSqKhPJ
	Ls4cX7RBgwFCmSPEOHgP86AnEgIBnUTIFLfnxF1xYZfRAhm4r91/
X-Google-Smtp-Source: AGHT+IG9I+hDSxyD1Im6G/LLTkYoz1TmcbofHmjXyd16Vyd3jct6bToKtjs1/z8pGQeFpGSefzEBMg==
X-Received: by 2002:a17:902:ea01:b0:1db:55cc:d226 with SMTP id s1-20020a170902ea0100b001db55ccd226mr14449454plg.66.1710364650361;
        Wed, 13 Mar 2024 14:17:30 -0700 (PDT)
Received: from [192.168.254.38] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b001da15580ca8sm65107plx.52.2024.03.13.14.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 14:17:29 -0700 (PDT)
Message-ID: <db86cba4-0e61-441d-8e66-405a13b61a3c@gmail.com>
Date: Wed, 13 Mar 2024 14:17:29 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
To: Eric Biggers <ebiggers@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Karel Balej
 <balejk@matfyz.cz>, dimitri.ledkov@canonical.com,
 alexandre.torgue@foss.st.com, davem@davemloft.net, dhowells@redhat.com,
 herbert@gondor.apana.org.au, keyrings@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mcgrof@kernel.org,
 mcoquelin.stm32@gmail.com, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, iwd@lists.linux.dev
References: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>
 <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
 <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com>
 <20240313194423.GA1111@sol.localdomain>
 <b838e729-dc30-4e18-b928-c34c16b08606@gmail.com>
 <20240313202223.GB1111@sol.localdomain>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240313202223.GB1111@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 3/13/24 1:22 PM, Eric Biggers wrote:
> On Wed, Mar 13, 2024 at 01:12:54PM -0700, James Prestwood wrote:
>> Hi,
>>
>> On 3/13/24 12:44 PM, Eric Biggers wrote:
>>> On Wed, Mar 13, 2024 at 10:26:06AM -0700, James Prestwood wrote:
>>>> Hi,
>>>>
>>>> On 3/13/24 1:56 AM, Johannes Berg wrote:
>>>>> Not sure why you're CC'ing the world, but I guess adding a few more
>>>>> doesn't hurt ...
>>>>>
>>>>> On Wed, 2024-03-13 at 09:50 +0100, Karel Balej wrote:
>>>>>>     and I use iwd
>>>>> This is your problem, the wireless stack in the kernel doesn't use any
>>>>> kernel crypto code for 802.1X.
>>>> Yes, the wireless stack has zero bearing on the issue. I think that's what
>>>> you meant by "problem".
>>>>
>>>> IWD has used the kernel crypto API forever which was abruptly broken, that
>>>> is the problem.
>>>>
>>>> The original commit says it was to remove support for sha1 signed kernel
>>>> modules, but it did more than that and broke the keyctl API.
>>>>
>>> Which specific API is iwd using that is relevant here?
>>> I cloned https://kernel.googlesource.com/pub/scm/network/wireless/iwd
>>> and grepped for keyctl and AF_ALG, but there are no matches.
>> IWD uses ELL for its crypto, which uses the AF_ALG API:
>>
>> https://git.kernel.org/pub/scm/libs/ell/ell.git/
> Thanks for pointing out that the relevant code is really in that separate
> repository.  Note, it seems that keyctl() is the problem here, not AF_ALG.  The
> blamed commit didn't change anything for AF_ALG.
>
>> I believe the failure is when calling:
>>
>> KEYCTL_PKEY_QUERY enc="x962" hash="sha1"
>>
>>  From logs Michael posted on the IWD list, the ELL API that fails is:
>>
>> l_key_get_info (ell.git/ell/key.c:416)
> Okay, I guess that's what's actually causing the problem.  KEYCTL_PKEY_* are a
> weird set of APIs where userspace can ask the kernel to do asymmetric key
> operations.  It's unclear why they exist, as the same functionality is available
> in userspace crypto libraries.
>
> I suppose that the blamed commit, or at least part of it, will need to be
> reverted to keep these weird keyctls working.
>
> For the future, why doesn't iwd just use a userspace crypto library such as
> OpenSSL?

I was not around when the original decision was made, but a few reasons 
I know we don't use openSSL:

  - IWD has virtually zero dependencies.

  - OpenSSL + friends are rather large libraries.

  - AF_ALG has transparent hardware acceleration (not sure if openSSL 
does too).

Another consideration is once you support openSSL someone wants wolfSSL, 
then boringSSL etc. Even if users implement support it just becomes a 
huge burden to carry for the project. Just look at wpa_supplicant's 
src/crypto/ folder, nearly 40k LOC in there, compared to ELL's crypto 
modules which is ~5k. You have to sort out all the nitty gritty details 
of each library, and provide a common driver/API for the core code, 
differences between openssl versions, the list goes on.

Thanks,

James


>
> - Eric
