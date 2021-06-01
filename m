Content-Type: multipart/mixed; boundary="===============4709929749657431083=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/8] autotests: Update APRanges usage in testAP
Date: Tue, 01 Jun 2021 10:22:48 -0500
Message-ID: <43709184-8319-4296-2461-c8486e2df1b1@gmail.com>
In-Reply-To: <20210528004737.2878442-7-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4709929749657431083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/27/21 7:47 PM, Andrew Zaborowski wrote:
> [General].APRange is now [IPv4].APAddressPool and the netmask is changed
> from 23 to 27 bits to make the test correctly assert that only two
> default-sized subnets are allowed by IWD simultaneously (default has
> changed from 24 to 28 bits)
> ---
>   autotests/testAP/dhcp/main.conf |  4 +++-
>   autotests/testAP/dhcp_test.py   | 12 +++++++++---
>   2 files changed, 12 insertions(+), 4 deletions(-)
> =


Patches 7 and 8 applied, thanks.

Regards,
-Denis

--===============4709929749657431083==--

