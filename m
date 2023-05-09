Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6067F18018
	for <iwd@lists.linux.dev>; Tue,  9 May 2023 16:46:14 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 786D03200930;
	Tue,  9 May 2023 12:46:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 09 May 2023 12:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mikesilva.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm3; t=1683650773; x=1683737173; bh=wpHjtM4oF8oBLUq2wuQBIqelw
	ixh7LoqbXyKPv89myk=; b=Mqzy2iGD6KMfhXp47T48GL0QxYLpMFr3InY3tTn+o
	psAK4BhXQSbta4skJyXAC+ufG13NK2O9do3Ag7PeHSIv29ZsLWDlH1tl56iO18Q4
	+e8EbbYcutsFl5fNnry6Y5bftPUyJcNXAookBNx8CULT65699u2DWLAcqEQakGwb
	nyekFwrW+zfh+hyvGlDvQ/CwmykZW6AHLCQa4nGiMhOwl9gXntAwUak4EqTDHNJr
	lKKfBiSqX8YWEVb1sJY5Wc5WW2pUGegbQhnljw60f1DJNcvKkzBAgV5n6vo4m3ku
	UmZ+ardasgmSNbab/+ETEjyb/i9/XZa98XtVXgmtuJ2hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1683650773; x=1683737173; bh=wpHjtM4oF8oBLUq2wuQBIqelwixh7LoqbXy
	KPv89myk=; b=WdQ/AUPHuGTMpwIbeQD1iNKP0RO6qFtss8XboyqKJmSlU9rZPTC
	cWp2Ze2QY6RBhQZaTmpttIx/zvqMpxV1l43oupAWysXxGkiDtcxkSd4USlGSBRw2
	H6TMq9/vQHCNm/QEx2SFkZ9hLBN7VJMtZswKIyheYmcn9eEyhqRn36Q0s0BzwOY0
	rnnOOEU3NpJaPJrNMxtyFYWCcGTmALRKRv10oUzog4wiGHcIWfw4Ex3amoCjTc56
	l+/s/74qAVxyCiXeJadpstHC6wpfBH+sYIkZcXm1ozwdroJ/N4yu0RiWDciGuPI3
	sDeBM3jYkWzOsBCrJ+fth4f1gvAiumGKhcA==
X-ME-Sender: <xms:1HhaZJ-V_2rzCAWtyZD4Fp2SMGGp9l741tqcFoVqHroTIrsZrIvKdg>
    <xme:1HhaZNuqyUfrNUi0uXxhC6ulixaO0xwzuBV6-6pARzV3yyGvi7UuOjURMnG77kj60
    _2WR6XU-UfIiCrznzg>
X-ME-Received: <xmr:1HhaZHDZoiO0g9t7g4nJG0eIStQrTui6ZeY0U6ZRX2o4TS2ErqSyspclqiJftXoKhg1EqSIATx5Si0Y_OtUt4wWcpdsvTFh0iFHm2CPfwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeguddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpefoihhk
    vgcuufhilhhvrgcuoehmihhkvgdrshhilhhvrgesmhhikhgvshhilhhvrgdrtghomheqne
    cuggftrfgrthhtvghrnhephedvheefkeejudfhvdeuveehteeuveffleehheeuteeffedv
    teejvdetgeeivedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhhikhgvrdhsihhlvhgrsehmihhkvghsihhlvhgrrdgtohhm
X-ME-Proxy: <xmx:1HhaZNeg1FOVI7HxotJ6JUU7uqXqdLo4EagbKeNjm_h_BZ67ZwjyKA>
    <xmx:1HhaZONpga7P0m3wE9NK62LcciKDTSPSa_RHyXq2iE8MIxXdB6HWHQ>
    <xmx:1HhaZPmjZoohWyWtCXK9v-kBdRuxRhR-Xer0IBqIQOlFWodQEWhDLg>
    <xmx:1XhaZIW0h-JtahVx-HtlEeB1cjeGKrP_mybvkyiWYAmvNX5CNv4Azw>
Feedback-ID: i3a5446d4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 12:46:12 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: powersave support
From: Mike Silva <mike.silva@mikesilva.com>
In-Reply-To: <f5ccf370-5197-c9a4-61b6-2a130c7242de@gmail.com>
Date: Tue, 9 May 2023 09:46:11 -0700
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <65588442-8D0B-4F0C-AE0D-0C249202D556@mikesilva.com>
References: <9EF567DC-15CC-40C0-9AF8-D69E27B81ACF@mikesilva.com>
 <f5ccf370-5197-c9a4-61b6-2a130c7242de@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)



> On May 9, 2023, at 7:17 AM, James Prestwood <prestwoj@gmail.com> =
wrote:
>=20
> Hi Mike,

Hello and thank you for your openness to my query, and understanding of =
why I=E2=80=99m asking it.

>=20
> On 5/8/23 7:50 PM, Mike Silva wrote:
>> Does IWD support disabling/enabling WiFi powersave/power management?
>=20
> No, currently it doesn't.
>=20
>> Perhaps, I=E2=80=99m failing in finding it in the documentation. =
It=E2=80=99s possible to do this as needed with ifconfig, iwconfig, or =
NetworkManager, or to permanently configure them to enable or disable it =
at boot..
>> If IWD doesn=E2=80=99t support this, it would be nice enhancement if =
IWD could when managing the adapter/connection, as some drivers do a =
poor job of handling powersave being on.
>=20
> Yes, I've recently seen instances of drivers handling this poorly. Are =
you envisioning something like these other tools, where power save is =
just toggled on/off?

I am hoping more for something along the lines of how NetworkManager =
allows one to both enable or disable powersave easily on demand =
interactively, but also allows for a quite simple configuration which =
would allow the user to set and persist their preference at boot and =
when waking from sleep.=20

If I=E2=80=99m happily allowing IWD to control every other aspect of the =
adapter instantiating a connection, it seems natural I would also set =
this in IWDs config, rather than looking to use one of these other tools =
either on demand or via a boot script.

>=20
> I think this could be done, and actually we do this manually every =
boot using iwconfig in the software stack I work with. The tricky part =
is PS is done per-interface and IWD doesn't have any concept of =
per-interface configurations.
>=20
> Denis might have preferences on this? but my initial thoughts would be =
something like:
>=20
> [General.wlan0]
> PowerSave=3D{on,off}

That=E2=80=99s exactly what I was hoping to be able to set in iwd.config =
or an iwd network configuration file. The analog of this pref in =
NetworkManager handles boot and wake from sleep.

>=20
> Thanks,
> James
>=20
>> Thanks!

