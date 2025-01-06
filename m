Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6F15665D
	for <iwd@lists.linux.dev>; Mon,  6 Jan 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177253; cv=none; b=IdrsnNYsx54iMsnuF3Vss1SGbv58El1W0U73XXjcWlbHx3OmcKk3o3o8hVS5HJgcJXa9LdAdis4xpDhfrwFTNBmo/R4KGdt5T+ZW4/ruHA5mFSEGpBWUztfK7AQdu06GRut4NR2N5rY21PaLQXVJ3TVWzdVc8Ug6g4VA4Fg43DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177253; c=relaxed/simple;
	bh=qerr9y/kH23X5GK565U0xsyQxdRlOYHSIkQM2/Axgco=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Uh3wRu4+X4wT+aCf5LbULsxK74xW/Akyn6crrcV5ypGR9cU7EzjSeBhtKFK/zZ1lD83JtsV2ph5PC+t4EV3LaPGliU4ZGvWZUXDybn5P+Lk6V7JMFfSQ/naiKRv8vYY0ledaOGftnDENoRQ5JtKir2VtzmdBXiYeNR8UmRmojqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz0DKrf6; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz0DKrf6"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29e65257182so6733176fac.2
        for <iwd@lists.linux.dev>; Mon, 06 Jan 2025 07:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736177250; x=1736782050; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RtcGfEbOhBfEBQp4Bsw4G7/F1CO1iF23Bj79pDFI4SM=;
        b=dz0DKrf6opsHUqZAo++UK4l0K8jcJYMeB/mZZ2tixvnzUBtAksmjnPthUmlfOxBqzb
         IIGbUKLhAsNrr0hdU8uWh6EPm4mDPB7k5ZyOyJ8xRGMmRRWix4/jeEIRvwr+aoLidRQF
         wx3qauEUVIkOqKQb7KEdDPS5LoTxAgdX+sCps0nW9X7+HfKYB/j//A9gpAixmX9zCDEE
         3MUs5CwgmmRMCFnLd4tlOuYLubtZvdiw87wmZl3T2T++XXLlSkzzcbSLhiyuLA5VaeTm
         0+MTvHqowEztrVqOJQrkRX0p6gWE8DIyKeb8Cnohbr4uw6j647zW+xXwnmONudHbyXfs
         q/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736177250; x=1736782050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtcGfEbOhBfEBQp4Bsw4G7/F1CO1iF23Bj79pDFI4SM=;
        b=a7cpfdjuYyAaNnEiW2Jym0Xc7tiWpz9j8pavMzjRW0u8pUJ4stOwPlNz6nvN48/mPt
         Od13oeSFq1yt20RNxy/bCI9JtiTP5UbQ/kYcYAHl6MZxKFm7yatplm7Ouez7czUMnhGk
         y4q0w7Ds3mXesPj04yF3XZoR4CXQLclnHfvPsTre4kH59591PLJAJEEkqf/g3FBBgpNP
         Dq8GwsxNph/AHo+If8o0wZdwUcssvbW2LzFfxqWIYtPxpJzmu3tsMoTd8oDxGhLQQqqo
         fLKtI74I8SN1qjFxOteKyOXIfs2/ngHssiSuGJCAihMzV4+jqr3IMUsT9x2StdCRRpsw
         MyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN0jpEKaEDY7/NBi3Mfd2Vwgr4zCzfIj6TYvVR77AzELbpm6QUeLa+a6CoDuVPgNcKs1E=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzbc/7RjlWQbimXFcoM4e6xrx68hzvnUVpfR8kaHH1c63fuY2px
	s4aJQNm0J+FpJvlVIHVEF8J1BKnk7Wt+9BLXOeM0xzSokfIva3tykBxjvQ==
X-Gm-Gg: ASbGnctlJEvhvvss05o/RUU7aCsat6rEDPqiy1/7bCgrSK//6e123yoeCInUrQA6X0F
	DVTi4FAA8OH/NUd/ylfPvaArbEeFfBa6JxC2MimplH9ktlNrEcjIux2hyspkT94xR7Bu4JSRAu+
	r3pRtSnBUwy/N2fbkT/XUSMfuAAb3sfoSwoAZEpSMTmieM5F5aJB5x/985fzQOZiYhtsMs3gB44
	N1dcekvXIoVIfbIDW6nRSHZwjsU3xz+ZafeV2MzOLCObvT6+p22SUzR9m3SXUPjgTei20RodfFH
	8b4qPSL27QlmNjW0FFK4rw==
X-Google-Smtp-Source: AGHT+IF7yGbsykZhEQTpBatWsGUE4RhedlLdv5dLI7Zp9sGI7aZ22RHhg5XVlKMFoqumhxzgyN5P2g==
X-Received: by 2002:a05:6871:3141:b0:270:1884:9db1 with SMTP id 586e51a60fabf-2a7fb00aeb6mr27586403fac.7.1736177249084;
        Mon, 06 Jan 2025 07:27:29 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2a7d745411csm11660980fac.6.2025.01.06.07.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 07:27:28 -0800 (PST)
Message-ID: <092b1528-96d8-4995-99b5-efde7883cde1@gmail.com>
Date: Mon, 6 Jan 2025 09:27:27 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] handshake: don't print NULL pmksa pointer
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250106134606.115334-1-prestwoj@gmail.com>
 <9bbdd1b7-8fc4-497f-8ac8-80871df4a8dc@gmail.com>
 <759fcc78-4ea7-4d74-8ee8-dc2704f3fed5@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <759fcc78-4ea7-4d74-8ee8-dc2704f3fed5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

 >>
>> Why is this behavior undefined? Would it not just print 0x0000...?
> 
> I had a brain fart, I was thinking for some reason it was using %s not %p. So 
> yes, this is a valid input to the %p formatter.
> 
> I can alter the commit description, but I do think it still makes sense to move 
> the print, or at least modify it to make it clear no PMKSA was cached, rather 
> than just printing "nul" or "nil" or "0x0000".

Sure, that makes sense.

Regards,
-Denis
