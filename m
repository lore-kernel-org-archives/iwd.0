Content-Type: multipart/mixed; boundary="===============1882790542306727614=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] auto-t: remove stale hw.conf options
Date: Wed, 27 Jan 2021 13:43:30 -0600
Message-ID: <81a46731-dfc8-5f2f-b307-c8aa5106ac38@gmail.com>
In-Reply-To: <20210127193426.939890-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1882790542306727614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/27/21 1:34 PM, James Prestwood wrote:
> After the test-runner re-write many tests were left with
> stale options that are no longer used at all. These were
> periodically getting removed as changes were made to
> individual tests, but its apparent now that a tree wide
> removal was needed.
> ---
>   autotests/testAPRoam/hw.conf                   | 1 -
>   autotests/testAdHoc/hw.conf                    | 1 -
>   autotests/testAddressRandomization/hw.conf     | 1 -
>   autotests/testAgent/hw.conf                    | 1 -
>   autotests/testBSSBlacklist/hw.conf             | 2 --
>   autotests/testClientNonInteractive/hw.conf     | 2 --
>   autotests/testConnectAutoconnect/hw.conf       | 4 +---
>   autotests/testDisconnectOnConnect/hw.conf      | 1 -
>   autotests/testEAP-AKA-ofono/hw.conf            | 2 --
>   autotests/testEAP-AKA-prime-ofono/hw.conf      | 2 --
>   autotests/testEAP-MSCHAPV2/hw.conf             | 1 -
>   autotests/testEAP-PEAP-GTC/hw.conf             | 2 --
>   autotests/testEAP-PEAP-MSCHAPv2/hw.conf        | 2 --
>   autotests/testEAP-PEAP/hw.conf                 | 2 --
>   autotests/testEAP-PEAPv0-CryptoBinding/hw.conf | 2 --
>   autotests/testEAP-PWD/hw.conf                  | 2 --
>   autotests/testEAP-SIM-ofono/hw.conf            | 2 --
>   autotests/testEAP-TLS-Frag/hw.conf             | 1 -
>   autotests/testEAP-TLS-embedded-pems/hw.conf    | 1 -
>   autotests/testEAP-TLS/hw.conf                  | 1 -
>   autotests/testEAP-TLSwithMFPC/hw.conf          | 1 -
>   autotests/testEAP-TLSwithMFPR/hw.conf          | 1 -
>   autotests/testEAP-TTLS-CHAP/hw.conf            | 1 -
>   autotests/testEAP-TTLS-EAP-MSCHAPV2/hw.conf    | 1 -
>   autotests/testEAP-TTLS-Frag/hw.conf            | 1 -
>   autotests/testEAP-TTLS-MSCHAP/hw.conf          | 1 -
>   autotests/testEAP-TTLS-MSCHAPv2/hw.conf        | 2 --
>   autotests/testEAP-TTLS-PAP/hw.conf             | 1 -
>   autotests/testEAP-TTLS/hw.conf                 | 1 -
>   autotests/testEAP-WPS-Frag/hw.conf             | 1 -
>   autotests/testEAP-WPS/hw.conf                  | 1 -
>   autotests/testFILS/hw.conf                     | 2 --
>   autotests/testFT-8021x-roam/hw.conf            | 3 ---
>   autotests/testFT-FILS-SHA256/hw.conf           | 2 --
>   autotests/testFT-FILS-SHA384/hw.conf           | 2 --
>   autotests/testFT-PSK-over-DS/hw.conf           | 3 ---
>   autotests/testFT-PSK-roam/hw.conf              | 3 ---
>   autotests/testFT-SAE-roam/hw.conf              | 3 ---
>   autotests/testHT-VHT/hw.conf                   | 2 --
>   autotests/testHotspot/hw.conf                  | 2 --
>   autotests/testKnownNetworks/hw.conf            | 1 -
>   autotests/testMFP-Options/hw.conf              | 2 --
>   autotests/testNetconfig/hw.conf                | 1 -
>   autotests/testPreauth-roam/hw.conf             | 3 ---
>   autotests/testRSSIAgent/hw.conf                | 3 ---
>   autotests/testRoamRetry/hw.conf                | 1 -
>   autotests/testSAQuery-spoofing/hw.conf         | 1 -
>   autotests/testScan/hw.conf                     | 2 --
>   autotests/testScanKnownFreqs/hw.conf           | 1 -
>   autotests/testWPA/hw.conf                      | 1 -
>   50 files changed, 1 insertion(+), 82 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============1882790542306727614==--

