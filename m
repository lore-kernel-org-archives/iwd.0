Content-Type: multipart/mixed; boundary="===============2806034357714379474=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC/PATCH] Install iwd and ead into $sbindir rather than
 $libexecdir.
Date: Fri, 06 Mar 2020 19:36:26 +0100
Message-ID: <4B8F296A-4E34-471A-B2E2-30B5B7808431@holtmann.org>
In-Reply-To: <20200218113427.25752-1-anton@khirnov.net>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2806034357714379474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anton,

> $libexecdir is supposed to contain "internal" binaries that are not
> supposed to be executed "from the outside", e.g. directly by users.
> Since iwd is a normal daemon that is directly executed from the outside,
> $sbindir is the appropriate place for it.

how is iwd executed directly by a user? It is only executed as a service. I=
t doesn=E2=80=99t belong in sbin either and the difference between sbin and=
 bin have been removed, because they are not really exit anymore on modern =
Linux distributions.

Regards

Marcel

--===============2806034357714379474==--

