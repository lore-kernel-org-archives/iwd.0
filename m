Content-Type: multipart/mixed; boundary="===============1267325271290519006=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: segfault after upgrade to iwd 1.22
Date: Wed, 26 Jan 2022 12:20:20 -0600
Message-ID: <6e6dcd40-cafa-fd51-99d9-433e546bc7a3@gmail.com>
In-Reply-To: 20220126164203.dnqmd3kfcqbwthiv@pine.grzadka

--===============1267325271290519006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jan,

> I suppose hs being NULL is the reason.

This wasn't quite it, but something more subtle.  The following patch on th=
e =

list should fix it:

[PATCH] handshake: use _hs directly in handshake_event

Regards,
-Denis
--===============1267325271290519006==--

