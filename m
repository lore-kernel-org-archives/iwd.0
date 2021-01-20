Content-Type: multipart/mixed; boundary="===============8082129174950205012=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/8] netdev: add netdev_get_all_stations
Date: Wed, 20 Jan 2021 14:06:58 -0600
Message-ID: <6cfd9f16-6d0e-d7b8-679e-2346432976b4@gmail.com>
In-Reply-To: <20210120183036.477287-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8082129174950205012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/20/21 12:30 PM, James Prestwood wrote:
> This is a nl80211 dump version of netdev_get_station aimed at
> AP mode. This will dump all stations, parse into
> netdev_station_info structs, and call the callback for each
> individual station found. Once the dump is completed the destroy
> callback is called.
> ---
>   src/netdev.c | 26 ++++++++++++++++++++++++++
>   src/netdev.h |  2 ++
>   2 files changed, 28 insertions(+)
> =


Patch 2 & 3 applied, thanks.

Regards,
-Denis

--===============8082129174950205012==--

