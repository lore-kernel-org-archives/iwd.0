Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0316E211C
	for <iwd@lists.linux.dev>; Tue, 30 Apr 2024 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462967; cv=none; b=fZpdx2z3uykyBLC1QdEOxX8EKaCbPlfyz7L5h/PVmP5vriMdGFZNLmaJ/awmiolxLtSPRG6MIGqJBx/boZbHkIngkygFj2OWXYj+9hAHQG/ujxueXazhZOIMPm1XHz+2Teon/zS7QM+cce4PJcQkmPs+AI8odxvnwKguCf9+v0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462967; c=relaxed/simple;
	bh=owvwV8QXKboasgsbxB61g8KsUCLgei8pMsmg+FRJ5NE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iFplbOJRZypR/kTZxYUsRMV++mFAfaT8STR9GLjuVjNcEXeN5A8yIxVuQNg5yPuytl128Ehkp6KESafNxapCEq8ARHh+l3OLTgkaxq4Ejppjwde9qmZizpfWzOFZCV+BZTNM9Q4wx1YQh+tWcOjgK51ra9mALQKahC4b6fVfwkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc49c.dip0.t-ipconnect.de [79.239.196.156])
	by mail.holtmann.org (Postfix) with ESMTPSA id 6300CCECC8;
	Tue, 30 Apr 2024 09:42:38 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: Raspberry Pi 5 and WPA3
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <91648487-9c59-40f9-996d-dfad1f1adcbb@gmail.com>
Date: Tue, 30 Apr 2024 09:42:27 +0200
Cc: Harry ten Berge <htenberge@gmail.com>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <38861D9C-F5F5-4149-99CD-0C59480986ED@holtmann.org>
References: <CAN+yObo7O+c7x51maXYxUiSttAC6ZJkuNb9DJwjCuegbAgyLow@mail.gmail.com>
 <91648487-9c59-40f9-996d-dfad1f1adcbb@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi James,

>> I'm not sure this is the right place to ask for some assistance, but
>> here we go...
>>=20
>> I'm the author for a small Raspberry Pi audio image that is
>> specifically targeting Roon.
>> If you're not familiair with Roon: it's an audio streaming platform
>> targeting audiophiles ;-)
>>=20
>> Anyways, about a year ago I switched from wpa_supplicant to iwd, to
>> full satisfaction.
>> Better and easier integration, and overall a feel of me being in more =
control.
>>=20
>> Now, recently I'm having issues with WPA3 support. This is partly
>> related to firmware (it's just so obfuscated how this all works with
>> firmware from broadcom and firmware from cypress :-(
>>=20
>> And one of those things is that I can't get it to work on the new Pi
>> 5. Specifically IWD reporting this:
>>=20
>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
>> Network is WPA3-Personal...
>> Apr 29 17:41:41 ropieee5 iwd[275]: SAE unsupported: brcmfmac needs
>> CMD_EXTERNAL_AUTH for SAE
>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
>> Can't use SAE, trying WPA2
>>=20
>> Now, the Pi guys point me to the missing CMD_EXTERNAL_AUTH message =
and
>> advise me to go back to wpa_supplicant. Which is not something I =
would
>> like to do for various reasons...
>>=20
>> Do you have any advice for me on what I can do? is this
>> CMD_EXTERNAL_AUTH really related to  this and are you planning on
>> implementing this?
>=20
> Unfortunately the external auth support is not yet implemented in IWD. =
The brcmfmac driver itself is rather unique being a fullmac driver. =
Depending on how you look at it, this on its own is "easier" to support. =
It handles connecting/roaming all on its own. But then, for some reason, =
someone didn't want to do SAE/WPA3 on the card itself so they came up =
with some one-off mechanism to offload that onto userspace. This is one =
of those things that got put upstream that is a pain for projects like =
IWD to support IMO. Its something we do need to support eventually, =
especially given the raspi 5 requires it.

if the Broadcom firmware finally would be able to support external_auth,
then it would be nice, but as seen on recent linux-wireless discussions,
it is unclear who does what. Broadcom wanted to support external_auth,
but then Infineon (the new owner) might be rather using SAE as part of
the firmware. And actually the chip on the RPi5 marks itself as Cypress
and so you it is an unclear story. I think that Raspberry Pi foundation
should get their story straight. Until really recently they shipped a
firmware that couldn=E2=80=99t do SAE and also their drivers couldn=E2=80=99=
t even do
external_auth and you were stuck with WPA2 only.

https://holtmann.dev/enabling-wpa3-on-raspberry-pi/

You can use an upstream firmware from linux-firmware and make the RPi5
support WPA3. And as of a few weeks ago, even RPi5 latest Debian was
switching to the upstream firmware.

On side note, there exists no wpa_supplicant release that really =
supports
SAE offload properly. You need to back port a lot of patches or hope
that your distro back ported them for you.

We should actually check if nl80211 tells us that external_auth is
supported by the driver. And if not (which is the case for the Broadcom
upstream driver) send a proper message to users and not lead them into
a wild goose chase.

Regards

Marcel

