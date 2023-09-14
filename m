Received: from greymarch.letopolis.de (greymarch.letopolis.de [37.120.179.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D731A10A2F
	for <iwd@lists.linux.dev>; Thu, 14 Sep 2023 17:54:04 +0000 (UTC)
Received: from [IPv6:2620:101:f000:3402::539] (unknown [IPv6:2620:101:f000:3402::539])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(No client certificate requested)
	by greymarch.letopolis.de (Postfix) with ESMTPSA id C61A3240092
	for <iwd@lists.linux.dev>; Thu, 14 Sep 2023 19:44:47 +0200 (CEST)
Message-ID: <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
Subject: Force use of 5GHz band
From: Jonas =?ISO-8859-1?Q?Gro=DFe?= Sundrup <cherti-iwd@letopolis.de>
To: iwd@lists.linux.dev
Date: Thu, 14 Sep 2023 13:44:46 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi,

is there a way to force iwd to use the 5GHz flavor of a specific wifi?
I am aware of BandModifier5GHz, but even with setting this to 1000 I
still end up on the 2.5GHz band. That band specifically, however, is
unfortunately suspect for some stability issues I'm facing and hence I
would like to force iwd onto the 5GHz band to see if the problems still
occur. That proves to be difficult, of course, if iwd is picking the
2.5GHz band=E2=80=A6

Even though I do see that iwd probably has the better insight into band
stability from a signal-strength point of view, any chance of
overruling iwd's internal mechanisms here? (Or should I just crank up
BandModifier5GHz by a couple of magnitudes?)


Thanks,
Jonas
