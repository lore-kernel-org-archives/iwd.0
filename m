Content-Type: multipart/mixed; boundary="===============5381369027507837393=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel at holtmann.org>
To: iwd at lists.01.org
Subject: Re: [RFC 2/2] network: add support for encrypted Passphrase/PSK
Date: Fri, 21 Jan 2022 15:53:13 +0100
Message-ID: <3F712928-7ABB-4E97-879E-13643C3F08DD@holtmann.org>
In-Reply-To: 20220121004130.2473281-3-prestwoj@gmail.com

--===============5381369027507837393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

> Two keys were added: PreSharedKeyEncrypted, PassphraseEncrypted which
> are now automatically set/loaded if SystemdEncrypt=3Dtrue.
> =

> When transitioning to this option any existing provisioning files will
> be read in as plaintext but when synced the *Encrypted options will be
> used instead. After that the file will no longer contain any plaintext
> psk/passphrase values.
> =

> The encryption itself uses AES-CTR with a zero IV. This is to avoid
> extra padding and dealing with block sizes. A magic 32 bit value is
> prepended to the beginning of the plaintext data to serve as verification
> that the decryption succeeded.

so this is a bad idea. If two independent networks happen to use the same p=
assphrase or PSK, then the encrypted data will be the same. You need to sal=
t the encryption so that even if the plaintext is the same, the encrypted d=
ata is different (give that you use the same key).

Regards

Marcel

--===============5381369027507837393==--

