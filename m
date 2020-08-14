Content-Type: multipart/mixed; boundary="===============8144978104625297736=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 11/16] eap-wsc: Registrar mode settings loading
Date: Fri, 14 Aug 2020 02:46:04 +0200
Message-ID: <CAOq732LmG4MksJm8MZfHs5O8J4X2Meu9dG-VT76oe3Ay4RMkbA@mail.gmail.com>
In-Reply-To: <67228342-87d2-9b90-8f45-8aa4b93478e3@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8144978104625297736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Aug 2020 at 18:25, Denis Kenzior <denkenz@gmail.com> wrote:
> On 8/12/20 7:53 PM, Andrew Zaborowski wrote:
> > +static bool eap_wsc_load_common(struct eap_state *eap,
> > +                                     struct l_settings *settings,
> > +                                     bool registrar)
>
> so based on the name, I'd expect this function to do the common things, n=
ot
> if-else everything based on registrar variable.  The if-else also leads to
> excessive nesting, which we should avoid...
>
> Perhaps it would be nicer if things that are only applicable to the parti=
cular
> role are moved in the specific load_settings functions below.

Ok, makes sense.

>
> > +{
> > +     struct eap_wsc_state *wsc;
> > +     const char *v;
> > +     uint8_t private_key[192];
> > +     size_t len;
> > +     unsigned int u32;
> > +     char *str;
> > +
> > +     wsc =3D l_new(struct eap_wsc_state, 1);
> > +     wsc->registrar =3D registrar;
> > +
> > +     if (registrar)
> > +             wsc->state =3D STATE_EXPECT_IDENTITY;
> > +     else
> > +             wsc->state =3D STATE_EXPECT_START;
>
> This for example can be set directly without a need for if-else
>
> > +
> > +     /*
> > +      * On the Enrollee we fill in all of the M1 data so that it's rea=
dy
> > +      * to send.  On the Registrar we store some information in wsc->m1
> > +      * for the actual M1's validation, and we fill in the elements of=
 M2
> > +      * that don't depend on the received M1 data.
> > +      */
> > +     wsc->m1 =3D l_new(struct wsc_m1, 1);
> > +
> > +     if (registrar)
> > +             wsc->m2 =3D l_new(struct wsc_m2, 1);
> > +     else {
> > +             wsc->m1->version2 =3D true;
> > +             wsc->m1->state =3D WSC_STATE_NOT_CONFIGURED;
> > +             wsc->m1->association_state =3D WSC_ASSOCIATION_STATE_NOT_=
ASSOCIATED;
> > +             wsc->m1->configuration_error =3D WSC_CONFIGURATION_ERROR_=
NO_ERROR;
> > +
> > +             wsc->m1->auth_type_flags =3D
> > +                                     WSC_AUTHENTICATION_TYPE_WPA2_PERS=
ONAL |
> > +                                     WSC_AUTHENTICATION_TYPE_WPA_PERSO=
NAL |
> > +                                     WSC_AUTHENTICATION_TYPE_OPEN;
> > +             wsc->m1->encryption_type_flags =3D WSC_ENCRYPTION_TYPE_NO=
NE |
> > +                                             WSC_ENCRYPTION_TYPE_AES_T=
KIP;
> > +             wsc->m1->connection_type_flags =3D WSC_CONNECTION_TYPE_ES=
S;
>
> This can be set up directly in the enrolee version.
>
> > +     }
> > +
> > +     v =3D l_settings_get_value(settings, "WSC", "EnrolleeMAC");
> > +     if (!v)
> > +             goto err;
> > +
> > +     if (!util_string_to_address(v, wsc->m1->addr))
> > +             goto err;
> > +
> > +     if (!wsc_uuid_from_addr(wsc->m1->addr, wsc->m1->uuid_e))
> > +             goto err;
> > +
>
> This is common, so maybe just assume m1/m2 are created by the enrollee/re=
gistrar
> specific methods.

BTW I was thinking it'd be easier if m1/m2 were static parts of
eap_wsc_state rather than pointers.

>
> > +     if (registrar && !load_hexencoded(settings, "UUID-R",
> > +                                             wsc->m2->uuid_r, 16))
> > +             goto err;
>
> This can be put into the registrar method directly

Ok.

>
> > +
> > +     if (!l_settings_get_uint(settings, "WSC", "ConfigurationMethods",=
 &u32))
> > +             u32 =3D WSC_CONFIGURATION_METHOD_VIRTUAL_DISPLAY_PIN;
> > +
> > +     if (!registrar)
> > +             wsc->m1->config_methods =3D u32;
> > +     else
> > +             wsc->m2->config_methods =3D u32;
> > +
>
> Ok
>
> > +     if (!registrar) {
> > +             if (!load_device_data(settings,
> > +                                     wsc->m1->manufacturer,
> > +                                     wsc->m1->model_name,
> > +                                     wsc->m1->model_number,
> > +                                     wsc->m1->serial_number,
> > +                                     &wsc->m1->primary_device_type,
> > +                                     wsc->m1->device_name,
> > +                                     &wsc->m1->rf_bands,
> > +                                     &wsc->m1->os_version))
> > +                     goto err;
> > +     } else {
> > +             if (!load_device_data(settings,
> > +                                     wsc->m2->manufacturer,
> > +                                     wsc->m2->model_name,
> > +                                     wsc->m2->model_number,
> > +                                     wsc->m2->serial_number,
> > +                                     &wsc->m2->primary_device_type,
> > +                                     wsc->m2->device_name,
> > +                                     &wsc->m2->rf_bands,
> > +                                     &wsc->m2->os_version))
> > +                     goto err;
> > +     }
> >
>
> Probably these belong in the enrolee/registrar specific methods

Ok.

>
> >       if (!l_settings_get_uint(settings, "WSC", "DevicePasswordId", &u3=
2))
> >               u32 =3D WSC_DEVICE_PASSWORD_ID_PUSH_BUTTON;
> >
> > -     wsc->m1->device_password_id =3D u32;
> > +     if (!registrar)
> > +             wsc->m1->device_password_id =3D u32;
> > +     else
> > +             wsc->m2->device_password_id =3D u32;
> >
> >       wsc->device_password =3D l_settings_get_string(settings, "WSC",
> >                                                       "DevicePassword");
> > @@ -1361,11 +1411,141 @@ static bool eap_wsc_load_settings(struct eap_s=
tate *eap,
> >       } else
> >               wsc->device_password =3D l_strdup("00000000");
> >
> > -     if (!load_hexencoded(settings, "E-SNonce1", wsc->e_snonce1, 16))
> > -             l_getrandom(wsc->e_snonce1, 16);
> > +     if (registrar) {
> > +             wsc->m2->auth_type_flags =3D 0;
> >
> > -     if (!load_hexencoded(settings, "E-SNonce2", wsc->e_snonce2, 16))
> > -             l_getrandom(wsc->e_snonce2, 16);
> > +             str =3D l_settings_get_string(settings, "WSC", "WPA2-SSID=
");
> > +             if (str) {
> > +                     if (strlen(str) > 32)
> > +                             goto err;
> > +
> > +                     wsc->m2->auth_type_flags |=3D
> > +                             WSC_AUTHENTICATION_TYPE_WPA2_PERSONAL;
> > +                     wsc->m2->encryption_type_flags |=3D
> > +                             WSC_ENCRYPTION_TYPE_AES_TKIP;
> > +                     wsc->wpa2_cred.auth_type =3D
> > +                             WSC_AUTHENTICATION_TYPE_WPA2_PERSONAL;
> > +                     wsc->wpa2_cred.encryption_type =3D
> > +                             WSC_ENCRYPTION_TYPE_AES_TKIP;
> > +
> > +                     wsc->wpa2_cred.ssid_len =3D strlen(str);
> > +                     memcpy(wsc->wpa2_cred.ssid, str,
> > +                             wsc->wpa2_cred.ssid_len);
> > +                     l_free(str);
> > +
> > +                     str =3D l_settings_get_string(settings, "WSC",
> > +                                                     "WPA2-Passphrase"=
);
> > +                     if (str) {
> > +                             len =3D strlen(str);
> > +                             if (len < 8 || len > 63) {
> > +                                     explicit_bzero(str, len);
> > +                                     goto err;
> > +                             }
> > +
> > +                             memcpy(wsc->wpa2_cred.network_key, str, l=
en);
> > +                             wsc->wpa2_cred.network_key_len =3D len;
> > +                             explicit_bzero(str, len);
> > +                     } else {
> > +                             uint8_t buf[32];
> > +                             int i;
> > +                             static const char hexdigits[16] =3D
> > +                                     "0123456789ABCDEF";
> > +
> > +                             if (!load_hexencoded(settings, "WPA2-PSK",
> > +                                                     buf, 32))
> > +                                     goto err;
> > +
> > +                             for (i =3D 0; i < 32; i++) {
> > +                                     wsc->wpa2_cred.network_key[i * 2]=
 =3D
> > +                                             hexdigits[buf[i] >> 4];
> > +                                     wsc->wpa2_cred.network_key[i * 2 =
+ 1] =3D
> > +                                             hexdigits[buf[i] & 15];
> > +                             }
>
> Hmm, what is this doing actually?  Is this some elaborate scheme to make =
sure
> that WPA2-PSK is a valid hex string?

My idea was to validate the hexstring and then save an uppercase
version of it.  I think actually it was the WSC DevicePassword that is
required to be uppercase, not the Network Key.  Nevertheless it's nice
to have the Network Key all lower-case or all upper-case, I guess
l_util_hexstring would work here.

I don't think it's slower than converting the setting value char by
char if we have to validate it first.

>
> > +
> > +                             wsc->wpa2_cred.network_key_len =3D 64;
> > +                             explicit_bzero(buf, 32);
> > +                     }
> > +
> > +                     memcpy(wsc->wpa2_cred.addr, wsc->m1->addr, 6);
> > +             }
> > +
> > +             str =3D l_settings_get_string(settings, "WSC", "Open-SSID=
");
> > +             if (str) {
> > +                     if (strlen(str) > 32)
> > +                             goto err;
> > +
> > +                     wsc->m2->auth_type_flags |=3D
> > +                             WSC_AUTHENTICATION_TYPE_OPEN;
> > +                     wsc->m2->encryption_type_flags |=3D
> > +                             WSC_ENCRYPTION_TYPE_NONE;
> > +                     wsc->open_cred.auth_type =3D
> > +                             WSC_AUTHENTICATION_TYPE_OPEN;
> > +                     wsc->open_cred.encryption_type =3D
> > +                             WSC_ENCRYPTION_TYPE_NONE;
> > +
> > +                     wsc->open_cred.ssid_len =3D strlen(str);
> > +                     memcpy(wsc->open_cred.ssid, str,
> > +                             wsc->open_cred.ssid_len);
> > +                     l_free(str);
> > +
> > +                     wsc->open_cred.network_key_len =3D 0;
> > +
> > +                     memcpy(wsc->open_cred.addr, wsc->m1->addr, 6);
> > +             }
> > +
> > +             if (!wsc->m2->auth_type_flags)
> > +                     goto err;
> > +
> > +             wsc->m2->connection_type_flags =3D WSC_CONNECTION_TYPE_ES=
S;
> > +     }
>
> This whole block seems to be registrar specific...

Yep.

>
> > +
> > +     /*
> > +      * The settings we read below probably shouldn't be used except to
> > +      * eliminate randomness in debugging/tests.
> > +      */
> > +     if (registrar) {
> > +             if (!load_hexencoded(settings, "RegistrarNonce",
> > +                                             wsc->m2->registrar_nonce,=
 16))
> > +                     l_getrandom(wsc->m2->registrar_nonce, 16);
> > +     } else {
> > +             if (!load_hexencoded(settings, "EnrolleeNonce",
> > +                                             wsc->m1->enrollee_nonce, =
16))
> > +                     l_getrandom(wsc->m1->enrollee_nonce, 16);
> > +     }
> > +
>
> Individual methods here?

Ok.

>
> > +     if (load_hexencoded(settings, "PrivateKey", private_key, 192)) {
> > +             if (!l_key_validate_dh_payload(private_key, 192,
> > +                                             crypto_dh5_prime,
> > +                                             crypto_dh5_prime_size)) {
> > +                     explicit_bzero(private_key, 192);
> > +                     goto err;
> > +             }
> > +
> > +             wsc->private =3D l_key_new(L_KEY_RAW, private_key, 192);
> > +             explicit_bzero(private_key, 192);
> > +     } else
> > +             wsc->private =3D l_key_generate_dh_private(crypto_dh5_pri=
me,
> > +                                                     crypto_dh5_prime_=
size);
> > +
> > +     if (!wsc->private)
> > +             goto err;
> > +
> > +     len =3D sizeof(wsc->m1->public_key);
> > +     if (!l_key_compute_dh_public(dh5_generator, wsc->private, dh5_pri=
me,
> > +                                     registrar ? wsc->m2->public_key :
> > +                                     wsc->m1->public_key, &len))
> > +             goto err;
> > +
> > +     if (len !=3D sizeof(wsc->m1->public_key))
> > +             goto err;
>
> Ok
>
> > +
> > +     if (!load_hexencoded(settings, registrar ? "R-SNonce1" : "E-SNonc=
e1",
> > +                                                     wsc->local_snonce=
1, 16))
> > +             l_getrandom(wsc->local_snonce1, 16);
> > +
> > +     if (!load_hexencoded(settings, registrar ? "R-SNonce2" : "E-SNonc=
e2",
> > +                                                     wsc->local_snonce=
2, 16))
> > +             l_getrandom(wsc->local_snonce2, 16);
>
> Ok
>
> >
> >       if (!load_hexencoded(settings, "IV1", wsc->iv1, 16))
> >               l_getrandom(wsc->iv1, 16);
> > @@ -1373,6 +1553,9 @@ static bool eap_wsc_load_settings(struct eap_stat=
e *eap,
> >       if (!load_hexencoded(settings, "IV2", wsc->iv2, 16))
> >               l_getrandom(wsc->iv2, 16);
> >
> > +     if (registrar && !load_hexencoded(settings, "IV3", wsc->iv3, 16))
> > +             l_getrandom(wsc->iv3, 16);
> > +
>
> Seems registrar specific here as well..
>
> >       eap_set_data(eap, wsc);
> >
> >       return true;
> > @@ -1387,12 +1570,22 @@ err:
> >       if (wsc->private)
> >               l_key_free(wsc->private);
> >
> > +     explicit_bzero(&wsc->wpa2_cred, sizeof(struct wsc_credential));
> > +     explicit_bzero(&wsc->open_cred, sizeof(struct wsc_credential));
> >       l_free(wsc->m1);
> > +     l_free(wsc->m2);
> >       l_free(wsc);
>
> In theory this cleanup block can be broken up to be more granular.  For e=
xample,
> the cred zeroing can be done only in the registrar loader.
>
> But you also have most of this being done in eap_wsc_free, so depending o=
n how
> lazy you want to be, consider just calling that, or break it up into smal=
ler
> chunks and just call the relevant _free method.

Yeah, let's use eap_wsc_free I guess.

Best regards
--===============8144978104625297736==--

