Content-Type: multipart/mixed; boundary="===============1863153903809362288=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] eap-tls: Make use of l_pem_load_container_file()
Date: Wed, 16 Dec 2020 16:08:22 +0000
Message-ID: <62699b81-6434-1017-9ea5-37ba87f65f8a@gmail.com>
In-Reply-To: <CAOq732J4BBFpraHDa3ndxLz9Dgc3BYYWA=Os2nPoEPQ_-bUKag@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1863153903809362288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 12/16/20 9:02 AM, Andrew Zaborowski wrote:
> [resend attempt]

yeah, massive gmail outage seems to have affected me yesterday.  So anythin=
g =

sent to me over the last few days had a good chance of being lost.

>>   The use o EAP-PEAP/TTLS-ClientCert is just an
>> artifact of how this was implemented originally.
> =

> I remember they were separate initially actually, and Tim made this
> big push to unify them.
> =


The unification didn't really change the behavior.  For whatever reason =

PEAP/TTLS supported ClientCert, etc from the beginning.  In fact, if you lo=
ok at =

our unit tests and autotests, they still have artifacts like EAP-TTLS-Clien=
tCert =

settings.

>>
>> I actually really wonder about the utility of these p12 files.
> =

> The utility is the same as of the PEM format.  However for me
> personally it's about supporting the popular formats (I think we're
> sitll missing one certificate format)

Sure, I get that.  But I have to wonder if spending massive amounts of time =

supporting something that is ultimately a dead end is a worthwhile exercise.

And I take it isn't possible for NM to convert these P12 files into somethi=
ng =

more sensible like a PEM + encrypted private key PEM on the fly?

>>
>> client_key_is_container would basically indicate whether the file was a =
p12 or
>> not.  If the p12 does not contain ca_certs, then this could be written a=
s:
> =

> Is it sepcified by the user though?  As I said I think that's an
> unneeded complication for all parties.
> =


What is specified by the user?  If ClientKey has a P12 format and you get b=
oth =

the private key and certificate out of it, then you're done.

I don't want users to produce files like:

EAP-TLS-ClientKey=3D/some/path/file.p12
EAP-TLS-ClientCert=3D/some/path/file.p12
EAP-TLS-CACert=3D/some/path/file.p12

It should be just
EAP-TLS-Certificates=3D/some/path/file.p12

>>
>> Or are you talking about the P12 file itself?  Do we  event want to supp=
ort
>> encrypted P12 files?
> =

> We only support encrypted PKCS#12 structs, I haven't seen unencrypted one=
s.
> =


Ugh, another reason why openssl needs to be killed with  fire.  That just m=
akes =

no sense for a container format in the context of connecting to WiFi.

>>
>> Note that P12 file might have an import key that is different than the
>> ClientKeyPassword.  So how are you handling that?  Is the user providing=
 two
>> passwords somehow?
> =

> I'm handling the format that I know is in use or supported by NM, so
> far.  I think that's what we normally want IWD.
> =

> What the spec says is that you can have an authentication password
> different from the encryption password, or you can use public keys for
> either the authentication or encryption, but I haven't seen files
> using any of those features.  I haven't seen software that can produce
> them, or NM / wpa_s support for that (neither multiple passwords nor
> public key authentication or encryption).  We can look into that once we
> have a use case.

FYI, the P12 files produced to access our VPN are like this.  The import ke=
y is =

(by default) the FSID of the path where the certificate is and the passphra=
se =

for the private key is something else entirely.

But in general, I really don't want us to be making the same mistakes as =

NM/wpa_s.  So if there are multiple passwords, we probably should support t=
hat.

> =

> Best regards
> =

> * Specifically you don't always know what is inside a PKCS#12
> container depending on how it's structured.  With openssl you know
> when a private key is present because it would not encrypt the
> Shrouded PKCS8 Key Bag type, and it would encrypt everything else as
> one opaque safe bag type.
> =


Can openssl be abused to encrypt with an empty password or something?  That=
 way =

we can still decode the public certchain and have the original encrypted pr=
ivate =

key..

It really sounds to me like .p12 is an awful choice for our use...

Regards,
-Denis

--===============1863153903809362288==--

