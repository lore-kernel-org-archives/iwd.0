Content-Type: multipart/mixed; boundary="===============7074601103221401792=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 1/7] storage: implement network profile encryption
Date: Fri, 04 Feb 2022 11:16:16 -0600
Message-ID: <384a83c1-820b-351a-3b99-8e2e1ee5b0b0@gmail.com>
In-Reply-To: 20220203212337.120613-1-prestwoj@gmail.com

--===============7074601103221401792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/3/22 15:23, James Prestwood wrote:
> Some users don't like the idea of storing network credentials in plaintext
> on the file system. As far as IWD goes the credential directory permissio=
ns
> should be set up such that nobody but the owner/root have access but
> nevertheless they are still plaintext.
> =

> For added security these credentials can be encrypted using a secret key.
> In this patch the origination of the key does not matter, but in this
> patch series IWD will support a systemd provided key.
> =

> The encryption itself will operate on the entire [Security] group as well
> as all embedded groups. Once encrypted the [Security] group will be repla=
ced
> with two key/values:
> =

> EncryptedSalt - A random string of bytes used for the encryption
> EncryptedSecurity - A string of bytes containing the encrypted [Security]
>                      group, as well as all embedded groups.
> =

> After the profile has been encrypted these values should not be modified.
> Note that any values added to [Security] after encryption has no effect.
> Once the profile is encrypted there is no way to modify [Security] without
> manually decrypting first, or just removing it entirely which effectively
> treated a 'new' profile.
> =

> The encryption/decryption is done using AES-SIV with a salt value and the
> network SSID as the IV.
> =

> Once a key is set any profiles opened will automatically be encrypted and
> re-written to disk. Modules using network_storage_open will be provided
> the decrypted profile, and will be unaware it was ever encrypted in the
> first place. Similarly when network_storage_sync is called the profile
> will by automatically encrypted and written to disk without the caller
> needing to do anything special.
> =

> A few private storage.c helpers were added to serve several purposes:
> =

> __storage_set_encryption_key():
> This sets the encryption key direct from systemd then uses extract and ex=
pand
> to create a new fixed length key to do encryption/decryption.
> =

> __storage_decrypt():
> Low level API to decrypt an l_settings object using a previously set key =
and
> the SSID/name for the network. This returns a 'changed' out parameter sig=
nifying
> that the settings need to be encrypted and re-written to disk. The purpos=
e of
> exposing this is for a standalone decryption tool which does not re-write=
 any
> settings.
> =

> __storage_open():
> Wrapper around __storage_decrypt() that handles re-writing a new profile =
to
> disk. This was exposed in order to support hotspot profiles.
> =

> __storage_encrypt():
> Encrypts an l_settings object and returns the full profile as data
> ---
>   Makefile.am   |   3 +-
>   src/storage.c | 268 +++++++++++++++++++++++++++++++++++++++++++++++---
>   src/storage.h |   8 ++
>   3 files changed, 267 insertions(+), 12 deletions(-)
> =

> v3:
>   * Created and exposed __storage_open for use in hotspot.
>   * Use extract-and-expand APIs to create encryption key
> =


This is looking pretty good to me now.  Just a few minor points:

> +/*
> + * Encrypt needed groups of 'settings' without modifying the object. Ret=
urns
> + * the entire settings object as data, with encrypted groups as a bytest=
ring
> + * set as the value to [Security].EncryptedSecurity. This also includes =
any
> + * embedded groups.
> + *
> + * Note: If encryption is not enabled or there is no Security group this=
 is
> + *       effectively l_settings_to_data.
> + */
> +char *__storage_encrypt(struct l_settings *settings, const char *ssid,

should the settings object be const?

> +				size_t *out_len)
> +{
> +	struct iovec ad[2];
> +	uint8_t salt[32];
> +	size_t len;
> +	_auto_(l_free) struct l_settings *to_encrypt =3D NULL;
> +	_auto_(l_free) struct l_settings *original =3D NULL;

I think you mean l_settings_free here.

> +	_auto_(l_free) char *plaintext =3D NULL;
> +	_auto_(l_free) uint8_t *enc =3D NULL;
> +	_auto_(l_strv_free) char **groups =3D NULL;
> +	char **i;
> +
> +	if (!system_key_set || !l_settings_has_group(settings, "Security"))
> +		return l_settings_to_data(settings, out_len);
> +
> +	/*
> +	 * Make two copies of the settings: One will contain only data to be
> +	 * encrypted (to_encrypt), the other will contain data to be left
> +	 * unencrypted (original). At the end any encrypted data will be set
> +	 * into 'original' as EncryptedSecurity.
> +	 */
> +	to_encrypt =3D l_settings_clone(settings);
> +	original =3D l_settings_clone(settings);
> +
> +	groups =3D l_settings_get_groups(to_encrypt);
> +	for (i =3D groups; *i; i++) {
> +		if (encrypt_group(*i))
> +			l_settings_remove_group(original, *i);
> +		else
> +			l_settings_remove_group(to_encrypt, *i);
> +	}
> +
> +	l_settings_remove_embedded_groups(original);
> +
> +	plaintext =3D l_settings_to_data(to_encrypt, &len);
> +	if (!plaintext)
> +		return NULL;
> +
> +	l_getrandom(salt, 32);
> +
> +	ad[0].iov_base =3D (void *) salt;
> +	ad[0].iov_len =3D 32;
> +	ad[1].iov_base =3D (void *) ssid;
> +	ad[1].iov_len =3D strlen(ssid);
> +
> +	enc =3D l_malloc(len + 16);
> +
> +	if (!aes_siv_encrypt(system_key, sizeof(system_key), plaintext, len,
> +				ad, 2, enc)) {
> +		l_error("Could not encrypt [Security] group");
> +		return NULL;
> +	}
> +
> +	l_settings_set_bytes(original, "Security", "EncryptedSalt", salt, 32);
> +	l_settings_set_bytes(original, "Security", "EncryptedSecurity",
> +				enc, len + 16);
> +
> +	return l_settings_to_data(original, out_len);
> +}
> +
> +/*
> + * Decrypt data in [Security].EncryptedSecurity. This data also includes
> + * embedded groups potentially. Once decrypted the data is put back into=
 the
> + * object.
> + *
> + * Note: if encryption is not enabled or there is no Security group sett=
ings
> + *       is not modified.
> + */
> +int __storage_decrypt(struct l_settings *settings, const char *ssid,
> +				bool *changed)
> +{
> +	_auto_(l_settings_free) struct l_settings *security =3D NULL;
> +	_auto_(l_free) uint8_t *encrypted =3D NULL;
> +	_auto_(l_free) uint8_t *decrypted =3D NULL;
> +	_auto_(l_free) uint8_t *salt =3D NULL;
> +	_auto_(l_strv_free) char **embedded =3D NULL;
> +	size_t elen, slen;
> +	struct iovec ad[2];
> +
> +	if (!system_key_set)
> +		goto done;
> +
> +	if (!l_settings_has_group(settings, "Security"))
> +		goto done;
> +
> +	encrypted =3D l_settings_get_bytes(settings, "Security",
> +						"EncryptedSecurity", &elen);
> +	salt =3D l_settings_get_bytes(settings, "Security",
> +						"EncryptedSalt", &slen);
> +
> +	/*
> +	 * Either profile has never been loaded after enabling encryption or is
> +	 * missing Encrypted{Salt,Security} values. If either are missing this
> +	 * profile is corrupted and must be fixed.
> +	 */
> +	if (!(encrypted && salt)) {
> +		/* Profile corrupted */
> +		if (encrypted || salt) {
> +			l_warn("Profile %s is corrupted reconfigure manually",
> +					ssid);
> +			return -EBADMSG;
> +		}
> +
> +		if (changed)
> +			*changed =3D true;
> +
> +		return 0;
> +	}
> +
> +	decrypted =3D l_malloc(elen - 16 + 1);
> +
> +	ad[0].iov_base =3D (void *)salt;
> +	ad[0].iov_len =3D slen;
> +	ad[1].iov_base =3D (void *)ssid;
> +	ad[1].iov_len =3D strlen(ssid);
> +
> +	if (!aes_siv_decrypt(system_key, sizeof(system_key), encrypted, elen,
> +				ad, 2, decrypted)) {
> +		l_error("Could not decrypt %s profile, did the secret change?",
> +				ssid);
> +		return -ENOKEY;
> +	}
> +
> +	decrypted[elen - 16] =3D '\0';
> +
> +	/* Remove encrypted [Security], and copy the decrypted one */
> +	l_settings_remove_group(settings, "Security");

Do you want to replace this with a for loop removing all groups listed in t=
he =

encrypt_groups array?

Should you also be removing any embedded groups just in case?

> +
> +	/*
> +	 * Load decrypted data into existing settings. This is not how the API
> +	 * is indended to be used (since this could result in duplicate groups)
> +	 * but since the Security group was just removed and EncryptedSecurity
> +	 * should only contain a Security group its safe to use it this way.
> +	 */
> +	if (!l_settings_load_from_data(settings, (const char *) decrypted,
> +					elen - 16)) {
> +		l_error("Could not load decrypted security group");
> +		return -EBADMSG;
> +	}
> +
> +done:
> +	if (changed)
> +		*changed =3D false;
> +
> +	return 0;
> +}
> +

Regards,
-Denis
--===============7074601103221401792==--

