Content-Type: multipart/mixed; boundary="===============2001231414211311531=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 8/9] monitor: Print WFD IE contents
Date: Fri, 20 Mar 2020 16:54:42 +0100
Message-ID: <CAOq732+evnhTjXUhuc-foDPq7HzEgZeSbea4J1me6c=Mo_tEYQ@mail.gmail.com>
In-Reply-To: <149857cb-92cf-892c-fef9-46670e2bfba0@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2001231414211311531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 20 Mar 2020 at 16:33, Denis Kenzior <denkenz@gmail.com> wrote:
> On 3/19/20 4:12 PM, Andrew Zaborowski wrote:
> > @@ -3097,7 +3109,6 @@ static void print_p2p_capability(unsigned int lev=
el, const char *label,
> >       CHECK_CAPS_BIT(P2P_GROUP_CAP_IP_ALLOCATION,
> >                       "IP Address Allocation");
> >   }
> > -#undef CHECK_CAPS_BIT
>
> Don't know if this is intended, but you no longer undef CHECK_CAPS_BIT ...

Right, I thought it now seems useful across a bigger part of the file
and a name conflict is unlikely...

>
> >
> >   static void print_p2p_go_intent(unsigned int level, const char *label,
> >                               const void *data, uint16_t size)
> > @@ -3658,11 +3669,294 @@ static void print_p2p_attributes(unsigned int =
level, const char *label,
> >       }
> >   }
> >
> > +static void print_wfd_device_info_flags(unsigned int level, const char=
 *label,
> > +                                     uint16_t caps)
> > +{
> > +     static const char *dev_type[4] =3D {
> > +             [WFD_DEV_INFO_TYPE_SOURCE] =3D "Source",
> > +             [WFD_DEV_INFO_TYPE_PRIMARY_SINK] =3D "Primary sink",
> > +             [WFD_DEV_INFO_TYPE_SECONDARY_SINK] =3D "Secondary sink",
> > +             [WFD_DEV_INFO_TYPE_DUAL_ROLE] =3D "Dual-role possible",
> > +     };
> > +#pragma GCC diagnostic ignored "-Woverride-init"
>
> Don't you want to #pragma push and pop instead of disabling this for the
> entire file?
>
> What is this trying to fix anyway?
>
> > +     static const char *session_avail[4] =3D {
> > +             [0 ... 3] =3D "Reserved",
>
> Perhaps not trying to initialize the entire array to "Reserved" first
>
> > +             [WFD_DEV_INFO_SESSION_NOT_AVAILABLE >> 4] =3D
> > +                     "Not available for WFD Session",
> > +             [WFD_DEV_INFO_SESSION_AVAILABLE >> 4] =3D
> > +                     "Available for WFD Session",
>
> And resetting it later  would help?

I can do that instead and give up trying to use the
WFD_DEV_INFO_SESSION_.* constants, I'll send a new patch.

Best regards
--===============2001231414211311531==--

