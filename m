Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD621343D69
	for <iwd@lists.linux.dev>; Tue, 16 Dec 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895682; cv=none; b=B/M/UBlYE+znj2iagnr4xOD5ZuB8GpR0pwXc//WoBvRVqE2M5yDcJwoso2S7E8EbuyRub8tYCwCJXwoOGduhWlb3QzJvhBrY6O7QRf9kTOEtZoRuThEgCTZBNZ2OeDpHcm8GDRBvQ6PyEHSCQpbqElltyEjUXFbFNXAmJVl9ZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895682; c=relaxed/simple;
	bh=PHgvrZzKtODlLqjox5v2VoFe/nFs3Q6PxR/PREnl7To=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gMisCyF/A5Jy4t495wtAzWe2XHZzzrnSfosNj0ttjlp3jdn2UYKf9Yutm2RGmGwsrOChPLNnGfVlQCiXm1u0LDj5mTGw9LQ+ozTqvvIgbiqqfG5VMzjdpbVV6SBK20hGhC/2w4MxdYdQcxNtmKhTsEkTIjoz5cV9OTJK063cBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U69MCdV7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U69MCdV7"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so1054721b3a.0
        for <iwd@lists.linux.dev>; Tue, 16 Dec 2025 06:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765895680; x=1766500480; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KwC38WtjBAc5CE0gSr8dhoVzrpHvf7eHJ02PYYAPDM=;
        b=U69MCdV7deZ1f3LDFgzfK1c9xmL9lAwtOQ7omgTnbfiw02C62No9GGWAzUJOqNLqhN
         ggy1INqpAcW01jKVg3pXFlWD53Pz113T8rSUUZC+C0ctjeBy/OUkTCzlURkoUjd/O1pY
         tcHN7YfK96RXR4g1eo6Rfr2cZfypOL65qKclwNF872jRDoQf05EbNZkT1HZYivosMb1G
         leSQ33G5jLIC1Z8MTjHPt7MT5fE1tk6N3bzymV0fngB0RUHESYAschLX6ngM1N02Jpvz
         bFYWjf+9Go/ZWtX3C4HWs96ONEkmsQT4agONv3ugk49mHZKlYmn+tWVki/gimnilesEd
         1jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765895680; x=1766500480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KwC38WtjBAc5CE0gSr8dhoVzrpHvf7eHJ02PYYAPDM=;
        b=oZFTeffswJOVNIHrFUz7VCcivh0YEa8IHNqPNveLytT9bck/lZJL2K9K/4zYNaBfoA
         ey/PAwOoJmPAuKQG7DQaILBVSKeVlf1rhRo9JieY6vNY7l6mCq3BFLkb9MZ6Ed+tAMpj
         09FnFg25bta/Qj6jPrnklnDXSo0lWPmtBbnvhSGw4gH/+8VOi0rTK7I6mgkbOkAy5bHw
         5qAPXTjfYOf3ujG5xHDJKZc9m3HGvMdpYzJiSiwT1OPf0xxoThVxYaGqY3x0GUc1yFMO
         VjBHcYRamgjyVPcH0HymFXgltYFhXKXyizuZgy9f93UAuyvucch/A22SdyRh4RiLdejC
         vEWg==
X-Forwarded-Encrypted: i=1; AJvYcCUI13dTYyGinK6YKDy5w8B95SEEGoq8Nak4qtxYzopC1D9yC4Kekjfn9Sw/fZTH02qtPiI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxmZtB/e5adHTnq8WuoELrhFv9qDbaSJ2H7Q10C+JIMJdKwDoYB
	HjRpCOqfjycGnAjkbWuR3O0WybYHsQYgM6Vihzu0eGRAILAcRJI4gD+tz8xNvx3e
X-Gm-Gg: AY/fxX4GrMpF6GhPRZo8gG0u5er3/ENS98bIHthOsGAw1kgS3J/+8FeSpY/HzsBs9Vl
	wNxkhUeeDdP5MqgsWIA12pdvEaTgcLQ10GDIH1F2cgYs0gABfXq5TksY9nNatRbncxb8XMQIINt
	ckWdRtD7jnX2meBMyPnh3M/3fHXQ+48seUbxbJscEA8oKG665b3F8FXURn0ggf1mJ0hq4yjfpsG
	0lob8X6KowZP/QId/xEQnHe+xKqdkARSeBsDNutaAfBWJDrKw+4bqbY0kk6aI/uJ76g4tnS9UD9
	EqKmtY6HWF+grX5vJeD2YQJmSqMHPigtvLTreODzRjCmu689Wa3BJv39HJqSMir31fR5ctXWskG
	78P3nFAr144LHWzvzBzLXAcwmIqqslZFqhnBZ/TzuoQQugtTtpHcPedBH+mTg9SHtxI98W1gesi
	95mPY4+TjfR6csGkufnJl+6dikgfMf2dvUcX5oMzRlFkMMmIx5ljJu+ixoxiPMv+XX
X-Google-Smtp-Source: AGHT+IHeelH6xoF7fMyYR4qTe2QmiddBITvDS/OFYD6lLyxXUD8WtmQUf5wxzFFzKHX9yMdd+LQOvA==
X-Received: by 2002:a17:903:2984:b0:2a0:906b:db3e with SMTP id d9443c01a7336-2a0906be8ffmr112619955ad.27.1765895679858;
        Tue, 16 Dec 2025 06:34:39 -0800 (PST)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f271bc8a0sm133526385ad.92.2025.12.16.06.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 06:34:39 -0800 (PST)
Message-ID: <b580ecf6-2d21-4e6a-bd6f-0309f20e9488@gmail.com>
Date: Tue, 16 Dec 2025 06:34:38 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6GHz only?
To: Ronan Pigott <ronan@rjp.ie>, iwd@lists.linux.dev
References: <a0121c7c60a6485d24b79f5313fd1e481c3ced55@rjp.ie>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <a0121c7c60a6485d24b79f5313fd1e481c3ced55@rjp.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ronan,

On 12/15/25 1:18 AM, Ronan Pigott wrote:
> Hi iwd,
>
> If I disable both 2.4GHz and 5GHz bands with the BandModifier settings, I get
> the following error:
>
>    "At least 2.4GHz and 5GHz bands must be enabled for IWD to start, check [Rank].BandModifier* setting"
>
> Is there a reason one of 2.4GHz or 5GHz is required and I cannot chose to
> connect only to a 6GHz band?

The original reason for this was based on the behavior of a few cards I 
initially tested when implementing 6GHz support in IWD. The only way to 
utilize 6GHz was after scanning either 2.4/5ghz to allow the kernel to 
identify the country it was in, thereby allowing 6GHz operation.

This may have changed now, and admittedly this restriction was 
implemented based on only a few hardware samples. If there is different 
hardware that doesn't need this, or things have changed in the kernel I 
have no problem removing this restrictions.

Would you be able to remove this check on your side, rebuild, and test 
if 6GHz only operation works as you expect? I know that all the hardware 
I have still is what I originally tested with, so I'm pretty sure I 
would get the same result as before.

Thanks,

James


>
> Cheers,
>
> Ronan
>
