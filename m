Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537ED4A9B5
	for <iwd@lists.linux.dev>; Mon, 22 Jan 2024 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947753; cv=none; b=tboJhsAXvM7cQIaP/5g7BaqzuKwURqbNUPvnjI+E3ZkqtffZBaqaNuEQ1JT5NOcHmZv6RlcJH395m8hn2AQHNSxy9Z8uLnmLpofIiZj8F18mTiG7YhFX3NvztML2DiNcb4Zlpr5FQpDsj/UUMwUYqWZg8TBOncJutO09GLBxR/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947753; c=relaxed/simple;
	bh=MlAZla48K/xxOadPEwyoFMmt07cF6wEYd1b6sme74h8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKzzoFe3Ekf84kB1wJs8qWsE8rTCSQZ9e4esoXNIiYXWCOxYH+Cjvrxzv7wWlrkpDKsuTETR5vX2vQctKbzDyAk6Hx8KPp13Wpptf558nhqMW5MIhMW6SnLHEJltQGmMlwHZbC6fRRuq84wZWBgvIOJ4HEZWXL+Symqu8HmTmw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=w0TQ2ug7; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=0PDykX4l; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="w0TQ2ug7";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="0PDykX4l"
Received: from workstation64.local (port-ip-88-150-49-16.reverse.mdcc-fun.de [88.150.49.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.archlinux.org (Postfix) with ESMTPSA id 9CE3826EEDE9;
	Mon, 22 Jan 2024 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1705947747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LbHyTlBuzUVknC8lQwvD5gZwYCkuAWnaIG8VLt4+i+U=;
	b=w0TQ2ug73AMjF6OQQ0uByJw9q77eivo2yUp/8lI1UGVPqy1QKYvaTW+FTXnCu2KDshSGrE
	3FVQdA+K3ELvGb9tWaSei4kvrE978Z1/gVaVI2IkjiatKZ47oajO8G16jxRKbnO1XN584R
	aB1Qu0OJRE3y7rVexxJKNhLUUk/aYywK6JYf4avS+gxhmkhzo85Md79i/Wx+/96Dchjw1d
	+ZfPVtNQ1/8E5wrIcWlV3bIuJu3o9PIe3oBQeLisPf3XQbZ7e2YcL1ik/Rwf3Si++dSlm6
	hrJbV43Al9L9XVQxuoVGD4O/NSSnyMf2/oq2baYsyRklDJZPuYzeJ7WtTpj36WG3mmy246
	+JD9YicHr1QpxtD8STXoRriN6gFc6eu9VUy5Fv6YX2l5iHwU0sUPu5o/A8IuVMWhIsnW3z
	T9fw8J8VQh4lSS69vHKIztK9KIiYw6/JXNnOFX4RcWRSNgffmS0w4FKGqnIbmopYQxKEC4
	sWEjqb0QAnIDysftMt9z4cuzcNEJVKsfx0SvU7+v9u3UWySdl2MJwApDBMkkt+IF6OlQGX
	T6L+wfpDcFU/bJwi90TwDalGC4acEuOH9/2E/oXXiZssU8XBGdrWaQUEZYEW6XdwG5OqER
	ZfaLVzxPVX65T+v0wIpS0lMChW6HaMO/g3Xx48XYLLn8XoZpABlR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1705947747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LbHyTlBuzUVknC8lQwvD5gZwYCkuAWnaIG8VLt4+i+U=;
	b=0PDykX4ltMIUMTPk1o6Pfe4RME000WtRWJXidTDL9kk2QJhGBGAIbKobRguEY6nEJ6tT70
	FExEu2Fhg1jvYeCg==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=andyrtr smtp.mailfrom=andyrtr@archlinux.org
Date: Mon, 22 Jan 2024 19:22:21 +0100
From: Andreas Radke <andyrtr@archlinux.org>
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Subject: Re: test failure in unit/test-wsc
Message-ID: <20240122192221.6f45afe2@workstation64.local>
In-Reply-To: <20fb2c69-c58d-4598-b7ab-31fdb34df542@gmail.com>
References: <20240122105312.66fb4dbf@workstation64.local>
	<20fb2c69-c58d-4598-b7ab-31fdb34df542@gmail.com>
Organization: ArchLinux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEXLVzlCOzajNBsxMDJ9Rjo7JB1CJx2jo6JhMh9CPj9gFBAcGRUvqpyyAAACVElEQVQ4jWXTvWvbQBQA8McRSMeqwtQhi/LQcHgTVwghi+sKIncrhRCSKZQY0S4pGNTgycK4D3UymUyXxhAQ5ymEJJD75/pOX1baNxjr/bj37t1JsFw47VjsVH9guKxzHWMeHGf5H5xx3phmKQwXTrH60DxofWvunNYKC7vmWXMYE/xTyjznxLE29y9g0TE5hhxzY3YasDvcfUxhi+Hjt7oLDMstnXgADJFeV7Xgqlj6sAIOrkba1GB7dB77sH3J5EdZA/ZIOjFAYgF8f/2pBbspwDYUIX7dVVAcUwp1iKgNx224b8Gp1wCGX1pw0oBA/6LVvA2ygu8Mr/NNKVGDvVrEFkSfSzjgH3zFUKGg4xL4Yrqe8ACz3GPa2opOS7C9PfQEH+wKMdOzSE+bYxcrEHyrGvXZCZG+aeYQwjbNUrg15jHOpg3YHiBzANLxBa02k/dFtd00o5l8AViBPwApN/AGK0A7uXQb6BKW2Z7HA+5twOny2PiHbQVIe0qp+vXpIs/GL8ogR5lNlaNcF5YVSJ1qOtVEcycIGnDQ6+XY07nOsxvXDRxXMbhcMQWpPUlZnmfnDmcUQ9EqFQJ1KrOvOZ3bFQwBQ6BSnkT0NLcgN7AJBQfKRmRBppyf81NRqoTBAAF79tuZOkWigdCeBtpKqgUHRyIc2GvHotIGnkIRsnCeZi+BxyAaoKT453UN75Q6DD3wiWKiEc3GNewr9fuHvXKaj0aj2TRJ3tfwdtK3nxLvaBSH0ThJxiUEyWS/eDVZZmE0STg+WDhKJk+XdoiwiAKSK/UXmpn5K/owqOUAAAAASUVORK5CYII=
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ErbWwNFkNnoRcpjNVjCKrKP";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/ErbWwNFkNnoRcpjNVjCKrKP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 22 Jan 2024 09:16:49 -0600
schrieb Denis Kenzior <denkenz@gmail.com>:

> Hi Andreas,
>=20
>  [...] =20
>=20
> Works here:
> [denkenz@archdev ~]$ uname -a
> Linux archdev 6.6.7-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 14 Dec 2023
> 03:45:42 +0000 x86_64 GNU/Linux
>=20
> Looks like it is failing in l_key_new(), so the kernel is refusing to
> load crypto_dh5_prime.  Probably a kernel misconfiguration or
> regression.  What does strace say?
>=20
> Regards,
> -Denis
>=20

I confirm this test passing when directly invoking the build using
"makepkg" but fails using our devtools "extra-x86_64-build" command. So
it's some missing privilege to load the kernel module from inside
the build chroot here failing that test.

-Andy

--Sig_/ErbWwNFkNnoRcpjNVjCKrKP
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEErcih/MFeAdRTEEGelGV6sg8qCSsFAmWusl0ACgkQlGV6sg8q
CSv0jAgAj/hXgjsmmftwkNa3siw1FB+XpLhRmDK8uaRcKp5NgPf6Zr82NCw09FIo
VbEPHFdh5/QAuUsrUDST9DchxncfkzeJ4ecOqcd1JtwIjZsJgG9TY/hzz9z6dh6W
TA56AXW3dJ+PmJARmbMSrx9lTGB+X/QPDT2MWbfRU4bFCq8kDhAPJ4rPdGwsJtg1
WmwLeHVY9SRyWQWlliVOLecdJFrqixQwSzXjkqb4XLADcmAgEda5Pz6EmERZtnKV
pseNJZ2cB+km2SbAurNr1++LfbQIPAR3SPRLYmzIvTnzt2kpMjFfze3pQwc0242S
FcKDNkMVCZAX5gnm3IlFHOYFi+rSNw==
=ho37
-----END PGP SIGNATURE-----

--Sig_/ErbWwNFkNnoRcpjNVjCKrKP--
