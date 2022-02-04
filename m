Content-Type: multipart/mixed; boundary="===============7564413734078410104=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v4 4/7] tools: add decrypt-profile tool
Date: Fri, 04 Feb 2022 13:57:43 -0600
Message-ID: <6441d532-031d-c11e-6a62-46cece2fbe1c@gmail.com>
In-Reply-To: 20220204173120.231730-4-prestwoj@gmail.com

--===============7564413734078410104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

> +int main(int argc, char *argv[])
> +{
> +	const char *pass =3D NULL;
> +	const char *file =3D NULL;
> +	const char *infile =3D NULL;
> +	const char *outfile =3D NULL;
> +	const char *ssid =3D NULL;
> +	_auto_(l_free) char *decrypted =3D NULL;
> +	_auto_(l_settings_free) struct l_settings *settings =3D NULL;
> +	enum security sec;
> +	int ret =3D EXIT_FAILURE;
> +	char profile[BUFSIZ];

What's BUFSIZ?  Is this from the fget* utilities?  If so, that is system =

dependent...

> +	ssize_t len =3D 0;
> +	char *line;
> +	int r;
> +
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
> +			ssid =3D optarg;
> +			break;
> +		case 'h':
> +			usage();
> +			return EXIT_SUCCESS;
> +		default:
> +			goto failed;
> +		}
> +	}
> +
> +	/*
> +	 * Sort out the argument dependencies:
> +	 *  1. Either --file or --pass must be provided
> +	 *  2. Either stdin or --infile must be provided
> +	 *  3. If using stdin --ssid must be provided
> +	 *  4. If using --infile without --ssid, attempt to get the SSID, if
> +	 *     that fails --ssid must be provided.
> +	 */
> +
> +	if (!file && !pass) {
> +		printf("--file or --pass must be supplied\n\n");
> +		goto usage;
> +	}
> +
> +	if (isatty(0) && !infile) {
> +		printf("No input file (use stdin or --infile)\n\n");
> +		goto usage;
> +	}
> +
> +	if (!infile && !ssid) {
> +		printf("--ssid is required if --infile is missing\n\n");
> +		goto usage;
> +	}
> +
> +	if (infile && !ssid) {
> +		ssid =3D storage_network_ssid_from_path(infile, &sec);
> +		if (!ssid) {
> +			printf("Can't get SSID from --infile, use --ssid\n");
> +			goto usage;
> +		}
> +	}
> +
> +	settings =3D l_settings_new();
> +
> +	if (infile) {
> +		if (!l_settings_load_from_file(settings, infile)) {
> +			printf("Profile is not formatted correctly\n");
> +			goto failed;
> +		}

Okay, but in theory you can mmap this as well and combine it with the case =

below.  Not sure if it makes the code any smaller though.

> +	} else {
> +		while ((line =3D fgets(profile + len,
> +					sizeof(profile) - len, stdin)))
> +			len +=3D strlen(profile + len);

This seems a bit limiting.  Why not use a growable buffer via realloc?  Or =

alternatively l_string_*

> +
> +		if (!l_settings_load_from_data(settings, profile, len)) {
> +			printf("Profile is not formatted correctly\n");
> +			goto failed;
> +		}
> +	}
> +
> +	if (pass)
> +		__storage_set_encryption_key((const uint8_t *)pass,
> +						strlen(pass));
> +	else if (!secret_from_file(file))
> +		goto failed;
> +
> +	r =3D __storage_decrypt(settings, ssid, NULL);
> +	if (r < 0) {
> +		printf("Unable to decrypt profile (%d)\n", r);
> +		goto failed;
> +	}
> +
> +	decrypted =3D l_settings_to_data(settings, (size_t *)&len);
> +
> +	if (!outfile)
> +		printf("%s\n", decrypted);

using write directly to stdout is probably better.

> +	else {
> +		int fd =3D open(outfile, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
> +
> +		if (fd < 0) {
> +			printf("Unable to open %s (%d)\n", outfile, fd);
> +			close(fd);
> +			goto failed;
> +		}
> +
> +		len =3D write(fd, decrypted, len);
> +
> +		close(fd);
> +
> +		if (len < 0) {
> +			printf("Unable to write to %s (%ld)\n", outfile, len);
> +			goto failed;
> +		}
> +	}
> +
> +	ret =3D EXIT_SUCCESS;
> +
> +usage:
> +	if (ret !=3D EXIT_SUCCESS)
> +		usage();
> +
> +failed:
> +	return ret;
> +}
> =


Regards,
-Denis
--===============7564413734078410104==--

