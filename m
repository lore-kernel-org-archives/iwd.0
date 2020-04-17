Content-Type: multipart/mixed; boundary="===============5264587194348289987=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 04/17] p2p: Add peer WSC device type properties
Date: Fri, 17 Apr 2020 22:55:37 +0200
Message-ID: <CAOq732JxJbN61vvJDnrOc2aUVJZb_uF5i=hY4UT3uWcPFsH_Qw@mail.gmail.com>
In-Reply-To: <fb807c29-1ed8-2df7-c6de-7ffd2181cd83@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5264587194348289987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 17 Apr 2020 at 21:33, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Andrew,
>
> On 4/3/20 11:14 AM, Andrew Zaborowski wrote:
> > ---
> >   src/p2p.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 208 insertions(+)
> >
> > diff --git a/src/p2p.c b/src/p2p.c
> > index 957482eb..49111a98 100644
> > --- a/src/p2p.c
> > +++ b/src/p2p.c
> > @@ -68,10 +68,156 @@ struct p2p_peer {
> >       struct scan_bss *bss;
> >       struct p2p_device *dev;
> >       char *name;
> > +     struct wsc_primary_device_type primary_device_type;
> >   };
> >
> >   static struct l_queue *p2p_device_list;
> >
> > +struct device_type_category_info {
> > +     char *category_str;
>
> const char?

Ok, makes sense.

>
> > +     unsigned int subcategory_max;
> > +     char **subcategory_str;
>
> const char **?

Same here.


>
> > +};
> > +
> > +/* Wi-Fi Simple Configuration Technical Specification v2.0.5 Table 41 =
*/
> > +struct device_type_category_info device_type_categories[] =3D {
> > +     [1] =3D {
> > +             "Computer",
> > +             10,
> > +             (char *[]) {
> > +                     [1] =3D "PC",
> > +                     [2] =3D "Server",
> > +                     [3] =3D "Media Center",
> > +                     [4] =3D "Ultra-mobile PC",
> > +                     [5] =3D "Notebook",
> > +                     [6] =3D "Desktop",
> > +                     [7] =3D "Mobile Internet Device",
> > +                     [8] =3D "Netbook",
> > +                     [9] =3D "Tablet",
> > +                     [10] =3D "Ultrabook",
> > +             },
> > +     },
> > +     [2] =3D {
> > +             "Input Device",
> > +             9,
> > +             (char *[]) {
> > +                     [1] =3D "Keyboard",
> > +                     [2] =3D "Mouse",
> > +                     [3] =3D "Joystick",
> > +                     [4] =3D "Trackball",
> > +                     [5] =3D "Gaming controller",
> > +                     [6] =3D "Remote",
> > +                     [7] =3D "Touchscreen",
> > +                     [8] =3D "Biometric reader",
> > +                     [9] =3D "Barcode reader",
> > +             },
> > +     },
> > +     [3] =3D {
> > +             "Printer or Scanner",
> > +             5,
> > +             (char *[]) {
> > +                     [1] =3D "Printer/Print Server",
> > +                     [2] =3D "Scanner",
> > +                     [3] =3D "Fax",
> > +                     [4] =3D "Copier",
> > +                     [5] =3D "All-in-one printer, scanner, fax, copier=
",
> > +             },
> > +     },
> > +     [4] =3D {
> > +             "Camera",
> > +             4,
> > +             (char *[]) {
> > +                     [1] =3D "Digital Still Camera",
> > +                     [2] =3D "Video Camera",
> > +                     [3] =3D "Web Camera",
> > +                     [4] =3D "Security Camera",
> > +             },
> > +     },
> > +     [5] =3D {
> > +             "Storage",
> > +             1,
> > +             (char *[]) {
> > +                     [1] =3D "NAS",
> > +             },
> > +     },
> > +     [6] =3D {
> > +             "Network Infrastructure",
> > +             5,
> > +             (char *[]) {
> > +                     [1] =3D "AP",
> > +                     [2] =3D "Router",
> > +                     [3] =3D "Switch",
> > +                     [4] =3D "Gateway",
> > +                     [5] =3D "Bridge",
> > +             },
> > +     },
> > +     [7] =3D {
> > +             "Display",
> > +             4,
> > +             (char *[]) {
> > +                     [1] =3D "Television",
> > +                     [2] =3D "Electronic Picture Frame",
> > +                     [3] =3D "Projector",
> > +                     [4] =3D "Monitor",
> > +             },
> > +     },
> > +     [8] =3D {
> > +             "Multimedia Device",
> > +             6,
> > +             (char *[]) {
> > +                     [1] =3D "DAR",
> > +                     [2] =3D "PVR",
> > +                     [3] =3D "MCX",
> > +                     [4] =3D "Set-top box",
> > +                     [5] =3D "Media Server/Adapter/Extender",
> > +                     [6] =3D "Portable Video Player",
> > +             },
> > +     },
> > +     [9] =3D {
> > +             "Gaming device",
> > +             5,
> > +             (char *[]) {
> > +                     [1] =3D "Xbox",
> > +                     [2] =3D "Xbox360",
> > +                     [3] =3D "Playstation",
> > +                     [4] =3D "Game Console/Console Adapter",
> > +                     [5] =3D "Portable Gaming Device",
> > +             },
> > +     },
> > +     [10] =3D {
> > +             "Telephone",
> > +             5,
> > +             (char *[]) {
> > +                     [1] =3D "Windows Mobile",
> > +                     [2] =3D "Single mode phone",
> > +                     [3] =3D "Dual mode phone",
> > +                     [4] =3D "Single mode smartphone",
> > +                     [5] =3D "Dual mode smartphone",
> > +             },
> > +     },
> > +     [11] =3D {
> > +             "Audio Device",
> > +             7,
> > +             (char *[]) {
> > +                     [1] =3D "Audio tuner/receiver",
> > +                     [2] =3D "Speakers",
> > +                     [3] =3D "Portable Music Player",
> > +                     [4] =3D "Headset",
> > +                     [5] =3D "Headphones",
> > +                     [6] =3D "Microphone",
> > +                     [7] =3D "Home Theater System",
> > +             },
> > +     },
> > +     [12] =3D {
> > +             "Docking Device",
> > +             2,
> > +             (char *[]) {
> > +                     [1] =3D "Computer docking station",
> > +                     [2] =3D "Media kiosk",
> > +             },
> > +     },
> > +};
> > +
>
> So two things I see here:
>
> 1. Does this belong in wscutil.c instead?

True, it fits better there.

> 2. Your intent seems to be to expose these as D-Bus API values.  If so,
> then this gets a bit tricky.  Our D-Bus APIs do not support translation.
>   This is by design, hence all values need to be defined in
> doc/foo-api.txt.  The values must also be all lower case.

Hmmm okay. The other option would be to export these as numeric values
but we'd be forcing the API users to look them up in the spec,
possibly also their translators.  I think it might be worth listing
the values in p2p-peer-api.txt even though there are 75 strings.  Or
could we reference "Wi-Fi Simple Configuration Technical Specification
v2.0.5 Table 41" in the docs instead?

Best regards
--===============5264587194348289987==--

