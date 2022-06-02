Content-Type: multipart/mixed; boundary="===============0678789725352274646=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] auto-t: allow skipping tests is wpa_supplicant is not
 found
Date: Thu, 02 Jun 2022 16:47:45 -0500
Message-ID: <6e15bff1-e59e-82ad-908f-26760f67f7d3@gmail.com>
In-Reply-To: 20220602184955.71055-1-prestwoj@gmail.com

--===============0678789725352274646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/2/22 13:49, James Prestwood wrote:
> Similarly to ofono/phonesim allow tests to be skipped if wpa_supplicant
> is not found on the system.
> =

> This required some changes to DPP/P2P where Wpas() should be called first
> since this can now throw a SkipTest exception.
> =

> The Wpas class was also made to allow __del__ to be called without
> throwing additional exceptions in case wpa_supplicant was not found.
> ---
>   autotests/testDPP/connection_test.py |  3 +--
>   autotests/testP2P/connection_test.py |  2 +-
>   autotests/util/wpas.py               | 13 +++++++++++--
>   tools/run-tests                      |  5 ++++-
>   4 files changed, 17 insertions(+), 6 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0678789725352274646==--

