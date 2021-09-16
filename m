Content-Type: multipart/mixed; boundary="===============0762882727004959996=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] netconfig: Remove usage of in6_addr.__in6_u
Date: Thu, 16 Sep 2021 11:11:34 -0500
Message-ID: <cd2c850b-8f72-9f35-7315-0446143ed684@gmail.com>
In-Reply-To: 20210915235829.536670-1-andrew.zaborowski@intel.com

--===============0762882727004959996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/15/21 6:58 PM, Andrew Zaborowski wrote:
> in6_addr.__in6_u.__u6_addr8 is glibc-specific and named differently in
> the headers shipped with musl libc for example.  The POSIX compliant and
> universal way of accessing it is in6_addr.s6_addr.
> ---
>   src/netconfig.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0762882727004959996==--

