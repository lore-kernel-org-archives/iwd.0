Content-Type: multipart/mixed; boundary="===============3021556928123586708=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 03/16] scan: Parse P2P IEs according to frame type
Date: Thu, 31 Oct 2019 02:45:13 +0100
Message-ID: <CAOq732+brTG+jONHNXtQm4v0_WZM1zKpoT1PZZYfdzXsNVAg0g@mail.gmail.com>
In-Reply-To: <4e835814-0283-2e3a-5c89-fc3180fe46df@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3021556928123586708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Oct 2019 at 17:52, Denis Kenzior <denkenz@gmail.com> wrote:
> On 10/28/19 9:04 AM, Andrew Zaborowski wrote:
> > Save the source frame type in struct scan_bss as it may affect how some
> > of the data in the struct should be parsed.  Also replace the P2P IE
> > payload data in that struct with a union containing pre-parsed p2p
> > attributes corresponding to the frame type.
> >
> > This means users don't have to call the parsers in p2putil.c on that
> > data, which wouldn't have worked anyway because we those parsers were
>
> This sentence doesn't parse

Oops, will fix.

>
> > assuming the raw concatenated P2P IEs as a parameter instead of the
> > payload extracted with ie_tlv_extract_p2p_payload.
> > ---
> >   src/scan.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++-------
> >   src/scan.h | 17 ++++++++++--
> >   2 files changed, 84 insertions(+), 12 deletions(-)
> >
> > diff --git a/src/scan.c b/src/scan.c
> > index 0ec7831c..0956c6f6 100644
> > --- a/src/scan.c
> > +++ b/src/scan.c
> > @@ -45,6 +45,7 @@
> >   #include "src/nl80211cmd.h"
> >   #include "src/nl80211util.h"
> >   #include "src/util.h"
> > +#include "src/p2putil.h"
> >   #include "src/scan.h"
> >
> >   #define SCAN_MAX_INTERVAL 320
> > @@ -987,6 +988,38 @@ static bool scan_parse_bss_information_elements(st=
ruct scan_bss *bss,
> >               }
> >       }
> >
> > +     bss->wsc =3D ie_tlv_extract_wsc_payload(data, len, &bss->wsc_size=
);
> > +
> > +     switch (bss->source_frame) {
> > +     case SCAN_BSS_PROBE_RESP:
> > +     {
> > +             struct p2p_probe_resp info;
> > +
> > +             if (p2p_parse_probe_resp(data, len, &info) =3D=3D 0)
> > +                     bss->p2p_probe_resp_info =3D l_memdup(&info, size=
of(info));
>
> So I don't like this l_memdup at all.  There has to be a better way.

The other way is to alloc memory at bss->p2p_probe_resp_info and
l_free it on error, let me do that instead.

>
> Also, how is it that you're passing data and len directly to
> p2p_parse_probe_resp?  Are these not wrapped in IEs somehow?

Yes, but the p2p_parse_* functions expect that wrapped data actually,
and will unwrap internally.

>
> > +
> > +             break;
> > +     }
> > +     case SCAN_BSS_PROBE_REQ:
>
> How do you even get here? And why should scan.c even care?  I think
> you're hacking stuff together here.  I doubt this belongs on the scan
> API at all.

We get here through the scan_bss_new_from_probe_req call I submitted
before.  This is called from outside of scan.c, in p2p.c, so you could
argue it doesn't belong here but actually what p2p.c is doing is
technically scanning, too.

There's also so much common code that it would just be annoying to not
re-use it... or to have to split it into a separate common file.

>
> > +     {
> > +             struct p2p_probe_req info;
> > +
> > +             if (p2p_parse_probe_req(data, len, &info) =3D=3D 0)
> > +                     bss->p2p_probe_req_info =3D l_memdup(&info, sizeo=
f(info));
> > +
> > +             break;
> > +     }
> > +     case SCAN_BSS_BEACON:
> > +     {
> > +             struct p2p_beacon info;
> > +
> > +             if (p2p_parse_beacon(data, len, &info) =3D=3D 0)
> > +                     bss->p2p_beacon_info =3D l_memdup(&info, sizeof(i=
nfo));
> > +
> > +             break;
> > +     }
> > +     }
> > +
> >       return have_ssid;
> >   }
> >
> > @@ -995,9 +1028,12 @@ static struct scan_bss *scan_parse_attr_bss(struc=
t l_genl_attr *attr)
> >       uint16_t type, len;
> >       const void *data;
> >       struct scan_bss *bss;
> > +     const uint8_t *ies =3D NULL;
> > +     size_t ies_len;
> >
> >       bss =3D l_new(struct scan_bss, 1);
> >       bss->utilization =3D 127;
> > +     bss->source_frame =3D SCAN_BSS_BEACON;
>
> So I don't think it is that simple.  Looks like the kernel guys really
> made a mess here.  We need to be looking at NL80211_BSS_BEACON_IES as
> well and applying 'heuristics' if the PRESP_DATA attribute isn't present.

I'll try to make sure I understand exactly how this works and add an
explanation in a comment somewhere.

>
> >
> >       while (l_genl_attr_next(attr, &type, &len, &data)) {
> >               switch (type) {
> > @@ -1025,20 +1061,19 @@ static struct scan_bss *scan_parse_attr_bss(str=
uct l_genl_attr *attr)
> >
> >                       bss->signal_strength =3D *((int32_t *) data);
> >                       break;
> > +             case NL80211_BSS_PRESP_DATA:
> > +                     bss->source_frame =3D SCAN_BSS_PROBE_RESP;
> > +                     break;
> >               case NL80211_BSS_INFORMATION_ELEMENTS:
> > -                     if (!scan_parse_bss_information_elements(bss,
> > -                                                             data, len=
))
> > -                             goto fail;
> > -
> > -                     bss->wsc =3D ie_tlv_extract_wsc_payload(data, len,
> > -                                                             &bss->wsc=
_size);
> > -                     bss->p2p =3D ie_tlv_extract_p2p_payload(data, len,
> > -                                                             &bss->p2p=
_size);
> > -
> > +                     ies =3D data;
> > +                     ies_len =3D len;
> >                       break;
> >               }
> >       }
> >
> > +     if (ies && !scan_parse_bss_information_elements(bss, ies, ies_len=
))
> > +             goto fail;
> > +
> >       return bss;
> >
> >   fail:
> > @@ -1198,9 +1233,33 @@ void scan_bss_free(struct scan_bss *bss)
> >       l_free(bss->rsne);
> >       l_free(bss->wpa);
> >       l_free(bss->wsc);
> > -     l_free(bss->p2p);
> >       l_free(bss->osen);
> >       l_free(bss->rc_ie);
> > +
> > +     switch (bss->source_frame) {
> > +     case SCAN_BSS_PROBE_RESP:
> > +             if (!bss->p2p_probe_resp_info)
> > +                     break;
> > +
> > +             p2p_free_probe_resp(bss->p2p_probe_resp_info);
> > +             l_free(bss->p2p_probe_resp_info);
> > +             break;
> > +     case SCAN_BSS_PROBE_REQ:
> > +             if (!bss->p2p_probe_req_info)
> > +                     break;
> > +
> > +             p2p_free_probe_req(bss->p2p_probe_req_info);
> > +             l_free(bss->p2p_probe_req_info);
>
> The naming needs some work.  Whenever I see _free in the name I assume
> it calls l_free on the passed in structure.  But here you have to free
> the structure separately.  And the _free should really be last per our
> naming conventions.

How about _clear_?  I'd rather keep it in the middle of the name to be
consistent with the _parse_ and _build_ function names, but I'll move
it to the end if you really prefer.

>
> > +             break;
> > +     case SCAN_BSS_BEACON:
> > +             if (!bss->p2p_beacon_info)
> > +                     break;
> > +
> > +             p2p_free_beacon(bss->p2p_beacon_info);
> > +             l_free(bss->p2p_beacon_info);
> > +             break;
> > +     }
> > +
> >       l_free(bss);
> >   }
> >
> > diff --git a/src/scan.h b/src/scan.h
> > index 626de80b..afed831e 100644
> > --- a/src/scan.h
> > +++ b/src/scan.h
> > @@ -40,6 +40,15 @@ typedef void (*scan_freq_set_func_t)(uint32_t freq, =
void *userdata);
> >
> >   struct scan_freq_set;
> >   struct ie_rsn_info;
> > +struct p2p_probe_resp;
> > +struct p2p_probe_req;
> > +struct p2p_beacon;
> > +
> > +enum scan_bss_frame_type {
> > +     SCAN_BSS_PROBE_RESP,
> > +     SCAN_BSS_PROBE_REQ,
> > +     SCAN_BSS_BEACON,
> > +};
> >
> >   struct scan_bss {
> >       uint8_t addr[6];
> > @@ -51,8 +60,12 @@ struct scan_bss {
> >       uint8_t *osen;
> >       uint8_t *wsc;           /* Concatenated WSC IEs */
> >       ssize_t wsc_size;       /* Size of Concatenated WSC IEs */
> > -     uint8_t *p2p;           /* Concatenated P2P IEs */
> > -     ssize_t p2p_size;       /* Size of Concatenated P2P IEs */
> > +     enum scan_bss_frame_type source_frame;
> > +     union {
> > +             struct p2p_probe_resp *p2p_probe_resp_info;
> > +             struct p2p_probe_req *p2p_probe_req_info;
> > +             struct p2p_beacon *p2p_beacon_info;
> > +     };
>
> a union of 3 pointers is rather pointless, no? :)

Only if you think non-void pointers are pointless ;)  But, we could do
void * if you want.

Best regards
--===============3021556928123586708==--

