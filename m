Content-Type: multipart/mixed; boundary="===============7314522152599403559=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 3/5] tools: add decrypt-profile tool
Date: Wed, 02 Feb 2022 13:39:19 -0600
Message-ID: <9f6f5694-8f0a-4d01-69f5-b9695c5a0e4d@gmail.com>
In-Reply-To: 20220202184744.1954-3-prestwoj@gmail.com

--===============7314522152599403559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/2/22 12:47, James Prestwood wrote:
> This tool will decrypt an IWD network profile which was previously
> encrypted using a systemd provided key. Either a text passphrase
> can be provided (--pass) or a file containing the secret (--file).

You may want to provide some usage examples in the commit description.  May=
be =

even mention stdin/--infile and stdout/-outfile use.

> =

> This can be useful for debugging, or recovering an encrypted
> profile after enabling SystemdEncrypt.
> ---
>   Makefile.am             |   8 +-
>   tools/decrypt-profile.c | 232 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 239 insertions(+), 1 deletion(-)
>   create mode 100644 tools/decrypt-profile.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index 35938d22..a106b56f 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -362,7 +362,7 @@ man_MANS +=3D wired/ead.8
>   endif
>   endif
>   =

> -noinst_PROGRAMS +=3D tools/probe-req
> +noinst_PROGRAMS +=3D tools/probe-req tools/decrypt-profile

Should this be an installed binary?  Something like iwd-decrypt-profile?

> +#include <stdio.h>
> +#include <unistd.h>
> +#include <libgen.h> > +#include <fcntl.h>

Isn't sys/stat.h enough? In any case, you might want to group related #incl=
udes =

together.

> +#include <getopt.h>
> +#include <sys/stat.h>
> +#include <ell/ell.h>
> +
> +#include "ell/useful.h"
> +
> +#include "src/storage.h"
> +

<snip>

> +int main(int argc, char *argv[])
> +{
> +	const char *pass =3D NULL;
> +	const char *file =3D NULL;
> +	const char *infile =3D NULL;
> +	const char *outfile =3D NULL;
> +	_auto_(l_free) char *ssid =3D NULL;
> +	_auto_(l_free) char *decrypted =3D NULL;
> +	_auto_(l_settings_free) struct l_settings *settings =3D NULL;
> +	_auto_(l_free) uint8_t *secret =3D NULL;
> +	size_t secret_len =3D 0;
> +	int ret =3D EXIT_FAILURE;
> +	char profile[BUFSIZ];
> +	ssize_t len =3D 0;
> +	char *line;
> +
> +	if (isatty(0))
> +		goto done_reading;

Err, why is the command line arguments not being parsed first?  I mean you =
might =

want to use 'decrypt-profile --help' ?

> +
> +	while ((line =3D fgets(profile + len, sizeof(profile) - len, stdin)))
> +		len +=3D strlen(profile + len);

You should check whether infile was specified prior to attempting this.

> +
> +done_reading:
> +	for (;;) {
> +		int opt;
> +
> +		opt =3D getopt_long(argc, argv, "pfhio",
> +					main_options, NULL);
> +		if (opt < 0)
> +			break;
> +
> +		switch (opt) {
> +		case 'p':
> +			pass =3D optarg;
> +			break;
> +		case 'f':
> +			file =3D optarg;
> +			break;
> +		case 'i':
> +			infile =3D optarg;
> +			break;
> +		case 'o':
> +			outfile =3D optarg;
> +			break;
> +		case 's':
> +			ssid =3D l_strdup(optarg);
> +			break;
> +		case 'h':
> +			usage();
> +			return EXIT_SUCCESS;
> +		default:
> +			goto failed;
> +		}
> +	}
> +
> +	if (!file && !pass) {
> +		usage();
> +		goto failed;
> +	}
> +
So if infile specified, read that.  Otherwise, if no --ssid, fail.  Read st=
din...

> +	if (!len && !infile) {
> +		printf("No input file (use stdin or --infile)\n\n");
> +		usage();
> +		goto failed;
> +	}
> +
> +	if (len && infile) {
> +		printf("Use only stdin or --infile for input profile\n\n");
> +		usage();
> +		goto failed;
> +	}
> +

Check for ssid and override that.

> +	if (infile) {
> +		/* Try and detect SSID from input file */
> +		if (!ssid) {
> +			char *dot;
> +
> +			ssid =3D l_strdup(basename((char *)infile));
> +			/* remove extension */
> +			dot =3D strchr(ssid, '.');
> +			if (!dot)
> +				goto no_ssid;
> +
> +			*dot =3D '\0';
> +		}
> +

That isn't how ssids are stored in the profile.  You're better off relying =
on =

storage_network_ssid_from_path() from storage.c here.

> +		len =3D read_file(profile, sizeof(profile), "%s", infile);
> +		if (len < 0) {
> +			printf("Could not read from %s (%ld)\n", infile, len);
> +			goto failed;
> +		}

Why not rely on the new functions from patch 1?  We could introduce a full-=
path =

version of storage_network_open maybe.

> +	}
> +
> +	if (!ssid) {
> +no_ssid:
> +		printf("Can't detect SSID from input source (use --ssid)\n");
> +		goto failed;
> +	}
> +
> +	if (pass) {
> +		secret_len =3D strlen(pass);
> +		secret =3D l_memdup(pass, secret_len);

Why do we need the memdup?

> +	} else
> +		secret =3D secret_from_file(file, &secret_len);

This could actually be an mmap instead.

> +
> +	__storage_set_encryption_key(secret, secret_len);
> +
> +	settings =3D l_settings_new();
> +
> +	if (!l_settings_load_from_data(settings, profile, len)) {
> +		printf("Profile is not formatted correctly\n");
> +		goto failed;
> +	}
> +
> +	if (!__storage_decrypt(settings, ssid, NULL)) {

Note that you will also get errors from this function as well.  So I'm not =
sure =

if you want to re-design it to not print unnecessarily.

> +		printf("Unable to decrypt profile\n");
> +		goto failed;
> +	}
> +
> +	decrypted =3D l_settings_to_data(settings, (size_t *)&len);
> +
> +	if (!outfile)
> +		printf("%s\n", decrypted);
> +	else {
> +		int fd =3D open(outfile, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
> +
> +		if (fd < 0) {
> +			printf("Unable to open %s (%d)\n\n", outfile, fd);
> +			close(fd);
> +			goto failed;
> +		}
> +
> +		len =3D write(fd, decrypted, len);
> +
> +		close(fd);
> +
> +		if (len < 0) {
> +			printf("Unable to write to %s (%ld)\n\n", outfile, len);
> +			goto failed;
> +		}
> +	}
> +
> +	ret =3D EXIT_SUCCESS;
> +
> +failed:
> +	return ret;
> +}
> =


Regards,
-Denis
--===============7314522152599403559==--

