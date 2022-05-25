Content-Type: multipart/mixed; boundary="===============0505249386432982843=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 1/6] test-runner: remove root user requirement from
 log/monitor/result
Date: Wed, 25 May 2022 15:00:26 -0500
Message-ID: <6cf675a8-019d-d063-3709-234329440108@gmail.com>
In-Reply-To: 20220525193729.336896-1-prestwoj@gmail.com

--===============0505249386432982843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/25/22 14:37, James Prestwood wrote:
> Certain aspects of QEMU like mounting host directories may still require
> root access but for UML this is not the case. To handle both cases first
> check if SUDO_UID/GID are set and use those to obtain the actual users
> ID's. Otherwise if running as non-root use the UID/GID of the user
> directly.
> ---
>   tools/runner.py | 18 ++----------------
>   1 file changed, 2 insertions(+), 16 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============0505249386432982843==--

