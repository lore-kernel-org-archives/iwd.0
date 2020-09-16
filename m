Content-Type: multipart/mixed; boundary="===============4995161669607428441=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] auto-t: add netconfig autotest
Date: Tue, 15 Sep 2020 20:21:10 -0500
Message-ID: <ab20776e-1e2c-0057-45aa-793b3139d43c@gmail.com>
In-Reply-To: <20200916000022.570808-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4995161669607428441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/15/20 7:00 PM, James Prestwood wrote:
> Tests that DHCP using IWD's internal netconfig functions properly.
> The actual IP address assignment is not verified, but since IWD does
> not signal the connection as successful unless DHCP succeeds we
> can assume it was successful by checking that the device is connected.
> =

> The process of actually starting dhcpd and configuring the interfaces
> is quite simple so it was left in the autotest itself. If (or when)
> more tests require IP capabilities (p2p, FILS, etc) this could be
> moved into test-runner itself and be made common. The reason I did not
> put it in there now is a) because this is the only test and b) more
> complex DHCP cases are likely to develop and may require more than this
> simplistic setup (like multiple APs/interfaces)
> ---
>   autotests/testNetconfig/connection_test.py | 70 ++++++++++++++++++++++
>   autotests/testNetconfig/dhcpd.conf         | 16 +++++
>   autotests/testNetconfig/hw.conf            |  6 ++
>   autotests/testNetconfig/main.conf          |  2 +
>   autotests/testNetconfig/ssidTKIP.conf      |  7 +++
>   5 files changed, 101 insertions(+)
>   create mode 100644 autotests/testNetconfig/connection_test.py
>   create mode 100644 autotests/testNetconfig/dhcpd.conf
>   create mode 100644 autotests/testNetconfig/hw.conf
>   create mode 100644 autotests/testNetconfig/main.conf
>   create mode 100644 autotests/testNetconfig/ssidTKIP.conf
> =

> -v2:
>   * Removed dhcpd.leases. Its an empty file anyways which caused issues w=
ith applying
>     the patches. Instead we can just touch /tmp/dhcpd.leases before start=
ing dhcpd.
> =


Applied, thanks.

Regards,
-Denis

--===============4995161669607428441==--

