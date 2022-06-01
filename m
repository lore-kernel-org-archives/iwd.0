Content-Type: multipart/mixed; boundary="===============6920524721217622683=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/2] auto-t: correctly import Mapping from collections
Date: Wed, 01 Jun 2022 11:02:26 -0500
Message-ID: <4f5236bb-6fb1-47cd-86a0-052024470458@gmail.com>
In-Reply-To: 20220601160548.262018-1-prestwoj@gmail.com

--===============6920524721217622683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/1/22 11:05, James Prestwood wrote:
> The current way this was being done was to import collections and
> use collections.Mapping. This has been deprecated since python 3.3
> but has worked up until python 3.10. After python 3.10 this will
> no longer work, and Mapping must be imported from collections.abc.
> ---
>   autotests/util/ead.py   | 4 ++--
>   autotests/util/hwsim.py | 6 +++---
>   autotests/util/iwd.py   | 5 +++--
>   3 files changed, 8 insertions(+), 7 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============6920524721217622683==--

