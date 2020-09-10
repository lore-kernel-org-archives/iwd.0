Content-Type: multipart/mixed; boundary="===============6614837016261722551=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 13/17] p2p: Start a basic P2P Group after GO Negotiation
Date: Thu, 10 Sep 2020 13:44:56 -0500
Message-ID: <9c5e55a6-aef4-271a-786c-019d09c1fb41@gmail.com>
In-Reply-To: <CAOq732J89+ozumJnq3chutZsh+TJkc4NUk4UCGCUsTrLo-V9uQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6614837016261722551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>> matters that there *exists* a passphrase but it doesn't matter whether
>>> we send the passphrase or the PSK inside the Network Key.  For the
>>
>> Not sure I agree.  The passphrase must exist for Legacy clients, but in =
the case
>> of P2P provisioning, the spec uses the words 'shall':
>>
>> "Use a Network Key Type of 64 Hex characters."
> =

> Do you mean that it doesn't say 'must', or?

What are we arguing here?  The spec clearly says:

1 Send a PSK to P2P provisioning clients
2 Send a PSK or Passphrase to WSC Legacy Clients
3 Share a passphrase with Legacy Clients via carrier pigeons.

3 is basically pointless, so unless you are doing certification, I'd comple=
tely =

ignore this.

> =

> I mean, like I said in the code comment, sending the passphrase
> instead of the PSK as the Network Key is agaist the spec but from a
> practical point of view a client who supports WSC supports both forms.
> Legacy clients (supporting WSC or not) are probably not the reason for
> the PSK requirement.

I don't even know why the spec mandates this.  But it does, so practicaliti=
es =

aside we should send the 64 byte version for now.

> =

>>
>>> record, the Network Key is assumed to be the PSK if it's 64 Hex chars
>>> long, and a passphrase if it's between 8 and 63...  So it's the "64
>>> Hex characters" phrase that implies we should use the PSK form, but it
>>
>> Right
>>
>>> makes no difference for the GO or the client, and as far as I know it
>>
>> Probably doesn't since they would support both, but the spec says to use=
 the key
>> form.  Note that this is sort of wrong if SAE is used, but SAE wasn't ar=
ound
>> back then...
>>
>>> makes no difference for security either.
>>
>> The key is derived from the passphrase and thus it can be much more easi=
ly
>> brute-forced compared to a 32 byte key.
> =

> Sorry, which are you saying is easier to brute-force?
> =

> The PSK is 32 * 8 bits while the passphrase is up to about 63 * 6 bits
> which is stronger but not by much.  You can brute-force either.  With
> the passphrase you get the PSK.  With the PSK you don't get the
> passphrase but you don't need it.  So I don't see much difference.

But you're not generating a 63 byte passphrase! A 20 character passphrase i=
s =

weaker.  And 8 char passphrase is likely too weak.  And if you're generatin=
g 30+ =

char passphrases, just generate a PSK and be done with it.

> =

>>   With a long enough passphrase it
>> doesn't matter of course, but the spec is recommending a bare minimum.
>>
>> With SAE it is less of a concern due to forward-secrecy properties.  Wit=
h WPA1/2
>> it is a major issue since simply sniffing the traffic allows attacks aga=
inst the
>> passphrase.
>>
>> Also consider that deriving the key from the passphrase on the peer take=
s extra
>> time.  On a slow CPU this can be quite significant and thus increases la=
tency.
> =

> So you're saying we should derive the PSK from the passphrase and send
> the PSK in Network Key, right?

We can, but the simpler approach would be to just generate the PSK and forg=
et =

the passphrase business for  now.

> =

> I don't think it's a noticeable task on a device that implements diffie-h=
ellman.
> =


Key derivation runs 4K iterations of hmac(sha1), so its not trivial.  I nee=
d to =

run some numbers, I remember I was shocked how long this actually takes, wh=
ich =

is why we cache the PSK in settings.  Maybe it is our implementation that n=
eeds =

fixing as well.

But still, I see no reason to make the other side suffer if we don't need t=
o.

>>
>> Seriously though, I don't see how a per-client key is precluded by the s=
pec.  It
>> doesn't support these outright, but it has no verbiage to limit such use.
> =

> I only said it doesn't consider that... but then it does say that you
> generate the credentials once and keep them until the group is torn
> down.

Which we would do ;)

> =

> Or do you mean it doesn't preclude it as in, it wouldn't break
> anything? As I said I think we can do it.  But throughout this thread
> you had been arguing for implementing the spec literally.
> =


I am arguing for that, but doesn't mean we should be doing pointless stuff. =

Right now I consider passphrases pointless.  We should not use them until a =

legacy client actually has to connect, which would be never.

Regards,
-Denis
--===============6614837016261722551==--

