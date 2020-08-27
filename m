Content-Type: multipart/mixed; boundary="===============6625057941309167192=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/11] wscutil: Add wsc_build_beacon
Date: Fri, 28 Aug 2020 01:18:22 +0200
Message-ID: <CAOq732KP+Zub=SAcCQPOB5zBiN96eh6hON4yPQvDQt__0GG70Q@mail.gmail.com>
In-Reply-To: <2927b86f-c1ef-82b4-efe0-ab0d8069b717@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6625057941309167192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Aug 2020 at 21:21, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Andrew,
>
> On 8/27/20 1:14 PM, Andrew Zaborowski wrote:
> > ---
> >   src/wscutil.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >   src/wscutil.h |  1 +
> >   2 files changed, 60 insertions(+)
> >
>
> <snip>
>
> > +
> > +     /* These two "should be provided" if dual-band */
> > +     if (beacon->rf_bands & (beacon->rf_bands - 1)) {
>
> I probably missed this in the earlier review, but would it be more clear =
to
> check rf_bands & ~WSC_RF_BAND_2_4_GHZ here instead?

That might be falsely triggered on a 5GHz-only AP.  I was gonna try
something like:

  (rf_bands & 2_4_AND_5_MASK) =3D=3D 2_4_AND_5_MASK

as the condition, but ended up copying this from
wsc_build_probe_response, I can change it in both places.
>
> > +             if (beacon->selected_registrar)
> > +                     build_uuid_e(builder, beacon->uuid_e);
> > +
> > +             build_rf_bands(builder, beacon->rf_bands);
> > +     }
> > +
> > +     if (!beacon->version2)
> > +             goto done;
> > +
> > +     START_WFA_VENDOR_EXTENSION();
> > +
> > +     if (!util_mem_is_zero(beacon->authorized_macs, 30)) {
> > +             int count;
> > +
> > +             for (count =3D 1; count < 5; count++)
> > +                     if (util_mem_is_zero(beacon->authorized_macs + co=
unt * 6,
> > +                                             30 - count * 6))
> > +                             break;
> > +
> > +             wsc_attr_builder_put_u8(builder,
> > +                                     WSC_WFA_EXTENSION_AUTHORIZED_MACS=
);
> > +             wsc_attr_builder_put_u8(builder, count * 6);
> > +             wsc_attr_builder_put_bytes(builder, beacon->authorized_ma=
cs,
> > +                                             count * 6);
> > +     }
>
> I'm guilty of copy-pasting as much as anyone, but could we make a utility=
 for
> this?  Also, wouldn't it make more sense to run util_mem_is_zero backward=
s 6
> bytes at a time instead of pounding the array 6 times?

Oops, I didn't realize the code was doing this.  I think elsewhere we
were assuming the first 6-zeros address in the array was the end of
the array, maybe it's enough here as well.

Best regards
--===============6625057941309167192==--

