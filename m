Content-Type: multipart/mixed; boundary="===============0288993319681531065=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] monitor: fix integer comparison error (clang)
Date: Fri, 10 Jun 2022 14:39:32 -0500
Message-ID: <67db2e07-3e69-67ee-8553-b4a4021f92b5@gmail.com>
In-Reply-To: 20220610192726.421340-1-prestwoj@gmail.com

--===============0288993319681531065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/10/22 14:27, James Prestwood wrote:
> Though the documentation for NLMSG_OK uses an int type for the length
> the actual check is based on nlmsghdr->nlmsg_len which is a 32 bit
> unsigned integer. Clang was complaining about one call in nlmon.c
> because nlmsg_len was int type. Every other usage in nlmon.c uses
> a uint32_t, so use that both for consistency and to fix the warning.
> =

> monitor/nlmon.c:7998:29: error: comparison of integers of different
> 		signs: '__u32' (aka 'unsigned int') and 'int'
> 		[-Werror,-Wsign-compare]
>          for (nlmsg =3D iov.iov_base; NLMSG_OK(nlmsg, nlmsg_len);
>                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/include/linux/netlink.h:100:24: note: expanded from macro 'NLMSG_OK'
>                             (nlh)->nlmsg_len <=3D (len))
> ---
>   monitor/nlmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0288993319681531065==--

