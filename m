Content-Type: multipart/mixed; boundary="===============7641963577095014524=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/2] eap-tls: Make use of l_pem_load_container_file()
Date: Wed, 16 Dec 2020 16:02:27 +0100
Message-ID: <CAOq732J4BBFpraHDa3ndxLz9Dgc3BYYWA=Os2nPoEPQ_-bUKag@mail.gmail.com>
In-Reply-To: <a8848e00-1f52-c81a-7350-bf31744af814@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7641963577095014524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[resend attempt]

On Tue, 15 Dec 2020 at 17:24, Denis Kenzior <denkenz@gmail.com> wrote:
> >> So this reminds me that ClientKeyPassphrase, ClientKey and ClientCert =
are
> >> already only relevant to EAP-TLS.  They probably don't even belong bei=
ng checked
> >> here in eap_tls_common_settins_load, etc.
> >
> > Even if you deprecate EAP-PEAP-ClientCert you'll probably want to keep
> > compatibility for some time.
> >
>
> Deprecate?  It was never supposed to be supported.  See 'man iwd.network.=
5'.
> These options are only for TLS.

True, I didn't realize it was not in man iwd.network.5'.

>  The use o EAP-PEAP/TTLS-ClientCert is just an
> artifact of how this was implemented originally.

I remember they were separate initially actually, and Tim made this
big push to unify them.

>
> >>
> >>>        snprintf(setting_key, sizeof(setting_key), "%sCACert", prefix);
> >>> -     value =3D l_settings_get_string(settings, "Security", setting_k=
ey);
> >>> -     if (value) {
> >>> -             eap_tls->ca_cert =3D eap_tls_load_ca_cert(settings, val=
ue);
> >>> -             if (!eap_tls->ca_cert) {
> >>> -                     l_error("Could not load CACert %s", value);
> >>> +     ca_cert =3D l_settings_get_string(settings, "Security", setting=
_key);
> >>> +     if (ca_cert) {
> >>> +             eap_tls->ca_cert =3D eap_tls_load_ca_cert(settings, ca_=
cert);
> >>> +             if (!eap_tls->ca_cert)
> >>>                        goto load_error;
> >>
> >> Hmm, the P12 files don't contain the CA certchain?  I thought the whol=
e point of
> >> these was to have the private key + public key + CA certchain?  Otherw=
ise I see
> >> little point in these since you effectively need to specify the P12 fi=
le _and_
> >> the CACert file?
> >
> > Putting the trusted CA certs in the same file (whether .p12, .pfx or
> > PEM) is not a usual use case and if it exists I'd guess you have to
> > use some PKCS#9 attributes to identify those certificates within the
> > file?  NM and wpa_s don't have logic for identifying those labels
> > AFAIK.
>
> I actually really wonder about the utility of these p12 files.

The utility is the same as of the PEM format.  However for me
personally it's about supporting the popular formats (I think we're
sitll missing one certificate format)

>  We already have
> a bit of an issue with iwd not being allowed to access user home director=
ies (by
> systemd for example).  Which is why I'd like to move to the embedded form=
at as
> much as possible.  With PEMs we at least have the ability to embed all ce=
rts
> into the settings file easily.

Right, I'm not suggesting it shouldn't be used..

>
> >
> > You can have just your key or just your certchain or individual
> > trusted CA certs in .p12 files without the other parts.
> >
>
> I'm pretty sure CA certs can be included in the p12 file for use on Andro=
id for
> example.  Maybe we should look into how this is done?

We probably should eventually.

>
> >>
> >>> -             }
> >>>        }
> >>>
> >>> -     l_free(value);
> >>> -
> >>>        snprintf(setting_key, sizeof(setting_key), "%sClientCert", pre=
fix);
> >>> -     value =3D l_settings_get_string(settings, "Security", setting_k=
ey);
> >>> -     if (value) {
> >>> -             eap_tls->client_cert =3D eap_tls_load_client_cert(setti=
ngs,
> >>> -                                                             value);
> >>> -             if (!eap_tls->client_cert) {
> >>> -                     l_error("Could not load ClientCert %s", value);
> >>> -                     goto load_error;
> >>> -             }
> >>> -     }
> >>> -
> >>> -     l_free(value);
> >>> -
> >>> -     snprintf(setting_key, sizeof(setting_key), "%sClientKeyPassphra=
se",
> >>> -                                                                    =
 prefix);
> >>> -     passphrase =3D l_settings_get_string(settings, "Security", sett=
ing_key);
> >>> +     client_cert =3D l_settings_get_string(settings, "Security", set=
ting_key);
> >>>
> >>>        snprintf(setting_key, sizeof(setting_key), "%sClientKey", pref=
ix);
> >>> -     value =3D l_settings_get_string(settings, "Security", setting_k=
ey);
> >>> -     if (value) {
> >>> -             eap_tls->client_key =3D eap_tls_load_priv_key(settings,=
 value,
> >>> +     client_key =3D l_settings_get_string(settings, "Security", sett=
ing_key);
> >>> +
> >>> +     if (client_cert && is_embedded(client_cert))
> >>> +             eap_tls->client_cert =3D eap_tls_load_embedded_cert(set=
tings,
> >>> +                                                             client_=
cert);
> >>> +     else if (client_cert) {
> >>> +             l_pem_load_container_file(client_cert, passphrase,
> >>> +                                             &eap_tls->client_cert,
> >>> +                                             client_key ? NULL :
> >>> +                                             &eap_tls->client_key, N=
ULL);
> >>> +     }
> >>> +
> >>> +     if (client_key && is_embedded(client_key))
> >>> +             eap_tls->client_key =3D eap_tls_load_embedded_priv_key(=
settings,
> >>> +                                                             client_=
key,
> >>>                                                                passph=
rase,
> >>>                                                                NULL);
> >>> -             if (!eap_tls->client_key) {
> >>> -                     l_error("Could not load ClientKey %s", value);
> >>> -                     goto load_error;
> >>> -             }
> >>> +     else if (client_key) {
> >>> +             l_pem_load_container_file(client_key, passphrase,
> >>> +                                             client_cert ? NULL :
> >>> +                                             &eap_tls->client_cert,
> >>> +                                             &eap_tls->client_key, N=
ULL);
> >>>        }
> >>>
> >>> +     if ((client_cert && !eap_tls->client_cert) ||
> >>> +                     (client_key && !eap_tls->client_key) ||
> >>> +                     !eap_tls->client_cert !=3D !eap_tls->client_key)
> >>> +             goto load_error;
> >>> +
> >>
> >> So assuming that the CACert is also part of the P12, I'd think
> >> eap_tls_load_settings should work something like:
> >>
> >> password =3D l_settings_get(.., "ClientPassphrase");
> >> container =3D l_settings_get(.., "ClientKey");
> >>
> >> if (client_key_is_container) {
> >>     // load client_key, client_cert, ca_cert
> >>     // load ServerDomainMask
> >>     return;
> >> }
> >>
> >> return eap_tls_common_settings_load()
> >
> > What's client_key_is_container though?  If it's something set by the
> > user I fear we're making things more complicated for the users than
> > even wpa_s is.  Also for ourselves by adding inconsistency between the
> > tls-based methods.
>
> What inconsistency?  As I pointed out earlier, ClientKey and ClientCert a=
re TLS
> only.

Right.

>
> client_key_is_container would basically indicate whether the file was a p=
12 or
> not.  If the p12 does not contain ca_certs, then this could be written as:

Is it sepcified by the user though?  As I said I think that's an
unneeded complication for all parties.

>
> password =3D ...
> container =3D ...
>
> if (client_key_is_p12) {
>         // load client_key, client_cert
>         goto done;
> }
>
> // Load client key, client_cert the usual way
>
> done:
>         return eap_tls_common_settings_load();
>
> where common_settings_load only cares about the CACerts and ServerDomainM=
ask.
>
> >
> > The "container" naming I used in the ell patch was about all these
> > certificate and/or key formats though.  Note that if we use special
> > settings here depending on what format we have, we're forcing the
> > users of this (be it IT admins) to understand more about these files.
>
> ??
>
> > And for me in the NM iwd-backend it may be directly impossible to
> > convert those EAP settings if I have to detect what is stored inside
> > the file since I can't decrypt it.
> >
> The P12 file contains a public certificate and a (possibly encrypted) pri=
vate
> key.  You're not getting to the encrypted private key without the user
> password...  But this is the same as if we had a PEM with an encrypted pr=
ivate
> key.  So I don't see a problem...?

With PEM we know the types of objects we have in it, while with
PKCS#12 we don't until we decrypt the file. *

In any case I'm still not sure what you're suggesting and how that is
an improvement over autodetecting the format.

>
> Or are you talking about the P12 file itself?  Do we  event want to suppo=
rt
> encrypted P12 files?

We only support encrypted PKCS#12 structs, I haven't seen unencrypted ones.

>
> Note that P12 file might have an import key that is different than the
> ClientKeyPassword.  So how are you handling that?  Is the user providing =
two
> passwords somehow?

I'm handling the format that I know is in use or supported by NM, so
far.  I think that's what we normally want IWD.

What the spec says is that you can have an authentication password
different from the encryption password, or you can use public keys for
either the authentication or encryption, but I haven't seen files
using any of those features.  I haven't seen software that can produce
them, or NM / wpa_s support for that (neither multiple passwords nor
public key authentication or encryption).  We can look into that once we
have a use case.

Best regards

* Specifically you don't always know what is inside a PKCS#12
container depending on how it's structured.  With openssl you know
when a private key is present because it would not encrypt the
Shrouded PKCS8 Key Bag type, and it would encrypt everything else as
one opaque safe bag type.
--===============7641963577095014524==--

