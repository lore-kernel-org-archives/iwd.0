Content-Type: multipart/mixed; boundary="===============3565227102333686582=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 02/16] scan: Hide CCK rates if no_cck_rates set
Date: Thu, 31 Oct 2019 02:25:36 +0100
Message-ID: <CAOq732JY9sVoLx1a9V3GS1x+X8Q-S-8S05xNtjJt1zVs+3pO-g@mail.gmail.com>
In-Reply-To: <cc2d27cc-4251-b01e-9232-16bd80a23606@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3565227102333686582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 30 Oct 2019 at 17:17, Denis Kenzior <denkenz@gmail.com> wrote:
> On 10/28/19 9:04 AM, Andrew Zaborowski wrote:
> > no_cck_rates is set in the scan parameters generally to make sure
> > that the Probe Request frames are not sent at any of the 802.11b
> > rates during active scans.  With this patch we also omit those rates
> > from the Supported Rates IEs, which is required by the p2p spec and
> > also matches our flag's name.
> > ---
> >   src/scan.c | 35 ++++++++++++++++++++++++++++++++++-
> >   1 file changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/scan.c b/src/scan.c
> > index c0c3177e..0ec7831c 100644
> > --- a/src/scan.c
> > +++ b/src/scan.c
> > @@ -347,10 +347,43 @@ static struct l_genl_msg *scan_build_cmd(struct s=
can_context *sc,
> >       if (flags)
> >               l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, &=
flags);
> >
> > -     if (params->no_cck_rates)
> > +     if (params->no_cck_rates) {
> > +             static const uint8_t b_rates[] =3D { 2, 4, 11, 22 };
> > +             uint8_t *scan_rates;
> > +             const uint8_t *supported;
> > +             unsigned int num_supported;
> > +             unsigned int count;
> > +
> >               l_genl_msg_append_attr(msg, NL80211_ATTR_TX_NO_CCK_RATE, =
0,
> >                                       NULL);
> >
> > +             /*
> > +              * Assume if we're sending the probe requests at OFDM bit
> > +              * rates we don't want to advertise support for 802.11b r=
ates.
> > +              */
> > +             supported =3D wiphy_get_supported_rates(sc->wiphy,
> > +                                                     NL80211_BAND_2GHZ,
> > +                                                     &num_supported);
> > +             if (!supported) {
> > +                     L_WARN_ON(true);
>
> So I will nag you not to do this, its just not very useful.  You really
> want the warning to convey as much info as possible.  Getting a message
> like "Warning: condition true failed" is pretty useless.
>
> Also, L_WARN_ON can be used in an if statement, FYI.

Ok, that should also work.  In the end you'll need to look at the
stack trace though.

>
> > +                     return msg;
> > +             }
> > +
> > +             scan_rates =3D l_malloc(num_supported);
> > +
> > +             for (count =3D 0; *supported; supported++)
> > +                     if (!memchr(b_rates, *supported, L_ARRAY_SIZE(b_r=
ates)))
> > +                             scan_rates[count++] =3D *supported;
> > +
> > +             L_WARN_ON(!count);
> > +
> > +             l_genl_msg_enter_nested(msg, NL80211_ATTR_SCAN_SUPP_RATES=
);
> > +             l_genl_msg_append_attr(msg, NL80211_BAND_2GHZ, count,
> > +                                     scan_rates);
> > +             l_genl_msg_leave_nested(msg);
>
> Why are we bothering to send an empty attribute?

We aren't except if something's broken in our code.

>
> > +             l_free(scan_rates);
> > +     }
> > +
> >       return msg;
> >   }
> >
> >
>
> Anyhow, I made some mods to this commit and pushed it out.  Please review.

Thanks, this new version should also work.

Best regards
--===============3565227102333686582==--

