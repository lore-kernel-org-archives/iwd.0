Content-Type: multipart/mixed; boundary="===============6860345950274673060=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v7 3/8] storage: implement network profile encryption
Date: Mon, 14 Feb 2022 09:30:46 -0800
Message-ID: <873caee451511b8f106eb803eba52a6d618847ea.camel@gmail.com>
In-Reply-To: 9718E496-59CC-4B34-A303-EAECFD409190@holtmann.org

--===============6860345950274673060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

<snip>

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ad[0].iov_base =3D (void *) =
salt;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ad[0].iov_len =3D 32;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ad[1].iov_base =3D (void *) =
ssid;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ad[1].iov_len =3D strlen(ssi=
d);
> =

> you want to use the SSID as string here since that is how we store
> it? Or would you rather use the fixed size binary blob of the SSID on
> how it goes over the air? So a comment is required here.

So pad the SSID with zero's? I'm not sure this really adds much except
an extra step. But I can leave a comment, or if you have a specific
reason for doing it I'm all ears.
> =

> =


<snip>

> > +/*
> > + * Initialize a systemd encryption key for encrypting/decrypting
> > credentials.
> > + * This uses the 'extract and expand' concept from RFC 5869 to
> > derive a new,
> > + * fixed length, key.
> > + */
> > +void __storage_set_encryption_key(const uint8_t *key, size_t
> > key_len)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint8_t tmp[32];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!hkdf_extract(L_CHECKSUM=
_SHA256, NULL, 0, 1, tmp, key,
> > key_len))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!hkdf_expand(L_CHECKSUM_=
SHA256, tmp, sizeof(tmp), "IWD
> > System Key",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0system_key, sizeof(system_key)))
> =

> So I have a dislike putting the IWD name in front of it. They are
> daemon specific to begin with. I would leave it at =E2=80=9CSystem Key=E2=
=80=9D. Key
> names should be domain specific and any attempt to make the globally
> unique will fail anyway.
> =

> The actual key is required to be provided by a human user creating
> the unit file. And thus it is specific to iwd=E2=80=99s unit file. If they
> end up re-using this for another daemon, then that is just plain
> stupid.

Sure, makes sense.

> =

> Now that all said, I am not sure you are using this correctly. I know
> you have defined the extract and expand functions, but I was really
> more thinking about the simple version of this:
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interim-key =3D func(SALT=
, system-key)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encryption-key =3D func(i=
nterim-key, =E2=80=9CSystem Key=E2=80=9D)
> =

> While the SALT is just a 32 octet random string instead of the
> default sequence of 0x00.
> =

> Since later on your are using AES for the encryption with a 128-bit
> key, I would recommend to just go with AES-CMAC. That means you can
> define func as this:
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0func(K, ID) =3D AES-CMAC(=
K, ID)
> =

> Where K is the 128-bit key into the AES-CMAS hash.

Maybe I'm missing something with how AES-CMAC works, but using a random
salt for the system key like this is going to result in a different
system key on each boot/run right? So I don't think that is going to
work. RFC 5869 mentions using a zero salt like I do here, basically
'salt' is optional.

Also I'm not sure why we want to define our own KDF (using AES-CMAC)
when extract-and-expand already exists for this purpose. I think NIST
even recommends using extract-and-expand KDFs.

> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0L_WARN_ON(mlock(system_key, =
sizeof(system_key)) < 0);
> =

> Actually, better to just abort here. Let it fail if we can=E2=80=99t lock=
 the
> memory. Otherwise also you call to unlock below is unbalanced.
> =

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0system_key_set =3D true;
> > +}
> > +
> > static int storage_init(void)
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *state_dir;
> > @@ -466,6 +726,11 @@ static void storage_exit(void)
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_free(storage_path);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_free(storage_hotspot_=
path);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (system_key_set) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0explicit_bzero(system_key, sizeof(system_key));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0munlock(system_key, sizeof(system_key));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > }
> > =

> > IWD_MODULE(storage, storage_init, storage_exit);
> > diff --git a/src/storage.h b/src/storage.h
> > index f75185f6..a3ae71be 100644
> > --- a/src/storage.h
> > +++ b/src/storage.h
> > @@ -48,3 +48,11 @@ int storage_network_remove(enum security type,
> > const char *ssid);
> > =

> > struct l_settings *storage_known_frequencies_load(void);
> > void storage_known_frequencies_sync(struct l_settings
> > *known_freqs);
> > +
> > +void __storage_set_encryption_key(const uint8_t *key, size_t
> > key_len);
> > +int __storage_decrypt(struct l_settings *settings, const char
> > *ssid,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool *changed);
> > +char *__storage_encrypt(const struct l_settings *settings, const
> > char *ssid,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t *out_len);
> > +bool __storage_open(struct l_settings *settings, const char *path,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum s=
ecurity type, const char *name);
> =

> Regards
> =

> Marcel
> =


Thanks,
James


--===============6860345950274673060==--

