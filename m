Content-Type: multipart/mixed; boundary="===============0042827862997765049=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 7/9] netconfig: Move loading settings to new method,
 refactor
Date: Thu, 26 Aug 2021 00:56:45 +0200
Message-ID: <CAOq732Lfd_x6d9AY5B0+bLLnV_Un3AbMwdHF0n4_Y9OLfTFxdg@mail.gmail.com>
In-Reply-To: <5fc5be3c-b015-6fa1-bae4-34a06ab8436f@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0042827862997765049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Aug 2021 at 00:43, Denis Kenzior <denkenz@gmail.com> wrote:
> > I thought we might have a future use case for calling
> > netconfig_load_settings() multiple times without netconfig_reset
> > between, but no strong motivation for that.
> >
>
> Can you elaborate on why we would want that?

When implementing a protocol similar to the FILS or P2P early IP
allocation, we might want to first load only the user l_settings to
find out whether the user even wants automatic netconfig.  Then
calling load_settings() would be one way, not necessarily the best
way, to pass the newly received network configuration to netconfig.c.

But even then calling netconfig_reset() in between is an option.

> But even more reason not to
> side-effect.

True.

>
> >>   We generally don't like
> >> side-effects in our APIs.
> >
> > I wouldn't call avoiding a leak a side effect ;)
> >
>
> My point is, you shouldn't be setting anything inside netconfig until you=
 know
> the operation will succeed completely.  Doing otherwise makes error handl=
ing a
> nightmare.
>
> netconfig_configure would never fail since it would ignore invalid input.=
  In
> fact, I'm not sure why it had a bool return in the first place.
>
> In this patch you're changing the contract such that netconfig_load_setti=
ngs
> checks up-front if the networking settings are correct or not.  Side-effe=
cting
> is not desirable in this case.

Agreed, I'll fix this.

Best regards
--===============0042827862997765049==--

