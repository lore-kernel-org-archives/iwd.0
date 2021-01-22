Content-Type: multipart/mixed; boundary="===============0284124414736694663=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] build: add After=network-pre.target to service files
Date: Fri, 22 Jan 2021 15:06:24 +0100
Message-ID: <C01DE24A-0491-422F-8008-22EB6CCCB356@holtmann.org>
In-Reply-To: <20210122135558.588248-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0284124414736694663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

> systemd specifies a special passive target unit 'network-pre.target'
> which may be pulled in by services that want to run before any network
> interface is brought up or configured. Correspondingly, network
> management services such as iwd and ead should specify
> After=3Dnetwork-pre.target to ensure a proper ordering with respect to
> this special target.
> =

> For more information, see systemd.special(7) and [1].
> =

> [1] https://www.freedesktop.org/wiki/Software/systemd/NetworkTarget/

so what does this really do in practice. Both daemons are fully hotplug awa=
re and it makes no difference when they are started.

Regards

Marcel

--===============0284124414736694663==--

