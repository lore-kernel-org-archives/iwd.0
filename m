Content-Type: multipart/mixed; boundary="===============5252834172378819686=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 01/16] hwsim: return radio ID on create
Date: Thu, 27 Aug 2020 13:21:19 -0700
Message-ID: <2bb9fb47fce4babfcdd41d1f3b84e20109ccc8b8.camel@gmail.com>
In-Reply-To: <d4772e1e-cf43-0d33-4d0b-3aa8fa468fca@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5252834172378819686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-08-27 at 15:08 -0500, Denis Kenzior wrote:
> Hi James,
> =

> On 8/27/20 12:32 PM, James Prestwood wrote:
> > Hwsim was relying on some internal behavior of mac80211_hwsim where
> > new
> > radios are created with ID's starting at zero and incremented.
> > While
> > this is a reasonable assumption its better to obtain the actual
> > radio
> > ID since mac80211_hwsim returns it in the radio creation callback.
> > =

> > Now hwsim will return the radio ID when creating radios. Negative
> > returns
> > are still errors, but any value >=3D 0 indicates the radio ID of the
> > newly
> > created radio.
> =

> Ah, now I see what you meant by exit code.  Sorry I should have
> caught this earlier.
> =

> So the problem is that UNIX doesn't really understand negative exit
> codes.  exit =

> code of 0 is a success and anything else is a failure.
> =

> I think you will get people screaming obscenities if they try to use
> hwsim in a =

> script...

Ok, makes sense. I can just track the ID internally until I get the
dbus stuff sorted out.

> =

> > ---
> >   tools/hwsim.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> > =

> =

> Regards,
> -Denis

--===============5252834172378819686==--

