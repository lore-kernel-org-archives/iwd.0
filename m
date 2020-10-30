Content-Type: multipart/mixed; boundary="===============8329959876379277500=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] auto-t: fix hotspot autoconnect test
Date: Fri, 30 Oct 2020 13:17:41 -0500
Message-ID: <d292b20a-8147-fc7a-d151-3c9b9169166f@gmail.com>
In-Reply-To: <20201029161902.2371076-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8329959876379277500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/29/20 11:19 AM, James Prestwood wrote:
> The test was removing files in /var/lib/iwd which is no longer
> mounted read/write (nor are config files put there anymore).
> ---
>   autotests/testHotspot/autoconnect_test.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis
--===============8329959876379277500==--

