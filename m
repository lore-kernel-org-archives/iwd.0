Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5222F1E
	for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142678; cv=none; b=Mj3pMt2di9dLAcyvRl72jxI5YO4bs0/zW4mTh8qk1D1vS/NZsb9MymgY7R803clK9mHfRJbxV/sepZTLvEfJox0Xrbaw5/x4uj6ZE/IotC96DDTj8zegWL2kGApKejfNAZrgXjIIwRqlqg997WPgm00cF0od5G6D7sKezbAGHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142678; c=relaxed/simple;
	bh=CHRR69H1FXToKoghnexKiCWr++TN+v2XGQkE3F0adDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nqzge3r3A952ph3Qu8R6j1GFNR1v9WMZTyxUyn8aMw3L1DDCdT5GX8rKZ0lYOCao+YZo29jcYCnXnGpxG23O8hNECdKuxYVB7rzpiXVZ4GRx7JmBw6LZmAvdxzsekkTZORfyRtQID48lpSFt/CSss+OLN/IAMqLcFYHAJdX6yOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx7Sb9kn; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx7Sb9kn"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ddf26eba3cso4410022a34.0
        for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 09:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709142676; x=1709747476; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sK2d1nF+qqjmf4rgYVPeeP0n9UGzjM3p41x2xOxUWo=;
        b=Hx7Sb9knWbi4zwet2DabnpkZeumFGFeUG99kx0WIFVVwQpU++J0rgYggY1x8vSQOCw
         mMyITfX11tjlOsGdUelc6j+essoqo+h6j452/QlV9jgSggBSJUVDriojiKaER6DP3uYJ
         N5cLOJcAWIDotS6J4zxpaGDILver2xoV/zNve1Dw+siY3+9mGyUC0SFZw6KR9dwgbZMZ
         homkDn8QXYzlerPyJwVogU+hky1pWZUNXj7U4NuZpc+js/N+snDnCBttxJ7VRM9et0sG
         /ZB8mI4zE9Q+VpYWOPfQerHCNXXH+852mJmbyt2lIJK+eRKPVFhz8CVqgMgOeH9knmMB
         eU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142676; x=1709747476;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sK2d1nF+qqjmf4rgYVPeeP0n9UGzjM3p41x2xOxUWo=;
        b=Usstly+O7puXInUj3yQUp6thLtNzpeB5orKLdUZro/Ovl6Z67RlR4UCo9ruWpNtk2X
         mrp54aGKr252xVJyiG/m26Za/RTS4ENbdU8OQLiUyzAAjoRwMYW5LsUC3JMlvMTZ9KqS
         qrEOu9WOLBLmEeR9LmOhdZzIFUcG/Qha5PbEPmTo4zh7sMtu6/pZMPM5+HoW8JuxRBvk
         kiDGUP7IhLrOTFaLkkA0GcR6CrwGGbrcTdLgw3vkC9exlJa18+o9cBgPm7HVQ0hy0Ung
         EpnIlM2S+jfboTxnQwL+6whX6L4tZrb0v60dcrTvu30SYw7haCLGxaF1j7cWlw7ykIFX
         nGCA==
X-Forwarded-Encrypted: i=1; AJvYcCWq8h54dCH4J2GOpEe6Y46O5c6aYkgkD0E1cahzFDzhdpDBRKdwNH1diugK7dZT6s3+1u1tHQryTEqncecFlJvFT8IR
X-Gm-Message-State: AOJu0YxuAc6pEl9F6cq4S0UhuK9ebM2ANOq5UkMiEQXOUAa4uaIkfFg6
	002djhhl2n1/69jHqs1hpgHcpr3cl4o0MxxbPQUXJzoP2hD3zxr5
X-Google-Smtp-Source: AGHT+IFUKpHYwYf3TX2k9jMZ1I9X3Z6zVnBC7YKjivUI9vHihITClsQ6wNqo13zPMC5gAkfkl27RIQ==
X-Received: by 2002:a9d:4d8a:0:b0:6e4:9eaf:939a with SMTP id u10-20020a9d4d8a000000b006e49eaf939amr273692otk.4.1709142676121;
        Wed, 28 Feb 2024 09:51:16 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ew10-20020a0568303d8a00b006e43f8eac57sm1977617otb.50.2024.02.28.09.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 09:51:15 -0800 (PST)
Message-ID: <83a1b6b2-3b34-4172-bacd-25dc78d7a1e2@gmail.com>
Date: Wed, 28 Feb 2024 11:51:15 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] auto-t: fix netconfig to handle resolvconf values out
 of order
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240228163616.1231620-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240228163616.1231620-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/28/24 10:36, James Prestwood wrote:
> The slaac_test was one that would occationally fail, but very rarely,
> due to the resolvconf log values appearing in an unexpected order.
> 
> This appears to be related to a typo in netconfig-commit which would
> not set netconfig-domains and instead set dns_list. This was fixed
> with a pending patch:
> 
> https://lore.kernel.org/iwd/20240227204242.1509980-1-denkenz@gmail.com/T/#u
> 
> But applying this now leads to testNetconfig failing slaac_test
> 100% of the time.
> 
> I'm not familiar enough with resolveconf to know if this test change
> is ok, but based on the test behavior the expected log and disk logs
> are the same, just in the incorrect order. I'm not sure if this the
> log order is deterministic so instead the check now iterates the
> expected log and verifies each value appears once in the resolvconf
> log.
> 
> Here is an example of the expected vs disk logs after running the
> test:
> 
> Expected:
> 
> -a wlan1.dns
> nameserver 192.168.1.2
> nameserver 3ffe:501:ffff:100::10
> nameserver 3ffe:501:ffff:100::50
> -a wlan1.domain
> search test1
> search test2
> 
> Resolvconf log:
> 
> -a wlan1.domain
> search test1
> search test2
> -a wlan1.dns
> nameserver 192.168.1.2
> nameserver 3ffe:501:ffff:100::10
> nameserver 3ffe:501:ffff:100::50
> ---
>   autotests/testNetconfig/slaac_test.py | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

