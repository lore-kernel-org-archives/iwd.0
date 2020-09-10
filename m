Content-Type: multipart/mixed; boundary="===============4669481692271335747=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 13/17] p2p: Start a basic P2P Group after GO Negotiation
Date: Thu, 10 Sep 2020 20:14:02 +0200
Message-ID: <CAOq732J89+ozumJnq3chutZsh+TJkc4NUk4UCGCUsTrLo-V9uQ@mail.gmail.com>
In-Reply-To: <f9aac398-1b64-8eee-172e-5c7f0acf421f@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4669481692271335747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Sep 2020 at 18:11, Denis Kenzior <denkenz@gmail.com> wrote:
> On 9/10/20 10:28 AM, Andrew Zaborowski wrote:
> > On Thu, 10 Sep 2020 at 16:58, Denis Kenzior <denkenz@gmail.com> wrote:
> >>> +      * Section 3.2.1: "The Credentials for a P2P Group issued to a
> >>> +      * P2P Device shall: [...]
> >>> +      *  - Use a Network Key Type of 64 Hex characters."
> >>
> >> So it looks to me like the spec wants you to deliver the credentials i=
n Network
> >> Key form, not a passphrase.  The exception is for 'Legacy Clients', wh=
ich can't
> >> connect anyway due to authorized_macs being restricted.  If we were to=
 allow
> >> that, how would we distinguish a legacy client ?
> >
> > So for a legacy client, as far as I understand, you're supposed to
> > "manually" provision the client, i.e. obtain the passphrase from the
> > GO in an unspecified way, type it into the client through, e.g.
> > Network Manager and it'll do the WPA2 Personal 4-way handshake.  So it
>
> That's one way.  But it also means WSC as well.  That same section:
>
> "This may be delivered using WSC, or in the case of a Legacy Client that =
does
> not support WSC, by means outside the scope of this specification".  This=
 is
> probably the most likely method for legacy clients.

Ok.

>
> > matters that there *exists* a passphrase but it doesn't matter whether
> > we send the passphrase or the PSK inside the Network Key.  For the
>
> Not sure I agree.  The passphrase must exist for Legacy clients, but in t=
he case
> of P2P provisioning, the spec uses the words 'shall':
>
> "Use a Network Key Type of 64 Hex characters."

Do you mean that it doesn't say 'must', or?

I mean, like I said in the code comment, sending the passphrase
instead of the PSK as the Network Key is agaist the spec but from a
practical point of view a client who supports WSC supports both forms.
Legacy clients (supporting WSC or not) are probably not the reason for
the PSK requirement.

>
> > record, the Network Key is assumed to be the PSK if it's 64 Hex chars
> > long, and a passphrase if it's between 8 and 63...  So it's the "64
> > Hex characters" phrase that implies we should use the PSK form, but it
>
> Right
>
> > makes no difference for the GO or the client, and as far as I know it
>
> Probably doesn't since they would support both, but the spec says to use =
the key
> form.  Note that this is sort of wrong if SAE is used, but SAE wasn't aro=
und
> back then...
>
> > makes no difference for security either.
>
> The key is derived from the passphrase and thus it can be much more easily
> brute-forced compared to a 32 byte key.

Sorry, which are you saying is easier to brute-force?

The PSK is 32 * 8 bits while the passphrase is up to about 63 * 6 bits
which is stronger but not by much.  You can brute-force either.  With
the passphrase you get the PSK.  With the PSK you don't get the
passphrase but you don't need it.  So I don't see much difference.

>  With a long enough passphrase it
> doesn't matter of course, but the spec is recommending a bare minimum.
>
> With SAE it is less of a concern due to forward-secrecy properties.  With=
 WPA1/2
> it is a major issue since simply sniffing the traffic allows attacks agai=
nst the
> passphrase.
>
> Also consider that deriving the key from the passphrase on the peer takes=
 extra
> time.  On a slow CPU this can be quite significant and thus increases lat=
ency.

So you're saying we should derive the PSK from the passphrase and send
the PSK in Network Key, right?

I don't think it's a noticeable task on a device that implements diffie-hel=
lman.

>
> >
> >>
> >> Also, this begs the question of whether we should generate per client =
keys.  I
> >> think that would actually be safer & more secure in the long run.  Tho=
ughts?
> >
> > P2P and WSC don't really consider this, we could do it but for now we
> > can only have a single client so technically we generate a per-client
> > key ;-)
>
> Lol, sure.  But then you're giving $reasons for generating a passphrase b=
ut turn
> around and argue that you don't support the use case for those $reasons ;)

Which use case?  We don't support multiple clients because we didn't
get there yet, no other reasons.  In fact we don't support one client
yet.

>
> I'm also not quite sure how your proposed design could be made to support=
 legacy
> or multiple clients nicely, but that's another conversation.

Do you mean the design of the struct p2p_device and such?  It will
need to evolve obviously, we'll need to use l_queue's etc, but should
we already be thinking about this?

>
> Seriously though, I don't see how a per-client key is precluded by the sp=
ec.  It
> doesn't support these outright, but it has no verbiage to limit such use.

I only said it doesn't consider that... but then it does say that you
generate the credentials once and keep them until the group is torn
down.

Or do you mean it doesn't preclude it as in, it wouldn't break
anything? As I said I think we can do it.  But throughout this thread
you had been arguing for implementing the spec literally.

Best regards
--===============4669481692271335747==--

