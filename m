Content-Type: multipart/mixed; boundary="===============2945138990504833015=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 01/10] test-runner: isolate Process/Namespace into utils
Date: Wed, 06 Apr 2022 14:48:35 -0500
Message-ID: <df6b78ba-50ed-d7a2-5d22-5ba8ca859371@gmail.com>
In-Reply-To: 20220406191453.978426-1-prestwoj@gmail.com

--===============2945138990504833015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/6/22 14:14, James Prestwood wrote:
> Way too many classes have a dependency on the TestContext class, in
> most cases only for is_verbose. This patch removes the dependency from
> Process and Namespace classes.
> =

> For Process, the test arguments can be parsed in the class itself which
> will allow for this class to be completely isolated into its own file.
> =

> The Namespace class was already relatively isolated. Both were moved
> into utils.py which makes 'run-tests' quite a bit nicer to look at and
> more fitting to its name.
> ---
>   tools/run-tests | 470 +-----------------------------------------------
>   tools/utils.py  | 455 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 464 insertions(+), 461 deletions(-)
>   create mode 100644 tools/utils.py
> =


All applied, thanks.

Regards,
-Denis

--===============2945138990504833015==--

