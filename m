Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07DF1803E
	for <iwd@lists.linux.dev>; Sun, 11 Aug 2024 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723405136; cv=none; b=Frv+V0/+JAVQJhJibdheotUxMmt74/yHBjBBfjLaCKfQdXOiVwjpMQbU/6+YdrXBPycUsOcn7F6mW5R6BUnFAvD6E7Rh3SbD+E44l7xP8XU1lawdNlbA1oC1SvKwPvjaKIJg/L+VhuukFGaMGERlL6d+2TXVzPnsFMraDmrl3Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723405136; c=relaxed/simple;
	bh=TiKBvjl8nFaE7+QPPxyQUXVbAov3LN2F3K0d4XvbFDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2urF0bMX85D5bKq9RoEcyOBo7laoee0V/ypqQci3PbEn6tH19FNnbBFoEaB48pox2XvY54XgOS04XZdSzFy6/fSB/Fg1D/2Yqc/J3XYRgoA5Xee3VVZmd2v1cq51rK/G2YGoGdSWpxgiGeO/z2mY8qoyeETHXpMYlFCS6RzgwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fefy6QxL; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fefy6QxL"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-261112c303bso2913611fac.1
        for <iwd@lists.linux.dev>; Sun, 11 Aug 2024 12:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723405133; x=1724009933; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jzrlps3eLehLzrlT9qs/yodwvqQIGnXmvgJeGXCcesg=;
        b=fefy6QxLUevsMuNPFb5whiE6hKIcRKfttA91QJB4k7zziOUxbyEPvJg85oWrrFnhBU
         /acZIYl8aVJUkAmY0EyeeLiv2sMkMilDy7wlKrsb38W7UO5BJ/Pnha3+L9VdkikLTvng
         GD+YrlCRc6Rrsu/KdQr1fA6Auix8LDC6AxJ7cpE8yHhreuDyVJk00MikhuUeG/pa2qbM
         fOPfbaXg/s3PQ0NdRq/HZUIA5x/EtpAo1rEZV3iwTBrdGLusmV5ScnMoP9zyUvSElOC/
         QC2aYOnNTE2vCTBRFpwZ0GGcp3M8QPdzbLk0Ljn0U3QYDzN/V1Pe8JsouGjEGrj0sUCy
         Lbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723405134; x=1724009934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jzrlps3eLehLzrlT9qs/yodwvqQIGnXmvgJeGXCcesg=;
        b=cn0KHStqsbAYifC0GN9YVIAdq4qDATVBKpkF6jvbwsk/SS/xMop9IDRePc0fvFdcWO
         PgHL7D5Ps2t29bTTml/nSGb3N1182SHxXj1kAK09D51MtI/7tdPr3ypBwSsrp64gVn7g
         rs1xQm7rqbVaK47iyElsc05meoOwiFxpKDMoymKv6BC+kJ0r1Wz9dbtKlrizOlNzhS72
         X1Hsj3b1M+qLtbtt6ioWF/RAt4vp70Dl3aT8pJ4NSyVuuS51x6OS8C+kEQKJoOJU3xv5
         +KMOZFujDFo1BgDR2knPJ1lJ8eQzdFx9bdYBimzzNAVwEblweVVL8L6bsV4zw8vFyIS4
         UbkA==
X-Forwarded-Encrypted: i=1; AJvYcCUyI3CcCbNnZi/xWNdOhs2KC1zwRcYlrv36ExseypjicS5nkPZuH6+XspPfDe0HVKSAgl5InxUDu8Xd2nKEYNBPQK1k
X-Gm-Message-State: AOJu0Yw7pRYZcy3hKzSRQU4AQ7GjbvYJDsyW6u2vzKnnU7wsJytPQoJv
	p4/QrothBQWYcHZfr26ZbmsoeAsiDpztSbcfG1NFu/oDdIi+8lr0lE2Hrw==
X-Google-Smtp-Source: AGHT+IF1I5QhZNhq4ctaOQ6MKr2wiCgz6X7hSYLJ5s0CRAzXqEolLCqtkceGvDC5jvWTe9unxw6g8A==
X-Received: by 2002:a05:6871:693:b0:25e:1cdf:c604 with SMTP id 586e51a60fabf-26c62f42ea7mr9208642fac.31.1723405133538;
        Sun, 11 Aug 2024 12:38:53 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-26c720427f5sm1409141fac.3.2024.08.11.12.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 12:38:53 -0700 (PDT)
Message-ID: <de951e97-547f-4c14-841c-267f64b0020b@gmail.com>
Date: Sun, 11 Aug 2024 14:38:52 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Request] iwd to support brcmfmac 'SAE with AUTHENTICATE'
To: KeithG <ys3al35l@gmail.com>
Cc: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <CAG17S_N+Hjt2c8t8hN4VMx79QsQ3hiiE_cwOErg6fKoyHkr67A@mail.gmail.com>
 <ef38aa12-634e-4870-888c-219c961f301c@gmail.com>
 <b0ef10a2-c30b-4b6c-8370-66f9e0ace7b1@gmail.com>
 <CAG17S_P_MO4_BZYTCp4WDkJ_q4j=0s_s3azCOWrsvqmLD0ravw@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_P_MO4_BZYTCp4WDkJ_q4j=0s_s3azCOWrsvqmLD0ravw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

>      Supported extended features:
>          * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>          * [ DFS_OFFLOAD ]: DFS offload
> 

<snip>

> 
> The pcap is uploaded to my gdrive:
> https://drive.google.com/file/d/1vIuje60MGFPklcXtSNMi9-IOlV_6sBJ8/view?usp=drivesdk

What is the PCAP supposed to show?  There's no Connection attempt in there.

> 
> Hopefully, this helps to get started.
> 

Anyway, I was curious and snooped on wpa_s from git trying to connect to an 
iPhone 12 Personal Hotspot (Maximum Compatibility option off, so it uses SAE). 
Not a pretty sight.  Firmware fails with errno=-52, Invalid exchange.  Has 
anyone from RPI team actually tested this firmware before pushing it out?

I also tried the old firmware with SAE_OFFLOAD bits, and that doesn't work with 
wpa_s or iwd either.

Until someone sends me a iwmon trace showing CMD_EXTERNAL_AUTH exchange working 
on an WPA3-Personal Only network, I remain skeptical that any of the Cypress 
firmwares actually work.

Regards,
-Denis
