Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8350B27702D
	for <iwd@lists.linux.dev>; Tue, 26 Aug 2025 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221868; cv=none; b=o/gCbrE0Wu0ibh8FhFSFZemf2urpjBBME1Fdutf9Q3eqIehwnjoRnqhbkccyR9RlTrDtaSXdChQvr+lzQD1FQYLJDX6YOKsw9mLhexn7kndvE+SDtSoc+EetGqHQRMVBSFax3sBJUm1b3xM2vCvGgDKygNqefR6dMB2VyrgZ+zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221868; c=relaxed/simple;
	bh=nt9ph0mizfmeZ8m5Q1w3E/b3jS1ikjCtBWeHWU5sBnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BCcgBfPmasumrnF+CGJ3uXA1Omf9rqIWk83/PcjesLjSYo28R0gBQdRBsKLv2geu2c3RujDQstC6wBs8lIdPYJp15LaWwIU2BtGYMQrLvucbUWtIWZc9iOh6YSxFdWsFubuizgt5F0eZCcgHskGMbbNHDzQC2/uvyWW1D8Yxa4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meXoA1HD; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meXoA1HD"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70a9f5dfa62so55117846d6.3
        for <iwd@lists.linux.dev>; Tue, 26 Aug 2025 08:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756221865; x=1756826665; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5jEg/RhSePm/XykenzXwK5Fq1/tpD9mCTlPfB5iddOk=;
        b=meXoA1HD6KxEcuYnBg2RPWVjj2TMpUx7THiICcq0GbFyFTpxmDgyZ/ZQGsz7ovgHu9
         t2gDG6zzrIuV3YBUfZbu9BRJBMAsO89d2Me8fgDswuyvYgsc36+uYoiBtV3JV17y1rxK
         dI4SW+FLZoajpQ74kZDHo9SN7c2H86ASxwngxucW/Wjjc7qgS3efDE2F1nZad6Ev8lIv
         YtinPt5uqyRnpZk89+wL0iwIZRhm5n4Jy2UNBwivoYunn1KYcb2TsnrLIV6wTxb7F51u
         MU5mn0ZZPSawhlhhaFMkl3qb+aTK1MFBYIoLBgSu1gXqrh1kaMXorcrp4ko1Hw5/r4mD
         4IrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756221865; x=1756826665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jEg/RhSePm/XykenzXwK5Fq1/tpD9mCTlPfB5iddOk=;
        b=HM4htcGVOgB9dq2xkprLep1kVx21+g9ly1q/EZbmu7OwXu2JK1TSUfFJnqKkAfhMb6
         +3IZq6ruHSLt/HC34FPFrlqUh5F/BxUoQfJaCI4kRT3CG/gQWR0sNZNuxh0U4GsO7IXh
         GmWhqGUc7l0nC9yUiqSSqRHryv9mArpklizWzEMg47xDQaSkyXjTYvXTQruqIWcPa+2x
         4lR6m6SHEclQHYdGgFvLOM9Ko6rqVu9+D8ubK+Hi9UUOfaC1h6rZ90PxmNCqzY+cykXv
         j2BH4SeZWxZmh0Ka0G92lPMvsOzSOwfvabDwwMuiICv2g6a/H3hlWNMNOJVmuAHPyqug
         J2yg==
X-Forwarded-Encrypted: i=1; AJvYcCVC4HMwy7iTzwflUXcqY9N8u26TodywXIBe0sj+BldmpM78zHZNajVDnGPtym4nH71oVsI=@lists.linux.dev
X-Gm-Message-State: AOJu0YyyTosMzvAeE2aqrjFoXDtGTwdfxWoVCwCdlNa6UrcBOD8M7VD6
	nFSWaa06ce/hfR9HDavxmE15TNx8DGFt/dP2+HoOVJ5VfZatWkXwK5hh
X-Gm-Gg: ASbGncuEE2l1ZE18PMi1uzL9+qbmks9PeF0+7FvDu1MIETSdPMPHASONqC0gFhzG59F
	cOlIWFQZDNkMLuDOHc6RF41N4zG6ffx01JewI8yDw7kKWOYosdtlytiOY8s8+jKxJsLMr44CDhB
	1o4qcdbcd3A/OyGn8WHEzIhooTHQtrzc3+LTCba6kKVBmXQWpQn4rovsv0nbuC2pMyC0+15RW/O
	CZCJ6QDfMrYux8CI8Uy6uGX2yDLbLprkKlJ+Mb5QRJtchptPzan2FrZ8yLDv++WyKK4RvaoBLwd
	N8FCmbR6r4dhe6u45YBM4heegT0hu2qLlI/8l2IqzGXBi+RUt39YXZGLpNoX4e81En8KS+3/ZrY
	HR8sG1t9KkFrCXNq7zcQ7z6r1gw==
X-Google-Smtp-Source: AGHT+IH2UcyhIy6RUMUMVQli41WG05ZUGjTXw+6axZTPIM0KPmqWr64wdr1Q9rbOQ75s2DOmogV/2Q==
X-Received: by 2002:ad4:5be8:0:b0:707:5ff2:aeac with SMTP id 6a1803df08f44-70d97097aeemr228250906d6.12.1756221864782;
        Tue, 26 Aug 2025 08:24:24 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da728544fsm67663916d6.43.2025.08.26.08.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 08:24:24 -0700 (PDT)
Message-ID: <533715f1-ccd6-4254-90a2-2fad273bdd22@gmail.com>
Date: Tue, 26 Aug 2025 08:24:22 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] wiphy: add driver quirk for the colocated scan flag
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20250822195118.271122-1-prestwoj@gmail.com>
 <d30b921a-6de5-4843-b3fa-83ec7973d8ac@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <d30b921a-6de5-4843-b3fa-83ec7973d8ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 8/26/25 7:47 AM, Denis Kenzior wrote:
> Hi James,
>
> On 8/22/25 2:51 PM, James Prestwood wrote:
>> Some drivers do not handle the colocated scan flag very well and this
>> results in BSS's not being seen in scans. This of course results in
>> very poor behavior.
>>
>> This has been seen on ath11k specifically but after some
>> conversations [1] on the linux-wireless mailing list others have
>> reported issues with iwlwifi acting similarly. Since there are many
>> hardware variants that use both ath11k and iwlwifi this new quirk
>> isn't being forced to those drivers, but let users configure IWD to
>> disable the flag if needed.
>>
>> [1] 
>> https://lore.kernel.org/linux-wireless/d1e75a08-047d-7947-d51a-2e486efead77@candelatech.com/
>
> So why does dropping the colocated flag help?  You have a 2/5 G 
> network that isn't related to the 6G network at all, meaning that 
> there is no RNR element. Hence 6G must be scanned passively on social 
> channels.  If you don't add the colocated flag, the end result should 
> be the same, no?  Or is colocated flag forcing the use of RNR element 
> only?

We noticed this issue specifically with a 6Ghz-only network. So in 
theory there should have been no RNR element at all... Despite this, and 
performing full spectrum scans, we would get a very limited set of BSS's 
back on 6ghz. I suspect maybe the kernel was only scanning social 
channels, but removing the colocated flag got things working as I would 
expect.

I asked the question, and Ben said he saw similar behavior on iwlwifi. 
Its likely an oversight in the kernel. It would be nice to fix there, 
but my dedication to fixing the kernel is ever dwindling. Based on my 
testing after removing the flag I opted for a one-line workaround...

>
>> ---
>>   src/wiphy | 23 +++++++++++++++++------
>>   src/wiphy.h |  1 +
>>   2 files changed, 18 insertions(+), 6 deletions(-)
>>
>
> Anyway, I went ahead and applied patches 1-4.
>
> Regards,
> -Denis
