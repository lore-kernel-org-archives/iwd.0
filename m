Content-Type: multipart/mixed; boundary="===============8180478119935209085=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 13/17] p2p: Start a basic P2P Group after GO Negotiation
Date: Thu, 10 Sep 2020 17:28:27 +0200
Message-ID: <CAOq732JJkOYyDH95thRHPEtZ8v-LftO1PVJVnCUGqGe3CfmMXw@mail.gmail.com>
In-Reply-To: <d0cb3932-129f-afd4-799e-63371bfbce45@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8180478119935209085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, 10 Sep 2020 at 16:58, Denis Kenzior <denkenz@gmail.com> wrote:
> > +      * Section 3.2.1: "The Credentials for a P2P Group issued to a
> > +      * P2P Device shall: [...]
> > +      *  - Use a Network Key Type of 64 Hex characters."
>
> So it looks to me like the spec wants you to deliver the credentials in N=
etwork
> Key form, not a passphrase.  The exception is for 'Legacy Clients', which=
 can't
> connect anyway due to authorized_macs being restricted.  If we were to al=
low
> that, how would we distinguish a legacy client ?

So for a legacy client, as far as I understand, you're supposed to
"manually" provision the client, i.e. obtain the passphrase from the
GO in an unspecified way, type it into the client through, e.g.
Network Manager and it'll do the WPA2 Personal 4-way handshake.  So it
matters that there *exists* a passphrase but it doesn't matter whether
we send the passphrase or the PSK inside the Network Key.  For the
record, the Network Key is assumed to be the PSK if it's 64 Hex chars
long, and a passphrase if it's between 8 and 63...  So it's the "64
Hex characters" phrase that implies we should use the PSK form, but it
makes no difference for the GO or the client, and as far as I know it
makes no difference for security either.

>
> Also, this begs the question of whether we should generate per client key=
s.  I
> think that would actually be safer & more secure in the long run.  Though=
ts?

P2P and WSC don't really consider this, we could do it but for now we
can only have a single client so technically we generate a per-client
key ;-)

Best regards
--===============8180478119935209085==--

