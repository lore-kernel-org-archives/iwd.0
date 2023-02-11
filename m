Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977964408
	for <iwd@lists.linux.dev>; Sat, 11 Feb 2023 16:52:51 +0000 (UTC)
Date: Sat, 11 Feb 2023 16:44:38 +0000
Authentication-Results: mail-4321.protonmail.ch;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="JrvaoWfw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1676133889; x=1676393089;
	bh=OaO2wZ5aAR/xzGNXBzOy4arghEqcrrc2/UHp5k/Ct/E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JrvaoWfwiPn/zXYn1ujQUVMfXZINhbmEXUF2drjUBpdOYNrr35zvpAtaIGJr7AdYz
	 46WTJijMKbSX6LEM+P1CsyTJ+aSTkFLypCzB1xKXbpm/dMtTYJysqAYGtOSRdLDxuo
	 ovAHH7gHlbs3VFu3tEBBdIUSYQ25pwSeFrbZNMuJEaWtXxgSuI7gA3ekiNfCLiEcef
	 Otx5CMcgpJdZs/wNUGeUmIpPzb20ph/Uipc92/a65F36ze9giLK/Dqk+c6gVtlfX9z
	 JlXQ1vFMwLDiJkC1IEGYnHSltm5Z8MkRoLh+pDKK6aeVmghwj72MHMWM5Sk/FqCvxX
	 Rsoml2bhhDH8Q==
To: Denis Kenzior <denkenz@gmail.com>
From: Michael Yartys <michael.yartys@protonmail.com>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: ECDSA support
Message-ID: <gxDpldx54cAZMd8uKyZg6GKlKGVRk2YRB0KixFuDqJlwmDeiQvW9ELIFFOlVXbNwbgHIbRlOt3sRXPAisAWzFCHB3Y0oPowSJiIbbBVO35s=@protonmail.com>
In-Reply-To: <6ebeca95-8618-f398-6a4e-e1edf8d65883@gmail.com>
References: <-H_hDnis_8eufaXJO7ObNd3y7Tys74ouHJg_A9OVHKpLIOMHWKBaayXV0QC0Ss61b5kZdOPQP5tIU0ySQF1XWgYc8zlQQ9qizmcGNw7JYf8=@protonmail.com> <6ebeca95-8618-f398-6a4e-e1edf8d65883@gmail.com>
Feedback-ID: 6588689:user:proton
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>=20
>=20
> Hi Michael,
>=20
> On 1/18/23 07:16, Michael Yartys wrote:
>=20
> > Hi
> >=20
> > I've been unable to connect to my university Eduroam network ever since=
 they switched their certificates from RSA to ECDSA. As far as I know, iwd =
has been working on getting ECDSA support into the kernel for a while now. =
What's the latest news on this? I would really prefer to ditch wpa_supplica=
nt due to the superior roaming functionality of iwd, which is really useful=
 on my FT-SAE home network.
>=20
>=20
> ECDSA support is already in iwd, but it requires the following fix to the=
 kernel
> which hasn't been upstreamed yet:
>=20
> https://patchwork.kernel.org/project/keyrings/patch/20220826145119.9375-1=
-denkenz@gmail.com/
>=20
> We've resent this twice now and there's crickets on the mailing list. If =
others
> want to nudge the upstream maintainers, be our guest :)

There's been no reply from the maintainers, so maybe it's worth trying to r=
esend it again? Strange that they pretty much ignore it...

>=20
> Regards,
> -Denis

Michael
