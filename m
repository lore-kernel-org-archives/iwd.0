Content-Type: multipart/mixed; boundary="===============3995418565869069134=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] eap-tls: Make use of l_pem_load_container_file()
Date: Tue, 15 Dec 2020 16:24:30 +0000
Message-ID: <a8848e00-1f52-c81a-7350-bf31744af814@gmail.com>
In-Reply-To: <CAOq732+MiOnAkvqByTYiBMQGw_nEgRWGG8b8QJkEFmU2g3LC1Q@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3995418565869069134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> So this reminds me that ClientKeyPassphrase, ClientKey and ClientCert are
>> already only relevant to EAP-TLS.  They probably don't even belong being=
 checked
>> here in eap_tls_common_settins_load, etc.
> =

> Even if you deprecate EAP-PEAP-ClientCert you'll probably want to keep
> compatibility for some time.
> =


Deprecate?  It was never supposed to be supported.  See 'man iwd.network.5'=
. =

These options are only for TLS.  The use o EAP-PEAP/TTLS-ClientCert is just=
 an =

artifact of how this was implemented originally.

>>
>>>        snprintf(setting_key, sizeof(setting_key), "%sCACert", prefix);
>>> -     value =3D l_settings_get_string(settings, "Security", setting_key=
);
>>> -     if (value) {
>>> -             eap_tls->ca_cert =3D eap_tls_load_ca_cert(settings, value=
);
>>> -             if (!eap_tls->ca_cert) {
>>> -                     l_error("Could not load CACert %s", value);
>>> +     ca_cert =3D l_settings_get_string(settings, "Security", setting_k=
ey);
>>> +     if (ca_cert) {
>>> +             eap_tls->ca_cert =3D eap_tls_load_ca_cert(settings, ca_ce=
rt);
>>> +             if (!eap_tls->ca_cert)
>>>                        goto load_error;
>>
>> Hmm, the P12 files don't contain the CA certchain?  I thought the whole =
point of
>> these was to have the private key + public key + CA certchain?  Otherwis=
e I see
>> little point in these since you effectively need to specify the P12 file=
 _and_
>> the CACert file?
> =

> Putting the trusted CA certs in the same file (whether .p12, .pfx or
> PEM) is not a usual use case and if it exists I'd guess you have to
> use some PKCS#9 attributes to identify those certificates within the
> file?  NM and wpa_s don't have logic for identifying those labels
> AFAIK.

I actually really wonder about the utility of these p12 files.  We already =
have =

a bit of an issue with iwd not being allowed to access user home directorie=
s (by =

systemd for example).  Which is why I'd like to move to the embedded format=
 as =

much as possible.  With PEMs we at least have the ability to embed all cert=
s =

into the settings file easily.

> =

> You can have just your key or just your certchain or individual
> trusted CA certs in .p12 files without the other parts.
> =


I'm pretty sure CA certs can be included in the p12 file for use on Android=
 for =

example.  Maybe we should look into how this is done?

>>
>>> -             }
>>>        }
>>>
>>> -     l_free(value);
>>> -
>>>        snprintf(setting_key, sizeof(setting_key), "%sClientCert", prefi=
x);
>>> -     value =3D l_settings_get_string(settings, "Security", setting_key=
);
>>> -     if (value) {
>>> -             eap_tls->client_cert =3D eap_tls_load_client_cert(setting=
s,
>>> -                                                             value);
>>> -             if (!eap_tls->client_cert) {
>>> -                     l_error("Could not load ClientCert %s", value);
>>> -                     goto load_error;
>>> -             }
>>> -     }
>>> -
>>> -     l_free(value);
>>> -
>>> -     snprintf(setting_key, sizeof(setting_key), "%sClientKeyPassphrase=
",
>>> -                                                                     p=
refix);
>>> -     passphrase =3D l_settings_get_string(settings, "Security", settin=
g_key);
>>> +     client_cert =3D l_settings_get_string(settings, "Security", setti=
ng_key);
>>>
>>>        snprintf(setting_key, sizeof(setting_key), "%sClientKey", prefix=
);
>>> -     value =3D l_settings_get_string(settings, "Security", setting_key=
);
>>> -     if (value) {
>>> -             eap_tls->client_key =3D eap_tls_load_priv_key(settings, v=
alue,
>>> +     client_key =3D l_settings_get_string(settings, "Security", settin=
g_key);
>>> +
>>> +     if (client_cert && is_embedded(client_cert))
>>> +             eap_tls->client_cert =3D eap_tls_load_embedded_cert(setti=
ngs,
>>> +                                                             client_ce=
rt);
>>> +     else if (client_cert) {
>>> +             l_pem_load_container_file(client_cert, passphrase,
>>> +                                             &eap_tls->client_cert,
>>> +                                             client_key ? NULL :
>>> +                                             &eap_tls->client_key, NUL=
L);
>>> +     }
>>> +
>>> +     if (client_key && is_embedded(client_key))
>>> +             eap_tls->client_key =3D eap_tls_load_embedded_priv_key(se=
ttings,
>>> +                                                             client_ke=
y,
>>>                                                                passphra=
se,
>>>                                                                NULL);
>>> -             if (!eap_tls->client_key) {
>>> -                     l_error("Could not load ClientKey %s", value);
>>> -                     goto load_error;
>>> -             }
>>> +     else if (client_key) {
>>> +             l_pem_load_container_file(client_key, passphrase,
>>> +                                             client_cert ? NULL :
>>> +                                             &eap_tls->client_cert,
>>> +                                             &eap_tls->client_key, NUL=
L);
>>>        }
>>>
>>> +     if ((client_cert && !eap_tls->client_cert) ||
>>> +                     (client_key && !eap_tls->client_key) ||
>>> +                     !eap_tls->client_cert !=3D !eap_tls->client_key)
>>> +             goto load_error;
>>> +
>>
>> So assuming that the CACert is also part of the P12, I'd think
>> eap_tls_load_settings should work something like:
>>
>> password =3D l_settings_get(.., "ClientPassphrase");
>> container =3D l_settings_get(.., "ClientKey");
>>
>> if (client_key_is_container) {
>>     // load client_key, client_cert, ca_cert
>>     // load ServerDomainMask
>>     return;
>> }
>>
>> return eap_tls_common_settings_load()
> =

> What's client_key_is_container though?  If it's something set by the
> user I fear we're making things more complicated for the users than
> even wpa_s is.  Also for ourselves by adding inconsistency between the
> tls-based methods.

What inconsistency?  As I pointed out earlier, ClientKey and ClientCert are=
 TLS =

only.

client_key_is_container would basically indicate whether the file was a p12=
 or =

not.  If the p12 does not contain ca_certs, then this could be written as:

password =3D ...
container =3D ...

if (client_key_is_p12) {
	// load client_key, client_cert
	goto done;
}

// Load client key, client_cert the usual way

done:
	return eap_tls_common_settings_load();

where common_settings_load only cares about the CACerts and ServerDomainMas=
k.

> =

> The "container" naming I used in the ell patch was about all these
> certificate and/or key formats though.  Note that if we use special
> settings here depending on what format we have, we're forcing the
> users of this (be it IT admins) to understand more about these files.

??

> And for me in the NM iwd-backend it may be directly impossible to
> convert those EAP settings if I have to detect what is stored inside
> the file since I can't decrypt it.
>
The P12 file contains a public certificate and a (possibly encrypted) priva=
te =

key.  You're not getting to the encrypted private key without the user =

password...  But this is the same as if we had a PEM with an encrypted priv=
ate =

key.  So I don't see a problem...?

Or are you talking about the P12 file itself?  Do we  event want to support =

encrypted P12 files?

Note that P12 file might have an import key that is different than the =

ClientKeyPassword.  So how are you handling that?  Is the user providing tw=
o =

passwords somehow?

Regards,
-Denis
--===============3995418565869069134==--

