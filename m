Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356821E412A
	for <iwd@lists.linux.dev>; Sat, 23 Aug 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960514; cv=none; b=mxurjg5sX1X1EvPjdYUWhpW5wFH5pcVMYui/h0CbqDjpHJt8DOB9UB3F27AHRmMd3r7WXFBFaLvhO6LimBmXUpsOzUZxdBZPz58m3/r0Q0XFSMGvd027qtWIZczLVVAOp7xDnGWBO8L/QXv0Z1cz9LctxJvNRz1y3FuKQ8seXPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960514; c=relaxed/simple;
	bh=1lXsgZSlMHeOU7hKGmHdMtinGxf7U2uuohU2AOTWct8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VVcxhH22XfwZsvLO/j0q8zTC8VbGVVrj66W9+zB8bE5ZtAfkQ7VeldEh4AVx1/tx7g8hwW4hBAOTJip3yvzyS00TxJUG/KcPmQAl47LlbaRoGSlc5+ADwdNtg2ebGbISwewXXPjpdrAaw5zFSkgdgKrbKVJA0fp54gdzlAZGNfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9f066.dip0.t-ipconnect.de [79.249.240.102])
	by mail.holtmann.org (Postfix) with ESMTPSA id D7214CECC5;
	Sat, 23 Aug 2025 16:48:30 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 13/15] station: check vendor quirk for BSS TM request
 candidate list
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20250822195118.271122-13-prestwoj@gmail.com>
Date: Sat, 23 Aug 2025 16:48:20 +0200
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <326D0476-1D08-4666-B820-EBAB74265608@holtmann.org>
References: <20250822195118.271122-1-prestwoj@gmail.com>
 <20250822195118.271122-13-prestwoj@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)

Hi James,

> If the AP vendor has known issues with the preferred candidate list
> ignore it and jump directly to requesting a neighbor report.
> ---
> src/station.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/station.c b/src/station.c
> index 4919f89e..3424964d 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -64,6 +64,7 @@
> #include "src/eap-tls-common.h"
> #include "src/storage.h"
> #include "src/pmksa.h"
> +#include "src/vendor_quirks.h"
>=20
> #define STATION_RECENT_NETWORK_LIMIT 5
> #define STATION_RECENT_FREQS_LIMIT 5
> @@ -3378,7 +3379,9 @@ static void station_ap_directed_roam(struct =
station *station,
> l_timeout_remove(station->roam_trigger_timeout);
> station->roam_trigger_timeout =3D NULL;
>=20
> - if (req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) {
> + if ((req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) &&
> + !(station->connected_bss->vendor_quirks &
> + VENDOR_QUIRK_BAD_BSS_TM_CANDIDATE_LIST)) {

this is unreadable in the long term. I would either add a variable or =
add a helper for the quirks.

As a side note, you might want to actually somewhere print the quirks =
which are active. Otherwise your debugging in the future will become a =
nightmare.

Regards

Marcel

