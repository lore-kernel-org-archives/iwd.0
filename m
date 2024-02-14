Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D87322071
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928265; cv=none; b=Lc32+TaRujdy+8XS1vKmxY8j+OgwjFntjuB3lzZzwvRcv3Ha1RRLC3jbpTv4yOygXdhW4F1O+lPGZBo2aXQ1pWumJB5iHwIU0veUICSF042pOh2dH72EZ5f4yQbp3C2aaUIkAJC/uDG3TgB+z5o1Igl9E8gIVHm/v+cL8XDxZ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928265; c=relaxed/simple;
	bh=QEmTj7sMRy7AToOHvyPjYvdsRnjDP1jV1Nhrn3wnbOA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pSFFDmN1qaq2DJHOeU7g8YLPBDPAwMCCnI5M+GW5xX4wCNrgoB+rWnY3hy55Qb+5ILCaXsxgQfxiCGaGePBnamo2YbX61OoyQVwVCjhWnEeDxxT/fPRhVA2W0As+b16bJlyAstKUttr9GcCqi3rEV9ePYHGQHEKjWeGXvEBjuwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9fa23.dip0.t-ipconnect.de [79.249.250.35])
	by mail.holtmann.org (Postfix) with ESMTPSA id 11251CECBE;
	Wed, 14 Feb 2024 17:31:02 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] wiphy: include libgen.h to fix implicit def. with musl
 libc
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <f9970105-c1c7-484b-8e13-5ca5f5bae901@gmail.com>
Date: Wed, 14 Feb 2024 17:30:51 +0100
Cc: Clayton Craft <clayton@craftyguy.net>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <34797D3A-D630-4D71-B4E8-BD29E9BB759C@holtmann.org>
References: <20240212184747.30422-1-clayton@craftyguy.net>
 <8b02ff06-9c2b-4503-8fb8-9784c2628394@gmail.com>
 <152B8E7F-C6D0-4827-AC38-25454FD6BAF7@holtmann.org>
 <f9970105-c1c7-484b-8e13-5ca5f5bae901@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)

Hi Denis,

>>>> This fixes a runtime segfault with musl libc and GCC13. musl =
dropped a
>>>> basename prototype[1] in string.h, causing GCC to define it =
implicitly
>>>> with the wrong function signature. The correct basename definition =
based
>>>> on how wiphy uses it is in libgen.h.
>>>=20
>>> Hmm, why did musl do that?  man 3 basename indicates that the =
libgen.h version implementation is free to scratch in the input =
argument, while the string.h one doesn't.
>>>=20
>>> In this particular case it doesn't matter since driver_path is never =
used again.  Still, the string.h version is much more intuitive.
>>>=20
>>> Maybe this should be re-implemented in missing.h or ell (say =
l_file_basename or l_dir_basename) instead?
>> we can also just do a l_util_basename that does the right thing and =
allocates a new string from it.
>=20
> We have l_path*, so I guess it would be l_path_basename.  That would =
work as well in this case.
>=20
> I only see two instances of basename() use in ofono / connman, both in =
src/log.c.  Given that the only real user is iwd, I wonder if we should =
just add l_sysctl_get_driver() API instead?

we can do that of course as well.

I have used basename() a lot recently for other code I have been working =
on and I got annoyed by it, but then just accepted it as is. If musl =
compilation makes us always stumble, we need a helper that does the =
right thing. So be it l_util or l_path is something I do not care about.

Add a _get_driver is a good idea as well, but what is the reason for =
l_sysctl since sysctl is some specific system call.

Regards

Marcel

