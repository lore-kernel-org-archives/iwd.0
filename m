Content-Type: multipart/mixed; boundary="===============5417802855345865929=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/2] eap-tls: Make use of l_pem_load_container_file()
Date: Tue, 15 Dec 2020 09:28:50 +0100
Message-ID: <CAOq732+MiOnAkvqByTYiBMQGw_nEgRWGG8b8QJkEFmU2g3LC1Q@mail.gmail.com>
In-Reply-To: <6da633ee-4599-1649-33d9-9f05d01c7465@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5417802855345865929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 15 Dec 2020 at 02:56, Denis Kenzior <denkenz@gmail.com> wrote:
> On 12/11/20 7:09 PM, Andrew Zaborowski wrote:
> > This allows .p12 files and other formats to be used.  When a single file
> > contains both the client certificates and the private key, it can be
> > given as either EAP-{TLS,PEAP,TTLS}-ClientCert or -ClientKey.  Also both
> > settings can point to the same or different files and only the
> > certificates will be loaded from one and only the key from the other (if
> > different).
> > ---
> >   src/eap-tls-common.c | 302 +++++++++++++++++++++++++------------------
> >   1 file changed, 178 insertions(+), 124 deletions(-)
> >
>
> <snip>
>
> > @@ -1121,7 +1169,9 @@ bool eap_tls_common_settings_load(struct eap_stat=
e *eap,
> >       struct eap_tls_state *eap_tls;
> >       char setting_key[72];
> >       char *domain_mask_str;
> > -     L_AUTO_FREE_VAR(char *, value) =3D NULL;
> > +     L_AUTO_FREE_VAR(char *, ca_cert) =3D NULL;
> > +     L_AUTO_FREE_VAR(char *, client_cert) =3D NULL;
> > +     L_AUTO_FREE_VAR(char *, client_key) =3D NULL;
> >       L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
> >
> >       eap_tls =3D l_new(struct eap_tls_state, 1);
> > @@ -1130,47 +1180,51 @@ bool eap_tls_common_settings_load(struct eap_st=
ate *eap,
> >       eap_tls->variant_ops =3D variant_ops;
> >       eap_tls->variant_data =3D variant_data;
> >
> > +     snprintf(setting_key, sizeof(setting_key), "%sClientKeyPassphrase=
",
> > +                                                                     p=
refix);
> > +     passphrase =3D l_settings_get_string(settings, "Security", settin=
g_key);
> > +
>
> So this reminds me that ClientKeyPassphrase, ClientKey and ClientCert are
> already only relevant to EAP-TLS.  They probably don't even belong being =
checked
> here in eap_tls_common_settins_load, etc.

Even if you deprecate EAP-PEAP-ClientCert you'll probably want to keep
compatibility for some time.

>
> >       snprintf(setting_key, sizeof(setting_key), "%sCACert", prefix);
> > -     value =3D l_settings_get_string(settings, "Security", setting_key=
);
> > -     if (value) {
> > -             eap_tls->ca_cert =3D eap_tls_load_ca_cert(settings, value=
);
> > -             if (!eap_tls->ca_cert) {
> > -                     l_error("Could not load CACert %s", value);
> > +     ca_cert =3D l_settings_get_string(settings, "Security", setting_k=
ey);
> > +     if (ca_cert) {
> > +             eap_tls->ca_cert =3D eap_tls_load_ca_cert(settings, ca_ce=
rt);
> > +             if (!eap_tls->ca_cert)
> >                       goto load_error;
>
> Hmm, the P12 files don't contain the CA certchain?  I thought the whole p=
oint of
> these was to have the private key + public key + CA certchain?  Otherwise=
 I see
> little point in these since you effectively need to specify the P12 file =
_and_
> the CACert file?

Putting the trusted CA certs in the same file (whether .p12, .pfx or
PEM) is not a usual use case and if it exists I'd guess you have to
use some PKCS#9 attributes to identify those certificates within the
file?  NM and wpa_s don't have logic for identifying those labels
AFAIK.

You can have just your key or just your certchain or individual
trusted CA certs in .p12 files without the other parts.

>
> > -             }
> >       }
> >
> > -     l_free(value);
> > -
> >       snprintf(setting_key, sizeof(setting_key), "%sClientCert", prefix=
);
> > -     value =3D l_settings_get_string(settings, "Security", setting_key=
);
> > -     if (value) {
> > -             eap_tls->client_cert =3D eap_tls_load_client_cert(setting=
s,
> > -                                                             value);
> > -             if (!eap_tls->client_cert) {
> > -                     l_error("Could not load ClientCert %s", value);
> > -                     goto load_error;
> > -             }
> > -     }
> > -
> > -     l_free(value);
> > -
> > -     snprintf(setting_key, sizeof(setting_key), "%sClientKeyPassphrase=
",
> > -                                                                     p=
refix);
> > -     passphrase =3D l_settings_get_string(settings, "Security", settin=
g_key);
> > +     client_cert =3D l_settings_get_string(settings, "Security", setti=
ng_key);
> >
> >       snprintf(setting_key, sizeof(setting_key), "%sClientKey", prefix);
> > -     value =3D l_settings_get_string(settings, "Security", setting_key=
);
> > -     if (value) {
> > -             eap_tls->client_key =3D eap_tls_load_priv_key(settings, v=
alue,
> > +     client_key =3D l_settings_get_string(settings, "Security", settin=
g_key);
> > +
> > +     if (client_cert && is_embedded(client_cert))
> > +             eap_tls->client_cert =3D eap_tls_load_embedded_cert(setti=
ngs,
> > +                                                             client_ce=
rt);
> > +     else if (client_cert) {
> > +             l_pem_load_container_file(client_cert, passphrase,
> > +                                             &eap_tls->client_cert,
> > +                                             client_key ? NULL :
> > +                                             &eap_tls->client_key, NUL=
L);
> > +     }
> > +
> > +     if (client_key && is_embedded(client_key))
> > +             eap_tls->client_key =3D eap_tls_load_embedded_priv_key(se=
ttings,
> > +                                                             client_ke=
y,
> >                                                               passphras=
e,
> >                                                               NULL);
> > -             if (!eap_tls->client_key) {
> > -                     l_error("Could not load ClientKey %s", value);
> > -                     goto load_error;
> > -             }
> > +     else if (client_key) {
> > +             l_pem_load_container_file(client_key, passphrase,
> > +                                             client_cert ? NULL :
> > +                                             &eap_tls->client_cert,
> > +                                             &eap_tls->client_key, NUL=
L);
> >       }
> >
> > +     if ((client_cert && !eap_tls->client_cert) ||
> > +                     (client_key && !eap_tls->client_key) ||
> > +                     !eap_tls->client_cert !=3D !eap_tls->client_key)
> > +             goto load_error;
> > +
>
> So assuming that the CACert is also part of the P12, I'd think
> eap_tls_load_settings should work something like:
>
> password =3D l_settings_get(.., "ClientPassphrase");
> container =3D l_settings_get(.., "ClientKey");
>
> if (client_key_is_container) {
>    // load client_key, client_cert, ca_cert
>    // load ServerDomainMask
>    return;
> }
>
> return eap_tls_common_settings_load()

What's client_key_is_container though?  If it's something set by the
user I fear we're making things more complicated for the users than
even wpa_s is.  Also for ourselves by adding inconsistency between the
tls-based methods.

The "container" naming I used in the ell patch was about all these
certificate and/or key formats though.  Note that if we use special
settings here depending on what format we have, we're forcing the
users of this (be it IT admins) to understand more about these files.
And for me in the NM iwd-backend it may be directly impossible to
convert those EAP settings if I have to detect what is stored inside
the file since I can't decrypt it.

Best regards
--===============5417802855345865929==--

