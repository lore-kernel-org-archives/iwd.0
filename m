Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF075C90E
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940207; cv=none; b=kxC9HOw0wdbpJlSrHLqy/c4FMJAF6pIkoQhma0/mTDX09Nht0zqRSyoNknC/yfWTGPHBKjNzaQcJ4aMOW8Nr6SKC5vA4e16b+pjKv/Y1mctYKPaNpB9V0t7ML1uc4N/DCEh6UWrwq2UNq2Bn6yfRrzX2dtlMNxJDQRPy89ECe2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940207; c=relaxed/simple;
	bh=Matavck+dAYdaAeZkYFy+SVgvkC6BR+eQJlr/aGMb+M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f/fYzFRt0hKoeGpSfxJkfZVQR8joZ7fe77gzFKspacngeCoGcjjR81WFm/aTIabrH6nLi8xSJs7erIECi2cj/ARRwxU6oqB5E+JnzpL761B80Rf87qn8exY0Egkav7mRH/X8PdXVN2tQLRwx5be7HH2I9r2rLSwGFr0yhsczIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9fa23.dip0.t-ipconnect.de [79.249.250.35])
	by mail.holtmann.org (Postfix) with ESMTPSA id A9B2FCECBE;
	Wed, 14 Feb 2024 20:50:03 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [RFC 5/5] doc: document use of l_log APIs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20240214193743.963349-6-prestwoj@gmail.com>
Date: Wed, 14 Feb 2024 20:49:59 +0100
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <1DB84D8A-74F6-43EC-9E27-A477FD343F0E@holtmann.org>
References: <20240214193743.963349-1-prestwoj@gmail.com>
 <20240214193743.963349-6-prestwoj@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)

Hi James,

> With the introduction of l_notice in IWD some guidelines need to be
> set for l_info, l_warn, l_error, l_debug and l_notice.
> ---
> doc/coding-style.txt | 24 ++++++++++++++++++++++++
> 1 file changed, 24 insertions(+)
>=20
> diff --git a/doc/coding-style.txt b/doc/coding-style.txt
> index bf0535c5..fdd9e0e3 100644
> --- a/doc/coding-style.txt
> +++ b/doc/coding-style.txt
> @@ -317,6 +317,30 @@ Functions that are static should not be =
forward-declared.  The only exception
> to this rule is if a circular dependency condition exists, and the =
forward
> declaration cannot be avoided.
>=20
> +M18: Use appropriate logging levels
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +An appropriate log level should be used depending on the type of =
message
> +being logged. Logging is done using the l_log APIs in ELL:
> +
> +l_info    Information that is expected during normal operation. =
l_info's use
> +          should be very limited so non-debug logs are concise
> +l_warn    An unexpected, but non-fatal condition ocurred
> +l_error   An unexpected condition ocurred. These are generally fatal =
to the
> +          current connection/protocol that is running but not =
generally to IWD's
> +          overall operation.
> +l_debug   General debugging. These can be used relatively freely but =
should
> +          provide some piece of useful information.
> +l_notice  Reserved for specific event-type notifications about IWD's =
internal
> +          state. These are logs that are mean to be both =
human-readable and
> +          parsed by tooling so they are required to be of a certain =
syntax. They
> +          should start with "event: <name>" followed by comma =
separated key
> +          value pairs containing the data of interest. Event names =
and their
> +          arguments should be consistent across the code base, i.e. =
two events
> +          called in different locations should have the same =
arguments.

and now they are not even in order of their log level. That confuses =
people.

> +
> +          For example:
> +
> +          l_notice("event: mycondition, arg1: value1, arg2: value2, =
...");

Please no semantics for the freeform text. If you want that, then better =
build some proper iwd_log functionality that does that.

Regards

Marcel

