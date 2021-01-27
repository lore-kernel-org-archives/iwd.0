Content-Type: multipart/mixed; boundary="===============0580618958268107011=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] auto-t: add test for roaming retry timing
Date: Wed, 27 Jan 2021 13:19:04 -0600
Message-ID: <fa98593e-a8b6-3151-61a7-eb1252df50ea@gmail.com>
In-Reply-To: <20210127100457.341757-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0580618958268107011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 1/27/21 4:05 AM, Alvin =C5=A0ipraga wrote:
> From: Alvin =C5=A0ipraga <alvin@pqrs.dk>
> =

> Recent changes make iwd more eager to retry roaming if it has detected a
> high RSSI since the last attempt. Add an autotest to verify this
> behaviour.
> ---
>   autotests/testRoamRetry/fast_retry_test.py | 145 +++++++++++++++++++++
>   autotests/testRoamRetry/hw.conf            |   7 +
>   autotests/testRoamRetry/ssid1.conf         |  11 ++
>   autotests/testRoamRetry/ssid2.conf         |  11 ++
>   4 files changed, 174 insertions(+)
>   create mode 100644 autotests/testRoamRetry/fast_retry_test.py
>   create mode 100644 autotests/testRoamRetry/hw.conf
>   create mode 100644 autotests/testRoamRetry/ssid1.conf
>   create mode 100644 autotests/testRoamRetry/ssid2.conf
> =


I went ahead and applied this after running dos2unix to fix the weird Windo=
ws =

style line endings.

Regards,
-Denis

--===============0580618958268107011==--

