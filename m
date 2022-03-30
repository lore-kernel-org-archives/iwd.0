Content-Type: multipart/mixed; boundary="===============3005966298208506851=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/4] p2p: Fix Device Address updates from Probe Requests
Date: Wed, 30 Mar 2022 12:41:35 -0700
Message-ID: <76b7984ff1ad01ef3b09ac3abd67150a650deb59.camel@gmail.com>
In-Reply-To: 20220330173400.259961-1-andrew.zaborowski@intel.com

--===============3005966298208506851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, 2022-03-30 at 19:33 +0200, Andrew Zaborowski wrote:
> p2p_peer_update_existing may be called with a scan_bss struct built
> from
> a Probe Request frame so it can't access bss->p2p_probe_resp_info
> even
> if peer->bss was built from a Probe Response.=C2=A0 Check the source frame
> type of the scan_bss struct before updating the Device Address.
> =

> This fixes one timing issue that would make the autotest fail often.

So I'm still seeing test_3_go_go_neg_responder and
test_4_go_go_neg_initiator failing, but the other two pass now.

> ---
> =C2=A0src/p2p.c | 10 +++++++---
> =C2=A01 file changed, 7 insertions(+), 3 deletions(-)
> =

> diff --git a/src/p2p.c b/src/p2p.c
> index 4c90efb6..ebd0f62b 100644
> --- a/src/p2p.c
> +++ b/src/p2p.c
> @@ -3655,11 +3655,15 @@ static bool p2p_peer_update_existing(struct
> scan_bss *bss,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Some property changes =
may need to be notified here.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (peer->device_addr =3D=3D p=
eer->bss->addr)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0peer->device_addr =3D bss->addr;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (bss->source_frame =3D=3D S=
CAN_BSS_PROBE_RESP)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0peer->device_addr =3D
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bss=
->p2p_probe_resp_info-
> >device_info.device_addr;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (bss->source_frame =3D=
=3D SCAN_BSS_PROBE_REQ &&
> !l_memeqzero(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bss->p2p_=
probe_req_info-
> >device_info.device_addr, 6))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0peer->device_addr =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bss->p2p_=
probe_req_info-
> >device_info.device_addr;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0peer->device_addr =3D bss->addr;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scan_bss_free(peer->bss);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0peer->bss =3D bss;


--===============3005966298208506851==--

