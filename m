Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FF5111B0
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894209; cv=none; b=S2VY95jXeKGluiuUBN8aE7lkW7UIDDEt2NaY3oR5v+bRAJzOm3xKGapO6ulSfeJP3reYW03gxD71Yr/cB99K8yLfAz2XTCHs8tbXijS5OvUUyS12UKQadyeRKDix7Luy7N2EM6TgfZelbFG5fBpohr9Uo3NmpgaX2lWAXzPPIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894209; c=relaxed/simple;
	bh=kMZH9pTLHgdFosqiTM7F6huAl85x5EWQU/fFCvlTKG8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SPlKgxiDVPEpC9lKYzT1xl3eahkh7l3Z+MZBKPgLM5aGSQEmtWJszrZv7PWFGhLKkGET9KxlFGMQ0bFGtjHM0Dzs61hvA2zLbCPnM0TZKe4C0BBHaM+4TD6OjC8I2oGb3/OuwBkXSQ95oXdwS6ivFI8jjWThRV1/Iux1dS44HxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9fa23.dip0.t-ipconnect.de [79.249.250.35])
	by mail.holtmann.org (Postfix) with ESMTPSA id 55DF3CECBE;
	Wed, 14 Feb 2024 08:03:20 +0100 (CET)
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
In-Reply-To: <8b02ff06-9c2b-4503-8fb8-9784c2628394@gmail.com>
Date: Wed, 14 Feb 2024 08:03:09 +0100
Cc: Clayton Craft <clayton@craftyguy.net>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <152B8E7F-C6D0-4827-AC38-25454FD6BAF7@holtmann.org>
References: <20240212184747.30422-1-clayton@craftyguy.net>
 <8b02ff06-9c2b-4503-8fb8-9784c2628394@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)

Hi Denis,

>> This fixes a runtime segfault with musl libc and GCC13. musl dropped =
a
>> basename prototype[1] in string.h, causing GCC to define it =
implicitly
>> with the wrong function signature. The correct basename definition =
based
>> on how wiphy uses it is in libgen.h.
>=20
> Hmm, why did musl do that?  man 3 basename indicates that the libgen.h =
version implementation is free to scratch in the input argument, while =
the string.h one doesn't.
>=20
> In this particular case it doesn't matter since driver_path is never =
used again.  Still, the string.h version is much more intuitive.
>=20
> Maybe this should be re-implemented in missing.h or ell (say =
l_file_basename or l_dir_basename) instead?

we can also just do a l_util_basename that does the right thing and =
allocates a new string from it.

Regards

Marcel

