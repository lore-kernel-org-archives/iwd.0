Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D61E14C587
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717054; cv=none; b=oSmZ8yAp8Pt6ewEr7aMIBu95D/EJ9mmlSmHLnF64fuMZLXnUFl/BnT4IUA1q79vNxfUU/acEC/+As1tvBQjL2TLmXUu2inyNWRbza0kU2cbj5KefGg/SztiPOW31lEOVNOFvaf8nJPY5yPhb4tEhr8eF5XD8XK45AQkHzg/fwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717054; c=relaxed/simple;
	bh=LoOiWwXujuprBi/FEgb6j2XRQKfTHQKu5qo5ozcdCVw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltS3tmFDw5WhTWRiZVnT7mJSuk+eenbGSCUC/pNt9DCA86eTOj13A3or/t7NZem54Gpbzr+N9dBJ+JM1mYtU1Qo7S/511gtMLJqvZ4dfYVwW8pKOFPlT+7EIXnH+1aqKwAhNOSN49YnQ5lz5GJ98skBg6GoEkzQv5pJczwwOkTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yartys.no; spf=pass smtp.mailfrom=yartys.no; dkim=pass (2048-bit key) header.d=yartys.no header.i=@yartys.no header.b=QH7nyXZc; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yartys.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yartys.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yartys.no header.i=@yartys.no header.b="QH7nyXZc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yartys.no;
	s=protonmail2; t=1708717038; x=1708976238;
	bh=LoOiWwXujuprBi/FEgb6j2XRQKfTHQKu5qo5ozcdCVw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QH7nyXZc2bnyZW+W7eZswR6zLm5LOa678aPb5bR1Sg5ISx0NjhK6j4rF/lklDxG1a
	 +0DWSshvUIJaQX1rrb2i4QK/EmtBu0kgI0ou4hB8I5t/junsCUJ05tsktt+vvJ/2C6
	 yXdEvRvWkAW2thmHmF0EsJsBcdp3UBfNDXvfuiDRRB3Q+1m7dFJu459xf6HXnSg1H4
	 kAfB2dhpX3vw1Nrgji1f/TDO6SCCUAinNmTL2PON4XJqv+aWedHjPluma0hPFtVrv/
	 q491IYjbV6r8vklCIpV3mOFbXhFZKzN6Qp9EBDwa/rTM7+TQ9TRZ6olhw8yurGxp72
	 OJsy6pCCNIW8Q==
Date: Fri, 23 Feb 2024 19:37:11 +0000
To: Denis Kenzior <denkenz@gmail.com>
From: Michael Yartys <mail@yartys.no>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: Unable to connect to eduroam
Message-ID: <oNiRr7aqwSLhickml0qZlRg5tAZ_r_d5KphKztkhii6KjSMvQ0-pYjNo-8NujElHLPJoc9ho9v8X3zD71jQ6O5pdzdTXqFF1T0x2dBQ9Oc0=@yartys.no>
In-Reply-To: <c935faa9-b90e-472a-917b-4cfd64c9d7f3@gmail.com>
References: <njvxKaPo_CBxsQGaNSRHj8xOSxzk1_j_K-minIe4GCKUMB1qxJT8nPk9SGmfqg7Aepm_5dO7FEofYIYP1g15R9V5dJ0F8bN6O4VthSjzu1g=@yartys.no> <c935faa9-b90e-472a-917b-4cfd64c9d7f3@gmail.com>
Feedback-ID: 77365699:user:proton
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Denis,
=20
>=20
> Hi Michael,
>=20
> > I'm sure these certificates are correct because I was able to roll back=
 to a working build on Fedora Silverblue to keep connecting to the network.=
 Unfortunately, I was dumb enough to forget to pin/freeze that working buil=
d to prevent it from being replaced by new versions as I continually update=
d the system.
>=20
>=20
> Do you have any clue what changes you made to the working build? iwd hasn=
't
> touched certificate bits for a number of releases now.

Just to be clear, I didn't build anything myself, I just updated my system =
as you would on a day to day basis. My guess is that a new kernel version c=
ame along that messed something up.

>=20
> > I searched a bit around and found that some other folks had experienced=
 the same issue on Arch: https://bbs.archlinux.org/viewtopic.php?id=3D29192=
1
> >=20
> > That thread links to another thread about the deprecation of SHA-1 in t=
he kernel: https://bbs.archlinux.org/viewtopic.php?id=3D292208
>=20
>=20
> Someone should complain to the linux-crypto folks for breaking uapis and =
have
> that change reverted.
>=20
> > rochus from the first thread was able to connect to their eduroam netwo=
rk when they tried a kernel with the offending commit reverted. Now, I know=
 very little about certificates, but no certificates in my cert chain are S=
HA-1 signed, are they? Could this still be related to the issue I'm experie=
ncing?
>=20
>=20
> I can't dump the second certificate for some reason, but the first has:
> [denkenz@archdev ell]$ openssl x509 -in cert2.pem -text
> ...
> Signature Algorithm: ecdsa-with-SHA256
>=20
> Do you have CONFIG_ECDSA=3Dy in your kernel?
>=20
> [denkenz@archdev ell]$ zless /proc/config.gz | grep ECDSA
> CONFIG_CRYPTO_ECDSA=3Dy
> CONFIG_MODULE_SIG_KEY_TYPE_ECDSA=3Dy

This is my config. As you can see, the first variable is set to yes, but th=
e second one is not set.

michael@localhost:~$ cat /usr/lib/modules/6.7.5-200.fc39.x86_64/config | gr=
ep ECDSA
CONFIG_CRYPTO_ECDSA=3Dy
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set

>=20
> Regards,
> -Denis

Michael
