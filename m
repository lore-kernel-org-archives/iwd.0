Content-Type: multipart/mixed; boundary="===============1932455815482083561=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 6/9] ft: get OCI prior to reassociation
Date: Mon, 27 Sep 2021 11:15:10 -0700
Message-ID: <54642fd79da805a3ed3b0c90f85b905b0469d536.camel@gmail.com>
In-Reply-To: 8cf91f8d-cf64-08e8-3e14-656f6f70e07a@gmail.com

--===============1932455815482083561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2021-09-27 at 12:55 -0500, Denis Kenzior wrote:
> Hi James,
> =

> On 9/27/21 12:04 PM, James Prestwood wrote:
> > This modifies the FT logic to fist call get_oci() before
> > reassociation. This allows the OCI to be included in reassociation
> > and in the 4-way handshake later on.
> > ---
> > =C2=A0 src/ft.c=C2=A0=C2=A0=C2=A0=C2=A0 | 13 ++++++++++++-
> > =C2=A0 src/ft.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A0 src/netdev.c | 20 +++++++++++++++++++-
> > =C2=A0 3 files changed, 33 insertions(+), 2 deletions(-)
> > =

> =

> <snip>
> =

> > @@ -2074,6 +2074,21 @@ static void netdev_get_oci_cb(struct
> > l_genl_msg *msg, void *user_data)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0handshake_state_set_cha=
ndef(netdev->handshake,
> > l_steal_ptr(chandef));
> > =C2=A0 =

> > =C2=A0 done:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (netdev->ap) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * Cant do much here. IWD assumes every
> > kernel/driver supports
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * this. There is no way of detecting support
> > either.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (L_WARN_ON(err < 0))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netdev=
_connect_failed(netdev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0NETDEV_RESULT_AUTHENTICATIO
> > N_FAILED,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0MMPDU_STATUS_CODE_UNSPECIFI
> > ED);
> =

> You could just let the other side reject our Association or reset
> ocvc, but okay.
> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0auth_p=
roto_rx_oci(netdev->ap);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0L_WARN_ON(!eapol_start(=
netdev->sm));
> > =C2=A0 }
> > =C2=A0 =

> =

> Otherwise looks fine.=C2=A0 Not sure if this patch requires changes due to
> comments =

> in patch 7.

I'll make sure. Also, I realized we will be getting the OCI again after
FT succeeds so I need to change up some logic a bit so we only get OCI
when its not already updated. I also have FILS changes locally which
suffer the same problem.



> =

> Regards,
> -Denis


--===============1932455815482083561==--

