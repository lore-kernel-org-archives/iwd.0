Content-Type: multipart/mixed; boundary="===============7377812861829680720=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] util: add bounds check to util_get_{domain,username}
Date: Thu, 17 Oct 2019 11:23:28 -0500
Message-ID: <9cc04c14-c03b-6de3-2b91-bcea9ee6001c@gmail.com>
In-Reply-To: <20191017161212.22073-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7377812861829680720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/17/19 11:12 AM, James Prestwood wrote:
> Two cases were using strcpy, and the other two were using strncpy.
> Instead all cases can use l_strlcpy which guarentees NULL termination.
> ---
>   src/util.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> =


I split this up into two commits and reworked the commit descriptions a bit.

Applied, thanks.

Regards,
-Denis

--===============7377812861829680720==--

