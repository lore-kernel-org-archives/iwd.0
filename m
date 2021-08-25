Content-Type: multipart/mixed; boundary="===============5876564151347751456=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] auto-t: hwsim.py: convert addresses to 42:* format
Date: Wed, 25 Aug 2021 08:52:17 -0500
Message-ID: <3d9c3519-72e8-f494-aed3-42e1f991cd67@gmail.com>
In-Reply-To: <20210823183221.558154-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5876564151347751456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/23/21 1:32 PM, James Prestwood wrote:
> mac80211_hwsim has a funny quirk with multiple addresses in
> radios. Some operations require address index zero, some index
> one. And these addresses (possibly a result of how test-runner
> initializes radios) sometimes get mixed up. For example scan
> results may show a BSS address as 02:00:00:00:00:00, while the
> next test run shows 42:00:00:00:00:00.
> =

> Ultimately, sending out frames requires the first nibble of the
> address to be 0x4 so to handle both variants of addresses described
> above hwsim.py was updated to always bitwise OR the first byte
> with 0x40.
> ---
>   autotests/util/hwsim.py | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> =


All applied, thanks.

--===============5876564151347751456==--

