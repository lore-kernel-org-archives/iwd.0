Content-Type: multipart/mixed; boundary="===============1442097735734319029=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 3/3] owe: netdev: refactor to remove OWE as an
 auth-proto
Date: Fri, 03 Sep 2021 14:44:53 -0500
Message-ID: <a577c13e-4971-e17c-f4c8-73498df974cd@gmail.com>
In-Reply-To: <20210903193544.13897-3-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1442097735734319029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/3/21 2:35 PM, James Prestwood wrote:
> ---
>   src/netdev.c | 545 +++++++++++++++++++++++++++------------------------
>   src/owe.c    | 148 ++------------
>   src/owe.h    |  12 +-
>   3 files changed, 312 insertions(+), 393 deletions(-)
> =

> v3:
>   * Deauth if OWE AKM is not in associate response RSN IE
>   * Remove owe_sm forward declaration from netdev.h

All applied.  I did amend some more 'goto error -> goto deauth' where appro=
priate.

Regards,
-Denis

--===============1442097735734319029==--

