Content-Type: multipart/mixed; boundary="===============0787982533959237487=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 4/7] scan: add support for scanning on AP interface type
Date: Thu, 24 Feb 2022 08:44:32 -0800
Message-ID: <794f20cc8d50a155f3d7623f67824d5f2f476f33.camel@gmail.com>
In-Reply-To: 0ea0a29c-edeb-b240-5c4c-98d69b555319@gmail.com

--===============0787982533959237487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 2022-02-23 at 12:50 -0600, Denis Kenzior wrote:
> Hi James,
> =

> On 2/22/22 16:57, James Prestwood wrote:
> > This adds a new flag, force_ap to the scan parameters. When enabled
> > this will set NL80211_SCAN_FLAG_AP.
> > ---
> > =C2=A0 src/scan.c | 4 ++++
> > =C2=A0 src/scan.h | 1 +
> > =C2=A0 2 files changed, 5 insertions(+)
> > =

> > diff --git a/src/scan.c b/src/scan.c
> > index 12b7a3fd..01056634 100644
> > --- a/src/scan.c
> > +++ b/src/scan.c
> > @@ -391,6 +391,10 @@ static struct l_genl_msg
> > *scan_build_cmd(struct scan_context *sc,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0NL80211_EXT_FEATURE_SCAN_RA
> > NDOM_SN))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0flags |=3D NL80211_SCAN_FLAG_RANDOM_SN;
> > =C2=A0 =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (params->force_ap && wiph=
y_has_feature(sc->wiphy,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NL80211_FEAT=
URE_AP_
> > SCAN))
> =

> You already check this in patch 5 ap_dbus_scan()?

With this newfound knowledge that brcmfmac doesn't advertise this
feature I think we do still want this here. I did test on brcmfmac
without this check and it accepted the scan request still but I think
it would be safer to keep it.

> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0flags |=3D NL80211_SCAN_FLAG_AP;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0l_genl_msg_append_attr(msg,
> > NL80211_ATTR_SCAN_FLAGS, 4, &flags);
> > =C2=A0 =

> > diff --git a/src/scan.h b/src/scan.h
> > index 2c401df6..7ad50e5d 100644
> > --- a/src/scan.h
> > +++ b/src/scan.h
> > @@ -98,6 +98,7 @@ struct scan_parameters {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool randomize_mac_addr=
_hint : 1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool no_cck_rates : 1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool duration_mandatory=
 : 1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool force_ap : 1;
> =

> force_ap_scan? or simply ap_scan?
> =

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const uint8_t *ssid;=C2=
=A0=C2=A0=C2=A0=C2=A0/* Used for direct probe request */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t ssid_len;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const uint8_t *source_m=
ac;
> > =

> =

> Regards,
> -Denis


--===============0787982533959237487==--

