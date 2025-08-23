Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A963259CB6
	for <iwd@lists.linux.dev>; Sat, 23 Aug 2025 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960634; cv=none; b=Z+082glTpGIsXbuFF1rXrqGafPO0hj02xChcD84IlUCdb9YoD5hpcZRhhmztrS4rWq8Ol/pE9Gq7lZ8iclnhHn126z/dafnAmxSoBc+YJX4ypEAYm4HtX+ydWnJ/wGYfjlzixQNcT8r5/a6nSoImx+uIST+OGtmnLM6YTyrx67E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960634; c=relaxed/simple;
	bh=8OT5mC+ahmC04AJnGJAb/C3QsZEI/9xXJ3PsAKiq48c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gt10x36BtCWn3Wv5yQkKnxpWDXsCmgOh+ekxXBqVeZcBuJ8muDrKD6CbtbY6DhDz8R2kdY45okE+y+bnDdtMvlyT7awJXmH+ky8FPPO29HlRO5C64ZNpe8TVfYRL8dTYAw98fLxDD9v+O7ZMxMzEg8i0JKnrF5vMhBXagedshUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9f066.dip0.t-ipconnect.de [79.249.240.102])
	by mail.holtmann.org (Postfix) with ESMTPSA id 4B749CECC3;
	Sat, 23 Aug 2025 16:43:55 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 05/15] vendor_quirks: initial skeleton
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20250822195118.271122-5-prestwoj@gmail.com>
Date: Sat, 23 Aug 2025 16:43:44 +0200
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <DED368F0-5FD4-4360-9C55-37D405566887@holtmann.org>
References: <20250822195118.271122-1-prestwoj@gmail.com>
 <20250822195118.271122-5-prestwoj@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)

Hi James,

> This module will provide a database for known issues or quirks with
> wireless vendors. For now the list of quirks is limited to 32 as
> that is the size returned in the bit mask. This could be extended
> to 64 in the future if needed, but of course the goal is to never
> reach that level.
>=20
> The vendor_quirks() API is intended to be called from scan.c when
> parsing vendor attributes. This will lookup any quirks associated
> with the OUI provided and a mask of quirks will be returned. This
> can be repeated against all the vendor OUI's seen in the scan. The
> result is then a bitmask containing all quirks for that BSS. This
> can then be referenced later during various operations in IWD.
> ---
> Makefile.am         |  2 ++
> src/vendor_quirks.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
> src/vendor_quirks.h | 25 +++++++++++++++++++++
> 3 files changed, 80 insertions(+)
> create mode 100644 src/vendor_quirks.c
> create mode 100644 src/vendor_quirks.h
>=20
> diff --git a/Makefile.am b/Makefile.am
> index 92adfa6e..c01cd4c4 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -274,6 +274,8 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h =
src/iwd.h \
> src/dpp.c \
> src/udev.c \
> src/pmksa.h src/pmksa.c \
> + src/vendor_quirks.h \
> + src/vendor_quirks.c \
> $(eap_sources) \
> $(builtin_sources)
>=20
> diff --git a/src/vendor_quirks.c b/src/vendor_quirks.c
> new file mode 100644
> index 00000000..ccfcb444
> --- /dev/null
> +++ b/src/vendor_quirks.c
> @@ -0,0 +1,53 @@
> +/*
> + *
> + *  Wireless daemon for Linux
> + *
> + *  Copyright (C) 2025  Locus Robotics Corporation. All rights =
reserved.
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later =
version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free =
Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <string.h>
> +
> +#include <ell/ell.h>
> +
> +#include "src/vendor_quirks.h"
> +
> +static const struct {
> + uint8_t oui[3];
> + uint32_t quirks;
> +} quirk_db[] =3D {
> + { }
> +};
> +
> +uint32_t vendor_quirks(const uint8_t *oui)
> +{
> + size_t i;
> + uint32_t ret =3D 0;
> +
> + for (i =3D 0; i < L_ARRAY_SIZE(quirk_db); i++) {
> + if (memcmp(quirk_db[i].oui, oui, 3))
> + continue;
> +
> + ret |=3D quirk_db[i].quirks;
> + }

if you are using an empty {} entry to signal end of the array, then it =
makes no sense to also use L_ARRAY_SIZE.

Regards

Marcel

