Content-Type: multipart/mixed; boundary="===============6246740025970182063=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Subject: Re: Failing to resolve after roams
Date: Thu, 12 Aug 2021 15:30:07 +0100
Message-ID: <CACsRnHXdDCfnRVgJ4UiWKqTmoEDcFfCPzkFN6v4rrRR9GX29Hg@mail.gmail.com>
In-Reply-To: <8c08d082-0494-8e77-32fb-2b42d99599cf@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6246740025970182063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

`systemd-networkd` isn't managing the wireless interface but still
needs to run for wired connections (or at least shouldn't be). I'm not
sure why it still prints connected/disconnect states. How does `iwd`
interact with `systemd-resolved`?

Regards,
Michael

On Thu, 12 Aug 2021 at 15:24, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Michael,
>
> On 8/10/21 5:58 AM, Michael Johnson wrote:
> > Hi all,
> >
> > I'm having a problem with iwd when it comes to roaming. Most of the
> > time it is working perfectly but rarely I get into this situation > whe=
re I can't resolve any hostnames.
> > I'm using a default server setup on ubuntu which uses systemd-networkd
> > and systemd-resolved with iwd configured to use
> > `EnableNetworkConfiguration=3Dtrue`.
> >
>
> Hmm, are you configuring systemd-networkd not to manage wireless interfac=
es?
> Otherwise iwd and networkd might be fighting each other when it comes to
> managing the network interface.  Generally, one would not set
> 'EnableNetworkConfiguration=3Dtrue' if networkd is being used.
>
> Regards,
> -Denis
--===============6246740025970182063==--

