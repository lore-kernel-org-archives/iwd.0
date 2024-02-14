Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CBA604AC
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928543; cv=none; b=OSsD9tubMxnu9swPQd1Pxu45VcNimChJWZ8SicHmrY9VtKILWN6zWq7l7I6pDWyEiyldubvYB9QKugPCejXvwWaKlx95IejB9HDq7vW+1IDspkVEsS+fFabYNzfHWSqiMJcRsDzQg6AqJuGNY7DTXGUc2UMHi5cCfSOihVTE0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928543; c=relaxed/simple;
	bh=BTf+cILd1ustshSoCKxMOCRYdbCCzyW0C3CE7s8sI4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4F+v1239d4ZxwjJ45KIxdQEnsISj1g4DFmclF1nYTJVps0xxEPGZI7b+OhfXxHG+0gGBNghjj2otC3vmQfcp7dgXdTYfQVX1Vz9xNEKBRJIH4Z6l9Tdvo00edvJ7MKIL5G1oUSaDXRPZj4hkTudWVj3n/xVxhHICYGtPpDML90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCCitH9D; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCCitH9D"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e2e452c852so1871970a34.3
        for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 08:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707928541; x=1708533341; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGJCenT3RNYnL5q+/IWOAQJJD5QCrQiSfm9Jnc0GAfQ=;
        b=MCCitH9DvY4+t9vLGFZXEN730qic1YiqJc67eheFTyOdhzfuoASpEtYC8mQejsSuka
         E8Au+it+s4tekTH/PiAKfYFLKFjeLPNjD0+6u+8HCQF3/MBPGsVgB8KkapMGe6vH8L/L
         wXISZHraDu9H7R1P4A55T+YRZUjPDCRmJnJodmnyBMttWPxzO7U11ZBjl444G1zp/LYN
         vzSd0B8QHjETdZ0ajf4OYdxtHn8aTtVj1N/3wbSManW6kqjLfYnQs3zsfFdWWIpOJNfp
         cdjzOLeRZhB7QlKNY+Y9at+OT7sLLDaOxjpQzXtWk8dWVJBH0oUrRGEO7tIJz1C6Lasb
         2D2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707928541; x=1708533341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGJCenT3RNYnL5q+/IWOAQJJD5QCrQiSfm9Jnc0GAfQ=;
        b=febpFYbLMteQVJAWYBkdi/9iIjsdasMm0qWElEoYTzN770xXfrSh9oBSsUy51Ewy7f
         cSN7iL+PHYnUK0WLW9LUfZ0s8+++6hfZOCWfGZUX0qj3id+y4E+sRDj5ZtUMqi886pu9
         8otTliBUetmC9Ou+F18juhOE9rVgGTTRLaK91VSxD4wNHbFfnhwinBfec6OLTIBzLLc1
         ACB/soGrTas0oS/vUl1XxNteCujJ1nHvHsZMJLBTaLUrXXep2piO30Tjxq4YEpVZAF/N
         tb9OvejXnM42bwVJtjc18tf2i6SAG5v8TTdTz6jZPKNuuzHZFv4krGsEQFuCQVIJy1sh
         URDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK6VeKF3qx/pQfR2XmUlJS8OfIz8JGReILj19cZ62jrdq/PlZJ+551sA98dP91ZNaPov78ungns5Gdp9HpghYIFsQk
X-Gm-Message-State: AOJu0Yx/p2kElotDYv1syPL+K3MOw/274MNn2OBkj6LDuqxSUrdccR/o
	S/KOJqxH0K0GJzxHeaTKyBBvwol8ufz0Q5abVzdWydsuwYZ1hhnkBuX82xWr
X-Google-Smtp-Source: AGHT+IEOTB/wHnr/5iSWcqPYHBoXpwapup7q2SopDZCD6G8+ZjLmcfEycRd5zaiRJ10jFMgMyW0YuQ==
X-Received: by 2002:a9d:63d4:0:b0:6e2:885f:d557 with SMTP id e20-20020a9d63d4000000b006e2885fd557mr3050753otl.10.1707928540892;
        Wed, 14 Feb 2024 08:35:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8A+oZzk+EjwVtreDFsHROVJ6MuHrLyNMyvJldFAZCjCsti3w9AvWrPnzGffnWQJtReFfYDTiTRPRdfXKE7mK3SBYj
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f14-20020a056830204e00b006e2de7a8f7csm835328otp.14.2024.02.14.08.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:35:40 -0800 (PST)
Message-ID: <b1b66222-6594-4775-94ed-2f17810029b1@gmail.com>
Date: Wed, 14 Feb 2024 10:35:39 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wiphy: include libgen.h to fix implicit def. with musl
 libc
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Clayton Craft <clayton@craftyguy.net>, iwd@lists.linux.dev
References: <20240212184747.30422-1-clayton@craftyguy.net>
 <8b02ff06-9c2b-4503-8fb8-9784c2628394@gmail.com>
 <152B8E7F-C6D0-4827-AC38-25454FD6BAF7@holtmann.org>
 <f9970105-c1c7-484b-8e13-5ca5f5bae901@gmail.com>
 <34797D3A-D630-4D71-B4E8-BD29E9BB759C@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <34797D3A-D630-4D71-B4E8-BD29E9BB759C@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

> 
> Add a _get_driver is a good idea as well, but what is the reason for l_sysctl since sysctl is some specific system call.

l_sysctl is used to write stuff into procfs or sysfs.  Naming comes from the 
sysctl(8) utility.

Regards,
-Denis
