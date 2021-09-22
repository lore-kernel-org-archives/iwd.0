Content-Type: multipart/mixed; boundary="===============0664733591976773740=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: Possible bug - DISASSOC_LOW_ACK
Date: Wed, 22 Sep 2021 15:53:47 +0100
Message-ID: <CACsRnHVji4BE+XCjXmv2myEyzJvekMex7Rv6Et5UT_iHAa5nhA@mail.gmail.com>
In-Reply-To: 94d5719f-178a-3ca8-40a6-b6f2692934c5@gmail.com

--===============0664733591976773740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 22 Sept 2021 at 15:13, Denis Kenzior <denkenz(a)gmail.com> wrote:
> This is indeed strange.  iwmon would capture this, but maybe it is easier=
 to put
> in a bit more debugging into the CQM paths and see if we get some more cl=
ues?
> Maybe the CQM events are propagated correctly but the signal isn't below =
the
> roaming threshold?

Maybe. I'll try and capture the contents of the CQM packets when it happens.

> > I'm not sure how to reproduce this as it's relatively rare, happening
> > 3 times in about a week. The logs below are from a machine running
> > version 1.17.
> > I'll see if I can start a rolling iwmon capture to get more info. Is
> > there anything else that would be useful?
>
> Might be chasing ghosts, but the only other thing I see is a a few CMD_FR=
AME
> events (see below) that we receive which are not recognized?  Or at least=
 I
> don't see any logs of them being parsed.  iwmon trace will capture these,=
 but
> may be easier to log them in your case.

I can do that. I'll add extra logging to those `_notify()` methods and
update when I see it happen again.

> Did we just roam, or is something else going on?

We roamed at 15:40:21.954094 and then lost comms at 15:42:30.885817.
I've put the full logs here https://pastebin.com/FJxpGmfd.

> > Sep 21 15:46:41.998639 p3-683 kernel: wlan0: deauthenticated from
> > ea:9e:38:78:08:71 (Reason: 34=3DDISASSOC_LOW_ACK)
>
> Hmm, never seen this before.  I wonder if the power limit event the kernel
> prints about earlier has something to do with this?

The "Limit TX power" message is always printed after a roam. I'm not
entirely sure why but I believe APs to advertise which power level to
use?

Regards,
Michael
--===============0664733591976773740==--

