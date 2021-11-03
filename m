Content-Type: multipart/mixed; boundary="===============4003400247051919697=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/4] sysfs: introduce sysfs module
Date: Wed, 03 Nov 2021 17:49:01 -0500
Message-ID: <11653fe8-a65c-33c0-3cae-6d6a0d9cb259@gmail.com>
In-Reply-To: 20211103221502.470442-1-prestwoj@gmail.com

--===============4003400247051919697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/3/21 5:14 PM, James Prestwood wrote:
> Netconfig was the only user of sysfs but now other modules will
> also need it.
> =

> Adding existing API for IPv6 settings, a IPv4 and IPv6 'supports'
> checker, and a setter for IPv4 settings.
> ---
>   Makefile.am |   1 +
>   src/sysfs.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/sysfs.h |  28 ++++++++++++++
>   3 files changed, 138 insertions(+)
>   create mode 100644 src/sysfs.c
>   create mode 100644 src/sysfs.h
> =


All applied, thanks.

Regards,
-Denis

--===============4003400247051919697==--

