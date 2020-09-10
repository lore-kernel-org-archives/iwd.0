Content-Type: multipart/mixed; boundary="===============1462969433559811876=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 01/26] auto-t: prepare autotests for test-runner
 re-write
Date: Thu, 10 Sep 2020 18:21:53 -0500
Message-ID: <a42bdf14-1d4a-cb56-7c55-ed4952d612c1@gmail.com>
In-Reply-To: <20200910231248.4995-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1462969433559811876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/10/20 6:12 PM, James Prestwood wrote:
> The tests basically remained the same with a few minor changes.
> The wiphy_map and in turn hostapd_map are no longer used. This
> was already partially converted a long time ago when the 'config'
> parameter was added to HostapdCLI. This patch fully converts all
> autotests to use 'config' rather than looking up by interface.
> =

> Some test scripts were named 'test.py' which was fine before but
> the new rewrite actually loads each python test as a module. The
> name 'test' is too ambiguous and causes issues due to a native
> python module with the same name. All of these files were
> renamed to 'connection_test.py'.
> ---
>   .../{test.py =3D> connection_test.py}           |  0
>   .../testAP/{test.py =3D> connection_test.py}    |  9 ++--
>   autotests/testAP/failure_test.py              |  6 +--
>   autotests/testAPRoam/connection_test.py       |  2 -
>   .../testBSSBlacklist/all_blacklisted_test.py  |  4 --
>   autotests/testBSSBlacklist/bad_pass_test.py   |  4 --
>   autotests/testBSSBlacklist/connection_test.py |  1 -
>   .../testBSSBlacklist/temp_blacklist_test.py   |  4 --
>   .../connect_command_test.py                   | 42 +++++++------------
>   .../disconnect_by_ap_test.py                  |  4 +-
>   autotests/testEAP-AKA/connection_test.py      |  1 -
>   .../testEAP-PEAPv0-CryptoBinding/ISK_test.py  |  1 -
>   .../NoISK_test.py                             |  1 -
>   .../testEAP-PEAPv0-CryptoBinding/main.conf    |  2 -
>   autotests/testEAP-PWD/connection_test.py      |  1 -
>   autotests/testEAP-SIM/connection_test.py      |  1 -
>   .../connection_test.py                        | 11 ++---
>   .../testEAP-TTLS-CHAP/connection_test.py      |  1 -
>   .../testEAP-TTLS-MSCHAP/connection_test.py    |  1 -
>   autotests/testEAP-TTLS-PAP/connection_test.py |  1 -
>   autotests/testEAP-WPS-Frag/wps_frag_test.py   |  4 +-
>   autotests/testEAP-WPS/four_digit_pin_test.py  |  4 +-
>   autotests/testEAP-WPS/pin_test.py             |  4 +-
>   autotests/testEAP-WPS/push_button_test.py     |  5 +--
>   autotests/testFILS/fils_256_test.py           |  1 -
>   autotests/testFILS/fils_384_test.py           |  1 -
>   .../{test.py =3D> connection_test.py}           |  2 +-
>   .../{test.py =3D> connection_test.py}           |  2 +-
>   .../{test.py =3D> connection_test.py}           |  2 +-
>   .../{test.py =3D> connection_test.py}           |  2 +-
>   .../{test.py =3D> connection_test.py}           | 17 +++++---
>   .../{test.py =3D> connection_test.py}           |  2 +-
>   .../{test.py =3D> connection_test.py}           |  2 +-
>   autotests/testOWE/connection_test.py          |  1 -
>   autotests/testOWE/renegotiate_test.py         |  1 -
>   .../{test.py =3D> connection_test.py}           |  2 +-
>   .../{test.py =3D> connection_test.py}           |  0
>   autotests/testSAE/connection_test.py          | 10 ++---
>   autotests/testSAE/group_20_connection_test.py | 10 ++---
>   .../testSAQuery-spoofing/connection_test.py   |  2 +-
>   autotests/testSAQuery/connection_test.py      |  2 +-
>   41 files changed, 56 insertions(+), 117 deletions(-)
>   rename autotests/testAP-no-support/{test.py =3D> connection_test.py} (1=
00%)
>   rename autotests/testAP/{test.py =3D> connection_test.py} (94%)
>   delete mode 100644 autotests/testEAP-PEAPv0-CryptoBinding/main.conf
>   rename autotests/testFT-8021x-roam/{test.py =3D> connection_test.py} (9=
9%)
>   rename autotests/testFT-FILS-SHA256/{test.py =3D> connection_test.py} (=
99%)
>   rename autotests/testFT-FILS-SHA384/{test.py =3D> connection_test.py} (=
99%)
>   rename autotests/testFT-PSK-over-DS/{test.py =3D> connection_test.py} (=
99%)
>   rename autotests/testFT-PSK-roam/{test.py =3D> connection_test.py} (96%)
>   rename autotests/testFT-SAE-roam/{test.py =3D> connection_test.py} (99%)
>   rename autotests/testHT-VHT/{test.py =3D> connection_test.py} (98%)
>   rename autotests/testPreauth-roam/{test.py =3D> connection_test.py} (98=
%)
>   rename autotests/testRSSIAgent/{test.py =3D> connection_test.py} (100%)
> =


All applied, thanks.

Regards,
-Denis

--===============1462969433559811876==--

