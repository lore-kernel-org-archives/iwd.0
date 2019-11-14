Content-Type: multipart/mixed; boundary="===============6426414512261692973=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] auto-t: fix intermittent failures in testEAP-MSCHAPV2
Date: Thu, 14 Nov 2019 12:58:39 -0600
Message-ID: <3f9d3847-71b1-b086-dfa1-b601a2f1c52d@gmail.com>
In-Reply-To: <20191114184356.23993-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6426414512261692973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/14/19 12:43 PM, James Prestwood wrote:
> Occationally autoconnect would start which was not expected in the
> test. This is fixed by disabling autoconnect in the provisioning files.
> ---
>   autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-1.8021x | 3 +++
>   autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-2.8021x | 3 +++
>   autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-3.8021x | 3 +++
>   autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-4.8021x | 3 +++
>   4 files changed, 12 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============6426414512261692973==--

