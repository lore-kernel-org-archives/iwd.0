Received: from greymarch.letopolis.de (greymarch.letopolis.de [37.120.179.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1613914F6B
	for <iwd@lists.linux.dev>; Thu, 14 Sep 2023 18:46:11 +0000 (UTC)
Received: from [IPv6:2620:101:f000:741::ba1] (unknown [IPv6:2620:101:f000:741::ba1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(No client certificate requested)
	by greymarch.letopolis.de (Postfix) with ESMTPSA id D4F852401DE;
	Thu, 14 Sep 2023 20:46:09 +0200 (CEST)
Message-ID: <0d355152339b4e937910fb2440d1d3ace453514a.camel@grosse-sundrup.com>
Subject: Re: Force use of 5GHz band
From: Jonas =?ISO-8859-1?Q?Gro=DFe?= Sundrup <cherti-iwd@letopolis.de>
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Date: Thu, 14 Sep 2023 14:46:07 -0400
In-Reply-To: <e74c1a50-b5bf-48eb-a53e-100d9706e7f5@gmail.com>
References: 
	<cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
	 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
	 <d0b59d7ddf82006b6280e3b6652614d9ece09f7a.camel@grosse-sundrup.com>
	 <6aac9366-36fd-474d-882e-1bcc940fb444@gmail.com>
	 <ea23c922129d3c18c4affb0f0e4a737b7e2a03e5.camel@grosse-sundrup.com>
	 <e74c1a50-b5bf-48eb-a53e-100d9706e7f5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2023-09-14 at 11:33 -0700, James Prestwood wrote:
> A value of 1000 should definitely work... Are you sure the syntax is=20
> right inside main.conf:
>=20
> [Rank]
> BandModifier5Ghz=3D1000
>=20
> (I noticed in your original email you had the 'h' capitalized in
> 5Ghz)

Oh, no I didn't, it was GHz in my configfile, probably my brain typed
the spelling of the actual unit=E2=80=A6 thanks, I'm on 5GHz now! :)

(Feature Request: also accept "5GHz" as spelling, given that's the
correct unit spelling? =F0=9F=98=85)

Thanks so much!

Jonas
