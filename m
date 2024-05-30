Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB917623E
	for <iwd@lists.linux.dev>; Thu, 30 May 2024 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079593; cv=none; b=Kdgg/JxiQw/r98y/5ryxZZs/7Te/EKMm//F8xP5YEXtswZ81ggGxKl1kELW18137L4unl2cRUPZQ8ySBRGJGsS9k6/cpymfTGXsar5DmrVZipCgXuzt20gko22VjBvV1Zw08+Kop9wlkmtG2FxDLQNtIoK1p0flpntLjxUaJ9LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079593; c=relaxed/simple;
	bh=VLT5J3sYpvZ9DqpPOO9VLvRwGp5WR5Q9jo8X4vCZNgc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLMo/Ebv1M9MsoLO8caYJEeLg5F4rm2q0xhfbcca5AKrE38ll7zLEvUwGSvrJF+JRwzgtr2OqdlqgTji481bW/to/ZauzA+Ho2ZXOx/DwlF4W4K6U/yek5cbeLi172huaiEpQ2ME6Gzk8WF0Q+dB+V+tHRtV5pYhUagm0XQ25Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=peeters.gent; spf=pass smtp.mailfrom=peeters.gent; dkim=pass (2048-bit key) header.d=peeters.gent header.i=@peeters.gent header.b=uWYvcI0Q; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=peeters.gent
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peeters.gent
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peeters.gent header.i=@peeters.gent header.b="uWYvcI0Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peeters.gent;
	s=protonmail2; t=1717079588; x=1717338788;
	bh=ntrmuMtjwvJ6KUFqbqRT435b+M0Kl6xzsN43yz44N2I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uWYvcI0QXUGffzBppVKq+O0iUMsJBLNDEet9oL0xwPMP7M3hkoAgNLW1K6LMo44Ol
	 /kdxF9akj/S+GLDeuPhEqaLfCOOA3vh6lgvcoI0mN+iF16/fl+jnZHZdfxszJ4Ak1j
	 8qg2KLont7gCK7hDdPT8NO8KY7+ST1U4tP2i14Bmfa9qiTJM6LHvc0vjib26Aap8xl
	 R1YwXnLBtlLHvHfD0BEdkxwN9T63VU8qbYa9n5UYI4OgcVSoGA9DST29LLgbhXxdT4
	 baRZ4O9Uzxo+t8QX4BW2UbbB26mj8onXT2gYDDzjbC2DUqrC98pZLy3sd5eilzscrs
	 7CuyNcWuhZZgQ==
Date: Thu, 30 May 2024 14:33:04 +0000
To: James Prestwood <prestwoj@gmail.com>
From: Laura Peeters <laura@peeters.gent>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: Bug when ttls start message is sent with tls_msg_len=0?
Message-ID: <l4bFTgc6F3Oq80Dymz6VJAGQB__Pk3Es1NIPcSFxe_-1QEn0748-s9jJxglFtzwRJ01E7iTSOfR8uCes7Adqk7WZQX8nfMKaBm1TpJYfzjs=@peeters.gent>
In-Reply-To: <5b5e743f-e3fb-43ae-9aea-b6b7530d33a4@gmail.com>
References: <tpitoeMEXJxiLQiWJBuau4l3V6w-zuBf8bQVFFXHyArcn6AZBp4Mb5TLsDLxqMLgD_uGDNQ2eKnChB5wbsB82NZpb-KdBfCYrnVcm5kDFRs=@peeters.gent> <5efbc990-b2fa-4bc0-864f-8d33b54407f3@gmail.com> <41FLzNr1wtrsfKFkZM0rMARBMcMTku8jAsn-Jgrsq1FO_Toq-t41UDHVXmSL9P7qSld0ULkyhImIup0G3M33hZZ6ADdntSK00735qr_AeNs=@peeters.gent> <5b5e743f-e3fb-43ae-9aea-b6b7530d33a4@gmail.com>
Feedback-ID: 91347878:user:proton
X-Pm-Message-ID: 55cc581073f9f164c20fd494078ab67cafc1d4ff
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, 30 May 2024 at 16:11, James Prestwood <prestwoj@gmail.com> wro=
te:
>=20
> On 5/30/24 6:40 AM, Laura Peeters wrote:
>=20
> > Hi James,
> >=20
> > On Thursday, 30 May 2024 at 15:10, James Prestwood prestwoj@gmail.com w=
rote:
> >=20
> > > My interpretation is that spec is somewhat ambiguous on this... The L
> > > flag indicates the frame is fragmented:
> > > not really true, the M flag indicates that the frame is fragmented,
> > > the L flag indicates that the Message Length is included (which is re=
dundant in unfragmented frames)
> >=20
> > "Unfragmented messages MAY have the L bit set and include
> > the length of the message (though this information is redundant)."
> > =E2=80=94 RFC 5281, Section 9.2.2
> >=20
> > This paragraph is actually quoted in the relevant code in `eap_tls_init=
_request_assembly()`
> > That code then correctly returns -ENOMSG, however, if tls_msg_len=3D=3D=
0 we never hit that code and return with -EINVAL earlier
>=20
>=20
> Ah, I should have kept following the logic. I see we do handle -ENOMSG
> specially up the stack. I still think its weird that the included length
> is zero though. Based on the code the original handling of this
> redundant length case only pertained to the lengths matching. But yes we
> could handle this case by adding:
>=20
> if (tls_msg_len =3D=3D len || tls_msg_len =3D=3D 0) {
> ...
> return -ENOMSG;
> }
>=20

I'd have to double check, but I do not think that an extra `tls_msg_len =3D=
=3D 0` check is needed.
From what I read `len` should also be 0 at that point. (if it is not then i=
t IS a malformed message)
So my proposal would just be:

--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -500,9 +500,9 @@ static int eap_tls_init_request_assembly(struct eap_sta=
te *eap,
        tls_msg_len =3D l_get_be32(pkt);
        len -=3D 4;
=20
-       if (!tls_msg_len || tls_msg_len > EAP_TLS_PDU_MAX_LEN) {
+       if (tls_msg_len > EAP_TLS_PDU_MAX_LEN) {
                l_warn("%s: Fragmented pkt size is outside of allowed"
-                               " boundaries [1, %u]", eap_get_method_name(=
eap),
+                               " boundaries [0, %u]", eap_get_method_name(=
eap),
                                                        EAP_TLS_PDU_MAX_LEN=
);
=20
                return -EINVAL;


I'll likely build iwd with this change for testing later. (though I'm not s=
ure when I'll be at the office next)

> And of course moving that check earlier.
>=20
> I think it would be useful to get a bit more information about this from
> the standpoint of freeradius as well as other radius implementations.
> e.g. is this just a bug or a feature introduced in freeradius 3.2.4, or
> did the config change on your network. Do other radius implementations
> have/support this behavior?

I am not in contact with freeradius people, but this is a result from a sma=
ll refactor on their end.
They used to have a dedicated codepath for sending the start message,
while in 3.2.4 the regular "send eap tls message" codepath is used with an =
extra flag to set the start flag.

While I'm not convinced the change in L flag behaviour was intentional, it =
in my opinion still does not violate the RFC.

The config on our network did not change, this is purely a (debian) package=
 upgrade that triggered this.

I do not have any experience with/access to other radius implementations to=
 compare.

>=20
> At the moment I still don't think this is a "bug" on the IWD side, but
> ambiguity in the spec. Yes the length is labeled as "redundant" in this
> case but what exactly does that mean? should it be ignored? I really
> don't know.

I think the language "Unfragmented messages MAY have the L bit set" is expl=
icit enough to imply that iwd should not fail if it is set in an unfragment=
ed message. even if that means the length is 0.

Just to be clear here: the message length of 0 IS correct. there is no data=
 after the message length field.
So "should it be ignored?" doesn't really play into this issue, and I don't=
 think it should be ignored.
If the length is there, it should be valid, as already enforced by the exis=
ting code.
We just do not end up reaching that code if the length specified is 0.

>=20
> Thanks,
>=20
> James
>=20
> > > "The L flag is set to indicate the presence of the four-octet TLS
> > > Message Length field, and MUST be set for the first fragment of a
> > > fragmented TLS message or set of messages."
> > >=20
> > > So a fragmented packet with a length of zero certainly makes no sense=
 at
> > > all IMO.
> > >=20
> > > But this is is set in a TLS-Start message since the S flag is set
> > > (right?). I can't find anything to indicate if you can fragment a
> > > TLS-Start message, except broadly:
> > >=20
> > > "TLS handshake messages SHOULD NOT be fragmented into multiple TLS
> > > records if they fit within a single TLS record."
> > >=20
> > > I quickly googled around and this all appears to be a configurable
> > > option in freeradius. I can't link to the section directly but in thi=
s
> > > docs page [1] there appears to be a configurable "length_included" op=
tion:
> > > while turning that off is indeed likely to "fix" this issue, the docu=
mentation of that parameter states:
> >=20
> > # This configuration item is here only to work around
> > # historical issues with misbehaving clients. In most cases,
> > # it does not need to be changed.
> >=20
> > Which would classify iwd as a misbehaving client according to the freer=
adius developers.
> >=20
> > Given that iwd already correctly handles the L flag being present in un=
fragmented frames for tls_msg_len > 0 I still believe this is an iwd bug.
> >=20
> > Greetings
> > Laura
> >=20
> > ps: I'm not on the list (given that I'm mostly just a (code-savy) user)=
, so please keep me cc-ed on this issue.
