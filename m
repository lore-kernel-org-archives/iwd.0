Content-Type: multipart/mixed; boundary="===============7022462205805749906=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Subject: Re: [PATCH] wiphy: set neighbor report capability flag
Date: Wed, 18 Aug 2021 18:39:26 +0100
Message-ID: <CACsRnHUM4SjW-mnKU+_9UDcqj3OpEB6q0EG46C1z7WtpQRaVwQ@mail.gmail.com>
In-Reply-To: <CACsRnHU6iw5HrQfDFkt_O_SnFkCZmCRBFgn0pcgRFEzf6EnGpw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7022462205805749906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

A couple of updates today after some testing.

Firstly the fix done to add the extended capabilities tags in FT roams
worked and I had successful 802.11v behaviour with Meraki access
points. Thank you very much for that.

Secondly, Meraki have checked their behavior and are now agreeing that
the Neighbor Report field does not need to be set for .11k to work
correctly and that they have a bug relating to the optional SSID tag
not being included in the message. However they are still saying that
setting the Neighbor Report field is subjectively "correct" citing
section 6.3.30 of the 2020 edition of the standard (being completely
open it is an interpretation rather than solid requirement).
Personally, I think it makes sense for it to be set when it is
supported but I don't suppose it makes much difference either way.

Kind Regards,
Michael

On Fri, 6 Aug 2021 at 16:28, Michael Johnson <mjohnson459@gmail.com> wrot=
e:
>
> Hi Denis,
>
> Thanks for the quick fix. I've confirmed the fields are being set on
> my client but I won't be able to check the behavior until next week as
> it requires some changes to my test environment. I'll let you know how
> it goes.
>
> I've also asked Meraki to clarify on the Neighbor Report field and
> will let you know when I hear back.
>
> Thanks again,
> Michael
>
> On Fri, 6 Aug 2021 at 03:10, Denis Kenzior <denkenz@gmail.com> wrote:
> >
> > Hi Michael,
> >
> > On 8/3/21 12:41 PM, Michael Johnson wrote:
> > > Hi Denis,
> > >
> > > On Tue, 3 Aug 2021 at 17:35, Denis Kenzior <denkenz@gmail.com> wrot=
e:
> > >> Hmm, I wonder if we have a different bug here.  This gives me a few =
ideas to
> > >> look into, let me poke around and I'll get back to you.
> > >>
> > >> What other problems are you having?
> > >
> > > Thank you!
> > >
> > > The other major problem I'm having is when 802.11v is enabled the APs
> > > are not sending BSS-TM frames during re-associations (i.e. FT roams)
> > > but it does work during a full association.
> > > The current suspect is that the client doesn't send the "extended
> > > capabilities" tags in the re-association frame like it does with a
> > > full association. Without this the Meraki APs assume the client
> > > doesn't support it.
> > > I don't know what the standard says about this one.
> > >
> >
> > I believe I have fixed this upstream now with commit 8f9e6b3f7626 ("net=
dev: Send
> > addititional IEs for FT/SAE/OWE/FILS")
> >
> > Can you give it another try?
> >
> > Regards,
> > -Denis
--===============7022462205805749906==--

