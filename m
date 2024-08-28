Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A81F45C1C
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856101; cv=none; b=dkUt+seUvVSn5I/PXmgVRqPNnm0FcAVSoGcc6MZ17wfVIZDbB9bLE67fb7WRQbq7+7g/jbT3BOB05kb017irF4NTGx6g3LArKpXDHe9phqNppogf+RrzKn7b9B+GYn0u+H1uoF6zFDnRIlTdacDvK1jDnEmLce7eO4074rmYEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856101; c=relaxed/simple;
	bh=NHUliooDHZ/SaNIkSLwRT8P7W8BjYxXckpBXa4LT3MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OxP+USGxDtaQBrv8jj4ZnHE3EowjzrnAgI+aUazt5fORUQlyVkc4oOAXXXoQRfpdOXfZJJeJJhhb409Mg6C33MMo8kUplJoxaws4wbzNrRh0sCrVST5DOQRlWbrIBtR1jRK3twyyqd/tGxOsGDxiIf8aI66NosVBE6UbO+qC8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jhoc/Tx9; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhoc/Tx9"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-709346604a7so4855649a34.1
        for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 07:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724856099; x=1725460899; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P2H3FA8KzeW+iZ2jebfDk02R8T3IH5K2DKkEKfKdZu4=;
        b=Jhoc/Tx9v8p6Xl1kIZyJBhW7FxQM+HMyzQNiAgMtLhCNVkwuvu9fh2JV/HM49dHKx2
         XGFDtO9YW/ho7q5fa1ApOEgEqHcn86MnQz7E0oIDoeaEkbmCF9Hu4ZZ8opWWGLiRFXRy
         jWFdJBV2Vp1q+U6Wr7ojTTJyswCMxjGUHH9sdSqz4Vq/Y4gIh3x69QGFKEU8W00MHKaI
         GbOXqMVWy1OzIcSULJBxYovd0v/od6sMx5VHHw7md3zpK3mZuDw2h/Ml0TQ3Z9go+lZr
         gCZ3iILoWTHXWqnuviVVWrM0kuhDJbZFAppGvoWDjGsoaHXM1COBJzRHOvo0skCMCWU8
         4VhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724856099; x=1725460899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2H3FA8KzeW+iZ2jebfDk02R8T3IH5K2DKkEKfKdZu4=;
        b=ilItZ7t04tCTPf3GogeAPNagvVM+230B39xfL2Mz2E3i+RLVL3HYWeK5WFaSG06PAX
         SaQXhzF3tDZtwnV8iUtndCxfAmfsaZk5jx88o3JlVc50Vr3giyTuoZbynCIvy2EIktDK
         zj7j1ENyxwAQg0lqOXW9DbLNRgTiS0o0vhPF+CFdQtK+Krqr6WErVorjRj5sYEPUtpNy
         Ariho3lK1W03CKMWI1a338pJVxGYho+u8+Y7RlCrnDr0mumxawlBZvycSOcmojjXjX68
         udVYnc5AahC6Yrw4bsRmGO5n772dFnXERddNgtUol/aF9jCgPJ9saLsihymAzCi+KoMS
         g6vg==
X-Forwarded-Encrypted: i=1; AJvYcCWnbdQ7I3MM81mzEGEEOqjC5wGNrWQe/cPvKpzUudOnoKKyu+BFB4h2D0CT8lO5K4Jt+HY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx03iEnXFhm/FeSmVBQkmjJDylwNdxMKjvUhlfLr9H9Wxk1Kp20
	CFG9RO3qR2xVHXkGExrW/8OzQ33K4OCdjujjXrEPu0peOQZzT+cj
X-Google-Smtp-Source: AGHT+IHrFCw2VJSBrNFQAhUFA/K9uUxqHHkH4FjhW82P0m++CDDHaWRJNzJUi+sg39L5THYdFxFfaw==
X-Received: by 2002:a05:6830:6183:b0:709:61c1:374c with SMTP id 46e09a7af769-70e0eb88668mr22649646a34.20.1724856099221;
        Wed, 28 Aug 2024 07:41:39 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70e03a8d22fsm2913797a34.26.2024.08.28.07.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 07:41:38 -0700 (PDT)
Message-ID: <054fff6d-24e9-46d3-8812-86cd5e0777c9@gmail.com>
Date: Wed, 28 Aug 2024 09:41:37 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: check for roam timeout before rearming
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240827141037.745738-1-prestwoj@gmail.com>
 <0c2294f1-8b91-446e-ab08-048d40e0aeff@gmail.com>
 <96473c52-e2d9-4a3c-b38c-0cc430d18d17@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <96473c52-e2d9-4a3c-b38c-0cc430d18d17@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>>
>> One thing I'm a bit worried about with such a simple approach is that we might 
>> have different roam timeouts.  For example, the 60 second roam retry interval 
>> is active and we get a low rssi event. In this case we probably should 
>> schedule a roam sooner.  Maybe we should book-keep timeout information better 
>> better and make sure the timeout happens within the minimum time (active time 
>> remaining / new timeout)?
> Sure, the thought crossed my mind as well. Looks like there is no way to get the 
> active timeout within the l_timeout itself, it doesn't track that so we can 
> manually.

You might be able to add something into ell using timerfd_gettime.

Regards,
-Denis
