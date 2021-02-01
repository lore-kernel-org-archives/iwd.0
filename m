Content-Type: multipart/mixed; boundary="===============4941543576509841759=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: broadcom fmac ap mode testing - how to set iwd as dhcp server?
Date: Mon, 01 Feb 2021 13:42:25 +0100
Message-ID: <CAOq732JsARfDP1u5r-bQJB2YW_2JUqAzDBrba9n2JaJyorkadA@mail.gmail.com>
In-Reply-To: <CAG17S_NVgvtXFqZQdn974imgypqb8F3g5zTP0Cx0dP55a4v1yw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4941543576509841759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On Sun, 31 Jan 2021 at 16:44, KeithG <ys3al35l@gmail.com> wrote:
> So, I finally tried running iwd in 'standalone' ap mode (no connman). It =
still connects but even though I have this for my main.conf:
> [General]
> UseDefaultInterface=3Dtrue
> EnableNetworkConfiguration=3Dtrue

If I'm not mistaken you're missing the APRanges=3D setting for server-side =
DHCP.

Best regards
--===============4941543576509841759==--

