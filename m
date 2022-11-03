Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CC363A0
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 18:24:08 +0000 (UTC)
Received: from smtpclient.apple (p5b3d21f3.dip0.t-ipconnect.de [91.61.33.243])
	by mail.holtmann.org (Postfix) with ESMTPSA id E2586CECDF;
	Thu,  3 Nov 2022 19:17:05 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 1/4] doc: document AP properties
 PairwiseCiphers/GroupCipher
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20221103173057.381232-1-prestwoj@gmail.com>
Date: Thu, 3 Nov 2022 19:17:05 +0100
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <C39B9D23-000E-44A9-AFFC-3805CECAE5C9@holtmann.org>
References: <20221103173057.381232-1-prestwoj@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)

Hi James,

> ---
> doc/access-point-api.txt | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>=20
> diff --git a/doc/access-point-api.txt b/doc/access-point-api.txt
> index 63e61d49..28e6437d 100644
> --- a/doc/access-point-api.txt
> +++ b/doc/access-point-api.txt
> @@ -71,3 +71,16 @@ Properties	boolean Started [readonly]
> 		uint32 Frequency [readonly, optional]
>=20
> 			The frequency that the Access Point is operating =
on.
> +
> +		string PairwiseCiphers [readonly, optional]
> +
> +			Comma separated list of pairwise ciphers the =
access
> +			point supports. The same format as setting a =
list of
> +			ciphers for an AP  profile, i.e. TKIP, CCMP-128,
> +			GCMP-128, CCMP-256, GCMP-256 etc.

why not array{string} since that makes it a cleaner from an API point of =
view.

Regards

Marcel

