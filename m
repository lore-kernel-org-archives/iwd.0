Content-Type: multipart/mixed; boundary="===============9138956847112530582=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/2] eap-tls: Make use of l_pem_load_container_file()
Date: Thu, 17 Dec 2020 10:18:52 +0100
Message-ID: <CAOq732L12a-KSUS-inAn0wCgHLNTWFrUmaUHs+SE_Gz20=kSOQ@mail.gmail.com>
In-Reply-To: <62699b81-6434-1017-9ea5-37ba87f65f8a@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9138956847112530582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Dec 2020 at 17:08, Denis Kenzior <denkenz@gmail.com> wrote:
> On 12/16/20 9:02 AM, Andrew Zaborowski wrote:
> >> I actually really wonder about the utility of these p12 files.
> >
> > The utility is the same as of the PEM format.  However for me
> > personally it's about supporting the popular formats (I think we're
> > sitll missing one certificate format)
>
> Sure, I get that.  But I have to wonder if spending massive amounts of ti=
me
> supporting something that is ultimately a dead end is a worthwhile exerci=
se.

Why is it different than .pem, .crt, .key, .p7b, etc.?

>
> And I take it isn't possible for NM to convert these P12 files into somet=
hing
> more sensible like a PEM + encrypted private key PEM on the fly?

Without the password, no.  I still don't see the reason to force IWD's
clients and/or users to do this when we can have ell seemlessly
autodetect the formats and clients like IWD (or https implementations)
can forget about it, I'm not sure why we're having this conversation.

>
> >>
> >> client_key_is_container would basically indicate whether the file was =
a p12 or
> >> not.  If the p12 does not contain ca_certs, then this could be written=
 as:
> >
> > Is it sepcified by the user though?  As I said I think that's an
> > unneeded complication for all parties.
> >
>
> What is specified by the user?

client_key_is_container, does it come from a boolean setting? Or do
you want ell to have a function that reads the file and detects the
format, separate from the function that loads the file?

> If ClientKey has a P12 format and you get both
> the private key and certificate out of it, then you're done.

That's exactly what calling l_pem_load_container_file() does, so the
clients don't have to worry about the 10 different file types.

>
> I don't want users to produce files like:
>
> EAP-TLS-ClientKey=3D/some/path/file.p12
> EAP-TLS-ClientCert=3D/some/path/file.p12
> EAP-TLS-CACert=3D/some/path/file.p12
>
> It should be just
> EAP-TLS-Certificates=3D/some/path/file.p12

I looked around a little for an indication that a .p12 file is ever
used to store the user keypair (for client authentication) *and* the
trusted CA set (for server authentication) but I can't find it, I
don't believe this exists.  I also believe if some implementer wanted
to support this -- it would be only for EAP, not other .p12 use cases
(like https, .apk signing, etc.), so they'd go all the way and create
a new format to store the full EAP configuration (Identity etc.) and
certificates + keys in one file rather than use .p12.  If you've seen
something like this please re-check the details, I think you're
talking about something different than .p12.

So you can't do either of the above, it's going to be something like:
> EAP-TLS-ClientCert=3D/some/path/file1.p12
> EAP-TLS-CACert=3D/some/path/file2.p12

>
> >>
> >> Or are you talking about the P12 file itself?  Do we  event want to su=
pport
> >> encrypted P12 files?
> >
> > We only support encrypted PKCS#12 structs, I haven't seen unencrypted o=
nes.
> >
>
> Ugh, another reason why openssl needs to be killed with  fire.  That just=
 makes
> no sense for a container format in the context of connecting to WiFi.
>
> >>
> >> Note that P12 file might have an import key that is different than the
> >> ClientKeyPassword.  So how are you handling that?  Is the user providi=
ng two
> >> passwords somehow?
> >
> > I'm handling the format that I know is in use or supported by NM, so
> > far.  I think that's what we normally want IWD.
> >
> > What the spec says is that you can have an authentication password
> > different from the encryption password, or you can use public keys for
> > either the authentication or encryption, but I haven't seen files
> > using any of those features.  I haven't seen software that can produce
> > them, or NM / wpa_s support for that (neither multiple passwords nor
> > public key authentication or encryption).  We can look into that once we
> > have a use case.
>
> FYI, the P12 files produced to access our VPN are like this.  The import =
key is
> (by default) the FSID of the path where the certificate is and the passph=
rase
> for the private key is something else entirely.

I'm looking at some scripts and that's not the case, I don't know if
you mean the same scripts, let me reply privately.

>
> But in general, I really don't want us to be making the same mistakes as
> NM/wpa_s.  So if there are multiple passwords, we probably should support=
 that.
>
> >
> > Best regards
> >
> > * Specifically you don't always know what is inside a PKCS#12
> > container depending on how it's structured.  With openssl you know
> > when a private key is present because it would not encrypt the
> > Shrouded PKCS8 Key Bag type, and it would encrypt everything else as
> > one opaque safe bag type.
> >
>
> Can openssl be abused to encrypt with an empty password or something?  Th=
at way
> we can still decode the public certchain and have the original encrypted =
private
> key..

It can encrypt with an empty password, yes, but I don't see what you
can use this for.

>
> It really sounds to me like .p12 is an awful choice for our use...

It's like the other formats each with its quirks.

Best regards
--===============9138956847112530582==--

