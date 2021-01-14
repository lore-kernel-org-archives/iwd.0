Content-Type: multipart/mixed; boundary="===============7549076044732759404=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: iwd in AP mode: no HT capabilities
Date: Thu, 14 Jan 2021 20:07:37 +0100
Message-ID: <CAOq732Lnuh208DMc9Bxz8_KgrAqjio4v1mgi8s2CRCa=Wr9LaQ@mail.gmail.com>
In-Reply-To: <20210114185358.2879.1670@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7549076044732759404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Georg,

On Thu, 14 Jan 2021 at 19:54, <georgmueller@gmx.net> wrote:
> I tried to switch from wpa_supplicant to iwd to start an access point.
>
> When looking at the scan results from another machine, I see that when us=
ing iwd, the device sends no HT capabilities and only supports 11MBit/s.

This is a missing feature in IWD at this time, the AP mode is still
very basic and only reports a few hardcoded bitrates.  AP beacon
changes are blocked by an ongoing development in ell for the moment.

Best regards
--===============7549076044732759404==--

