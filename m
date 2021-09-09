Content-Type: multipart/mixed; boundary="===============2753382361857099574=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] auto-t: remove OWE renegotiate test
Date: Wed, 08 Sep 2021 20:05:41 -0500
Message-ID: <011b8035-35be-03bc-c713-434ecbc17c20@gmail.com>
In-Reply-To: <20210908231516.103337-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2753382361857099574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/8/21 6:15 PM, James Prestwood wrote:
> Since IWD tries group 20 first all other OWE tests are actually
> triggering group negotiation where this test is not. Since this
> code is exercised this test can be removed completely, as well
> as the additional radio/network.
> ---
>   autotests/testOWE/hw.conf             |  3 +-
>   autotests/testOWE/renegotiate_test.py | 60 ---------------------------
>   autotests/testOWE/ssidGroup20.conf    |  8 ----
>   3 files changed, 1 insertion(+), 70 deletions(-)
>   delete mode 100644 autotests/testOWE/renegotiate_test.py
>   delete mode 100644 autotests/testOWE/ssidGroup20.conf
> =


Applied, thanks.

Regards,
-Denis

--===============2753382361857099574==--

