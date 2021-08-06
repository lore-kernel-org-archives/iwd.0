Content-Type: multipart/mixed; boundary="===============0220717854447443822=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Subject: Re: [PATCH] wiphy: set neighbor report capability flag
Date: Fri, 06 Aug 2021 16:28:18 +0100
Message-ID: <CACsRnHU6iw5HrQfDFkt_O_SnFkCZmCRBFgn0pcgRFEzf6EnGpw@mail.gmail.com>
In-Reply-To: <4af22a81-e447-0f79-e9d3-062e6148d3ff@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0220717854447443822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thanks for the quick fix. I've confirmed the fields are being set on
my client but I won't be able to check the behavior until next week as
it requires some changes to my test environment. I'll let you know how
it goes.

I've also asked Meraki to clarify on the Neighbor Report field and
will let you know when I hear back.

Thanks again,
Michael

On Fri, 6 Aug 2021 at 03:10, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Michael,
>
> On 8/3/21 12:41 PM, Michael Johnson wrote:
> > Hi Denis,
> >
> > On Tue, 3 Aug 2021 at 17:35, Denis Kenzior <denkenz@gmail.com> wrote:
> >> Hmm, I wonder if we have a different bug here.  This gives me a few id=
eas to
> >> look into, let me poke around and I'll get back to you.
> >>
> >> What other problems are you having?
> >
> > Thank you!
> >
> > The other major problem I'm having is when 802.11v is enabled the APs
> > are not sending BSS-TM frames during re-associations (i.e. FT roams)
> > but it does work during a full association.
> > The current suspect is that the client doesn't send the "extended
> > capabilities" tags in the re-association frame like it does with a
> > full association. Without this the Meraki APs assume the client
> > doesn't support it.
> > I don't know what the standard says about this one.
> >
>
> I believe I have fixed this upstream now with commit 8f9e6b3f7626 ("netde=
v: Send
> addititional IEs for FT/SAE/OWE/FILS")
>
> Can you give it another try?
>
> Regards,
> -Denis
--===============0220717854447443822==--

