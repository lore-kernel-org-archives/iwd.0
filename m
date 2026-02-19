Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F11A285CB3
	for <iwd@lists.linux.dev>; Thu, 19 Feb 2026 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771502281; cv=none; b=uqc+TgwTK5tvS2JmHC8h8Mywjz+PaxeN/KXEFEfLQqK9E2gImGAiIQ9Yh93t54Ls5/WLgowtzwUnLT6U85EuVV3EGSBgT0cb/e+YtBObaSxTx5eb0fCgZrf1zM4pb+651hXxohVZGFI3ppSCzPPAcXLBJyqYXkS295gcWDGbRLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771502281; c=relaxed/simple;
	bh=UDbeWeaXq/BzCvaESWwhO0X6F21wIH1qxt6DSIEo+1M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QPkK4PRtgKK8Y9rFvoizIi2JfXNs8FFLvFJS9flk8aVGk7kaEkIsAu3L46ZdGbDRXMtCNQcRzn+97Ruwl1QQ2irIjJgI5WgdyPbIr3YE8YC2Zi7hGj0QPG+G22xDsjW3XIDGWhUQBbMVxzuhKJyUBcbgC+oJbkg11v14B+HhReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc5c5.dip0.t-ipconnect.de [79.239.197.197])
	by mail.holtmann.org (Postfix) with ESMTPSA id 6EBE3CECBE;
	Thu, 19 Feb 2026 12:57:58 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2] unit: Add better check for pkcs8_key_parser
 availability
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20260219112014.2206170-1-hadess@hadess.net>
Date: Thu, 19 Feb 2026 12:57:48 +0100
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <F37EFF67-DC9B-4982-BF62-6B5936B83646@holtmann.org>
References: <20260219112014.2206170-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
X-Mailer: Apple Mail (2.3864.400.21)

Hi Bastien,

> Check whether the pkcs8_key_parser kernel module is available (whether
> built-in or as a module) before announcing that we support PKCS#8.
> ---
> Changes since v1:
> - Fix missing #include
>=20
> unit/test-eapol.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>=20
> diff --git a/unit/test-eapol.c b/unit/test-eapol.c
> index 58f3e054a5ae..2ffc3e700108 100644
> --- a/unit/test-eapol.c
> +++ b/unit/test-eapol.c
> @@ -27,6 +27,7 @@
> #include <stdio.h>
> #include <string.h>
> #include <assert.h>
> +#include <sys/stat.h>
> #include <linux/if_ether.h>
> #include <ell/ell.h>
>=20
> @@ -3923,6 +3924,16 @@ static bool aes_precheck(const void *data)
>=20
> static bool pkcs8_precheck(const void *data)
> {
> + struct stat s;
> +
> + /* Despite the path, this directory exists whether the module
> + * is external or built-in. */

for some reason we stuck with this comments style (M2 in =
doc/coding-style.txt):

	/*
	 * foo
	 * bar
	 */

Regards

Marcel

