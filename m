Content-Type: multipart/mixed; boundary="===============2249715061162265813=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 4/8] ap: Refactor global address pool loading
Date: Wed, 02 Jun 2021 01:06:55 +0200
Message-ID: <CAOq732Kf1wsrLOtnFJ3Z5i=O341C4zj3namR5Lcv=44kL=KJMw@mail.gmail.com>
In-Reply-To: <6f05e4a5-61d3-26b2-ea1f-c50024317320@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2249715061162265813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 1 Jun 2021 at 17:14, Denis Kenzior <denkenz@gmail.com> wrote:
> On 5/27/21 7:47 PM, Andrew Zaborowski wrote:
> > +             } else if (l_settings_get_value(settings,
> > +                                             "General", "APRanges")) {
> > +                     global_addr4_strs =3D l_settings_get_string_list(=
settings,
> > +                                                             "General",
> > +                                                             "APRanges=
",
> > +                                                             ',');
>
> Do you want to print a warning that this setting is deprecated?

Ok, will send a patch.

Best regards
--===============2249715061162265813==--

