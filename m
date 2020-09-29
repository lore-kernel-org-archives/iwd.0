Content-Type: multipart/mixed; boundary="===============1666022579767194134=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 1/8] test-runner: Reserve radios for wpa_supplicant
Date: Tue, 29 Sep 2020 10:14:59 -0700
Message-ID: <e9e7515d2c2f4afe1b401ffdfcfd8aca79e5e95d.camel@gmail.com>
In-Reply-To: <20200929163717.754459-7-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1666022579767194134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, 2020-09-29 at 18:37 +0200, Andrew Zaborowski wrote:
> Add the "wpa_supplicant_radios=3D<radio_name_list>" option in hw.conf's
> SETUP section that only reserves radios for the autotest to be able
> to
> start wpa_supplicant on them, i.e. prevents iwd or hostapd from being
> started on them.

Instead could we just add a new group [WPA_S] or [WPA_SUPPLICANT] and
have radN=3D<config>. This would be consistent with how hostapd works,
and still allows you to reserve radios for wpa_supplicant. And if we
ever require wpa_s specific options in the future we may want a group
for it.

This would also allow you to hide a lot of those init arguments to your
wpa_s constructor since you would already know the config file,
interface, and control socket.

Thanks,
James

--===============1666022579767194134==--

