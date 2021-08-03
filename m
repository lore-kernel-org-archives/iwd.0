Content-Type: multipart/mixed; boundary="===============1819272174191843320=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Subject: Re: [PATCH] wiphy: set neighbor report capability flag
Date: Tue, 03 Aug 2021 18:41:20 +0100
Message-ID: <CACsRnHX0yR+SnWGPPtKkKQGGdcRn=pySxjyFy4eQmG-YkfAoqw@mail.gmail.com>
In-Reply-To: <39c22b3d-8ac1-62ee-0e10-28b483681ae4@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1819272174191843320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 3 Aug 2021 at 17:35, Denis Kenzior <denkenz@gmail.com> wrote:
> Hmm, I wonder if we have a different bug here.  This gives me a few ideas=
 to
> look into, let me poke around and I'll get back to you.
>
> What other problems are you having?

Thank you!

The other major problem I'm having is when 802.11v is enabled the APs
are not sending BSS-TM frames during re-associations (i.e. FT roams)
but it does work during a full association.
The current suspect is that the client doesn't send the "extended
capabilities" tags in the re-association frame like it does with a
full association. Without this the Meraki APs assume the client
doesn't support it.
I don't know what the standard says about this one.

> > https://mrncciew.com/2014/09/11/cwsp-802-11k-ap-assisted-roaming/
>
> This link shows an Association Request with 'neighbor report' capability =
zero-d
> out.  See 'Frame 41'

Ah! I completely misread that as enabling an alternative "channel report".

> It could be that Meraki really does want this, but I suspect something el=
se is
> the real culprit.  Lets get to the bottom of this.

Let me know how I can help!

Regards,
Michael
--===============1819272174191843320==--

