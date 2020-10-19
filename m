Content-Type: multipart/mixed; boundary="===============2331748569169996590=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] test-runner: Reserve radios for wpa_supplicant
Date: Mon, 19 Oct 2020 17:22:04 -0500
Message-ID: <0d996b89-7c12-3921-9690-a3edf236e5d9@gmail.com>
In-Reply-To: <20201009180855.1063394-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2331748569169996590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/9/20 1:08 PM, Andrew Zaborowski wrote:
> Add support for a WPA_SUPPLICANT section in  hw.conf where
> 'radN=3D<config_path>' lines will only reserve radios and create
> interfaces for the autotest to be able to start wpa_supplicant on them,
> i.e. this prevents iwd or hostapd from being started on them but doesn't
> start a wpa_supplicant instance by itself.
> ---
>   tools/test-runner | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============2331748569169996590==--

