Content-Type: multipart/mixed; boundary="===============4020743058426966898=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 8/9] sae: don't send commit in confirmed state
Date: Wed, 08 Sep 2021 09:40:13 -0700
Message-ID: <4d186fbdb3c2f4407cbe20c9ac609cd75d93bde3.camel@gmail.com>
In-Reply-To: <8cdacee8-07ca-1451-55ca-0c24656d8a1c@molgen.mpg.de>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4020743058426966898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paul,

> > =

> > Do non-hostapd setups even exist? :) But in reality no it shouldn't
> > effect anything. I do need to amend this commit slightly, but v2
> > will
> > have identical behavior as wpa_supplicant, i.e. ignore the commit
> > message completely.
> =

> Great, it=E2=80=99d be great if you mentioned that.
> =

> Also, from the other thread *Re: Cannot connect to SAE protected AP
> with =

> iwd 1.16 and beyond*, if the ell commit really introduced the =

> regression, it=E2=80=99d be great if you mentioned that too.

So we actually had two separate problems here:

First was some APs don't properly do SAE group negotiation. The ELL
change, while not a bug, changed the default group to 20 which 802.11
does not mandate support for (but it is more secure). In this case the
SAE protocol negotiates the group but as mentioned these APs end up
failing the connection. This was worked around in an earlier commit by
detecting these problem APs and forcing group 19 from the beginning.

The second problem was one addressed in this patche where the AP
receives an unexpected commit message and fails the connection rather
than dropping the message.

In any case, I will add a bit more context to the commit message.

Thanks,
James

> =

> =

> Kind regards,
> =

> Paul


--===============4020743058426966898==--

