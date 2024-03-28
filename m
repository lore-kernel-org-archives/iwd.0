Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA613118C
	for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642925; cv=none; b=RjIiLMtQIfvr6hPYB5rETMD7ODLlOpsXm7D/5KRtocM0MmIM2VSnUEMI6XGL0s4RN62XCxOQCDLHjm9G72CKE0H37z59C43OUzr91elEwkmhwl6khdy8FA6pdQmnwgq7DWGduqBa9o86mQ+1yg6/2RiJzmHQB2gW590lxNfaa5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642925; c=relaxed/simple;
	bh=ky4y5eKmIBFbuK8ZG/n/zmxy1OJHl9GYRfSmDLF99fw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=aPhqyB5VrbyrD8h7N3eRGRa89IFJsYvR+2Ys1Ll237sohVZsyj3r44mbNPSbnT9N+HaWd35Oc8eOLgT+EUrFd4k3zsH7X0eVvrjUwdQo9TOcC9dUW3PKR3s3ZRuna3QN6sJPbpqLRCr2NF1vrKi0ng13KkUatrewAeczm7wWYjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=svenstaro.org; spf=pass smtp.mailfrom=svenstaro.org; dkim=pass (2048-bit key) header.d=svenstaro.org header.i=@svenstaro.org header.b=t6TPXf5L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SEO6h9gF; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=svenstaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenstaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenstaro.org header.i=@svenstaro.org header.b="t6TPXf5L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SEO6h9gF"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 29B205C0066;
	Thu, 28 Mar 2024 12:22:00 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Thu, 28 Mar 2024 12:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenstaro.org;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1711642920;
	 x=1711729320; bh=d6KFsh5j3NOv52CCczRKgCBFINFprVvZCse8F0L485A=; b=
	t6TPXf5LuEHnzaYpULGSveBYXt6FaKHBa4vv+XHkgzHb5gKoeoiCXryYVtYDkraw
	9HGgNPyFxvg5TiOxks5X6dK64eEVkLuzv/tcBygpfOtoE0LMoDDujrarLwFCRouf
	VK28dYmdWDRSTbb6Wd9JZb6Qw2A8B5IVEiW9Qc2gKp+j78VMWvSLbEjo0MshhJkV
	4xTFpZ2xFgui7uOIRhOflFs2gdFxEwzkHuyiN/HDmFwf7YSFI4FJ5HB7V54LU/SM
	Q295uaQFJFnh1tJ+w4M0lAHRAEQst0LfSyhkrWt91u9+pkUwvV0nF785JZ9WcFn2
	FgBFJBV9b2aWkGRpJ7YxQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711642920; x=
	1711729320; bh=d6KFsh5j3NOv52CCczRKgCBFINFprVvZCse8F0L485A=; b=S
	EO6h9gFBJFNmEI61EKt7AUCTXgBLoZ7GG1Fgk7mbqwri6ggIar11g8T4epKg0FD8
	Zy+E+tbQ98IAB0eP3ZLa7lWMyNWKMh0139chaTGBiWImg706Pjp4MR7kp45XH/85
	up0btvYqMaeX05YD2CoiONd2a7zKdFGCc9GKmbBC2nUaCRGdCVlIPscftVDiHx1t
	JUHLkOVGkm0YjPhCP4TOX83Z83aNAFdhml9XnBawUu8F67LbrhTgjmCa44Z1NSbG
	SEkHQpSxFeKpo0y1SybTrQ4ya81prQEZHnbIBb/LUxb9y6aBdPa3l7j+85Hv8kFV
	GlaBupTyChQcKx9bYmNAw==
X-ME-Sender: <xms:J5kFZm9-Hd85ZSSNypCoEBKa9UHgvEOPwE9XR1oP4j3mkFRN_1q-rQ>
    <xme:J5kFZmurcJer4SPo0h55FXQB_qI0mh3MK9bDX1_I7WitB8oD0zXM_9Xc6VQ4zxRE5
    0zzuTExsfYium_2yuU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduledgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfufhv
    vghnqdfjvghnughrihhkucfjrggrshgvfdcuoehmrghilhhinhhglhhishhtshesshhvvg
    hnshhtrghrohdrohhrgheqnecuggftrfgrthhtvghrnhepheekhffgtdfhveeikefgheeu
    kedtffevgeffveejhfdtlefhvdegffeivdfhjeetnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrihhlihhnghhlihhsthhssehsvhgvnhhs
    thgrrhhordhorhhg
X-ME-Proxy: <xmx:J5kFZsB2_3wKqPJ_ZDUlII47CHl2JjAFdZjiwYWRb93lA7OPWv96NA>
    <xmx:J5kFZud7WfsFo9TnEc756_JkfsDltOmYESjJ9B3S8HtGpjty_Deacg>
    <xmx:J5kFZrMPozHrbR6aQJem9UQKz8ZoRqODlo97a7Xb1k0dbDBuPjpuaQ>
    <xmx:J5kFZokdc9ZM82KsQTN3qxkmMA4lTUpAeccc7JSJuCyKTUs0N5e4sw>
    <xmx:KJkFZtWrvFnyUtOPUgbZwGP5Ilc5B3fZg2hh013wI2p4i3H7t3ntVQ>
Feedback-ID: i6bf14966:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C55EB1700093; Thu, 28 Mar 2024 12:21:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <aa2a5e2a-77f0-4b79-80d0-6dbf877c5b6e@app.fastmail.com>
In-Reply-To: <5c42759f-abe9-42c9-922f-4568d4f04de1@gmail.com>
References: <699c79ff-0082-4602-9bb8-475722563c46@app.fastmail.com>
 <16f79ea4-32a2-47f5-b6a9-cfd911454a6a@gmail.com>
 <07f49420-74e8-4954-bd87-9ae3290e86d3@app.fastmail.com>
 <5c42759f-abe9-42c9-922f-4568d4f04de1@gmail.com>
Date: Thu, 28 Mar 2024 17:21:39 +0100
From: "Sven-Hendrik Haase" <mailinglists@svenstaro.org>
To: "James Prestwood" <prestwoj@gmail.com>, iwd@lists.linux.dev
Subject: Re: iwd picking worse network despite better one available
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024, at 14:48, James Prestwood wrote:
> Hi Sven,
>=20
> On 3/27/24 12:21 PM, Sven-Hendrik Haase wrote:
> > On Wed, Mar 27, 2024, at 19:54, James Prestwood wrote:
> >> Hi,
> >>
> >> On 3/27/24 11:36 AM, Sven-Hendrik Haase wrote:
> >>> Hello,
> >>>
> >>> I've spent a good chunk of my evening looking into why iwd doesn't=
 select the network I want it to select. I have a network "Home" with tw=
o APs. iwd seems to strongly prefer the AP that is further away and that=
 has worse strength as measured by iwd.
> >>>
> >>>   From some testing, I believe it has to do with the AP rather tha=
n the wifi adapter. I tested a wifi adapter using mt7921e and one using =
iwlwifi and the result is the same in both cases. The APs are both prett=
y modern: The one iwd doesn't like is a FRITZ!Box 7590 AX while the one =
it likes is a FRITZ!Repeater 6000. From the log it seems that iwd is una=
ble to perform a proper data rate estimation and then falls back to some=
 default. At any rate, the rank would indicate that the estimated data r=
ate plays an important role. If I use the developer mode to force roamin=
g to the AP I want (named "better" in the log) then I'm able to use it p=
erfectly well with a good data rate.
> >>>
> >>> As such I think this is a bug _somewhere_ but I'm not exactly sure=
 where. I searched the configuration options but it seems it's not possi=
ble to turn off the data rate estimations for the ranking. I'd be perfec=
tly happy to just go by signal strength. However, I suppose it would be =
better to actually fix the core problem in iwd.
> >> IWD bases the ranking of BSS's heavily off the estimated data rate.=
 If
> >> that fails then as you see the rank is very low as it defaults back=
 to
> >> 802.11b rates. There are several IEs the AP sends which IWD parses,=
 any
> >> one of them could be either not included at all, or not be formatted
> >> correctly, or an actual bug in the parsing code. Could you get an i=
wmon
> >> capture of IWD scanning your APs so I could take a look and see exa=
ctly
> >> why its failing? Then we can go from there.
> >>
> >> Thanks,
> >>
> >> James
> >>
> > Hi James,
> >
> > You should have received a pcap file of an iwd restart in a separate=
 email. I hope there's some usable data in there for you.
> >
> > Cheers,
> > Sven
>=20
> The issue is that the AP in question is not setting a bit correctly in=20
> the HE capabilities element. As part of the HE PHY capabilities there =
is=20
> a "Supported Channel Width Set" (Table 9-322b):
>=20
> =E2=80=94 B2 indicates support for a 160 MHz channel width.
> =E2=80=94 B3 indicates support for a 160/80+80 MHz channel
> width.
>=20
> And it then goes to say:
>=20
> B3 is set to 1 if supported. If B3 is 1, then B2 is set to 1.
>=20
> In your case B3=3D1 and B2=3D0. This is checked by IWD and fails. So t=
his is=20
> something the AP should fix. But at the same time this check actually=20
> bypasses the VHT/HT/basic rates calculations which is why your only=20
> getting 2mbps as the estimation. I just sent patches to the list fixin=
g=20
> this, so this should certainly help in your case, although the HE=20
> capabilities will still fail to parse which means IWD will estimate=20
> based on VHT instead.
>=20
> Thanks,
>=20
> James
>=20

Hey James,

I just tested the patches and can confirm that they perform perfectly fo=
r me and I'm now getting the right AP selected along with incredible spe=
eds so I'm happy. Looking forward to the next release of iwd!

I also reported the problem in detail to AVM. Let's see whether they wil=
l actually get an engineer onboard to fix the fundamental problem.

Cheers,
Sven
