Content-Type: multipart/mixed; boundary="===============5815406194614876254=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] auto-t: remove more /var/lib/iwd references
Date: Wed, 04 Nov 2020 13:35:27 -0600
Message-ID: <0baacce9-f135-c120-0e6f-ffc8a022624e@gmail.com>
In-Reply-To: <20201103205114.2744828-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5815406194614876254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/3/20 2:51 PM, James Prestwood wrote:
> The address randomization test was using a /var/lib/iwd which
> is no longer specially mounted or used for IWD storage. Instead
> use /tmp/iwd.
> ---
>   autotests/testAddressRandomization/connection_test.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============5815406194614876254==--

