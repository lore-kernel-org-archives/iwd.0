Content-Type: multipart/mixed; boundary="===============7879468433866194330=="
MIME-Version: 1.0
From: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
Subject: RE: Problems attempting to use ad-hoc mode, link state remains dormant
Date: Wed, 08 Apr 2020 16:46:25 +0000
Message-ID: <
 <VI1PR01MB516732A2E162CF4C56456C1B88C00@VI1PR01MB5167.eurprd01.prod.exchangelabs.com>>
In-Reply-To: <77aeba33-e3aa-58ca-cd3e-1dd0916753dc@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7879468433866194330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
> Hi Diego,
> =

> > However, I have another device with an Atheros QCA6174 (ath10k_pci
> driver) and if I put it into ap mode no other station sees it (Windows la=
ptop,
> Linux laptop, iPhone). Do you know if there is anything special to do to =
use ap
> mode on these devices?
> >
> =

> I'm not aware of any, but admittedly we're not actively focused on AP
> mode at the moment, so it is a 'less developed' area of the iwd codebase.

OK, got it. I actually just tried out using hostapd instead and it works ni=
cely with the above wireless card, I could successfully connect from my iPh=
one (open, no auth).

BTW, could you share what is the status of the wired 802.1x support? Is it =
something that can be relied upon?
 =

Best,
Diego

-- =

Diego Santa Cruz, PhD
Technology Architect
spinetix.com



--===============7879468433866194330==--

