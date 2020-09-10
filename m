Content-Type: multipart/mixed; boundary="===============6462749187549626575=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 13/17] p2p: Start a basic P2P Group after GO Negotiation
Date: Thu, 10 Sep 2020 11:06:00 -0500
Message-ID: <f9aac398-1b64-8eee-172e-5c7f0acf421f@gmail.com>
In-Reply-To: <CAOq732JJkOYyDH95thRHPEtZ8v-LftO1PVJVnCUGqGe3CfmMXw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6462749187549626575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/10/20 10:28 AM, Andrew Zaborowski wrote:
> Hi Denis,
> =

> On Thu, 10 Sep 2020 at 16:58, Denis Kenzior <denkenz@gmail.com> wrote:
>>> +      * Section 3.2.1: "The Credentials for a P2P Group issued to a
>>> +      * P2P Device shall: [...]
>>> +      *  - Use a Network Key Type of 64 Hex characters."
>>
>> So it looks to me like the spec wants you to deliver the credentials in =
Network
>> Key form, not a passphrase.  The exception is for 'Legacy Clients', whic=
h can't
>> connect anyway due to authorized_macs being restricted.  If we were to a=
llow
>> that, how would we distinguish a legacy client ?
> =

> So for a legacy client, as far as I understand, you're supposed to
> "manually" provision the client, i.e. obtain the passphrase from the
> GO in an unspecified way, type it into the client through, e.g.
> Network Manager and it'll do the WPA2 Personal 4-way handshake.  So it

That's one way.  But it also means WSC as well.  That same section:

"This may be delivered using WSC, or in the case of a Legacy Client that do=
es =

not support WSC, by means outside the scope of this specification".  This i=
s =

probably the most likely method for legacy clients.

> matters that there *exists* a passphrase but it doesn't matter whether
> we send the passphrase or the PSK inside the Network Key.  For the

Not sure I agree.  The passphrase must exist for Legacy clients, but in the=
 case =

of P2P provisioning, the spec uses the words 'shall':

"Use a Network Key Type of 64 Hex characters."

> record, the Network Key is assumed to be the PSK if it's 64 Hex chars
> long, and a passphrase if it's between 8 and 63...  So it's the "64
> Hex characters" phrase that implies we should use the PSK form, but it

Right

> makes no difference for the GO or the client, and as far as I know it

Probably doesn't since they would support both, but the spec says to use th=
e key =

form.  Note that this is sort of wrong if SAE is used, but SAE wasn't aroun=
d =

back then...

> makes no difference for security either.

The key is derived from the passphrase and thus it can be much more easily =

brute-forced compared to a 32 byte key.  With a long enough passphrase it =

doesn't matter of course, but the spec is recommending a bare minimum.

With SAE it is less of a concern due to forward-secrecy properties.  With W=
PA1/2 =

it is a major issue since simply sniffing the traffic allows attacks agains=
t the =

passphrase.

Also consider that deriving the key from the passphrase on the peer takes e=
xtra =

time.  On a slow CPU this can be quite significant and thus increases laten=
cy.

> =

>>
>> Also, this begs the question of whether we should generate per client ke=
ys.  I
>> think that would actually be safer & more secure in the long run.  Thoug=
hts?
> =

> P2P and WSC don't really consider this, we could do it but for now we
> can only have a single client so technically we generate a per-client
> key ;-)

Lol, sure.  But then you're giving $reasons for generating a passphrase but=
 turn =

around and argue that you don't support the use case for those $reasons ;)

I'm also not quite sure how your proposed design could be made to support l=
egacy =

or multiple clients nicely, but that's another conversation.

Seriously though, I don't see how a per-client key is precluded by the spec=
.  It =

doesn't support these outright, but it has no verbiage to limit such use. =

Security wise it is much better to generate a per-client key and I wouldn't=
 even =

generate a passphrase unless needed for some cert test.  I doubt legacy use =

cases even exist in the wild.

Regards,
-Denis
--===============6462749187549626575==--

