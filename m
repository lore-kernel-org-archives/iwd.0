Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B63C242D97
	for <iwd@lists.linux.dev>; Thu, 19 Feb 2026 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771504151; cv=none; b=WhJoB/efVSKKD/8csLfe3QCwe8/V/fmVKFCXBk4H1J3HzJ5Cdgq3Y05y3uqsFZfxtA8XuQmuio2XNOtL/KO/9yOfkl/KPvNQ2RW4MbXqK+DkYE1h4AzF/ape+Nx4I1JGk8xX5yxEIQOi2isjXIOZfSSKM0U+0XiWvHoqg1pC4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771504151; c=relaxed/simple;
	bh=oMRNMFmIau9WlXqc3zlHOgVYdoQX0XcF1oREAR3idcQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eCKXWrB/iVQURYyOKIiNXbihMiqAVTRqhg8IwSgBCpxqRPVyQIk5jp6AXDI5QWYMbwf4RHfn9iISUarZBRYUlTOfpVgkNYhaA79AZJCa8NaH4EE5yunozCJeZ6cy47ZBuGeIm3Ddxen/Dhp2RKLgWPJO2jrBU8As57lVun+K3OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 210D443275;
	Thu, 19 Feb 2026 12:29:07 +0000 (UTC)
Message-ID: <6abd1afe80b07f0e0a9daa6a3f8604523792f142.camel@hadess.net>
Subject: Re: [PATCH v2] unit: Add better check for pkcs8_key_parser
 availability
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
Date: Thu, 19 Feb 2026 13:29:06 +0100
In-Reply-To: <F37EFF67-DC9B-4982-BF62-6B5936B83646@holtmann.org>
References: <20260219112014.2206170-1-hadess@hadess.net>
	 <F37EFF67-DC9B-4982-BF62-6B5936B83646@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepvddutdffgeegfedvjeehpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtohepihifugeslhhishhtshdrlhhinhhugidru
 ggvvh
X-GND-State: clean

On Thu, 2026-02-19 at 12:57 +0100, Marcel Holtmann wrote:
> Hi Bastien,
>=20
> > Check whether the pkcs8_key_parser kernel module is available
> > (whether
> > built-in or as a module) before announcing that we support PKCS#8.
> > ---
> > Changes since v1:
> > - Fix missing #include
> >=20
> > unit/test-eapol.c | 11 +++++++++++
> > 1 file changed, 11 insertions(+)
> >=20
> > diff --git a/unit/test-eapol.c b/unit/test-eapol.c
> > index 58f3e054a5ae..2ffc3e700108 100644
> > --- a/unit/test-eapol.c
> > +++ b/unit/test-eapol.c
> > @@ -27,6 +27,7 @@
> > #include <stdio.h>
> > #include <string.h>
> > #include <assert.h>
> > +#include <sys/stat.h>
> > #include <linux/if_ether.h>
> > #include <ell/ell.h>
> >=20
> > @@ -3923,6 +3924,16 @@ static bool aes_precheck(const void *data)
> >=20
> > static bool pkcs8_precheck(const void *data)
> > {
> > + struct stat s;
> > +
> > + /* Despite the path, this directory exists whether the module
> > + * is external or built-in. */
>=20
> for some reason we stuck with this comments style (M2 in doc/coding-
> style.txt):
>=20
> 	/*
> 	 * foo
> 	 * bar
> 	 */

Sent a v3.
