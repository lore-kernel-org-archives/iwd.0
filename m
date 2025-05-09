Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D372918F2
	for <iwd@lists.linux.dev>; Fri,  9 May 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799813; cv=none; b=iGpJdMm6ZR4NSOuY2fklOjTi4c/a22gGWZTfTZ7ZUZGA/IMvCIdqp7Kh8c5vUqUmMf+55h1UCFFdLosekoKSBPv1uFAEHdYH/Ag4GpuyP0vryRYfvmgdgSRd8sJXWdvgRmwKhUKvIUP93bKI89oSp6hUl5SGhv91ZMkr50YzB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799813; c=relaxed/simple;
	bh=jv2nYnyW45W2O7iOZjQIFqIOczwNPCCn+cSs4vmT9Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPOZTsSO0sdUhC67QGTvRkJkhRM6dtnbfGB7HKtB6r5po1PYRrP4gLFWn1CjN26BnMW5QmGN9Cd53OIkno3oP1CaATcP+2UiCDrfIGjaXTjuhKt63JYm2krHPafSb2iJfsH0fh1kOApyHeXkTIhCcfKOac/mCkI3cUNFsr0fwjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivvPE+vr; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivvPE+vr"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5b8d13f73so276690685a.0
        for <iwd@lists.linux.dev>; Fri, 09 May 2025 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746799811; x=1747404611; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1rXhUKHNS5ZnX5jzs+VLeHWyFhaGS+q5ScHq6Ic0gQ=;
        b=ivvPE+vredqCqyh4zRIvTJhSz0sRA0Is9NDx2Ql5chNZu6kJjkbrKZiKAkaPQXKwCP
         hGPPAsWCzVp3RTVrHj/oCe+qRLSMywQDjhFhoR1bXBYE0C6ThPYwQJcJU9ugmf7WwdFG
         C1jUoRXuKSkRJ2Lo1QObg9kWrEUa5xuHmZ5NpccF1KZKd6YK6U9VLXl77zKIBnl3Xyhs
         eqCm9AwGA2vtHNvJWZuU8Q/t8fVJwhrb7yDwpkxbAnqPdVV6JaOUSeoCFaz9j0BQ6tmR
         q/pYi161DKqHQsixIGAEyedrh3kxziZtlXthnRWzuOPov1/AkPeXrYAyXgyvT94MK4sP
         UDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746799811; x=1747404611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1rXhUKHNS5ZnX5jzs+VLeHWyFhaGS+q5ScHq6Ic0gQ=;
        b=F7XzOMkHnstbE+Xz2WEPCv++tByFBSInCjynXRNrXg1MoNjCa9IRYcVItw3MiwckKI
         NY4jIPSQgAb14VpLsGhuD8faL8WJdsKsMSJGdeOSqgpJaixfK7i9vM2BhYksVX/S7zUd
         pMBaKUmT/HYkHx8om3EN96EEKANHF80qLvbb2p6Q71lwk7RgxQfU+WbyRD2RKICKRIDx
         oOeXk+X0nZR3MSc/qzOUKIZKiHXEpvADAapW/SM2KZkQSpX4IJB4b1kBfANtJlAXQ3C6
         Kbdf4892YPe4bJyKKhKldUoweaDhemjJ2Z3NVC4wWrK9Ci8Agox2Mm0F2HEr/S5nTpCK
         wiGw==
X-Forwarded-Encrypted: i=1; AJvYcCUSz2A4VfE6ffbEo1YlR7LJlMjGny0epFvGtpgAlqnqwZ5a4R+akuX6h3xRHxweuEfJKsU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw58nxGFdVxaqKEMEuIu8CWVvc6tgOM1GKgHPlghu9zChH+2Hjd
	XnpOA3UVI1zr62IJIbPxsk0UgZcW4OyA77v/lpBA7J07IKiSlGMW
X-Gm-Gg: ASbGncucnxiaF/Ht7+OmJshw4IvZ9eB9eQa9iR+YrQp9qqZYva5ofvgHtRGBEiLwJTq
	x2ygul0KaPpyEpdP2pl6ZWEMc8OuF6aG1695ker/ba83P9u7PLn3dDCv7B5BKrkJnoiX1ZlYKN7
	lqT3iW7tYX9dMPSvHmFr27vBY4L9t1CMS+LM2fg+6JSPOExHbeqm7oJKcoK7UMQ8DRcyPNKRCWB
	m44iCsIvhUpS534L1jkvuv7OiF4KaiKSKTmWjp+/AgFRewFV8/Kb7ZxxUQOwu/7r0Fq4/2jIMr8
	nsqLk4fxh5EHoxt+6cj82kGoU9v+aqrwO/e06y9FGlnw
X-Google-Smtp-Source: AGHT+IE3h/Timp0Govs5h8jv7g5PW/qPtietaf4THLtBxhWNkr5tQO9cExgL2PWE1hAYX6b4p84VGw==
X-Received: by 2002:a05:620a:4403:b0:7c5:9a6c:b7d3 with SMTP id af79cd13be357-7cd01157590mr554349485a.37.1746799811008;
        Fri, 09 May 2025 07:10:11 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00fdc779sm143486985a.76.2025.05.09.07.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 07:10:10 -0700 (PDT)
Message-ID: <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
Date: Fri, 9 May 2025 07:10:08 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: linux-wireless@vger.kernel.org,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev
References: <aB30Ea2kRG24LINR@archlinux>
 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com> <aB4HC8Iaa6wR5dj7@archlinux>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <aB4HC8Iaa6wR5dj7@archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/9/25 6:45 AM, Jan Hendrik Farr wrote:
> On 09 06:12:23, James Prestwood wrote:
>> One thing you could try easily right off the bat would be to try forcing the
>> default SAE group in IWD's config. I've seen some APs really struggle with
>> group negotiation which is why we added the ability to set this. In your
>> network profile (/var/lib/iwd/ssid.psk) set this:
>>
>>
>> [Settings]
>> UseDefaultEccGroup=true
>>
>> And see if that helps.
> Thanks for the suggestion. It does not appear to change the behavior I'm
> seeing. Also I'm pretty convinced that the AP is not at fault here. It
> is sending the confirm, and the STA fails to ACK that and the confirm
> never shows up in iwd.
>
> Confirmed that the settings is applied using these logs from iwd:
>
> [SAE]: Using SAE H2E
> [SAE]: Using group 19
>
> I assume group 19 is the default group?

Yep that's it. At least we can take that out of the equation.

And yes, in the PCAP I do see the confirm's being sent but no ACK. We'll 
have to wait for an iwlwifi person to chime in. I suspect we'll need 
some iwlwifi debugging enabled to see if the confirm was received at 
some level in the driver and dropped, or never received at all.

Thanks,

James

>
> Best Regards
> Jan
