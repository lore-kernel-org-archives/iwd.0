Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15D7604AA
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929577; cv=none; b=q+FrMqeFSENdqrL28fpmBNQo8USkwP66oxnFjtZy5Va9FMjtQWfXS8+JPHvwdxK7v13uIAjNTlxgGuqhkg/Kenp+NaOIqwoMLm0G5o/qUVEaR5kgYPBkeU32xBcFGZbnIM4mNKF/j2Oa6Toc1GbjFtT6gGJc6S3y0nT9TH7v5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929577; c=relaxed/simple;
	bh=pWD4uDJGt/0cvJxGTOlDuk4Q6j4/IK1Y7ep/QhOX5jE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FzyySOIqi84KXolZ84HQa1olaS7eMqPWf/ESQ5mJTfzXMD/Vqto1yOUUO7wWVgevMGw8jBQn6bzg7ZC9YMxMKqA9NmPiQjdFPPYaKGRdXiRFZZpVg4SntzNWZKwWuJ8AVARkN6pHSXvJspFmX8HVEirZtBo45q6FPnoU82bR8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9fa23.dip0.t-ipconnect.de [79.249.250.35])
	by mail.holtmann.org (Postfix) with ESMTPSA id AC3EECECBE;
	Wed, 14 Feb 2024 17:52:53 +0100 (CET)
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
In-Reply-To: <a64273d2-e585-4e48-a35a-38384b79202c@gmail.com>
Date: Wed, 14 Feb 2024 17:52:43 +0100
Cc: Clayton Craft <clayton@craftyguy.net>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <440488C8-0481-4A8F-BF68-A7F97FAADC8C@holtmann.org>
References: <20240212184747.30422-1-clayton@craftyguy.net>
 <8b02ff06-9c2b-4503-8fb8-9784c2628394@gmail.com>
 <152B8E7F-C6D0-4827-AC38-25454FD6BAF7@holtmann.org>
 <f9970105-c1c7-484b-8e13-5ca5f5bae901@gmail.com>
 <34797D3A-D630-4D71-B4E8-BD29E9BB759C@holtmann.org>
 <b1b66222-6594-4775-94ed-2f17810029b1@gmail.com>
 <BC62FEA8-DA18-4084-A5B6-A96C82AE799B@holtmann.org>
 <a64273d2-e585-4e48-a35a-38384b79202c@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)

Hi Denis,

>>>> Add a _get_driver is a good idea as well, but what is the reason =
for l_sysctl since sysctl is some specific system call.
>>>=20
>>> l_sysctl is used to write stuff into procfs or sysfs.  Naming comes =
from the sysctl(8) utility.
>> actually no. sysctl just handles /proc/sys/. It has nothing to do =
with sysfs.
>=20
> You're right about sysctl.  ell used the same naming since it was =
meant to control net/ipv* kernel parameters.  However, the same API can =
be used inside sysfs since the semantics are identical.
>=20
> If you don't like l_sysctl_get_driver, then lets call it =
l_sysfs_get_driver().

yes, I would prefer l_sysfs_get_driver.

Regards

Marcel

