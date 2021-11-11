Content-Type: multipart/mixed; boundary="===============6208491379218180712=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] auto-t: replace ifconfig with ip commands
Date: Thu, 11 Nov 2021 14:32:13 -0600
Message-ID: <f5df8fb9-d0f4-7386-6f6f-05703eff4bd1@gmail.com>
In-Reply-To: 20211111021202.26369-1-noreply.torsten@gmail.com

--===============6208491379218180712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Torsten,

On 11/10/21 8:12 PM, Torsten Schmitz wrote:
> ifconfig has long been deprecated in favor of ip from iproute2.
> It is usually no longer installed by default.
> ---
> changes from v1:
>      remove ifconfig introduced in commmit d30fc978
>      fix typo adrr
>      changed commit message
> ---
>   autotests/testFILS/fils_256_test.py           |  2 +-
>   autotests/testFILS/fils_384_test.py           |  2 +-
>   .../testFT-8021x-roam/connection_test.py      | 18 +++++++------
>   autotests/testFT-FILS/connection_test.py      | 18 ++++++-------
>   autotests/testNetconfig/connection_test.py    |  8 +++---
>   autotests/testNetconfig/static_test.py        |  3 +--
>   autotests/testP2P/connection_test.py          |  2 +-
>   autotests/testPSK-roam/connection_test.py     | 16 +++++------
>   autotests/testPreauth-roam/connection_test.py |  2 +-
>   autotests/testSAE-roam/connection_test.py     | 27 ++++++++++---------
>   doc/test-runner.txt                           |  2 +-
>   tools/test-runner                             |  6 ++---
>   12 files changed, 55 insertions(+), 51 deletions(-)
> =


Applied, thanks!

Regards,
-Denis
--===============6208491379218180712==--

