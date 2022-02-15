Content-Type: multipart/mixed; boundary="===============5640230744477747116=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v8 1/6] storage: implement network profile encryption
Date: Tue, 15 Feb 2022 17:48:16 -0600
Message-ID: <3ed2a129-abbb-ceb4-d2fe-be8b10e2fbb9@gmail.com>
In-Reply-To: 20220215214134.1335469-1-prestwoj@gmail.com

--===============5640230744477747116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2/15/22 15:41, James Prestwood wrote:
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

> storage_init/exit():
> This sets/cleans up the encryption key direct from systemd then uses extr=
act
> and expand to create a new fixed length key to do encryption/decryption.
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
>   src/storage.c | 315 ++++++++++++++++++++++++++++++++++++++++++++++++--
>   src/storage.h |  10 ++
>   3 files changed, 316 insertions(+), 12 deletions(-)
> =


I went ahead and applied everything in this set (except patch 4) with some =

slight modifications.  Mostly just small nitpick fixes, clarifying some com=
ments =

and taking care of some >80 char lines.

Regards,
-Denis
--===============5640230744477747116==--

