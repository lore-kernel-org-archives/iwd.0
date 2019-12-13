Content-Type: multipart/mixed; boundary="===============2185386747407164095=="
MIME-Version: 1.0
From: Simon Brand <simon.brand@postadigitale.de>
Subject: Re: EAP-Method=PEAP and tls_reset_handshake/authentication timeout
 results in core-dumped
Date: Fri, 13 Dec 2019 12:53:32 +0100
Message-ID: <20191213115332.6bfd8127@hostpad>
In-Reply-To: <7e33164a-3504-6d9e-2a23-f70d9327db57@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2185386747407164095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

this seams to fix my problem, thank you very much.
Sorry for your time, I should have tested the git version first.

Regards,
Simon


On Thu, 12 Dec 2019 10:46:08 -0600
Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Simon,
> =

> On 12/12/19 1:37 AM, Simon Brand wrote:
> > Hi,
> > =

> > I build iwd 1.2 with the mentioned options, got 4 backtraces and the
> > journalctl and iwmon logs.
> > I tried to reproduce with another device, but was not able to, so
> > probably device related (or just easier to reproduce with this
> > device).
> > =

> > https://www.dropbox.com/s/w2xs4oggf0zognf/logs.tar.xz?dl=3D1
> > =

> > If I can provide anything else, please let me know.
> >   =

> =

> So looking at your traces, it seems you've hit the same bug that was =

> fixed upstream recently.  Can you apply this fix (or just run iwd git =

> HEAD) and see if the issue persists?
> =

> https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=3Dd255=
6a48b7d65eb670fb0ce20e3f929bf9839a20
> =

> We should have iwd 1.3 out in the next few days.
> =

> Regards,
> -Denis
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org

--===============2185386747407164095==--

