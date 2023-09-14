Received: from greymarch.letopolis.de (greymarch.letopolis.de [37.120.179.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715818E1B
	for <iwd@lists.linux.dev>; Thu, 14 Sep 2023 18:13:29 +0000 (UTC)
Received: from [IPv6:2620:101:f000:741::15a] (unknown [IPv6:2620:101:f000:741::15a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(No client certificate requested)
	by greymarch.letopolis.de (Postfix) with ESMTPSA id 804112401DE;
	Thu, 14 Sep 2023 20:13:27 +0200 (CEST)
Message-ID: <d0b59d7ddf82006b6280e3b6652614d9ece09f7a.camel@grosse-sundrup.com>
Subject: Re: Force use of 5GHz band
From: Jonas =?ISO-8859-1?Q?Gro=DFe?= Sundrup <cherti-iwd@letopolis.de>
To: James Prestwood <prestwoj@gmail.com>, Jonas =?ISO-8859-1?Q?Gro=DFe?=
	Sundrup <cherti-iwd@letopolis.de>, iwd@lists.linux.dev
Date: Thu, 14 Sep 2023 14:13:25 -0400
In-Reply-To: <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
References: 
	<cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
	 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Not right now, but if you give me a command that'd spit out what you
want to see, I'll get them.

Just iwd -d and then trigger a scan in iwctl?

On Thu, 2023-09-14 at 11:06 -0700, James Prestwood wrote:
> Hi Jonas,
>=20
> On 9/14/23 10:44 AM, Jonas Gro=C3=9Fe Sundrup wrote:
> > Hi,
> >=20
> > is there a way to force iwd to use the 5GHz flavor of a specific
> > wifi?
> > I am aware of BandModifier5GHz, but even with setting this to 1000
> > I
> > still end up on the 2.5GHz band. That band specifically, however,
> > is
> > unfortunately suspect for some stability issues I'm facing and
> > hence I
> > would like to force iwd onto the 5GHz band to see if the problems
> > still
> > occur. That proves to be difficult, of course, if iwd is picking
> > the
> > 2.5GHz band=E2=80=A6
> >=20
> > Even though I do see that iwd probably has the better insight into
> > band
> > stability from a signal-strength point of view, any chance of
> > overruling iwd's internal mechanisms here? (Or should I just crank
> > up
> > BandModifier5GHz by a couple of magnitudes?)
>=20
> All we have now is BandModifier5GHz which is multiplied by the
> computed=20
> rank. The stock rank is based mainly on a data rate computation which
> is=20
> theoretical, but uses capabilities and signal strength to estimate.
>=20
> 1000 is pretty high, so essentially your 2.4GHz BSS's would need to
> have=20
> a rank 1000x larger than the 5Ghz ones. So either 5ghz is incredibly
> low=20
> signal, doesn't support HT/VHT, or maybe the IEs are malformed so the
> data rate isn't being computed correctly e.g. (defaulting to basic
> rates).
>=20
> Do you have debug logs of the scan results?
>=20
> >=20
> >=20
> > Thanks,
> > Jonas
> >=20

