Content-Type: multipart/mixed; boundary="===============6130263344237456009=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/2] tools: add decrypt-profile tool
Date: Wed, 16 Feb 2022 16:12:01 -0600
Message-ID: <36fabee1-25d2-b0aa-6496-071b4e238a9e@gmail.com>
In-Reply-To: 20220216002826.1361879-1-prestwoj@gmail.com

--===============6130263344237456009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/15/22 18:28, James Prestwood wrote:
> This tool will decrypt an IWD network profile which was previously
> encrypted using a systemd provided key. Either a text passphrase
> can be provided (--pass) or a file containing the secret (--file).
> =

> This can be useful for debugging, or recovering an encrypted
> profile after enabling SystemdEncrypt.
> ---
>   Makefile.am                 |   8 +-
>   tools/iwd-decrypt-profile.c | 213 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 220 insertions(+), 1 deletion(-)
>   create mode 100644 tools/iwd-decrypt-profile.c
> =


Both applied, thanks.

Regards,
-Denis

--===============6130263344237456009==--

