Content-Type: multipart/mixed; boundary="===============1449694480285234009=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] eap-tls: Make use of l_pem_load_container_file()
Date: Thu, 17 Dec 2020 12:48:03 -0600
Message-ID: <8509a249-2b7f-ab2e-c52e-52376d787b63@gmail.com>
In-Reply-To: <CAOq732+7rZwVSoM8BBjBOEVpsob-M46Jo6gz7D-VU62hTFSYNg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1449694480285234009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 12/17/20 12:04 PM, Andrew Zaborowski wrote:
> Hi Denis,
> =

> On Thu, 17 Dec 2020 at 17:16, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 12/17/20 3:18 AM, Andrew Zaborowski wrote:
>>> Why is it different than .pem, .crt, .key, .p7b, etc.?
>>
>> The difference is that this format can't be embedded into our settings f=
ile easily.
>>
>> Don't get me wrong, I'm all for supporting all these file formats.   But=
 as I
>> mentioned previously, we're already getting bitten by people putting cer=
ts into
>> their home directory and having systemd deny iwd permissions to read the=
m.
>> Something that you can't troubleshoot without reading logs and knowing w=
here to
>> look.
>>
>> The fix is to have the user modify systemd default permissions for iwd t=
o allow
>> it to read user home directories (which it probably shouldn't), or forci=
ng the
>> user to put the files 'somewhere' accessible.  Either is terrible user
>> experience...
>>
>> So I think it would be unfortunate if NM was forced into doing the same =
as above
>> on a larger scale.  Especially when multiple potentially sensitive files=
 are
>> involved which should be removed along with the network profile.  This i=
s why I
>> consider non-embeddable file types a dead end.  We either need to figure=
 out how
>> to embed them or do something else.
> =

> Right, but a couple of things to consider:
> =

> NM and wpa_s also usually run as root and they're allowed to read
> those files from wherever the user has placed them.  When you create a
> connection via nm-connection editor, the EAP settings are sent to NM
> over DBus but the public crypto files are only sent as file paths.  I
> don't know how much effort it is for the distribution people to allow
> NM/wpa_s to access those files but assuming that IWD is treated the
> same way it should have no problem.

Yes, we can do this.  And people have resorted to doing just that.  But, re=
ally, =

the question is whether we _should_.  Having iwd access files outside of it=
s =

play area is a security risk.  The less we have access to, the better.  So =
from =

that perspective, what you suggest here is something I'd want to avoid.

> =

> Secondly, NM could still convert the file to a "BEGIN PKCS12"-type PEM
> file and embed it.  openssl doesn't seem to support creating exactly
> this format, but I didn't invent it ;) Cisco access points apparently
> want this format from the user.  I'm not considering doing this right
> now because making copies of the user keys whether encrypted or not,
> needs extra work proving that it's safe, maybe issuing warnings in the
> logs etc.  Also we'd need to be sure that deleting and modifying IWD
> network configs from the same NM UIs works 100% bulletproof.

That sounds like an idea we should pursue...

> =

> Also we can't tell somebody that we don't allow them to use their
> standalone .p12 file (or .cer which is also binary) fbecause those
> files can't be embedded, it's a different use case.
> =


We can certainly support .p12 files the way we support non-embedded PEMs to=
day. =

I'm just not in favor of having NM use non-embedded files and forcing iwd t=
o =

have worldwide read permissions.

>>> I looked around a little for an indication that a .p12 file is ever
>>> used to store the user keypair (for client authentication) *and* the
>>> trusted CA set (for server authentication) but I can't find it, I
>>
>> Here's one:
>> http://cubicspot.blogspot.com/2013/04/setting-up-wpa2-enterprise-aes-wit=
h.html
> =

> Okay, so what seems to be happening is that Android can import
> certificates and keys from .p12 files into its credentials storage,
> the article that this post linked was about Android 2.2 but it still
> works on my Android 9 device.  The device asks me for the decryption
> password, whether I want it for VPN and wlan, and a user-friendly name
> for the bundle.  The ell test .p12 files contain the leaf certificate,
> the intermediate CA and the root (self-signed) CA, and they private
> key.  Android imports the 3 certs and one key as a bundle under the
> name I gave.  Then, when I set up a new EAP-TLS connection I can
> select one bundle for the trusted CA certificate and one for the user
> certificate + key, and they can be the same bundle but they can be
> different too.

So looks like Android got something right :)

> =

> So this is smart because often a .p12 file will contain the full
> cert-chain from the leaf user cert to root CA.cert, and often the root
> CA is the same for user authentication and for server authentication,
> and then you need just one .p12 file.  But often this is not the case

Exactly.  But for a self-signed CA, which is what you'd typically use this =
for, =

I would expect that the root CA to be included.

> (because the certchain can be shorter or can contain no CAs at all, or
> because there are different roots for users and for the server) and

Yes, this is possible.  I wonder why anyone would come up with such a setup=
 in =

practice.

> they also support this situation becuase you can specify different
> files.  In our code we're specifically not checking that the user
> certchain can be verified with the CA certs because they can be
> different, I think we made this change after someone complained.

Yes, I recall something like this.  My memory is fuzzy.  I seem to recall y=
ou =

originally had a place holder for this but never implemented it.  So we too=
k it out.

> =

> So I think we should also allow a .p12 file to be specified as a
> EAP-TLS-CACerts (I haven't worked on this) and then we should use the
> last, not the first certificate from that file.  Note that openssl

Yep, sounds reasonable.

> doesn't support creating pkcs12 files where the certificates don't
> form a valid certchain, so you can't have multiple root CAs and you
> can't have a user cert + a CA for server authentication unless it's
> also the root of the user certchain.

I think that sort of makes sense (see above.)  So, maybe we should just ass=
ume =

this setup and use the root CA provided as part of the .p12 file unless =

over-ridden by a separate CACert entry.  But these details can be left unti=
l =

later...

Regards,
-Denis
--===============1449694480285234009==--

