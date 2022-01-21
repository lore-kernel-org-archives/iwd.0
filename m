Content-Type: multipart/mixed; boundary="===============3540728916077606071=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [RFC 0/2] Encrypt secrets using systemd provided key
Date: Fri, 21 Jan 2022 12:19:16 -0800
Message-ID: <6c282c5ba41e220c4cd862ee920b7164618e4390.camel@gmail.com>
In-Reply-To: 358D320D-57E1-45B2-9EED-EC848D10EF5A@holtmann.org

--===============3540728916077606071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Fri, 2022-01-21 at 16:20 +0100, Marcel Holtmann wrote:
> Hi James,
> =

> > There has been interest in enabling IWD users to store their
> > network
> > credentials in some encrypted form. Recently systemd added support
> > for
> > passing secrets/credentials to services only accessible by the
> > service
> > they are intended. This provides a clean way of obtaining a secret
> > key
> > which IWD can use to encrypt anything it writes to the FS. In
> > addition
> > there is no hard dependency on systemd since the credential is
> > provided
> > as a file (i.e. no Dbus API or linked library etc).
> > =

> > At the moment setting up the IWD service to use this feature will
> > be
> > left up to the user. But setting this up is very straight forward.
> > I
> > used docs for systemd-creds (Example 2):
> > =

> > https://www.freedesktop.org/software/systemd/man/systemd-creds.html
> > =

> > The only difference is the --name argument should be iwd-secret.
> > =

> > Note: systemd version 250 is required.
> > =

> > The reason this is being sent as an RFC is because of some open
> > questions
> > I had and wanted feedback on:
> > =

> > 1. What options specifically do we want encrypted? These patches
> > only
> > =C2=A0=C2=A0 address Passphrase and PreSharedKey but really any option =
could
> > be
> > =C2=A0=C2=A0 encrypted. Obviously we would also want 802.1x secrets, bu=
t are
> > there
> > =C2=A0=C2=A0 other non-obvious options with privacy concerns?
> =

> we only need to encrypt things that are provided by the user. If we
> wouldn=E2=80=99t ask the user for it, then it is not worth while protecti=
ng.

Ok, another option would be encrypting the entire [Security] group and
assume anything here should be secure. This would actually make things
quite a bit cleaner, and may be the only solution with how we do the
802.1x profiles since they are recursive.

> =

> > 2. What is the stance on existing provisioning files? Currently
> > these
> > =C2=A0=C2=A0 changes overwrite any existing files with the new *Encrypt=
ed
> > options
> > =C2=A0=C2=A0 automatically. Is this desirable? or should user have to o=
pt-in
> > their
> > =C2=A0=C2=A0 existing provisioning files.
> =

> The problem arises that you no longer can move from one machine to
> the next without re-entering your secrets. So I guess this only
> desirable if the master key is part of your users keyring. If you
> have 200 PSKs entered and you set up a new machine, you now end up
> having to re-enter these as you go visiting new networks.

How would this work though? The user would have to either manually
encrypt the settings/group or have some way to tell IWD to do it?

I think the act of enabling the main.conf option would be enough, and
we could emphasise this in the docs. Yes this means you cannot go back
but if you really had 200 profiles you absolutely could not lose you
probably should have those saved somewhere else, offline.

Also, really the only security benefit (above what we do now) is when
using a TPM meaning you couldn't move the profiles between machines
regardless.

> =

> > 3. Is the secret provided via a file enough? (the secret is still
> > stored
> > =C2=A0=C2=A0 as plaintext *somewhere*, though systemd limits permission=
s).
> > Systemd
> > =C2=A0=C2=A0 supports an IPC mechanism to obtain the secret. Is this mo=
re
> > secure?
> =

> From iwd perspective it is always a file. systemd does the reading
> from an AF_UNIX socket and storing it as a file. When IPC part
> becomes interesting if you want to provide an iwd-secrets-provider
> tool.
> =

> Note: At least that is how I understood the man page. I have not
> verified this in the systemd sources.
> =

> > 4. Should full provisioning file encryption be optional/supported?
> > I felt
> > =C2=A0=C2=A0 it was best to only encrypt sensitive options like
> > PSK/Passphrase which
> > =C2=A0=C2=A0 would allow editing of the provisioning file without extra=
 steps
> > of
> > =C2=A0=C2=A0 decrypting, editing, and encrypting. I think this is above=
 the
> > capability
> > =C2=A0=C2=A0 or desire of most users.
> > =

> > =C2=A0=C2=A0 If, though, a provisioning file is never expected to chang=
e or
> > issued by
> > =C2=A0=C2=A0 a network administrator that does not want it edited I cou=
ld see
> > full
> > =C2=A0=C2=A0 file encryption being ok.
> =

> What you want is that system / networks admins can sign their
> provision file and you would verify that it is unmodified. That is
> generally useful as well, but we would need to discuss where the
> certificate that you verify against comes from.
> =

> Regards
> =

> Marcel
> =



--===============3540728916077606071==--

