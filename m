Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBBF81AB9
	for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626496; cv=none; b=X2cW258Fc9FLfhFUHhCxjrTlPKn3YzTyAqBMVWfKEptAYAPl714/oAP5MwfNG6Aq0HJZuiTcUf+RxRRCKrXOPKgJKwngqWtGj4HJMvO8JgzbvqnuwrIz1wZ235L8sX5ZWq8Fv6rr/BQqx+HucllrwhWdbmeM+7z2b4gcWP9E0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626496; c=relaxed/simple;
	bh=jkAHcPI0bgQ1dWBftvYio558kD9OjyX3Ia1BGI3bzN8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=luYhT4ElL/LvgbbRaDtSGS3MhMTXmu5PaWLC5/P2EXv2L8RdpJJbWsrLs8/3LuKuE70aI/r3rJZoL2y/j6JbU8Nwcnxr5FekfnW3BlVHxrajsfFOkkoAFqg+dluOnmaf6p6QdHzH2r+QJidTI2hVu+Rh3UnZHwnVxtyHfCD/pvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9f86b.dip0.t-ipconnect.de [79.249.248.107])
	by mail.holtmann.org (Postfix) with ESMTPSA id 342F4CECC6;
	Tue, 30 Jan 2024 15:54:53 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [RFC] udev: Add module for checking interface renaming actions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <a6385e0a-6bd4-4152-930f-a995c0435179@gmail.com>
Date: Tue, 30 Jan 2024 15:54:42 +0100
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE05B63F-A9DD-4CF9-A680-198D7329EBE1@holtmann.org>
References: <20240126231339.10388-1-marcel@holtmann.org>
 <a6385e0a-6bd4-4152-930f-a995c0435179@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)

Hi James,

>> ---
>>  Makefile.am |   1 +
>>  src/udev.c  | 285 =
++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 286 insertions(+)
>>  create mode 100644 src/udev.c
>>=20
> Just curious what this is for. Are we trying to avoid needing to =
install the link file to disable udev renaming? And instead allow =
renaming but pick up the changes internally?

this is meant as sample what it takes to wait for udev renaming. When =
you receive that event above, then you know for sure that udev is done =
with renaming and we can IFF_UP the hardware.

I do need to check this on big endian and if we have to adjust the hash =
value for =E2=80=9Cnet=E2=80=9D.

Regards

Marcel

