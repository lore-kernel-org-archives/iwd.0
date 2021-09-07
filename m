Content-Type: multipart/mixed; boundary="===============4831141990660927310=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] test-runner: remove special case for "root" namespace
Date: Tue, 07 Sep 2021 12:46:42 -0500
Message-ID: <626c4be5-e112-a141-9684-410c192b7b6f@gmail.com>
In-Reply-To: <20210907165439.9913-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4831141990660927310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/7/21 11:54 AM, James Prestwood wrote:
> This was a placeholder at one point but modules grew to depend on it
> being a string. Fix these dependencies and set the root namespace
> name to None so there is no more special case needed to handle both
> a named namespace and the original 'root' namespace.
> ---
>   autotests/util/hwsim.py |  8 ++++----
>   autotests/util/iwd.py   |  2 +-
>   tools/test-runner       | 10 ++--------
>   3 files changed, 7 insertions(+), 13 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============4831141990660927310==--

