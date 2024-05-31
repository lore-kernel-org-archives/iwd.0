Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5E41CAA6
	for <iwd@lists.linux.dev>; Fri, 31 May 2024 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190619; cv=none; b=MsYIKqlkz1i3UBAHf1bmOtBt9qET+gLINWbPG+hgBqnJ9qe4tVy+dmo7cgglykKx40qWLaTGYpTAn8PGZ/i7TkuhQXPegvKNWZAWzEuGi1ZMoc9Lfd5fNRK5DZIOnILTwUQM1tAaoZffLWfLWSQQIs11qvzf/E/++QyGK3kkRUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190619; c=relaxed/simple;
	bh=E4O5VjSR02IVDg/FS6FeE4cF2pCt767p4CKsN/n7+UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ODT0C2VXJbbTXUmcJPfxYUPu65/lnjT6ffCxYhonvUV/UMTPWr2Bw9zfRQdc2JW8s5LBVGU5XM3E86cWnkxqoeyGuBHADi9p3q/t+UNeMwrw0Sl8iWtOwA+HEj3cf4eSKZHPr3z8W8kZJVTglxcppgUmMZM6BBVFwi4+IVmlLkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGgMjLqh; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGgMjLqh"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ba1c2612a8so104920eaf.2
        for <iwd@lists.linux.dev>; Fri, 31 May 2024 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717190617; x=1717795417; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/fFH2FCNfVXYiOA8AORJ1HaB8wTrx3A9z2ST0m8Ry7g=;
        b=NGgMjLqhRtFK/EW2pH98AATsC4l2zO9y1SySwjHYWgl9QFbL1wysp9Uk0Koe9rULj2
         hjoFowcYFqVzDAv5bPegROxZLl3BPhSTkPpzG6i14DiLQKqmadkWL1i8aLG9U/GtFHEK
         y5F4yAd6gRrIDXxZik3dcs1eA8MXlLzNXKRIgpGP+9mOIYifid+byWTwso8ndCZCTiBp
         TrN15jpUXV7ZtNksqq8pU2kzj8MFmCcajaBbLDeyWPcMLOI2mmPHfr+AiMK/ky/x6F2c
         ZUU8wUOb1deF65C+RVJNqgzc2C5eswli2BFYdOJIFqek2IaeJujBtQ3DD+7My4JqpQeJ
         +vQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717190617; x=1717795417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fFH2FCNfVXYiOA8AORJ1HaB8wTrx3A9z2ST0m8Ry7g=;
        b=sVp0lD9fX83oIqjahWapbGOmR8ukQ22GcR3vzgu5cbIVQmmArT8H7svx/QH5xJtrGv
         I5RZ9vS4Q4CcLlHsXrkBgHdxB0GmA5oS4/2/nvfu2BDJCviIJCxz+CwTKF9E7a7tBHbI
         kMTXd6v/gewTx1/eA3o5MVW9REeY7VByUqeYMGyD2FGk3iBiFG81IFtD6z1qIx9wZAp9
         q+i6X9UwsyBFhw5Q8VxIors4yqbF58pVljf2wEtoLU3eQZ34cEVsoGzvkYFFyU+BTYCP
         4J0QGgDMsqVSCZFaNDUZjy35AO/vbRC9F722wAuUZdt78J1lWvi8DEkCvupLo0YihV0/
         nogQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvUgpufyebw1ZPKbRIG4MkrF1CDj6EyfssF9gtEjqg5WyhIWf1tY8VOB3UPPrkfV2DJOjXSERq0XmnGWVxSAEOzkU9
X-Gm-Message-State: AOJu0Yy/7K7/F7BgLievAXE9J4eG1IfvyRp9B6if20aoJoaum0rABTy8
	Cw7mhScjTpNgrBBYKhxabfa/PrMnZ2NxZFTS0XXSFFFxWlWNd50u2hOVyw==
X-Google-Smtp-Source: AGHT+IHZ2JjlvfPfaqOuqDyhHWY1i7KlPsIAIQeoCvau3UcUspT/C+3MSdwoun45OiM/twOGy4pDug==
X-Received: by 2002:a05:6820:1ad4:b0:5b5:3d56:287b with SMTP id 006d021491bc7-5ba05d5b472mr3274990eaf.4.1717190617235;
        Fri, 31 May 2024 14:23:37 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5ba004b3d49sm535125eaf.29.2024.05.31.14.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 14:23:36 -0700 (PDT)
Message-ID: <8187814e-437a-425f-b740-2b2a992d5241@gmail.com>
Date: Fri, 31 May 2024 16:23:36 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eap-tls: Allow tls_msg_len to be zero
To: Laura Peeters <laura@peeters.gent>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <1Nzi5TXKeegCbYp_JtW0ImxohaCclZWDu-VPAdUpguYP81MxtYr5g6PFwORmGDoOQ7fYErD-uJENgsCmZiHFVr-u0DwrHrFP1EvPGNgSkVg=@peeters.gent>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1Nzi5TXKeegCbYp_JtW0ImxohaCclZWDu-VPAdUpguYP81MxtYr5g6PFwORmGDoOQ7fYErD-uJENgsCmZiHFVr-u0DwrHrFP1EvPGNgSkVg=@peeters.gent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Laura,

On 5/31/24 7:36 AM, Laura Peeters wrote:
> EAP-TTLS Start packets are empty by default, but can still be sent with
> the L flag set. When attempting to reassemble a message we should not
> fail if the length of the message is 0, and just treat it as any other
> unfragmented message with the L flag set.
> ---
>   src/eap-tls-common.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Applied, thanks.

Regards,
-Denis

