Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BFE14CAA2
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726168; cv=none; b=T71nYy1CNfw6PoLn6DrEF9E7tgO3g9okmtXusTcwY8Kw0Tu7VFcX8MiAuWGHsP4HfqPV82q1LnVmh5lCfhl25ctbM9fut/Vavn1vHy9qdNAWheDqro5E+VGmcU4bZYdTtKkQbzXSPuDKRRsS2+4x/mcq6ZLbnnBtV7b0ybnqlfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726168; c=relaxed/simple;
	bh=OIt0AffPydRisuBx2qASe52GJn/LAM7XnXZsHauYCkw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrpHeS7ihtmS6cH3m8PUb58z4g/kZJWYsC3iR3MdTcmq7pG8Zf3NJOQSteFkXRbCHAYs1ebJcrLPFjjlIkXORnjO3oJlj62YJSveFpk+IIWHVsW9gMEDMHHMWQ7zq/g6ozwaNXcReYIMxkccYGgBh3T9Jg5s4yNwQuD5KR5GnJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yartys.no; spf=pass smtp.mailfrom=yartys.no; dkim=pass (2048-bit key) header.d=yartys.no header.i=@yartys.no header.b=JrfV7P2l; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yartys.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yartys.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yartys.no header.i=@yartys.no header.b="JrfV7P2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yartys.no;
	s=protonmail2; t=1708726156; x=1708985356;
	bh=OIt0AffPydRisuBx2qASe52GJn/LAM7XnXZsHauYCkw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JrfV7P2l7PpzXa/RgxdileLahhLCB6ddPwfIRqL0mu1vX+LyzV1ao/uQTVkba1DVi
	 y+oEtm7fmISOxnrhLbm2ofDbJLolcjHb99m70g5/OGo3kjf7k0bIWnd5RMrK+AWtJp
	 l7OexL1/sfFO4UvsQ/ziQeau/ckVX+Ykybj8Hnp5KQJkTUq2DlENjinRIRejm1o3gN
	 TopVnwKG3BgPtAS1ueybXUmHD6JopS5RzSe2jXUrjlRwIrWavZnWjTpKKgY5svCzBS
	 RyGdIV9L/P0PtOh4Dv16G7Z0/3qx35sqNvqN4kZ/4esto9TFY0gYtVP0X/YgGvbnxZ
	 HOGbv6MpL2ICA==
Date: Fri, 23 Feb 2024 22:09:06 +0000
To: Denis Kenzior <denkenz@gmail.com>
From: Michael Yartys <mail@yartys.no>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: Unable to connect to eduroam
Message-ID: <ghq_OJQ1so1_7JGCGGTtn5Go_9tm_ZbROdd1umG7CzQ5G95vXzLCzCfWCbGjO4IBU2ZKzM1dmSUOCrKlsPhuDMbTVcJivxvPOXHBYPU6IyM=@yartys.no>
In-Reply-To: <f411612a-3d8c-47c8-abc1-41dda98e7732@gmail.com>
References: <njvxKaPo_CBxsQGaNSRHj8xOSxzk1_j_K-minIe4GCKUMB1qxJT8nPk9SGmfqg7Aepm_5dO7FEofYIYP1g15R9V5dJ0F8bN6O4VthSjzu1g=@yartys.no> <c935faa9-b90e-472a-917b-4cfd64c9d7f3@gmail.com> <oNiRr7aqwSLhickml0qZlRg5tAZ_r_d5KphKztkhii6KjSMvQ0-pYjNo-8NujElHLPJoc9ho9v8X3zD71jQ6O5pdzdTXqFF1T0x2dBQ9Oc0=@yartys.no> <f411612a-3d8c-47c8-abc1-41dda98e7732@gmail.com>
Feedback-ID: 77365699:user:proton
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Denis

>=20
> > This is my config. As you can see, the first variable is set to yes, bu=
t the second one is not set.
>=20
>=20
> Okay, CONFIG_CRYPTO_ECDSA should be enough. I can't dump out one of the t=
wo
> certificates you have. Do you have the CA certificate? If so you can try =
running
>=20
> ell.git/tools/certchain-verify <ca file> <certchain file>
>=20
>=20
> and see what happens. If your only change was a kernel upgrade, then I wo=
uld
> suspect sha1 removal as the culprit. Boot to an earlier kernel and see?

As far as I understand, this would be the CA certificate, right? https://ed=
uroam.no/connect/download/?idp=3D297;profile=3D430;os=3Dx-pem

I tried to compile ell, but I've run into some issues. Do you have a compil=
ed certchain-verify on hand? I could give it a try if you send it to me (by=
 link or whatever works).

I took a look at the kernel changelog and found out that version 6.7 remove=
d sha1 support (just search for "crypto: pkcs7 - remove sha1 support"): htt=
ps://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.7

I'll try to downgrade to version 6.6.14 and give it a try on Monday when I'=
m back at the uni.

>=20
> If it does turn out to be sha1 deprecation, then this is a bug report for=
 your
> distro and upstream kernel folks. They need to stop breaking uapis. SHA1
> signatures, while no longer secure, are still widespread.
>=20
> Regards,
> -Denis

Michael
