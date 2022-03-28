Content-Type: multipart/mixed; boundary="===============2827840830952098444=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v4 00/13] Combined test-runner fixes
Date: Mon, 28 Mar 2022 12:39:12 -0500
Message-ID: <789cabdf-8aa4-28d9-b871-39261b27d490@gmail.com>
In-Reply-To: 20220328172842.1660272-1-prestwoj@gmail.com

--===============2827840830952098444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/28/22 12:28, James Prestwood wrote:
> This combines the individual test fixes with the memory fixes
> =

> James Prestwood (13):
>    test-runner: add memory usage for debugging
>    test-runner: fix OOM issues (hopefully)
>    auto-t: remove waitstatus_to_exitcode for better compatibility
>    auto-t: iwd.py: fix full_scan argument
>    auto-t: fixup testRoamRetry for better timing reliability
>    auto-t: use wait_for_event in testBSSBlacklist
>    auto-t: use wait_for_event in testSAE-roam
>    auto-t: do full scan for testSAE
>    auto-t: use wait_for_event in testPSK-roam
>    auto-t: do a full scan when getting network
>    dpp: fail if disconnected during DPP protocol
>    dpp: set new_freq when configuring as initiator
>    auto-t: don't wait for wpa_supplicant to connect
> =

>   autotests/testBSSBlacklist/connection_test.py | 18 ++--
>   autotests/testDPP/connection_test.py          |  5 +-
>   autotests/testNetconfig/connection_test.py    |  5 +-
>   .../testOWE-transition/connection_test.py     | 13 +--
>   autotests/testPSK-roam/connection_test.py     | 29 +-----
>   autotests/testRoamRetry/fast_retry_test.py    | 13 ++-
>   autotests/testRoamRetry/stop_retry_test.py    |  7 +-
>   autotests/testSAE-roam/connection_test.py     | 11 ++-
>   autotests/testSAE/connection_test.py          | 14 +--
>   autotests/util/iwd.py                         | 23 ++---
>   src/dpp.c                                     | 15 +++-
>   tools/test-runner                             | 89 +++++++++++++++++--
>   12 files changed, 142 insertions(+), 100 deletions(-)
> =

All applied, thanks.

Regards,
-Denis
--===============2827840830952098444==--

