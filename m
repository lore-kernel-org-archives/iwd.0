Content-Type: multipart/mixed; boundary="===============0482511878282575453=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel at holtmann.org>
To: iwd at lists.01.org
Subject: Re: [RFC 0/2] Encrypt secrets using systemd provided key
Date: Fri, 21 Jan 2022 16:20:10 +0100
Message-ID: <358D320D-57E1-45B2-9EED-EC848D10EF5A@holtmann.org>
In-Reply-To: 20220121004130.2473281-1-prestwoj@gmail.com

--===============0482511878282575453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

> There has been interest in enabling IWD users to store their network
> credentials in some encrypted form. Recently systemd added support for
> passing secrets/credentials to services only accessible by the service
> they are intended. This provides a clean way of obtaining a secret key
> which IWD can use to encrypt anything it writes to the FS. In addition
> there is no hard dependency on systemd since the credential is provided
> as a file (i.e. no Dbus API or linked library etc).
> =

> At the moment setting up the IWD service to use this feature will be
> left up to the user. But setting this up is very straight forward. I
> used docs for systemd-creds (Example 2):
> =

> https://www.freedesktop.org/software/systemd/man/systemd-creds.html
> =

> The only difference is the --name argument should be iwd-secret.
> =

> Note: systemd version 250 is required.
> =

> The reason this is being sent as an RFC is because of some open questions
> I had and wanted feedback on:
> =

> 1. What options specifically do we want encrypted? These patches only
>    address Passphrase and PreSharedKey but really any option could be
>    encrypted. Obviously we would also want 802.1x secrets, but are there
>    other non-obvious options with privacy concerns?

we only need to encrypt things that are provided by the user. If we wouldn=
=E2=80=99t ask the user for it, then it is not worth while protecting.

> 2. What is the stance on existing provisioning files? Currently these
>    changes overwrite any existing files with the new *Encrypted options
>    automatically. Is this desirable? or should user have to opt-in their
>    existing provisioning files.

The problem arises that you no longer can move from one machine to the next=
 without re-entering your secrets. So I guess this only desirable if the ma=
ster key is part of your users keyring. If you have 200 PSKs entered and yo=
u set up a new machine, you now end up having to re-enter these as you go v=
isiting new networks.

> 3. Is the secret provided via a file enough? (the secret is still stored
>    as plaintext *somewhere*, though systemd limits permissions). Systemd
>    supports an IPC mechanism to obtain the secret. Is this more secure?

>From iwd perspective it is always a file. systemd does the reading from an =
AF_UNIX socket and storing it as a file. When IPC part becomes interesting =
if you want to provide an iwd-secrets-provider tool.

Note: At least that is how I understood the man page. I have not verified t=
his in the systemd sources.

> 4. Should full provisioning file encryption be optional/supported? I felt
>    it was best to only encrypt sensitive options like PSK/Passphrase which
>    would allow editing of the provisioning file without extra steps of
>    decrypting, editing, and encrypting. I think this is above the capabil=
ity
>    or desire of most users.
> =

>    If, though, a provisioning file is never expected to change or issued =
by
>    a network administrator that does not want it edited I could see full
>    file encryption being ok.

What you want is that system / networks admins can sign their provision fil=
e and you would verify that it is unmodified. That is generally useful as w=
ell, but we would need to discuss where the certificate that you verify aga=
inst comes from.

Regards

Marcel

--===============0482511878282575453==--

