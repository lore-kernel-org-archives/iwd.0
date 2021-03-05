Content-Type: multipart/mixed; boundary="===============0165845785041328035=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/10] ap: Load profile before calling ap_start, extend
 Address syntax
Date: Sat, 06 Mar 2021 00:51:13 +0100
Message-ID: <CAOq732Kx5m+fDJCswFc-fpGVXvD7QJXQs=se13Xnsn6u0wgNFg@mail.gmail.com>
In-Reply-To: <36f74829-cb08-8bcc-c06d-4a5939b5ffb3@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0165845785041328035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Mar 2021 at 23:19, Denis Kenzior <denkenz@gmail.com> wrote:
> On 3/5/21 9:09 AM, Andrew Zaborowski wrote:
> > After the profile support was added some settings were passed to
> > ap_start() through the ap_config struct and others were loaded inside
> > ap_start() based on the profile path.  Instead make profiles transparent
> > to ap_start():
> >
> > * don't pass the profile path to ap_start(),
> > * add storage for the profile settings directly to ap_config,
>
> This is ok, but I would actually load them directly into the l_dhcp_serve=
r object

So the idea is that struct ap_config is part of the public API.  Right
now only P2P uses it but the idea was that it can be mapped directly
to a config file, that's why we didn't add callbacks or other
complicated structures to it.

I guess P2P could create an l_dhcp_server object and store it the
ap_config object but that would limit what we can do with struct
ap_config.

Also each of the 3 callers of ap_start() would need to know whether
netconfig is enabled, do the address selection (hopefully
consistently) and create their own l_dhcp_server object.

>
> > * load and validate the settings from the profile file directly
> >    in the caller (ap_dbus_start_profile).
> >
> > Now any user of the ap_start() api can set those values and the
> > difference between .Start and .StartProfile is only that one loads the
> > extra settings from the profile whlie the other relies on the defaults.
>
> typo 'whlie'
>
> >
> > Temporarily drop most of the DHCP setup code as it needs to be rewritten
> > to account for the new setting syntax and setup order, this happens in
> > the subsequent commits in steps.
> >
> > While I'm rewriting the profile loading I also expand the [IPv4].Address
> > syntax to allow a new format: a list of <IP>/<prefix_len> -form strings
> > that define the address space for subnet address selection.
>
> Not ideal, but ok..

I couldn't think of a different way to split the changes.

>
> > ---
> >   src/ap.c | 425 ++++++++++++++++++++++---------------------------------
> >   src/ap.h |  10 +-
> >   2 files changed, 180 insertions(+), 255 deletions(-)
> >
> > diff --git a/src/ap.c b/src/ap.c
> > index 2042cde6..677ba8fa 100644
> > --- a/src/ap.c
> > +++ b/src/ap.c
> > @@ -225,6 +225,171 @@ static const char *broadcast_from_ip(const char *=
ip)
> >       return inet_ntoa(ia);
> >   }
> >
> > +#define AP_DEFAULT_IPV4_PREFIX_LEN 28
> > +
> > +struct ap_config *ap_config_load_profile(const char *ssid)
> > +{
> > +     L_AUTO_FREE_VAR(char *, profile_path) =3D
> > +             storage_get_path("ap/%s.ap", ssid);
> > +     L_AUTO_FREE_OBJ(l_settings, profile) =3D l_settings_new();
>
> So I can't apply this until the ell part is figured out.  Way to live on
> bleeding edge :)

This has served as a test and as a usage example and I assumed
(correctly) that I'd have a few more chances to drop it ;)

>
> > +     L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
> > +     struct ap_config *config;
> > +     uint32_t static_addr4 =3D 0;
> > +     unsigned int lease_time;
> > +
> > +     if (!l_settings_load_from_file(profile, profile_path))
> > +             return NULL;
> > +
> > +     passphrase =3D l_settings_get_string(profile, "Security",
> > +                                                     "Passphrase");
> > +     if (!passphrase) {
> > +             l_error("[Security].Passphrase not found in "
> > +                     "AP profile");
>
> Hmm, don't we have open network profiles?

So I think we did have open profiles (because profile loading didn't
strictly require [Security].Passphrase) but we had no open AP
implementation ;)

>
> > +             return NULL;
> > +     }
> > +
> > +     /* Full checks done later in crypto_passphrase_is_valid() */
> > +     if (strlen(passphrase) > 63) {
>
> I wonder why we would want to delay this?  Also, where does this check ac=
tually
> happen?  I can't seem to find this in this patch set?  Or do you mean som=
ewhere
> inside ap_start when we try to generate the PSK?

Yep, in crypto_psk_from_passphrase()

>
> I would actually run the full sanity check here...

Ok.

Best regards
--===============0165845785041328035==--

