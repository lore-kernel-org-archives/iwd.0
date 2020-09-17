Content-Type: multipart/mixed; boundary="===============7615233713246031077=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] auto-t: fix testNetconfig
Date: Thu, 17 Sep 2020 16:20:29 -0500
Message-ID: <b8dd3553-6ca9-ee22-3dcf-894080c410d1@gmail.com>
In-Reply-To: <20200917213228.788093-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7615233713246031077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/17/20 4:32 PM, James Prestwood wrote:
> The interface was hard coded to wln0 which works when running single
> tests but not when running multiple. Instead use the actual ifname
> that hostapd is using.
> ---
>   autotests/testNetconfig/connection_test.py | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7615233713246031077==--

