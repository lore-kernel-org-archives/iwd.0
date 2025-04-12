Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B642614F117
	for <iwd@lists.linux.dev>; Sat, 12 Apr 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744489403; cv=none; b=tp+XpDkuHBD7K9xyKfZH0t6y9SKWNh0OVTEst30GzaOxyYI9/LT5AetFTpTKVBdOhJ1110xMjb/ISgZWoVFqY3k7tb6u1n8JJ6yi+I0dMPPpI6MEfA5P2Q3asJT0yleoswtRz5KkT5VPpgOOszkK+dosplQzFnKN/23f6MelzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744489403; c=relaxed/simple;
	bh=Qyp5YlcTJhF1X69UgT8yqTdsUT3wi9xK4P1s/WrU++U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h3mp+W0n/VLZ8SXtbI27jHfQopMxo19cSS11ElU8S2EDnYjXfGiwlKdQdf9SShby3RNvrm5rz0ncmNZuM0tX6Dnfg97x/lpDeYCR7i2hTM6Pyx102K/bKGxJL9Gwp9WCOAQTGEmvLfZ1aUfEGBZPqpGA9y7/p3pmq6xJ43r1N/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6z+aCgj; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6z+aCgj"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-601a46ee19fso1528857eaf.0
        for <iwd@lists.linux.dev>; Sat, 12 Apr 2025 13:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744489400; x=1745094200; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FhmVn8b31GX8TGFCBrcXmPXqGrs0WsLA/ryXOaNOykE=;
        b=Z6z+aCgjZEYMUQUIQX617UTw+rKlcLUkKeX4UAE9YZZonEyAc6lJ1//3zaMV/tZ573
         7Of371Is6scc0UmNMnAJYJMrEu2BiNsQwESQOr1OHH7s0yoEw6Q2Lc/y8jSUc5SvQ8uA
         csc4YmmdH5HnuhwSr1bMONlQn4bvIDWQOq3UeNvKxfDuG+PKcRRXMP1z/DahQReW9N6h
         otydRyNgvXZz9OvW29WAmj1smbqhoMdA39j+t1ZhvmLJsNmIAuWyELvObsyIhUHooV43
         6q5SOGWSHpy81LXztvFa7xavAn6Dgay8OFS38uUIDL/3n3NsLiM0Lq8WASFc5zGuMn+P
         3agQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744489400; x=1745094200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhmVn8b31GX8TGFCBrcXmPXqGrs0WsLA/ryXOaNOykE=;
        b=GphYtjUm42YHpYAdzJrxE3bJ/UB8EteK9GnP9TNNw6vER9wleTN2QYRmtI6CXEANIw
         ++WuFGzbdXsNZUwdF8T66Cq2cz4Z1M3vw6npz5U5F56LN3zEHduafBdEFlUXMFiO2FtS
         RQXmeW0wbslXsCmEvC1hf+rwu32aYRIyp+I0n7ntPFLsFBHDAWKZnOh7WexUFyUPP8xY
         NZhHdBPC8C6NcZ7k1gF4yUT8McrEYX0lj5PhLpb4EyRlix9acvfD2RZGofd/MylTw4hG
         XY8CCEkR+giCv+424KigbfSD3+t+wQ+uN0zw3MChvjt4oVfy92+HiK+WuNAoUeHF8s5e
         Ijpw==
X-Forwarded-Encrypted: i=1; AJvYcCXSLf/By1Vn2s0VV4Qr86SAtVmT+cYJidJQRudU9OmYLO7YMcr6FItDprYM3/vWbFverQI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwnDRh7puy1RiZ6jXxND8wXZsi/78PEqNk971kRPvdNC0GyJRk1
	Knc8biRlcyEvADF8uZJ0MOZ8ciF1JRnl3uQmdVDCaN5rjj4+I0mi
X-Gm-Gg: ASbGncutITFdtCZw2iWhr59gNTC9IAfg2V0qe5sZXgf1urAX9fjPj5VxYcB3qWvzPN6
	oV+8jb73H37C5uHV+pta9RLty80UvfuGlz2HT099DlU49J0z2x38Wl5AQAw4JJ+rMxgQiX/d1Vg
	PSz/y+kEQjc043tJtxsN10lcFR3DbC8EsSP1p7UqG/A2Qpfdr/BN9XnU2wV2x5jHUwX4YsnHjvh
	49+7lMQmAfMRa5VXIaZGk93GU0qlsfU9WTnST4yCn6YuuraoN66nTh9M8kYp/mSfUN5/9h2kbbI
	nNviwsLMJx+YGHTCR3QZLztY51vjvuE6Iex8yn23TK0d++9sq4oL3fIjk29dkCQegPqoYY+NSot
	kjAjHcw==
X-Google-Smtp-Source: AGHT+IFI08Apk3SVAHzRCj6rmiwhT2BNjokHoi4HYYxSWos5rnET9o+7Jnze7p+PI14CE+P8DMuZ7A==
X-Received: by 2002:a05:6870:1b15:b0:2c2:3fad:760f with SMTP id 586e51a60fabf-2d0d5f80ac8mr4350159fac.37.1744489400441;
        Sat, 12 Apr 2025 13:23:20 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2d096d4af4esm1640826fac.45.2025.04.12.13.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Apr 2025 13:23:19 -0700 (PDT)
Message-ID: <da603744-b1de-42fb-bdd6-61472a684d85@gmail.com>
Date: Sat, 12 Apr 2025 15:23:18 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: how to get scanned network strength over dbus
To: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev
References: <CAG17S_NCdQ39dBaKtNdiF5yWcX=sgpppPxqhifM+Oik4o=s==A@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_NCdQ39dBaKtNdiF5yWcX=sgpppPxqhifM+Oik4o=s==A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 4/12/25 1:48 PM, KeithG wrote:
> I am trying to get a listing of ssid Dbm values for my UI. I an trying
> to write a python script to do that and ran across the ones in the iwd
> directrory
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/test
> I copied get-diagnostics and ran it and it works for the conneced

diagnostics is for the connected BSS (not network per se, there may be multiple 
BSSes in a network).

> network. How do I get the dBm values for all scanned networks?
> # python3 get-diagnostics.py /net/connman/iwd/0/3
> ConnectedBss : a6:2e:48:fd:9e:73
> RSSI : -57 dBm
> TxBitrate : 292500 Kbps
> RxBitrate : 292500 Kbps
> 
> but I want this for all the scanned networks... Is this possible
> across the dBus?

If you don't need to know the signal strength of individual BSSes, then
                 array(on) GetOrderedNetworks()

is what you want.  See doc/station-api.txt


Regards,
-Denis
