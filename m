Content-Type: multipart/mixed; boundary="===============6610721089284937387=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 2/3] scan: add scan_freq_set_serialize
Date: Tue, 30 Nov 2021 12:26:01 -0600
Message-ID: <b9164c3e-0847-fe30-3fda-5e4778a471a8@gmail.com>
In-Reply-To: 20211130174813.384374-2-prestwoj@gmail.com

--===============6610721089284937387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/30/21 11:48 AM, James Prestwood wrote:
> This serializes a scan_freq_set into a uint32_t array.

Looks like you didn't update 'serialize' to _fixed_array in the commit head=
er.

> ---
>   src/util.c | 33 +++++++++++++++++++++++++++++++++
>   src/util.h |  2 ++
>   2 files changed, 35 insertions(+)
> =


Please respin to use l_uintset_size.

Regards,
-Denis
--===============6610721089284937387==--

