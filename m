Content-Type: multipart/mixed; boundary="===============0399431289749686804=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] autotests: Work around wpa_s config issue in testP2P
Date: Mon, 06 Jun 2022 10:39:38 -0500
Message-ID: <3f58e69a-685b-03f8-5c52-3b9e586c62f7@gmail.com>
In-Reply-To: 20220606090154.980544-1-andrew.zaborowski@intel.com

--===============0399431289749686804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 6/6/22 04:01, Andrew Zaborowski wrote:
> Since commit 922fa099721903b106a7bc1ccd1ffe8c4a7bce69 in hostap, our
> setting of config_methods on P2P-client interface was ignored.  Work
> around that commit, in addition to the previous workaround we have in
> this test, to again ensure the correct config_methods value is used.
> ---
>   autotests/testP2P/connection_test.py | 5 +++++
>   1 file changed, 5 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============0399431289749686804==--

