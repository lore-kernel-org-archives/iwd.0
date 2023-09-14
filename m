Received: from greymarch.letopolis.de (greymarch.letopolis.de [37.120.179.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B95FBE7
	for <iwd@lists.linux.dev>; Thu, 14 Sep 2023 18:22:44 +0000 (UTC)
Received: from [IPv6:2620:101:f000:741::18b6] (unknown [IPv6:2620:101:f000:741::18b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(No client certificate requested)
	by greymarch.letopolis.de (Postfix) with ESMTPSA id 5678B240092;
	Thu, 14 Sep 2023 20:22:42 +0200 (CEST)
Message-ID: <ea23c922129d3c18c4affb0f0e4a737b7e2a03e5.camel@grosse-sundrup.com>
Subject: Re: Force use of 5GHz band
From: Jonas =?ISO-8859-1?Q?Gro=DFe?= Sundrup <cherti-iwd@letopolis.de>
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Date: Thu, 14 Sep 2023 14:22:40 -0400
In-Reply-To: <6aac9366-36fd-474d-882e-1bcc940fb444@gmail.com>
References: 
	<cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
	 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
	 <d0b59d7ddf82006b6280e3b6652614d9ece09f7a.camel@grosse-sundrup.com>
	 <6aac9366-36fd-474d-882e-1bcc940fb444@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2023-09-14 at 11:16 -0700, James Prestwood wrote:
> Yep that would do it.

automatically quick scan upon start: https://p.nnev.de/12646

explicit scan triggered via "station wifi scan":
https://p.nnev.de/12647

anything insightful in there?


Thanks,
Jonas
