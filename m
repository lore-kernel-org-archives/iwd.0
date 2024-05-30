Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C917D89B
	for <iwd@lists.linux.dev>; Thu, 30 May 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076458; cv=none; b=nN0QVVsCzB57qrtCS87DMvVTXUwyplnLzcadz+Ote/yxWBdSPV/lNzmJzWFTTE6vkmr/mcE81wyT49lM6/d4pnzy3kaINtqYEaHX8vNYTdQtNSG2VhdbGoiaXbHi57MkyMB52lZgDNQBhzJJRV5xPP2nUmCVt5XXubXtsvyOdpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076458; c=relaxed/simple;
	bh=m34K24Js20EHxzZXjgAe/Osdh2s6fdQwFNBwf9X1oAs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUoFWXBGRS91le8q1MftgeBdWNTrv4E0KdQVO1cRYlD4rOdpWWQNxygcGDLGfqVSW/Vrfz2rY6YU07LR+qTobY3uxhYViSm4GrYFkkMibtWni1U+2ANDwazHAObjbcrmJ8YQTs5bDk9LNLO6GNGlcf8VQ3eTiaepsUe2zbdaBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=peeters.gent; spf=pass smtp.mailfrom=peeters.gent; dkim=pass (2048-bit key) header.d=peeters.gent header.i=@peeters.gent header.b=ka0vinQE; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=peeters.gent
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peeters.gent
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peeters.gent header.i=@peeters.gent header.b="ka0vinQE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peeters.gent;
	s=protonmail2; t=1717076443; x=1717335643;
	bh=SDqqRmT4Cl1H8rwS7ioCmayaxHdI4G03z5ZdGAiWkGA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ka0vinQE5aoHMNkycAZ/VywepBJM1cKYBsC2/UAsi4b22a9ry3cwsgsBhOfYobx1m
	 UwkZ1ufswnTFtuDGBAtxuvuVewvQ/anlW5lIhhdy+4vELUFuXmYAI6F4tsymdV+354
	 FP1pWhMe9tlqYmYPWC5RKChQtOmZ1uSKSj2glVFq0gs+Jfz/VHo4w8rXRGDS/gHiFb
	 wfmXOouC8rrJJ73FMmvK6jrgvH0xuo35EC/LsnfxiYeIGSKkQiAWs+52+2pXSKbmET
	 KzKUjbMnIYwLEu8qhAFRPfBF7Gsjnn/0SaATTVG+uyVyxveBlJIqIJkYorhwSRjmDU
	 up45OYgdSmmYA==
Date: Thu, 30 May 2024 13:40:38 +0000
To: James Prestwood <prestwoj@gmail.com>
From: Laura Peeters <laura@peeters.gent>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: Bug when ttls start message is sent with tls_msg_len=0?
Message-ID: <41FLzNr1wtrsfKFkZM0rMARBMcMTku8jAsn-Jgrsq1FO_Toq-t41UDHVXmSL9P7qSld0ULkyhImIup0G3M33hZZ6ADdntSK00735qr_AeNs=@peeters.gent>
In-Reply-To: <5efbc990-b2fa-4bc0-864f-8d33b54407f3@gmail.com>
References: <tpitoeMEXJxiLQiWJBuau4l3V6w-zuBf8bQVFFXHyArcn6AZBp4Mb5TLsDLxqMLgD_uGDNQ2eKnChB5wbsB82NZpb-KdBfCYrnVcm5kDFRs=@peeters.gent> <5efbc990-b2fa-4bc0-864f-8d33b54407f3@gmail.com>
Feedback-ID: 91347878:user:proton
X-Pm-Message-ID: ef1dd6d14366f3e3d075195eed4393c7c4cac1cf
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi James,

On Thursday, 30 May 2024 at 15:10, James Prestwood <prestwoj@gmail.com> wro=
te:
> My interpretation is that spec is somewhat ambiguous on this... The L
> flag indicates the frame is fragmented:

not really true, the M flag indicates that the frame is fragmented,
the L flag indicates that the Message Length is included (which is redundan=
t in unfragmented frames)

"Unfragmented messages MAY have the L bit set and include
the length of the message (though this information is redundant)."
=E2=80=94 RFC 5281, Section 9.2.2

This paragraph is actually quoted in the relevant code in `eap_tls_init_req=
uest_assembly()`
That code then correctly returns -ENOMSG, however, if tls_msg_len=3D=3D0 we=
 never hit that code and return with -EINVAL earlier

>=20
> "The L flag is set to indicate the presence of the four-octet TLS
> Message Length field, and MUST be set for the first fragment of a
> fragmented TLS message or set of messages."
>=20
> So a fragmented packet with a length of zero certainly makes no sense at
> all IMO.
>=20
> But this is is set in a TLS-Start message since the S flag is set
> (right?). I can't find anything to indicate if you can fragment a
> TLS-Start message, except broadly:
>=20
> "TLS handshake messages SHOULD NOT be fragmented into multiple TLS
> records if they fit within a single TLS record."
>=20
> I quickly googled around and this all appears to be a configurable
> option in freeradius. I can't link to the section directly but in this
> docs page [1] there appears to be a configurable "length_included" option=
:

while turning that off is indeed likely to "fix" this issue, the documentat=
ion of that parameter states:

  #  This configuration item is here only to work around
  #  historical issues with misbehaving clients.  In most cases,
  #  it does not need to be changed.

Which would classify iwd as a misbehaving client according to the freeradiu=
s developers.

Given that iwd already correctly handles the L flag being present in unfrag=
mented frames for tls_msg_len > 0 I still believe this is an iwd bug.
=20
Greetings
Laura

ps: I'm not on the list (given that I'm mostly just a (code-savy) user), so=
 please keep me cc-ed on this issue.
